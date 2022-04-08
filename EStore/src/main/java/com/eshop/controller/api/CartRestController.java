package com.eshop.controller.api;

import com.eshop.entity.ShoppingCart;
import com.eshop.service.CartService;
import com.eshop.service.UserService;
import com.eshop.utils.MessageUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/carts")
public class CartRestController {
    @Autowired
    CartService cartService;
    @Autowired
    UserService userService;
    @Autowired
    ModelMapper mapper;
    @Autowired
    MessageUtils messageUtils;

    @GetMapping
    public ResponseEntity<List<ShoppingCart>> getCart(Authentication auth) {
        List<ShoppingCart> result = cartService.getCartByUser(userService.getByEmail(auth.getName()));
        return ResponseEntity.ok().body(result);
    }

    @PostMapping
    public ResponseEntity<ShoppingCart> addCart(@RequestBody Map<String, Object> data) {
        Integer productId = Integer.parseInt(data.get("productId").toString());
        Integer quantity = Integer.parseInt(data.get("quantity").toString());

        ShoppingCart result = cartService.addCart(productId, quantity);
        return result == null ? ResponseEntity.badRequest().build() : ResponseEntity.ok().body(result);
    }

	@PutMapping("/{cartId}")
    public ResponseEntity<ShoppingCart> updateQuantity(@PathVariable("cartId") Integer cartId, @RequestBody Map<String, Object> data) {
        ShoppingCart result = cartService.updateQuantity(cartId, Integer.parseInt(data.get("quantity").toString()));
        return result == null ? ResponseEntity.badRequest().build() : ResponseEntity.ok().body(result);
    }

	@DeleteMapping("/{cartId}")
    public ResponseEntity<Void> deleteCart(@PathVariable("cartId") Integer cartId) {
        cartService.deleteCart(cartId);
        return ResponseEntity.ok().build();
    }
}
