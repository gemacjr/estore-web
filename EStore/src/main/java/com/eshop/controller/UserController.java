package com.eshop.controller;

import com.eshop.dto.account.*;
import com.eshop.entity.User;
import com.eshop.service.UserService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.IOException;
import java.util.Objects;


@Controller
public class UserController {
    @Autowired
    UserService userService;

    @Autowired
    MessageSource messages;

    @Autowired
    HttpServletRequest request;

    @Autowired
    LocaleResolver localeResolver;

    @Autowired
    ModelMapper mapper;

    @Autowired
    ServletContext app;

    @GetMapping("/login")
    public String getLogin(HttpServletRequest request) {
        String referrer = request.getHeader("Referer");
        request.getSession().setAttribute("url_prior_login", referrer);
        return "user/login";
    }

    @GetMapping("/register")
    public String showRegisterPage(WebRequest request, @ModelAttribute("user") Register user) {
        return "user/register";
    }

    @PostMapping("/register")
    public String processRegister(@ModelAttribute("user") @Valid Register register, Errors errors, Model model,
                                  RedirectAttributes redirectAttributes) throws Exception {
        if (errors.hasErrors()) {
            return "user/register";
        }

        if (userService.register(register) != null) {
            String title = messages.getMessage("home.verify_account.title", null, localeResolver.resolveLocale(request));
            String note = messages.getMessage("home.verify_account.note", null, localeResolver.resolveLocale(request));
            model.addAttribute("titlePage", title);
            model.addAttribute("note", note);
            return "user/verify";
        } else {
            String message = messages.getMessage("Auth.login.failed", null, localeResolver.resolveLocale(request));
            model.addAttribute("failed", message);
            return "user/register";
        }
    }

    @RequestMapping("/verify")
    public String veriryRegister(@RequestParam("code") String verifyToken, Model model) {
        String message = userService.verifyRegistrationWithToken(verifyToken, localeResolver.resolveLocale(request));
        model.addAttribute("titlePage", message);
        return "user/verify";
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordPage(@ModelAttribute("forgotPass") ForgotPass forgotPass) {
        return "user/forgot_password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@ModelAttribute("forgotPass") @Valid ForgotPass forgotPass, Errors errors, Model model) {
        if (errors.hasErrors()) {
            return "user/forgot_password";
        }
        try {
            userService.sendTokenResetPassword(forgotPass.getEmail());

            String message = messages.getMessage("Auth.forgotPassword.info", null, localeResolver.resolveLocale(request));
            model.addAttribute("message", message);
        } catch (Exception ex) {
            model.addAttribute("error", ex.getMessage());
        }

        return "user/forgot-password";
    }

    @GetMapping("/reset-password")
    public String showResetPasswordPage(@ModelAttribute("resetPass") ResetPass resetPass, @RequestParam("token") String token,
            Model model) {
        if (userService.tokenValidation(token)) {
            String message = messages.getMessage("Auth.verificationToken.failed", null, localeResolver.resolveLocale(request));
            model.addAttribute("error", message);
        }
        return "user/reset_password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(@ModelAttribute("resetPass") @Valid ResetPass resetPass, Errors errors, Model model) {
        if (errors.hasErrors()) {
            errors.getGlobalErrors().forEach(error -> {
                String message = messages.getMessage(Objects.requireNonNull(error.getCode()), null, localeResolver.resolveLocale(request));
                model.addAttribute(error.getCode(), message);
            });
            return "user/reset-password";
        }
        if (userService.tokenValidation(resetPass.getToken())) {
            String message = messages.getMessage("Auth.verificationToken.failed", null, localeResolver.resolveLocale(request));
            model.addAttribute("error", message);
            return "user/reset-password";
        } else {
            userService.updatePasswordWithToken(resetPass.getToken(), resetPass.getPassword());
            String message = messages.getMessage("Auth.resetPassword.success", null, localeResolver.resolveLocale(request));
            model.addAttribute("titlePage", message);
            return "user/verify";
        }
    }

    @GetMapping("/change-password")
    @PreAuthorize("isAuthenticated()")
    public String showChangePasswordPage(@ModelAttribute("changePass") ChangePass changePass, Model model) {
        return "user/change_password";
    }

    @PostMapping("/change-password")
    public String processChangePassword(@ModelAttribute("changePass") @Valid ChangePass changePass, Errors errors, Model model) {
        if (errors.hasErrors()) {
            errors.getGlobalErrors().forEach(error -> {
                String message = messages.getMessage(Objects.requireNonNull(error.getCode()), null, localeResolver.resolveLocale(request));
                model.addAttribute(error.getCode(), message);
            });
            return "user/change-password";
        }
        User user = userService.getCurrentUser();
        User result = userService.changePassword(user, changePass.getNewPassword());
        if (result != null) {
            String message = messages.getMessage("Auth.changePass.success", null, localeResolver.resolveLocale(request));
            model.addAttribute("success", message);
        } else {
            String message = messages.getMessage("Auth.changePass.failed", null, localeResolver.resolveLocale(request));
            model.addAttribute("failed", message);
        }
        return "user/change_password";
    }

    @GetMapping("/user-profile")
    @PreAuthorize("isAuthenticated()")
    public String showUserProfilePage(@ModelAttribute("profile") Profile profile, Model model) {
        User user = userService.getCurrentUser();
        profile = mapper.map(user, Profile.class);
        model.addAttribute("profile", profile);
        return "user/profile-info";
    }

    @PostMapping("/user-profile")
    public String updateProfile(@ModelAttribute("profile") @Valid Profile profile, Errors errors, Model model) throws IOException {
        User user = userService.getCurrentUser();

        if (errors.hasErrors()) {
            model.addAttribute("profile", profile);
            return "user/profile-info";
        }
        User result = userService.updateProfile(user, profile);
        if (result != null) {
            profile = mapper.map(result, Profile.class);
            model.addAttribute("profile", profile);
            String message = messages.getMessage("Auth.updateProfile.success", null, localeResolver.resolveLocale(request));
            model.addAttribute("success", message);
        } else {
            String message = messages.getMessage("Auth.updateProfile.failed", null, localeResolver.resolveLocale(request));
            model.addAttribute("failed", message);
        }
        return "user/profile_info";
    }

}
