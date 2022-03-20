package com.eshop.controller.admin;

import com.eshop.dto.UserDTO;
import com.eshop.entity.User;
import com.eshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/user-manager")
public class UserManagerController {
    @Autowired
    private UserService userService;

    @RequestMapping("/save-user")
    public User saveUser(@ModelAttribute UserDTO user) {
        return userService.save(user);
    }

    @DeleteMapping("/{id}")
    public void deleteUser(@PathVariable Integer id) {
        userService.delete(id);
    }

}
