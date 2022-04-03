package com.eshop.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.eshop.dto.DiscountDTO;
import com.eshop.entity.Discount;
import com.eshop.service.DiscountService;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/discount-manager")
public class DiscountRest2Controller {
    @Autowired
    private DiscountService discountService;

    @SuppressWarnings("rawtypes")
    @RequestMapping("/save")
    public ResponseEntity saveDiscount(@ModelAttribute DiscountDTO discountDTO) {
        Discount discount = discountService.saveDiscount(discountDTO);
        if (discount != null) {
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @SuppressWarnings("rawtypes")
    @DeleteMapping("/{id}")
    public ResponseEntity deleteDiscount(@PathVariable Integer id) {
        try{
            discountService.deleteDiscount(id);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().build();
        }
    }

}
