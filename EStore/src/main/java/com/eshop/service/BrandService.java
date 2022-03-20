package com.eshop.service;

import com.eshop.entity.Brand;

import java.util.List;

public interface BrandService {
    List<Brand> getByCategory(String categorySlug);
    List<Brand> getAll();
    Brand getBrand(String slug);
    Brand updateBrand(String slug, Brand brand);
    void createBrand(Brand brand);
    void removeBrand(String slug);
}
