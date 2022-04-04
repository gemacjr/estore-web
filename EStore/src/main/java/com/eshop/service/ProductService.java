package com.eshop.service;

import com.eshop.dto.ProductDTO;
import com.eshop.dto.ProductUpdated;
import com.eshop.entity.Product;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ProductService {
    List<Product> getPromotionalProducts();
    List<Product> getByProduct(String productName);
    List<Product> getAll();
    List<ProductUpdated> getAllByCategoryAndBrand(String categorySlug, String brandSlug);
    Page<Product> getAllByCategoryAndBrand(String categorySlug, String brandSlug, int page, int size, String direction);
    Page<ProductDTO> getPromotionalProducts(int page, int size);
    Product getProduct(String slug);
    ProductUpdated save(ProductUpdated product);
    void remove(String slug);
}