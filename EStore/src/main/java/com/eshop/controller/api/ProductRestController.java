package com.eshop.controller.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.eshop.dto.ProductToSave;
import com.eshop.service.ProductService;
import com.eshop.utils.MessageUtils;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/product-manager")
public class ProductRestController {
    @Autowired
    private ProductService productService;
    @Autowired
    private MessageUtils messageUtils;

    @DeleteMapping("/{slug}")
    @SuppressWarnings("rawtypes")
    public ResponseEntity removeProduct (@PathVariable("slug") String productSlug) {
        try {
            productService.remove(productSlug);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @PutMapping("/{slug}")
    public ProductToSave updateProduct (@PathVariable("slug") String productSlug, @RequestBody ProductToSave product) {
        if (productService.getProduct(product.getSlug()) != null && !productSlug.equals(product.getSlug())) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        } else {
            return productService.save(product);
        }
    }

    @PostMapping("/{slug}")
    public ProductToSave createProduct (@RequestBody ProductToSave product) {
        if (productService.getProduct(product.getSlug()) != null) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        } else {
            return productService.save(product);
        }
    }
}
