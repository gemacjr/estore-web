package com.eshop.service;

import com.eshop.dto.ProductDTO;
import com.eshop.dto.ProductToSave;
import com.eshop.entity.Product;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ProductService {
    List<Product> getPromotionalProducts();
    List<Product> getByProduct(String productName);
    List<Product> getAll();
    List<Product> getAll(Integer categoryId, Integer brandId);
    List<Product> getAll(String categorySlug, String brandSlug);
    Page<Product> getAll(String categorySlug, String brandSlug, int page, int size, String direction);
    Page<ProductDTO> getPromotionalProducts(int page, int size);
    Product getProduct(String slug);
    ProductToSave save(ProductToSave product);
    void remove(String slug);
}