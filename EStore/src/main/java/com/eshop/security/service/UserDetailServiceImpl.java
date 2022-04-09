package com.eshop.security.service;

import com.eshop.entity.User;
import com.eshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailServiceImpl implements UserDetailsService {
    @Autowired
    UserService userService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userService.getByEmail(username);
        if (user == null) {
            throw new UsernameNotFoundException("No user found with email: " + username);
        }
        return new UserDetailsImpl(user);
    }
}
