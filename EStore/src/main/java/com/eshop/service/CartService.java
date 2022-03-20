package com.eshop.service;

import com.eshop.entity.ShoppingCart;

import java.util.List;

public interface CartService {
    List<ShoppingCart> getAllProductsInCart();

    ShoppingCart addProductToCart(Integer productId, Integer quantity);

    ShoppingCart updateProductInCart(Integer cartId, Integer quantity);

    void deleteProductFromCart(Integer cartId);
}
