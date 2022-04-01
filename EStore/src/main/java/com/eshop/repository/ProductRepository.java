package com.eshop.repository;

import com.eshop.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findByDiscountNotNull();
    Page<Product> findByDiscountNotNull(Pageable pageable);
    List<Product> findTop8ByOrderByCreatedDateDesc();
    List<Product> findByNameContainingAllIgnoreCase(String name);
    List<Product> findByCategorySlugAndBrandSlug(String categorySlug, String brandSlug);
    List<Product> findByCategorySlugContainingAndBrandSlugContaining(String categorySlug, String brandSlug);
    Page<Product> findByCategorySlugAndBrandSlug(String categorySlug, String brandSlug, Pageable pageable);
    Page<Product> findByCategorySlug(String slug, Pageable pageable);
    Product findBySlug(String slug);
}
