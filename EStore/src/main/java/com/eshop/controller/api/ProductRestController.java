package com.eshop.controller.api;

import com.eshop.dto.ProductToSave;
import com.eshop.service.ProductService;
import com.eshop.utils.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/products")
public class ProductRestController {
    @Autowired
    private ProductService productService;
    @Autowired
    private MessageUtils messageUtils;

    @GetMapping
    public ResponseEntity<?> getAllProducts (@RequestParam(value = "category-slug", defaultValue = "") String categorySlug,
                                             @RequestParam(value = "brand-slug", defaultValue = "") String brandSlug) {
        return ResponseEntity.ok(productService.getAllByCategoryAndBrandIsLike(categorySlug, brandSlug));
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
