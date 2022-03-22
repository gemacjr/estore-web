package com.eshop.controller.admin.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.eshop.dto.BrandDTO;
import com.eshop.entity.Brand;
import com.eshop.service.BrandService;
import com.eshop.utils.MapperUtils;
import com.eshop.utils.MessageUtils;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/brand-manager")
public class BrandManagerController {
    @Autowired
    private BrandService brandService;
    @Autowired
    private MessageUtils messageUtils;

    @SuppressWarnings("rawtypes")
	@PostMapping("/")
    public ResponseEntity createBrand (@RequestBody BrandDTO brandDTO) {
        if (brandService.getBrand(brandDTO.getSlug()) != null) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        }
        Brand brand = MapperUtils.map(brandDTO, Brand.class);
        brandService.createBrand(brand);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/{slug}")
    public BrandDTO getBrand(@PathVariable(name = "slug") String brandSlug) {
        return MapperUtils.map(brandService.getBrand(brandSlug), BrandDTO.class);
    }

    @SuppressWarnings("rawtypes")
    @DeleteMapping("/{slug}")
    public ResponseEntity removeBrand (@PathVariable("slug") String brandSlug) {
        brandService.removeBrand(brandSlug);
        return ResponseEntity.ok().build();
    }
    @PutMapping("/{slug}")
    public BrandDTO updateBrand (@PathVariable("slug") String brandSlug, @RequestBody BrandDTO brandDTO) {
        Brand brand = MapperUtils.map(brandDTO, Brand.class);
        if (brandService.getBrand(brandSlug) != null && !brandSlug.equals(brandDTO.getSlug())) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        }
        return MapperUtils.map(brandService.updateBrand(brandSlug, brand), BrandDTO.class);
    }

}
