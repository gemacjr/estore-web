package com.eshop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductToSave implements Serializable {
    @Serial
    private static final long serialVersionUID = -1631116986209408405L;
    private Integer id;
    private String name;
    private String slug;
    private String image;
    private String imagePreview1;
    private String imagePreview2;
    private String imagePreview3;
    private String imagePreview4;
    private String videoPreview;
    private String description;
    private Integer quantity;
    private Double price;
    private Integer available;
    private String categoryId;
    private String brandId;
    private String discountId;
}
