package com.eshop.repository;

import com.eshop.entity.Category;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CategoryRepository extends JpaRepository<Category, Integer> {
    public Category findBySlug(String slug);
    public List<Category> findDistinctByProductsBrandSlug(String brandSlug);
}