package com.eshop.custom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.web.servlet.LocaleResolver;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;

public class CustomAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {
    @Autowired
    private MessageSource messages;

    @Autowired
    private LocaleResolver localeResolver;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        setDefaultFailureUrl("/login?error");
        super.onAuthenticationFailure(request, response, exception);

        //System.out.println(exception.getMessage());

        Locale locale = localeResolver.resolveLocale(request);
        String errorMessage = "";
        if (exception.getMessage().equals("Bad credentials")) {
            errorMessage = messages.getMessage("AbstractUserDetailsAuthenticationProvider.badCredentials", null, locale);
        } else if (exception.getMessage().equals("User is disabled")) {
            errorMessage = messages.getMessage("AbstractUserDetailsAuthenticationProvider.disabled", null, locale);
        }

        request.getSession().setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, errorMessage);
    }

}
