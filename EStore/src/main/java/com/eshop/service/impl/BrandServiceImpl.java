package com.eshop.service.impl;

import com.eshop.entity.Brand;
import com.eshop.repository.BrandRepository;
import com.eshop.service.BrandService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class BrandServiceImpl implements BrandService {
    @Autowired
    BrandRepository brandRepo;

    @Autowired
    ModelMapper mapper;

    @Override
    public List<Brand> getByCategory(String categorySlug) {
        return brandRepo.findDistinctByProductsCategorySlug(categorySlug);
    }

    @Override
    public List<Brand> getAll() {
        return brandRepo.findAll();
    }

    @Override
    public Brand getBrand(String slug) {
        return brandRepo.findBySlug(slug);
    }

    @Override
    @Transactional
    public void createBrand(Brand brand) {
        brandRepo.save(brand);
    }

    @Override
    @Transactional
    public void removeBrand(String slug){
        brandRepo.delete(brandRepo.findBySlug(slug));
    }

    @Override
    @Transactional
    public Brand updateBrand(String slug, Brand brand) {
        Brand brandToUpdate = brandRepo.findBySlug(slug);
        if (brandToUpdate != null) {
            brandToUpdate.setName(brand.getName());
            brandToUpdate.setSlug(brand.getSlug());
            return brandRepo.save(brandToUpdate);
        }
        return null;
    }

}
