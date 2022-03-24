package com.eshop.controller;

import com.eshop.dto.OrderDTO;
import com.eshop.dto.ProductDTO;
import com.eshop.entity.User;
import com.eshop.service.CartService;
import com.eshop.service.OrderService;
import com.eshop.service.ProductService;
import com.eshop.service.UserService;
import com.eshop.utils.MapperUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
public class HomeController {
    @Autowired
    ProductService productService;

    @Autowired
    CartService cartService;

    @Autowired
    OrderService orderService;

    @Autowired
    UserService userService;

    @Autowired
    ModelMapper mapper;

    @RequestMapping("/")
    public String index() {
        return "redirect:/home";
    }

    @RequestMapping("/home")
    public String showHomePage(Model model, @RequestParam("p") Optional<Integer> p) {
        int page = p.orElse(0);
        int size = 8;

        Page<ProductDTO> discountProducts = productService.getPromotionalProducts(page, size);

        model.addAttribute("discountProducts", discountProducts);
        return "home/index";
    }

    @RequestMapping("/shopping-cart")
    public String showShoppingCartPage(Model model) {
        return "product/shopping-cart";
    }

    @RequestMapping("/checkout-detail")
    public String showCheckoutDetailPage(Model model) {
        User user = userService.getCurrentUser();
        model.addAttribute("user", user);
        return "product/checkout-detail";
    }

    @GetMapping("/order-history")
    public String showOrderHistoryPage(Model model) {
        List<OrderDTO> orders = MapperUtils.mapAll(orderService.getByUser(), OrderDTO.class);
        model.addAttribute("orders", orders);
        return "product/order-history";
    }

    @GetMapping("/error/403")
    public String showError403Page() {
        return "error/403";
    }
}
