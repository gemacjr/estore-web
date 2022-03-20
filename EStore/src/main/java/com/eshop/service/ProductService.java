package com.eshop.service;

import com.eshop.dto.ProductDTO;
import com.eshop.dto.ProductToSave;
import com.eshop.entity.Product;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ProductService {
    List<Product> getAll();
    Product getProduct(String slug);
    List<Product> getPromotionalProducts();
    Page<ProductDTO> getPromotionalProducts(int page, int size);
    List<Product> getByCategory(String categorySlug);
    List<Product> getByProduct(String name);
    List<Product> getByCategoryAndBrand(String categorySlug, String brandSlug);
    Page<Product> getByCategoryAndBrand(String categorySlug, String brandSlug, int page, int size, String direction);
    void remove(String slug);
    ProductToSave save(ProductToSave product);
}