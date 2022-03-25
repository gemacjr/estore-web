package com.eshop.customer;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

public class CustomerLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
    public CustomerLoginSuccessHandler(String defaultTargetUrl) {
        setDefaultTargetUrl(defaultTargetUrl);
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session != null) {
            String redirectUrl = (String) session.getAttribute("url_prior_login");
            if (redirectUrl != null && !isUrlNotRedirect(redirectUrl)) {
                // we do not forget to clean this attribute from session
                session.removeAttribute("url_prior_login");
                // then we redirect
                getRedirectStrategy().sendRedirect(request, response, redirectUrl);
            } else {
                super.onAuthenticationSuccess(request, response, authentication);
            }
        } else {
            super.onAuthenticationSuccess(request, response, authentication);
        }
    }

    private Boolean isUrlNotRedirect(String redirectUrl) {
        List<String> urlsNotRedirect = Arrays.asList("/login", "/register", "/reset-password", "/verify", "/change-password",
                "forgot-password");
        for (String url : urlsNotRedirect) {
            if (redirectUrl.contains(url)) {
                return true;
            }
        }
        return false;
    }
}
