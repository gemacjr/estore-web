package com.eshop.service;

import com.eshop.entity.Category;

import java.util.List;

public interface CategoryService {
    List<Category> getAll();
    List<Category> getAllByBrand(String brandSlug);
    Category get(String categorySlug);
    Category get(Integer categoryId);
    Category update(Integer id, Category category);
    void remove(Integer id);
    Category create(Category category);
}
