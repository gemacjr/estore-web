package com.eshop.repository;

import com.eshop.entity.Discount;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DiscountRepository extends JpaRepository<Discount, Integer> {
    List<Discount> findByIsActive(boolean isActive);
    List<Discount> findAllByOrderBySaleOffAsc();
    List<Discount> findAllByOrderByCreatedDateDesc();
    List<Discount> findByIsActiveOrderBySaleOffAsc(boolean isActive);
    List<Discount> findByIsActiveOrderByCreatedDateDesc(boolean isActive);
}