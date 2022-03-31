package com.eshop.controller.api;

import com.eshop.entity.Brand;
import com.eshop.service.BrandService;
import com.eshop.utils.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/brands")
public class BrandRestController {
    @Autowired
    private BrandService brandService;
    @Autowired
    private MessageUtils messageUtils;

    @GetMapping
    public Iterable<Brand> getAllBrands() {
        return brandService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Brand> getBrand(@PathVariable(name = "id") Integer brandId) {
        Brand brand = brandService.getBrand(brandId);
        return brand == null ? ResponseEntity.notFound().build() : ResponseEntity.ok().body(brand);
    }

	@PostMapping
    public ResponseEntity<Brand> createBrand (@RequestBody Brand brand) {
        if (brandService.getBrand(brand.getSlug()) != null) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        }
        Brand newBrand = brandService.createBrand(brand);
        if (newBrand == null) {
            throw new RuntimeException(messageUtils.getMessage("SomethingWentWrong"));
        }
        return ResponseEntity.ok().body(brand);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> removeBrand (@PathVariable("id") Integer brandId) {
        brandService.removeBrand(brandId);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Brand> updateBrand (@PathVariable("id") Integer brandId, @RequestBody Brand brand) {
        if (brandService.getBrand(brandId) != null && !brandService.getBrand(brandId).getSlug().equals(brand.getSlug())) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        }
        if (brandService.updateBrand(brandId, brand) == null) {
            throw new RuntimeException(messageUtils.getMessage("SomethingWentWrong"));
        }
        return ResponseEntity.ok().body(brand);
    }

}
