package com.eshop.controller.api;

import com.eshop.dto.ProductUpdated;
import com.eshop.entity.Product;
import com.eshop.service.ProductService;
import com.eshop.utils.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/products")
public class ProductRestController {
    @Autowired
    private ProductService productService;
    @Autowired
    private MessageUtils messageUtils;

    @GetMapping
    public ResponseEntity<?> getAllProducts (@RequestParam(value = "category", required = false) String categorySlug,
                                             @RequestParam(value = "brand", required = false) String brandSlug) {
        List<Product> products = null;
        if (!categorySlug.isBlank() && !brandSlug.isBlank()) {
            products = productService.getAllByCategoryAndBrand(categorySlug, brandSlug);
        } else if (!categorySlug.isBlank()) {
            products = productService.getAllByCategory(categorySlug);
        } else if (!brandSlug.isBlank()) {
            products = productService.getAllByBrand(brandSlug);
        } else {
            products = productService.getAll();
        }
        return ResponseEntity.ok(products);
    }

    @DeleteMapping("/{slug}")
    public ResponseEntity<?> removeProduct (@PathVariable("slug") String productSlug) {
        try {
            productService.remove(productSlug);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException(messageUtils.getMessage("SomethingWentWrong"));
        }
    }

    @PutMapping("/{slug}")
    public ProductUpdated updateProduct (@PathVariable("slug") String productSlug, @RequestBody ProductUpdated product) {
        if (productService.getProduct(product.getSlug()) != null && !productSlug.equals(product.getSlug())) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        } else {
            return productService.save(product);
        }
    }

    @PostMapping("/{slug}")
    public ProductUpdated createProduct (@RequestBody ProductUpdated product) {
        if (productService.getProduct(product.getSlug()) != null) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        } else {
            return productService.save(product);
        }
    }
}
