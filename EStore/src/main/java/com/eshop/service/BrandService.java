package com.eshop.service;

import com.eshop.entity.Brand;

import java.util.List;

public interface BrandService {
    List<Brand> getAll();
    List<Brand> getAllByCategory(String categorySlug);
    Brand get(Integer brandId);
    Brand get(String brandSlug);
    Brand updateBrand(Integer brandId, Brand brand);
    Brand createBrand(Brand brand);
    void removeBrand(Integer brandId);
}
