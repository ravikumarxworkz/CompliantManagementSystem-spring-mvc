package com.modal.complaintManagementSystem.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.modal.complaintManagementSystem.utils.GeneratePassword;

import lombok.extern.slf4j.Slf4j;

@Configuration
@ComponentScan("com.modal.complaintManagementSystem")
@Slf4j
public class WebConfiguration implements WebMvcConfigurer {

	public WebConfiguration() {
		log.info("this the weconfiguration constructor");

	}

	@Bean
	public GeneratePassword generatePassword() {
		return new GeneratePassword();
	}

	@Bean
	public InternalResourceViewResolver viewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix(".jsp");
		return resolver;
	}

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
	    registry.addResourceHandler("/res/css/**").addResourceLocations("/Resources/css/");
	    registry.addResourceHandler("/res/images/**").addResourceLocations("/Resources/images/");
	    registry.addResourceHandler("/res/js/**").addResourceLocations("/Resources/js/");
	    registry.addResourceHandler("/res/**").addResourceLocations("/Resources/");
	}


	@Bean(name = "multipartResolver")
	public CommonsMultipartResolver getCommonsMultipartResolver() {
		log.info("Registering the multipart resolver in to spring");
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
		multipartResolver.setMaxUploadSize(20971520); // 20MB
		multipartResolver.setMaxInMemorySize(1048576); // 1MB
		return multipartResolver;
	}
	
	  @Override
	    public void addCorsMappings(CorsRegistry registry) {
	        registry.addMapping("/**")
	                .allowedOrigins("http://127.0.0.1:5500")
	                .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
	                .allowedHeaders("*")
	                .allowCredentials(true);
	    }

}
