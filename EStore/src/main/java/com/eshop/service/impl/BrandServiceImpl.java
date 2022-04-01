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
    public List<Brand> getAllByCategory(String categorySlug) {
        return brandRepo.findDistinctByProductsCategorySlug(categorySlug);
    }

    @Override
    public List<Brand> getAll() {
        return brandRepo.findAll();
    }

    @Override
    public Brand get(Integer brandId) {
        return brandRepo.getById(brandId);
    }

    @Override
    public Brand get(String brandSlug) {
        return brandRepo.findBySlug(brandSlug);
    }

    @Override
    @Transactional
    public Brand createBrand(Brand brand) {
        return brandRepo.save(brand);
    }

    @Override
    @Transactional
    public void removeBrand(Integer brandId) {
        brandRepo.delete(brandRepo.getById(brandId));
    }

    @Override
    @Transactional
    public Brand updateBrand(Integer brandId, Brand brand) {
        Brand brandToUpdate = brandRepo.getById(brandId);
        brandToUpdate.setName(brand.getName());
        brandToUpdate.setSlug(brand.getSlug());
        return brandRepo.save(brandToUpdate);
    }

}
