package com.dealim;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
@EnableJpaAuditing
@SpringBootApplication
public class AddinTeam4Application {

    public static void main(String[] args) {
        ApplicationContext appContext = SpringApplication.run(AddinTeam4Application.class, args);
    }
}