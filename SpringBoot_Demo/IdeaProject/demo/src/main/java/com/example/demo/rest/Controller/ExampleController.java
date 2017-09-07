package com.example.demo.rest.Controller;

/**
 * Created by Matring on 9/7/17.
 */
import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;
@RestController @EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
public class ExampleController {
    @RequestMapping("/index")
    String home( @RequestParam(required = false, defaultValue = "") String name) {
        return "Hello " + name + "!";
    }
}

