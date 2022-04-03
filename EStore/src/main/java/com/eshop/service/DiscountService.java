package com.eshop.service;

import com.eshop.dto.DiscountDTO;
import com.eshop.entity.Discount;

import java.util.List;

public interface DiscountService {
    List<Discount> getByActivated();
    List<Discount> getByOrderBySaleOffAsc();
    List<Discount> getActivedOrderBySaleOffAsc(boolean isActive);
    List<Discount> getActivedOrderByCreateDateDesc(boolean isActive);
    Discount saveDiscount(DiscountDTO discountDTO);
    void deleteDiscount(Integer id);
}
