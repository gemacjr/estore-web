package com.eshop.security;

import com.eshop.security.handler.AuthenticationFailureHandlerCustom;
import com.eshop.security.handler.LoginSuccessHandlerCustom;
import com.eshop.security.jwt.AuthEntryPointJwt;
import com.eshop.security.jwt.AuthTokenFilter;
import com.eshop.security.service.UserDetailServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
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
    private DataSource dataSource;

    @Autowired
    private AuthEntryPointJwt unauthorizedHandler;

    @Bean
    public AuthTokenFilter authenticationJwtTokenFilter() {
        return new AuthTokenFilter();
    }

    @Bean
    public UserDetailsService userDetailService() {
        return new UserDetailServiceImpl();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
    
    @Bean
    public AuthenticationSuccessHandler successHandler() {
        return new LoginSuccessHandlerCustom("/home");
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
        return new AuthenticationFailureHandlerCustom();
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable()
            .cors().disable();
        http.authorizeRequests()
                .antMatchers("/", "/assets/**", "/login/**", "/logout/**", "/register/**", "/home/**", "/product-list/**",
                        "/product-detail/**", "/forgot-password/**", "/verify", "/reset-password/**", "/error/**").permitAll()
                /*.antMatchers( "/change-password/**", "/user-profile/**", "/order-history/**",
                        "/checkout-detail/**").access("hasAnyRole('ROLE_CUSTOMER', 'ROLE_STAFF', 'ROLE_DIRECTOR')")*/
                .antMatchers( "/shopping-cart/**", "/api/carts").access("hasRole('ROLE_CUSTOMER')")
                .antMatchers( "/dashboard/**").access("hasAnyRole('ROLE_STAFF', 'ROLE_DIRECTOR')")
                .anyRequest().authenticated();
        http.formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/home", false)
                .successHandler(successHandler());
                //.failureHandler(authenticationFailureHandler())
        http.exceptionHandling()
                .accessDeniedPage("/error/forbidden");
        //        .authenticationEntryPoint(unauthorizedHandler);
        http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
        http.logout()
				.deleteCookies("JSESSIONID")
    			.permitAll();
        http.rememberMe()
    	        .key("uniqueAndSecret")
    	        .tokenRepository(persistentTokenRepository())
    	        .userDetailsService(userDetailService())
    	        .tokenValiditySeconds(24 * 60 * 60);

        //http.addFilterBefore(authenticationJwtTokenFilter(), UsernamePasswordAuthenticationFilter.class);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(authenticationProvider());
    }

}
