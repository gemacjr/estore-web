package com.eshop.config;

import com.eshop.component.GlobalInterceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {
    @Autowired
    GlobalInterceptor global;

    /**
     * Cấu hình cho phép GlobalInterceptor chạy khi request đến mọi URL ngoại trừ
     * các URL đến tài nguyên tĩnh (js, css, images…) đặt trong thư mục assets
     */
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(global)
                .addPathPatterns("/**")
                .excludePathPatterns("/assets/**");
    }

}
