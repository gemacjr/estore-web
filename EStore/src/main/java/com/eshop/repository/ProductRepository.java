package com.eshop.repository;

import com.eshop.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findByDiscountNotNull();
    Page<Product> findByDiscountNotNull(Pageable pageable);
    Page<Product> findByDiscountNotNullAndAvailable(Integer available, Pageable pageable);
    List<Product> findTop8ByOrderByCreatedDateDesc();
    List<Product> findByNameContainingAllIgnoreCase(String productName);
    List<Product> findByCategorySlug(String categorySlug);
    List<Product> findByBrandSlug(String brandSlug);
    Page<Product> findByCategorySlug(String slug, Pageable pageable);
    Page<Product> findByCategorySlugAndBrandSlug(String categorySlug, String brandSlug, Pageable pageable);
    List<Product> findByCategorySlugAndBrandSlug(String categorySlug, String brandSlug);
    Page<Product> findByCategorySlugAndBrandSlugAndAvailable(String categorySlug, String brandSlug, Integer available, Pageable pageable);
    Page<Product> findByCategorySlugContainingAndBrandSlugContainingAndAvailable(String categorySlug, String brandSlug, Integer available, Pageable pageable);
    Page<Product> findByCategorySlugAndAvailable(String slug, Integer available, Pageable pageable);
    Product findBySlug(String slug);
}
