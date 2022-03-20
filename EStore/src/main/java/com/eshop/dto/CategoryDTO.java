package com.eshop.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

@Getter @Setter
public class CategoryDTO implements Serializable {
    @Serial
    private static final long serialVersionUID = 430176719204800040L;
    private Integer id;
    private String nameVI;
    private String nameEN;
    private String slug;
    @JsonIgnore
    private List<ProductDTO> products;

    public double getTotalPrice() {
        return products.size() > 0 ? products.stream().mapToDouble(ProductDTO::getTotalPrice).sum() : 0;
    }
}
