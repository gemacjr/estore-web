package com.eshop.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.LocaleResolver;

import javax.servlet.http.HttpServletRequest;

@Service
public class MessageUtils {
    @Autowired
    HttpServletRequest request;
    @Autowired
    LocaleResolver localeResolver;
    @Autowired
    MessageSource messages;

    public String getMessage(String code, Object[] args) {
        return messages.getMessage(code, args, localeResolver.resolveLocale(request));
    }

    public String getMessage(String code) {
        return getMessage(code, null);
    }
}
