package com.eshop.service;

import com.eshop.entity.Brand;

import java.util.List;

public interface BrandService {
    List<Brand> getAll();
    List<Brand> getAll(String categorySlug);
    Brand getBrand(Integer brandId);
    Brand getBrand(String brandSlug);
    Brand updateBrand(Integer brandId, Brand brand);
    Brand createBrand(Brand brand);
    void removeBrand(Integer brandId);
}
