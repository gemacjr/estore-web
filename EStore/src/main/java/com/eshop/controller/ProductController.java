package com.eshop.controller;

import com.eshop.dto.BrandDTO;
import com.eshop.dto.CategoryDTO;
import com.eshop.dto.ProductDTO;
import com.eshop.service.BrandService;
import com.eshop.service.CategoryService;
import com.eshop.service.ProductService;
import com.eshop.utils.MapperUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Optional;

@Controller
public class ProductController {
    @Autowired
    ProductService productService;
    @Autowired
    CategoryService categoryService;
    @Autowired
    BrandService brandService;
    @Autowired
    HttpServletRequest request;
    @Autowired
    ModelMapper mapper;

    @RequestMapping("/product-list")
    public String productListByCategory(
            Model model,
            @RequestParam("p") Optional<Integer> p,
            @RequestParam("orderBy") Optional<String> orderByOptional,
            @RequestParam("category") Optional<String> categorySlugOptional,
            @RequestParam("brand") Optional<String> brandSlugOptional
    ) {
        int page = p.orElse(0);
        int size = 6;
        String direction = orderByOptional.orElse("ASC");
        String categorySlug = categorySlugOptional.orElse("phone");
        String brandSlug = brandSlugOptional.orElse("");

        Page<ProductDTO> productPage = productService.getAllByCategoryAndBrand(categorySlug, brandSlug, page, size, direction)
                .map(product -> mapper.map(product, ProductDTO.class));

        model.addAttribute("direction", direction);
        model.addAttribute("productPage", productPage);
        model.addAttribute("category", MapperUtils.map(categoryService.get(categorySlug), CategoryDTO.class));
        model.addAttribute("brands", MapperUtils.mapAll(brandService.getAllByCategory(categorySlug), BrandDTO.class));
        return "product/list";
    }

    @RequestMapping("/product-search")
    public String productSearch(Model model, @RequestParam("keyword") String kw) {
        if (kw.isBlank()) {
            return "redirect:/home";
        }
        List<ProductDTO> products = MapperUtils.mapAll(productService.getByProduct(kw), ProductDTO.class);
        model.addAttribute("products", products);
        model.addAttribute("keyword", kw);
        return "product/search";
    }

    @RequestMapping("/product-detail/{productSlug}")
    public String productDetail(
            Model model,
            @PathVariable("productSlug") String productSlug
    ) {
        model.addAttribute("discountProducts", MapperUtils.mapAll(productService.getTop8Products(), ProductDTO.class));
        ProductDTO product = MapperUtils.map(productService.getProduct(productSlug), ProductDTO.class);
        model.addAttribute("product", product);
        return "product/detail";
    }
}
