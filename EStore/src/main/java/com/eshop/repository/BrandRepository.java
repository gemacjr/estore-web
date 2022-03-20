package com.eshop.repository;

import com.eshop.entity.Brand;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BrandRepository extends JpaRepository<Brand, Integer> {
    Brand findBySlug(String slug);
    List<Brand> findDistinctByProductsCategorySlug(String categorySlug);
}