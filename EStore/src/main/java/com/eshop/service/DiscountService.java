package com.eshop.service;

import com.eshop.dto.DiscountDTO;
import com.eshop.entity.Discount;

import java.util.List;

public interface DiscountService {
    List<Discount> getAll();
    List<Discount> getByActivated();
    List<Discount> getActived();
    List<Discount> getActivedOrderByCreateDateDesc(boolean isActive);
    Discount save(DiscountDTO discountDTO);
    Discount save(Discount discount);
    void delete(Integer discountId);
    void deleteFromDB(Integer discountId);
}
