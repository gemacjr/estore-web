package com.eshop.controller.admin;

import com.eshop.dto.CategoryDTO;
import com.eshop.entity.Category;
import com.eshop.service.CategoryService;
import com.eshop.utils.MapperUtils;
import com.eshop.utils.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/category-manager")
public class CategoryManagerController {
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private MessageUtils messageUtils;

    @SuppressWarnings("rawtypes")
    @PostMapping("/")
    public ResponseEntity createCategory (@RequestBody CategoryDTO categoryDTO) {
        if (categoryService.getBySlug(categoryDTO.getSlug()) != null) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        }
        Category category = MapperUtils.map(categoryDTO, Category.class);
        categoryService.createCategory(category);
        return ResponseEntity.ok().build();
    }
    @GetMapping("/{slug}")
    public CategoryDTO getCategory (@PathVariable("slug") String categorySlug) {
        return MapperUtils.map(categoryService.getBySlug(categorySlug), CategoryDTO.class);
    }
    @SuppressWarnings("rawtypes")
    @DeleteMapping("/{slug}")
    public ResponseEntity removeCategory (@PathVariable("slug") String categorySlug) {
        categoryService.removeCategory(categorySlug);
        return ResponseEntity.ok().build();
    }
    @PutMapping("/{slug}")
    public CategoryDTO updateCategory (@PathVariable("slug") String categorySlug, @RequestBody CategoryDTO categoryDTO) {
        Category category = MapperUtils.map(categoryDTO, Category.class);
        if (categoryService.getBySlug(categorySlug) != null && !categorySlug.equals(categoryDTO.getSlug())) {
            throw new RuntimeException(messageUtils.getMessage("NotExistsSlug"));
        }
        return MapperUtils.map(categoryService.updateCategory(categorySlug, category), CategoryDTO.class);
    }
}
