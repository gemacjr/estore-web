package com.eshop.controller;

import com.eshop.dto.ProductDTO;
import com.eshop.service.ProductService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class HomeController {
    @Autowired
    ProductService productService;

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

    @GetMapping("/error/forbidden")
    public String showError403Page() {
        return "error/forbidden";
    }
}
