package com.eshop.dto;

import lombok.Getter;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;

@Setter @Getter
public class OrderDTO implements Serializable {
    @Serial
    private static final long serialVersionUID = -632534675735237345L;
    private Integer id;
    private String orderCode;
    private Timestamp createdDate;
    private Integer status;
    private String address;
    private String fullname;
    private String phoneNumber;
    private String email;
    private List<OrderDetailDTO> orderDetails;

    public Double getTotal(){
        return orderDetails.stream().mapToDouble(orderDetail -> orderDetail.getPrice() * orderDetail.getQuantity()).sum();
    }
}
