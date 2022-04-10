package com.eshop.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Getter @Setter
@ToString
public class DiscountDTO implements Serializable {
    @Serial
    private static final long serialVersionUID = 5918300763169469894L;
    private Integer id;
    private String name;
    private Double saleOff;
    @DateTimeFormat(pattern = "dd/MM/yyyy")
    private Date startDate;
    @DateTimeFormat(pattern = "dd/MM/yyyy")
    private Date endDate;
    private Date createdDate;
    @JsonIgnore
    private List<ProductDTO> products;
}
