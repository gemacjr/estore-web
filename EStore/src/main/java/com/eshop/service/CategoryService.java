package com.eshop.service;

import com.eshop.entity.Category;

import java.util.List;

public interface CategoryService {
    List<Category> getAll();
    List<Category> getByBrand(String brandSlug);
    Category getBySlug(String slug);
    void removeCategory(String slug);
    Category updateCategory(String slug, Category category);
    Category createCategory(Category category);
}
