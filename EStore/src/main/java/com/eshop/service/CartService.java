package com.eshop.service;

import com.eshop.entity.ShoppingCart;
import com.eshop.entity.User;

import java.util.List;

public interface CartService {
    List<ShoppingCart> getCartByUser(User user);

    ShoppingCart addCart(Integer productId, Integer quantity);

    ShoppingCart updateQuantity(Integer cartId, Integer quantity);

    void deleteCart(Integer cartId);
}
