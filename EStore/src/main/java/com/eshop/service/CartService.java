package com.eshop.service;

import com.eshop.entity.ShoppingCart;
import com.eshop.entity.User;

import java.util.List;

public interface CartService {
    List<ShoppingCart> getAllCartByUser(User user);

    ShoppingCart addProductToCart(Integer productId, Integer quantity);

    ShoppingCart updateProductInCart(Integer cartId, Integer quantity);

    void deleteProductFromCart(Integer cartId);
}
