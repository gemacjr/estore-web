package com.eshop.service.impl;

import com.eshop.dto.ProductDTO;
import com.eshop.dto.ProductToSave;
import com.eshop.entity.Product;
import com.eshop.repository.BrandRepository;
import com.eshop.repository.CategoryRepository;
import com.eshop.repository.DiscountRepository;
import com.eshop.repository.ProductRepository;
import com.eshop.service.ProductService;
import com.eshop.utils.MapperUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductRepository productRepo;
    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    BrandRepository brandRepository;
    @Autowired
    DiscountRepository discountRepository;
    @Autowired
    ModelMapper mapper;

    @Override
    public List<Product> getAll() {
        return productRepo.findAll();
    }

    @Override
    public Product getProduct(String slug) {
        return productRepo.findBySlug(slug);
    }

    @Override
    public List<Product> getPromotionalProducts() {
        return productRepo.findByDiscountNotNull();
    }

    @Override
    public Page<ProductDTO> getPromotionalProducts(int page, int size) {
        Page<Product> products = productRepo.findByDiscountNotNull(PageRequest.of(page, size));
        Page<ProductDTO> productDTOs = MapperUtils.mapAll(products, ProductDTO.class);
        return productDTOs;
    }

    @Override
    public List<Product> getByCategory(String categorySlug) {
        return productRepo.findByCategorySlug(categorySlug);
    }

    @Override
    public List<Product> getByProduct(String name) {
        return productRepo.findByNameContainingAllIgnoreCase(name);
    }

    @Override
    public List<Product> getByCategoryAndBrand(String categorySlug, String brandSlug) {
        return productRepo.findByCategorySlugAndBrandSlug(categorySlug, brandSlug);
    }

    @Override
    public Page<Product> getByCategoryAndBrand(String categorySlug, String brandSlug, int page, int size, String direction) {
        Sort sort = Sort.by(direction.equalsIgnoreCase("ASC") ? Sort.Direction.ASC : Sort.Direction.DESC, "name");
        if (brandSlug.isBlank()) {
            return productRepo.findByCategorySlug(categorySlug, PageRequest.of(page, size, sort));
        } else {
            return productRepo.findByCategorySlugAndBrandSlug(categorySlug, brandSlug, PageRequest.of(page, size, sort));
        }
    }

    @Override
    @Transactional
    public void remove(String slug) {
        productRepo.delete(productRepo.findBySlug(slug));
    }

    @Override
    @Transactional
    public ProductToSave save(ProductToSave productToSave) {
        Product product = MapperUtils.map(productToSave, Product.class);
        product.setCategory(categoryRepository.getById(Integer.parseInt(productToSave.getCategoryId())));
        product.setBrand(brandRepository.getById(Integer.parseInt(productToSave.getBrandId())));
        product.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        if (!productToSave.getDiscountId().isBlank()) {
            product.setDiscount(discountRepository.getById(Integer.parseInt(productToSave.getDiscountId())));
        } else {
            product.setDiscount(null);
        }
        return MapperUtils.map(productRepo.save(product), ProductToSave.class);
    }
}
