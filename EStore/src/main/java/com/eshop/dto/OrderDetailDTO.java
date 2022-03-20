package com.eshop.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;

@Setter
@Getter
public class OrderDetailDTO implements Serializable {
    @Serial
    private static final long serialVersionUID = 5901705432273386833L;
    private Integer id;
    private ProductDTO product;
    private OrderDTO order;
    private Integer quantity;
    private Double price;

    public Double getSubtotal() {
        return price * quantity;
    }
}
