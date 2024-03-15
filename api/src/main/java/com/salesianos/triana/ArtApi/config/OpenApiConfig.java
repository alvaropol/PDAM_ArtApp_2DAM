package com.salesianos.triana.appbike.config;

import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.info.License;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class OpenApiConfig {
    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("ArtApi Spring Boot 3 API -------")
                        .version("1.0")
                        .description("Api for virtual art gallery app")
                        .license(new License().name("Alvaro Polonio Fullstack Developer").url("https://github.com/alvaropol/ArtApp")));
    }

}