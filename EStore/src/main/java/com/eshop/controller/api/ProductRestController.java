package com.eshop.controller.api;

import com.eshop.dto.ProductUpdated;
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
    public ResponseEntity<?> getAllProducts (@RequestParam(value = "category", defaultValue = "") String categorySlug,
                                             @RequestParam(value = "brand", defaultValue = "") String brandSlug) {
        List<ProductUpdated> products = productService.getAllByCategoryAndBrand(categorySlug, brandSlug);
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

    @PutMapping("/{id}")
    public ProductUpdated updateProduct (@PathVariable("id") Integer productId, @RequestBody ProductUpdated product) {
        if (productService.getProduct(product.getSlug()) != null && !productService.getProduct(product.getSlug()).getId().equals(productId)) {
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
