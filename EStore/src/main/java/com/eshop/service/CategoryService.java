package com.eshop.service;

import com.eshop.entity.Category;

import java.util.List;

public interface CategoryService {
    List<Category> getAll();
    List<Category> getAll(String brandSlug);
    Category get(String slug);
    Category get(Integer id);
    Category update(Integer id, Category category);
    void remove(Integer id);
    void create(Category category);
}
