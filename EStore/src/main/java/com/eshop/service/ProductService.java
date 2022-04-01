package com.eshop.service;

import com.eshop.dto.ProductDTO;
import com.eshop.dto.ProductToSave;
import com.eshop.entity.Product;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ProductService {
    List<Product> getPromotionalProducts();
    List<Product> getByProduct(String productName);
    List<Product> getAllByCategoryAndBrand();
    List<Product> getAllByCategoryAndBrandIsLike(String categorySlug, String brandSlug);
    List<Product> getAllByCategoryAndBrand(String categorySlug, String brandSlug);
    Page<Product> getAllByCategoryAndBrand(String categorySlug, String brandSlug, int page, int size, String direction);
    Page<ProductDTO> getPromotionalProducts(int page, int size);
    Product getProduct(String slug);
    ProductToSave save(ProductToSave product);
    void remove(String slug);
}