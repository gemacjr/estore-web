package com.eshop.service.impl;

import com.eshop.entity.Brand;
import com.eshop.repository.BrandRepository;
import com.eshop.service.BrandService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BrandServiceImpl implements BrandService {
    @Autowired
    BrandRepository brandDAO;

    @Autowired
    ModelMapper mapper;

    @Override
    public List<Brand> getByCategory(String categorySlug) {
        return brandDAO.findDistinctByProductsCategorySlug(categorySlug);
    }

    @Override
    public List<Brand> getAll() {
        return brandDAO.findAll();
    }

    @Override
    public Brand getBrand(String slug) {
        return brandDAO.findBySlug(slug);
    }

    @Override
    public void createBrand(Brand brand) {
        brandDAO.save(brand);
    }

    @Override
    public void removeBrand(String slug){
        brandDAO.delete(brandDAO.findBySlug(slug));
    }

    @Override
    public Brand updateBrand(String slug, Brand brand) {
        Brand brandToUpdate = brandDAO.findBySlug(slug);
        if (brandToUpdate != null) {
            brandToUpdate.setName(brand.getName());
            brandToUpdate.setSlug(brand.getSlug());
            return brandDAO.save(brandToUpdate);
        }
        return null;
    }

}
