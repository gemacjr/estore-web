package com.eshop.service.impl;

import com.eshop.customer.exception.UserAlreadyExistException;
import com.eshop.customer.exception.UserNotFoundException;
import com.eshop.dto.UserDTO;
import com.eshop.dto.account.Profile;
import com.eshop.dto.account.Register;
import com.eshop.entity.*;
import com.eshop.repository.AuthorityRepository;
import com.eshop.repository.RoleRepository;
import com.eshop.repository.UserRepository;
import com.eshop.repository.VerificationTokenRepository;
import com.eshop.service.UserService;
import com.eshop.utils.MailUtils;
import com.eshop.utils.MapperUtils;
import com.eshop.utils.MessageUtils;
import com.eshop.utils.ParamUtils;
import net.bytebuddy.utility.RandomString;
import org.apache.commons.lang3.time.DateUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.MessagingException;
import javax.transaction.Transactional;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Objects;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserRepository userRepository;
    @Autowired
    RoleRepository roleRepository;
    @Autowired
    AuthorityRepository authorityRepository;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    VerificationTokenRepository verifyRepo;
    @Autowired
    ResourceLoader resourceLoader;
    @Autowired
    MessageUtils messageUtils;
    @Autowired
    ParamUtils paramUtils;
    @Autowired
    MailUtils mailUtils;
    @Autowired
    ModelMapper mapper;

    private boolean isTokenFound(VerificationToken verificationToken) {
        return verificationToken == null;
    }

    private boolean isTokenExpired(VerificationToken resetPassToken) {
        return resetPassToken.getExpiryDate().before(new Date());
    }

    private void createVerificationToken(String token, String email) {
        VerificationToken verifyToken = verifyRepo.findByUserEmail(email);
        if (verifyToken == null) {
            verifyToken = new VerificationToken();
            verifyToken.setUser(userRepository.findByEmail(email));
        }
        verifyToken.setToken(token);
        verifyToken.setExpiryDate(DateUtils.addMinutes(new Date(), VerificationToken.EXPIRATION));
        verifyRepo.save(verifyToken);
    }

    private void createVerificationToken(String token, User user) {
        VerificationToken verifyToken = verifyRepo.findByUserEmail(user.getEmail());
        if (verifyToken == null) {
            verifyToken = new VerificationToken();
            verifyToken.setUser(user);
        }
        verifyToken.setToken(token);
        verifyToken.setExpiryDate(DateUtils.addMinutes(new Date(), VerificationToken.EXPIRATION));
        verifyRepo.save(verifyToken);
    }

    @Override
    public List<UserDTO> getAll() {
        return MapperUtils.mapAll(userRepository.findAll(), UserDTO.class);
    }

    @Override
    public List<UserDTO> getAllIsEnabled() {
        return MapperUtils.mapAll(userRepository.findByEnabled(true), UserDTO.class);
    }

    @Override
    public User getByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    @Override
    public User getCurrentUser() {
        return userRepository.findByEmail(SecurityContextHolder.getContext().getAuthentication().getName());
    }

    @Override
    public boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    @Override
    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }

    @Override
    public boolean existsByPasswordAndToken(String password, String token) {
        User user = userRepository.findByVerificationTokenToken(token);
        return passwordEncoder.matches(password, user.getPassword());
    }

    @Override
    public boolean existsByEmailAndPassword(String email, String password) {
        User user = userRepository.findByEmail(email);
        return passwordEncoder.matches(password, user.getPassword());
    }

    @Override
    @Transactional
    public User register(Register register) throws UserAlreadyExistException, MessagingException {
        if (existsByEmail(register.getEmail())) {
            throw new UserAlreadyExistException("There is an account with that email address: " + register.getEmail());
        } else if (existsByUsername(register.getUsername())) {
            throw new UserAlreadyExistException("There is an account with that username: " + register.getUsername());
        }
        User user = new User();
        user.setUsername(register.getUsername());
        user.setPassword(passwordEncoder.encode(register.getPassword()));
        user.setEmail(register.getEmail());
        user.setFullname(register.getFullname());
        user.setEnabled(false);
        user.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        User userCreated = userRepository.save(user);

        Authority authority = new Authority();
        authority.setUser(userCreated);
        authority.setRole(roleRepository.findByName(Role.CUSTOMER));
        authorityRepository.save(authority);

        // Create verification token
        String token = "register:" + RandomString.make(21);
        createVerificationToken(token, userCreated);

        // Send email
        String to = register.getEmail();
        String subject = "Welcome to EShop";
        String body = "";
        try {
            Resource resource = resourceLoader.getResource("classpath:templates/user/email_register_success.html");
            Reader reader = new InputStreamReader(resource.getInputStream());
            body = FileCopyUtils.copyToString(reader)
                    .replace("${name}", register.getFullname())
                    .replace("${link}", paramUtils.getSiteURL() + "/verify?code=" + token);
        } catch (Exception e) {
            e.printStackTrace();
        }
        mailUtils.push(new MailInfo(MailUtils.FROM, to, subject, body));

        return userCreated;
    }

    @Override
    @Transactional
    public String verifyRegistrationWithToken(String verificationToken, Locale locale) {
        User user = userRepository.findByVerificationTokenToken(verificationToken);
        if (!verificationToken.contains("register") || user == null) {
            return messageUtils.getMessage("Auth.verificationToken.failed");
        }
        user.setEnabled(true);
        userRepository.save(user);
        verifyRepo.delete(verifyRepo.findByToken(verificationToken));
        return messageUtils.getMessage("Auth.verificationToken.success");
    }

    @Override
    public void sendTokenResetPassword(String email) throws UserNotFoundException, MessagingException {
        String token = RandomString.make(30);
        createVerificationToken(token, email);

        String resetPasswordLink = paramUtils.getSiteURL() + "/reset-password?token=" + token;
        MailInfo mailInfo = new MailInfo();
        mailInfo.setFrom(MailUtils.FROM);
        mailInfo.setTo(email);
        mailInfo.setSubject("Here's the link to reset your password");
        mailInfo.setBody(
                """
                            <p>Hello,</p>
                            <p>You have requested to reset your password.</p>
                            <p>Click the link below to change your password:</p>
                            <p><a href="${link}">Change my password</a></p>
                            <br>
                            <p>Ignore this email if you do remember your password,\s
                            or you have not made the request.</p>
                        """.replace("${link}", resetPasswordLink)
        );
        mailUtils.push(mailInfo);
    }

    @Override
    public boolean tokenValidation(String token) {
        VerificationToken resetPassToken = verifyRepo.findByToken(token);
        return isTokenFound(resetPassToken) || isTokenExpired(resetPassToken);
    }

    @Override
    @Transactional
    public void updatePasswordWithToken(String token, String newPassword) {
        User user = userRepository.findByVerificationTokenToken(token);
        user.setPassword(passwordEncoder.encode(newPassword));
        verifyRepo.delete(verifyRepo.findByToken(token));
        userRepository.save(user);
    }

    @Override
    @Transactional
    public User changePassword(User user, String newPassword) {
        user.setPassword(passwordEncoder.encode(newPassword));
        return userRepository.save(user);
    }

    @Override
    @Transactional
    public User updateProfile(User user, Profile profile) {
        user.setFullname(profile.getFullname());
        user.setAddress(profile.getAddress());
        user.setPhoneNumber(profile.getPhoneNumber());

        this.uploadFile(user, profile.getPhotoFile());

        return userRepository.save(user);
    }

    @Override
    @Transactional
    public User save(UserDTO userDTO) {
        User user = null;
        if (userDTO.getId() == null) {
            if (userRepository.existsByUsername(userDTO.getUsername())) {
                throw new RuntimeException(messageUtils.getMessage("NotExistsUsername"));
            }
            if (userRepository.existsByEmail(userDTO.getEmail())) {
                throw new RuntimeException(messageUtils.getMessage("NotExistsEmail"));
            }
            user = new User();
            user.setUsername(userDTO.getUsername());
            user.setEmail(userDTO.getEmail());
            user.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        } else {
            user = userRepository.findById(userDTO.getId()).orElse(null);
            if (!Objects.requireNonNull(user).getPassword().equals(userDTO.getPassword())) {
                user.setPassword(passwordEncoder.encode(userDTO.getPassword()));
            }
        }
        this.uploadFile(user, userDTO.getPhotoFile());
        user.setFullname(userDTO.getFullname());
        user.setAddress(userDTO.getAddress());
        user.setPhoneNumber(userDTO.getPhoneNumber());
        user.setEnabled(userDTO.getEnabled() != null);
        //user.setAdmin(userDTO.getIsAdmin() != null);

        return userRepository.save(user);
    }

    @Override
    @Transactional
    public void delete(Integer id) {
        userRepository.deleteById(id);
    }

    private void uploadFile(User user, MultipartFile photoFile) {
        if (photoFile.getOriginalFilename() != null && !photoFile.getOriginalFilename().isBlank()) {
            try {
                String path = new File("src/main/resources/static/assets/user/img/avatar/").getAbsolutePath();

                String fileName = user.getUsername() + "." + photoFile.getContentType().split("/")[1];
                user.setPhoto(fileName);
                photoFile.transferTo(new File(path + "/" + fileName));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
