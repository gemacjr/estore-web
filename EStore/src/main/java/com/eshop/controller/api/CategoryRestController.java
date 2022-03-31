package com.eshop.controller.api;

import com.eshop.entity.Category;
import com.eshop.service.CategoryService;
import com.eshop.utils.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/categories")
public class CategoryRestController {
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private MessageUtils messageUtils;

    @GetMapping
    public Iterable<Category> getAllCategories() {
        return categoryService.getAll();
    }

    @GetMapping("/{id}")
    public Category getCategory(@PathVariable("id") Integer categoryId) {
        return categoryService.get(categoryId);
    }

    @PostMapping
    public ResponseEntity<Category> createCategory(@RequestBody Category category) {
        if (categoryService.get(category.getSlug()) != null) {
            throw new IllegalArgumentException(messageUtils.getMessage("NotExistsSlug"));
        }
        if (categoryService.create(category) == null) {
            throw new IllegalArgumentException(messageUtils.getMessage("SomethingWentWrong"));
        }
        return ResponseEntity.ok().body(category);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Category> updateCategory(@PathVariable("id") Integer categoryId, @RequestBody Category category) {
        if (categoryService.get(category.getSlug()) != null && !categoryService.get(category.getSlug()).getId().equals(categoryId)) {
            throw new IllegalArgumentException(messageUtils.getMessage("NotExistsSlug"));
        }
        if (categoryService.update(categoryId, category) == null) {
            throw new IllegalArgumentException(messageUtils.getMessage("SomethingWentWrong"));
        }
        return ResponseEntity.ok().body(category);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Category> removeCategory(@PathVariable("id") Integer categoryId) {
        categoryService.remove(categoryId);
        return ResponseEntity.ok().build();
    }
}
