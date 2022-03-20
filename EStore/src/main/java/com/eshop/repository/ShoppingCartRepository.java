package com.eshop.repository;

import com.eshop.entity.Product;
import com.eshop.entity.ShoppingCart;
import com.eshop.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ShoppingCartRepository extends JpaRepository<ShoppingCart, Integer> {
    public List<ShoppingCart> findByUser(User user);
    public ShoppingCart findByUserAndProduct(User user, Product product);
    public Boolean existsByUserAndProduct(User user, Product product);
}