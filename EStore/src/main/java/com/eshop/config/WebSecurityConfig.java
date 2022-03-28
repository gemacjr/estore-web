package com.eshop.config;

import com.eshop.customer.CustomerAuthenticationFailureHandler;
import com.eshop.customer.CustomerLoginSuccessHandler;
import com.eshop.customer.CustomerUserDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    DataSource dataSource;

    @Bean
    public UserDetailsService userDetailService() {
        return new CustomerUserDetailService();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return new CustomerLoginSuccessHandler("/home");
    }
    
    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
    	DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
    	
    	authProvider.setUserDetailsService(userDetailService());
    	authProvider.setPasswordEncoder(passwordEncoder());
    	
    	return authProvider;
    }

    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
        tokenRepository.setDataSource(dataSource);
        return tokenRepository;
    }

    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        return new CustomerAuthenticationFailureHandler();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .cors().disable();
        http.authorizeRequests()
                .antMatchers("/", "/assets/**", "/login/**", "/logout/**", "/register/**", "/home/**", "/product-list/**",
                        "/product-detail/**", "/forgot-password/**", "/verify", "/reset-password/**", "/error/**", "/api/**").permitAll()
                .antMatchers( "/change-password/**", "/user-profile/**", "/shopping-cart/**",
                        "/order-history/**", "/checkout-detail/**").access("hasAnyRole('ROLE_STAFF', 'ROLE_CUSTOMER', 'ROLE_DIRECTOR')")
                .antMatchers( "/admin/**").access("hasAnyRole('ROLE_DIRECTOR')")
                .anyRequest().authenticated();
        http.formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/home", false)
                .successHandler(successHandler());
                //.failureHandler(authenticationFailureHandler())
        http.logout()
				.deleteCookies("JSESSIONID")
    			.permitAll();
        http.exceptionHandling().accessDeniedPage("/error/forbidden");
        http.rememberMe()
    	        .key("uniqueAndSecret")
    	        .tokenRepository(persistentTokenRepository())
    	        .userDetailsService(userDetailService())
    	        .tokenValiditySeconds(24 * 60 * 60);
        		
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authenticationProvider());
    }
}
