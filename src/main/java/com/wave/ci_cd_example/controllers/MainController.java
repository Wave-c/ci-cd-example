package com.wave.ci_cd_example.controllers;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import reactor.core.publisher.Mono;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
@RequestMapping("/api")
public class MainController {
    @GetMapping("/hello")
    public Mono<ResponseEntity<String>> hello() {
        return Mono.just(ResponseEntity.ok("Hello, World!"));
    }
    
}
