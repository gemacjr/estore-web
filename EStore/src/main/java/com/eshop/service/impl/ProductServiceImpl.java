package com.eshop.service.impl;

import com.eshop.dto.ProductDTO;
import com.eshop.dto.ProductUpdated;
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
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {
    @Autowired
    ProductRepository productRepo;
    @Autowired
    CategoryRepository categoryRepo;
    @Autowired
    BrandRepository brandRepo;
    @Autowired
    DiscountRepository discountRepo;
    @Autowired
    ModelMapper mapper;

    @Override
    public List<Product> getAll() {
        return productRepo.findAll();
    }

    @Override
    public List<Product> getAllByBrand(String brandSlug) {
        return productRepo.findByBrandSlug(brandSlug);
    }

    @Override
    public List<Product> getAllByCategory(String categorySlug) {
        return productRepo.findByCategorySlug(categorySlug);
    }

    @Override
    public List<Product> getAllByCategoryAndBrand(String categorySlug, String brandSlug) {
        return productRepo.findByCategorySlugAndBrandSlug(categorySlug, brandSlug);
    }

    @Override
    public Page<Product> getAllByCategoryAndBrand(String categorySlug, String brandSlug, int page, int size, String direction) {
        Sort sort = Sort.by(direction.equalsIgnoreCase("ASC") ? Sort.Direction.ASC : Sort.Direction.DESC, "name");
        if (brandSlug.isBlank()) {
            return productRepo.findByCategorySlug(categorySlug, PageRequest.of(page, size, sort));
        } else {
            return productRepo.findByCategorySlugAndBrandSlug(categorySlug, brandSlug, PageRequest.of(page, size, sort));
        }
    }

    @Override
    public Product getProduct(String slug) {
        return productRepo.findBySlug(slug);
    }

    @Override
    public List<Product> getPromotionalProducts() {
        List<Product> products = productRepo.findByDiscountNotNull();
        if (products.size() == 0) {
            products = productRepo.findTop8ByOrderByCreatedDateDesc();
        }
        return products;
    }

    @Override
    public Page<ProductDTO> getPromotionalProducts(int page, int size) {
        Page<Product> products = productRepo.findByDiscountNotNull(PageRequest.of(page, size));
        if (products.getTotalElements() == 0) {
            List<Product> lstProduct = productRepo.findTop8ByOrderByCreatedDateDesc();
            products = new PageImpl<Product>(lstProduct, PageRequest.of(page, size), lstProduct.size());
        }
        return MapperUtils.mapAll(products, ProductDTO.class);
    }

    @Override
    public List<Product> getByProduct(String productName) {
        return productRepo.findByNameContainingAllIgnoreCase(productName);
    }

    @Override
    @Transactional
    public void remove(String slug) {
        productRepo.delete(productRepo.findBySlug(slug));
    }

    @Override
    @Transactional
    public ProductUpdated save(ProductUpdated productToSave) {
//        Product product = MapperUtils.map(productToSave, Product.class);
//        product.setCategory(categoryRepo.getById(Integer.parseInt(productToSave.getCategoryId())));
//        product.setBrand(brandRepo.getById(Integer.parseInt(productToSave.getBrandId())));
//        product.setCreatedDate(new Timestamp(System.currentTimeMillis()));
//        if (!productToSave.getDiscountId().isBlank()) {
//            product.setDiscount(discountRepo.getById(Integer.parseInt(productToSave.getDiscountId())));
//        } else {
//            product.setDiscount(null);
//        }
//        return MapperUtils.map(productRepo.save(product), ProductUpdated.class);
        return null;
    }
}
