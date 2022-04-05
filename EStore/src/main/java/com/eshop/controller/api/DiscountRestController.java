package com.eshop.controller.api;

import com.eshop.entity.Discount;
import com.eshop.service.DiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/discounts")
public class DiscountRestController {
    @Autowired
    private DiscountService discountService;

    @GetMapping
    public ResponseEntity<?> getAllDiscounts() {
        return ResponseEntity.ok(discountService.getAll());
    }

    @GetMapping("/active")
    public ResponseEntity<?> getDiscountsIsActive() {
        return ResponseEntity.ok(discountService.getActived());
    }

    @PostMapping
    public ResponseEntity<?> addDiscount(@RequestBody Discount discount) {
        return discountService.save(discount) != null ? ResponseEntity.ok(discount) : ResponseEntity.badRequest().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateDiscount(@PathVariable("id") int id, @RequestBody Discount discount) {
        return discountService.save(discount) != null ? ResponseEntity.ok(discount) : ResponseEntity.badRequest().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteDiscount(@PathVariable("id") int id) {
        try {
            discountService.deleteFromDB(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

}
