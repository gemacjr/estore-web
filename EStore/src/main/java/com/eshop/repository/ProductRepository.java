package com.eshop.repository;

import com.eshop.entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    List<Product> findByDiscountNotNull();
    Page<Product> findByDiscountNotNull(Pageable pageable);
    List<Product> findTop8ByDiscountNotNullOrderByDiscountCreatedDateDesc();
    List<Product> findByNameContainingAllIgnoreCase(String name);
    List<Product> findByCategorySlugAndBrandSlug(String slug, String brand);
    Page<Product> findByCategorySlugAndBrandSlug(String slug, String brand, Pageable pageable);
    List<Product> findByCategorySlug(String slug);
    Page<Product> findByCategorySlug(String slug, Pageable pageable);
    Product findBySlug(String slug);
}
