package com.eshop.controller;

import com.eshop.dto.OrderDTO;
import com.eshop.entity.User;
import com.eshop.service.CartService;
import com.eshop.service.OrderService;
import com.eshop.service.UserService;
import com.eshop.utils.MapperUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class CartController {
    @Autowired
    CartService cartService;

    @Autowired
    OrderService orderService;

    @Autowired
    UserService userService;

    @Autowired
    ModelMapper mapper;

    @RequestMapping("/shopping-cart")
    public String showShoppingCartPage(Model model) {
        return "cart/shopping_cart";
    }

    @GetMapping("/shopping-cart/add-to-cart")
    public String addCart(@RequestParam("productId") Integer productId,
                        @RequestParam("quantity") Integer quantity) {
        cartService.addCart(productId, quantity);
        return "layout/fragments::#view-cart-fragment";
    }

    @RequestMapping("/checkout-detail")
    public String showCheckoutDetailPage(Model model) {
        User user = userService.getCurrentUser();
        model.addAttribute("user", user);
        return "cart/checkout_detail";
    }

    @GetMapping("/order-history")
    public String showOrderHistoryPage(Model model) {
        List<OrderDTO> orders = MapperUtils.mapAll(orderService.getByUser(), OrderDTO.class);
        model.addAttribute("orders", orders);
        return "cart/order_history";
    }
}
