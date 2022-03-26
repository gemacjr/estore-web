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
@RequestMapping("/api/shopping-cart")
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
        List<ShoppingCart> result = cartService.getAllCartByUser(userService.getByEmail(auth.getName()));
        return ResponseEntity.ok().body(result);
    }

    @PostMapping
    public ResponseEntity<ShoppingCart> addToCart(@RequestBody Map<String, Object> data) {
        Integer productId = Integer.parseInt(data.get("productId").toString());
        Integer quantity = Integer.parseInt(data.get("quantity").toString());

        ShoppingCart result = cartService.addProductToCart(productId, quantity);
        return result == null ? ResponseEntity.badRequest().build() : ResponseEntity.ok().body(result);
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
