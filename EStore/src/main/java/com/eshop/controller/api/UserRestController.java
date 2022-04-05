package com.eshop.controller.api;

import com.eshop.dto.UserDTO;
import com.eshop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/users")
public class UserRestController {
    @Autowired
    private UserService userService;

    @GetMapping
    public ResponseEntity<?> getAll() {
        List<UserDTO> users = userService.getAllIsEnabled();
        return ResponseEntity.ok(users);
    }

   @PutMapping("/{id}")
    public ResponseEntity<?> update(@PathVariable Integer id, @RequestBody UserDTO userDTO) {
        return ResponseEntity.ok(userService.save(userDTO));
    }

    @PostMapping
    public ResponseEntity<?> save(@RequestBody UserDTO userDTO) {
        return ResponseEntity.ok(userService.save(userDTO));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> delete(@PathVariable Integer id) {
        userService.delete(id);
        return ResponseEntity.ok().build();
    }
}
