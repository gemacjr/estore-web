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
    CategoryRepository categoryRepo;

    @Autowired
    ModelMapper mapper;

    @Override
    public List<Category> getAll() {
        return categoryRepo.findAll();
    }

    @Override
    public List<Category> getAllByBrand(String brandSlug) {
        return categoryRepo.findDistinctByProductsBrandSlug(brandSlug);
    }

    @Override
    public Category get(String categorySlug) {
        return categoryRepo.findBySlug(categorySlug);
    }

    @Override
    public Category get(Integer categoryId) {
        return categoryRepo.getById(categoryId);
    }

    @Override
    @Transactional
    public void remove(Integer id) {
        Category category = categoryRepo.getById(id);
        categoryRepo.delete(category);
    }

    @Override
    @Transactional
    public Category update(Integer id, Category category) {
        Category categoryToUpdate = categoryRepo.getById(id);
        categoryToUpdate.setNameEN(category.getNameEN());
        categoryToUpdate.setNameVI(category.getNameVI());
        categoryToUpdate.setSlug(category.getSlug());
        return categoryRepo.save(categoryToUpdate);
    }

    @Override
    @Transactional
    public Category create(Category category) {
        return categoryRepo.save(category);
    }

}
