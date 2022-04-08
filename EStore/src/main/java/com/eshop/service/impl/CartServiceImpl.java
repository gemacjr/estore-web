package com.eshop.service.impl;

import com.eshop.entity.Product;
import com.eshop.entity.ShoppingCart;
import com.eshop.entity.User;
import com.eshop.repository.ProductRepository;
import com.eshop.repository.ShoppingCartRepository;
import com.eshop.repository.UserRepository;
import com.eshop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.List;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    ShoppingCartRepository cartRepo;

    @Autowired
    ProductRepository productRepo;

    @Autowired
    UserRepository userRepo;

    @Override
    public List<ShoppingCart> getCartByUser(User user) {
        return cartRepo.findByUser(user);
    }

    @Override
    @Transactional
    public ShoppingCart addCart(Integer productId, Integer quantity) {
        User user = userRepo.findByEmail(SecurityContextHolder.getContext().getAuthentication().getName());
        Product product = productRepo.getById(productId);

        ShoppingCart cart = cartRepo.findByUserAndProduct(user, product);
        if (cart == null) {
            cart = new ShoppingCart();
            cart.setUser(user);
            cart.setProduct(product);
            cart.setCreatedDate(new Timestamp(System.currentTimeMillis()));
            cart.setQuantity(quantity);
        } else {
            cart.setQuantity(cart.getQuantity() + quantity);
        }

        return cartRepo.save(cart);

    }

    @Override
    @Transactional
    public void deleteCart(Integer cartId) {
        cartRepo.delete(cartRepo.getById(cartId));
    }

    @Override
    @Transactional
    public ShoppingCart updateQuantity(Integer cartId, Integer quantity) {
        ShoppingCart cart = cartRepo.getById(cartId);
        if (cart.getProduct().getQuantity() < quantity) {
            if (LocaleContextHolder.getLocale().getLanguage().equals("vi")) {
                throw new RuntimeException("Số lượng sản phẩm không đủ (" + cart.getProduct().getQuantity() + " sản phẩm có sẵn)");
            } else {
                throw new RuntimeException("The quantity of product is not enough (" + cart.getProduct().getQuantity() + " product available)");
            }

        }
        cart.setQuantity(quantity);
        return cartRepo.save(cart);
    }
}
