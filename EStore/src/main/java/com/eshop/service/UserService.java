package com.eshop.service;

import com.eshop.customer.exception.UserAlreadyExistException;
import com.eshop.customer.exception.UserNotFoundException;
import com.eshop.dto.UserDTO;
import com.eshop.dto.account.Profile;
import com.eshop.dto.account.Register;
import com.eshop.entity.User;

import javax.mail.MessagingException;
import java.util.List;
import java.util.Locale;

public interface UserService {
    List<UserDTO> getAll();
    User getByEmail(String email);
    User getCurrentUser();
    boolean existsByEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByPasswordAndToken(String username, String token);
    boolean existsByEmailAndPassword(String email, String password);
    boolean tokenValidation(String token);
    String verifyRegistrationWithToken(String verificationToken, Locale locale);
    void sendTokenResetPassword(String email) throws UserNotFoundException, MessagingException;
    void updatePasswordWithToken(String token, String newPassword);
    User register(Register user) throws UserAlreadyExistException, MessagingException;
    User changePassword(User user, String newPassword);
    User updateProfile(User user, Profile profile);
    User save(UserDTO userDTO);
    void delete(Integer id);
}
