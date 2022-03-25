package com.eshop.controller.rest;

import com.eshop.entity.ShoppingCart;
import com.eshop.service.CartService;
import com.eshop.utils.MessageUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@RestController
@CrossOrigin("*")
@RequestMapping("/shopping-cart")
public class CartRestController {
    @Autowired
    CartService cartService;
    @Autowired
    ModelMapper mapper;
    @Autowired
    MessageUtils messageUtils;

    @SuppressWarnings("rawtypes")
	@PostMapping("/add/{productId}")
    public ResponseEntity addToCart(@PathVariable("productId") Integer productId, @RequestBody Map<String, Object> data,
                                    Principal principal) {
        Map<String, Object> response = new HashMap<>();

        ShoppingCart result = cartService.addProductToCart(productId, Integer.parseInt(data.get("quantity").toString()));
        if (result == null) {
            String message = messageUtils.getMessage("ShoppingCart.addToCart.failed");
            response.put("status", "failed");
            response.put("message", message);
            return ResponseEntity.badRequest().body(response);
        } else {
            String message = messageUtils.getMessage("ShoppingCart.addToCart.success");
            response.put("status", "success");
            response.put("message", message);
            return ResponseEntity.ok().body(response);
        }
    }

    @SuppressWarnings("rawtypes")
	@PutMapping("/update/{id}")
    public ResponseEntity updateCart(@PathVariable("id") Integer cartId, @RequestBody Map<String, Object> data) {
        ShoppingCart result = cartService.updateProductInCart(cartId, Integer.parseInt(data.get("quantity").toString()));
        return result == null ? ResponseEntity.badRequest().build() : ResponseEntity.ok().build();
    }

    @SuppressWarnings("rawtypes")
	@DeleteMapping("/delete/{id}")
    public ResponseEntity deleteProductOfCart(@PathVariable("id") Integer id) {
        cartService.deleteProductFromCart(id);
        return ResponseEntity.ok().build();
    }
}
