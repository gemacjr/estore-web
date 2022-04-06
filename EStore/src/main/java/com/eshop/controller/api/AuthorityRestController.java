package com.eshop.controller.api;

import com.eshop.entity.Authority;
import com.eshop.service.AuthorityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin(origins = "*")
@RequestMapping("/api/authorities")
public class AuthorityRestController {
    @Autowired
    private AuthorityService authorityService;

    @GetMapping
    public ResponseEntity<?> getAuthorities() {
        return ResponseEntity.ok(authorityService.getAll());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteAuthority(@PathVariable Long id) {
        authorityService.delete(id);
        return ResponseEntity.ok().build();
    }

    @PostMapping
    public ResponseEntity<?> createAuthority(@RequestBody Authority authority) {
        return ResponseEntity.ok(authorityService.save(authority));
    }


}
