package com.eshop.controller.api;

import com.eshop.service.DiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/discounts")
public class DiscountRestController {
    @Autowired
    private DiscountService discountService;

    @GetMapping
    public ResponseEntity<?> getDiscounts() {
        return ResponseEntity.ok(discountService.getActivedOrderBySaleOffAsc(true));
    }

}
