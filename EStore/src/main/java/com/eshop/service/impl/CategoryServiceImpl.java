package com.eshop.service.impl;

import com.eshop.entity.Category;
import com.eshop.repository.CategoryRepository;
import com.eshop.service.CategoryService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    CategoryRepository categoryDAO;

    @Autowired
    ModelMapper mapper;

    @Override
    public List<Category> getAll() {
        return categoryDAO.findAll();
    }

    @Override
    public List<Category> getByBrand(String brandSlug) {
        return categoryDAO.findDistinctByProductsBrandSlug(brandSlug);
    }

    @Override
    public Category getBySlug(String slug) {
        return categoryDAO.findBySlug(slug);
    }

    @Override
    @Transactional
    public void removeCategory(String slug) {
        Category category = categoryDAO.findBySlug(slug);
        if (category != null) {
            categoryDAO.delete(category);
        }
    }

    @Override
    @Transactional
    public Category updateCategory(String slug, Category category) {
        Category categoryToUpdate = categoryDAO.findBySlug(slug);
        if (categoryToUpdate != null) {
            categoryToUpdate.setNameEN(category.getNameEN());
            categoryToUpdate.setNameVI(category.getNameVI());
            categoryToUpdate.setSlug(category.getSlug());
            return categoryDAO.save(categoryToUpdate);
        }
        return null;
    }

    @Override
    @Transactional
    public Category createCategory(Category category) {
        return categoryDAO.save(category);
    }

}
