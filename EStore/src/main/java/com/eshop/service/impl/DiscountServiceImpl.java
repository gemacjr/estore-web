package com.eshop.service.impl;

import com.eshop.dto.DiscountDTO;
import com.eshop.entity.Discount;
import com.eshop.repository.DiscountRepository;
import com.eshop.repository.ProductRepository;
import com.eshop.service.DiscountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Service
public class DiscountServiceImpl implements DiscountService {
    @Autowired
    private DiscountRepository discountRepository;
    @Autowired
    private ProductRepository productRepository;

    @Override
    public List<Discount> getByActivated() {
        return discountRepository.findByIsActive(true);
    }

    @Override
    public List<Discount> getByOrderBySaleOffAsc() {
        return discountRepository.findAllByOrderBySaleOffAsc();
    }

    @Override
    public List<Discount> getByOrderByCreateDateDesc() {
        return discountRepository.findAllByOrderByCreatedDateDesc();
    }

    @Override
    public List<Discount> getActivedOrderByCreateDateDesc(boolean isActive) {
        return discountRepository.findByIsActiveOrderByCreatedDateDesc(isActive);
    }

    @Override
    public List<Discount> getActivedOrderBySaleOffAsc(boolean isActive) {
        return discountRepository.findByIsActiveOrderBySaleOffAsc(isActive);
    }

    @Override
    @Transactional
    public Discount saveDiscount(DiscountDTO discountDTO) {
        Discount discount = null;
        if (discountDTO.getId() == null) {
            discount = new Discount();
            discount.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        } else {
            discount = discountRepository.findById(discountDTO.getId()).get();
        }
        discount.setSaleOff(discountDTO.getSaleOff());
        discount.setEndDate(discountDTO.getEndDate());
        discount.setStartDate(discountDTO.getStartDate());
        discount.setIsActive(true);
        discount.setName(discountDTO.getName());

        return discountRepository.save(discount);
    }

    @Override
    @Transactional
    public void deleteDiscount(Integer id) {
        Discount discount = discountRepository.findById(id).get();
        discount.setIsActive(false);
        discount.setEndDate(new Date());

        discount.getProducts().forEach(product -> {
            product.setDiscount(null);
            productRepository.save(product);
        });

        discountRepository.save(discount);
    }

    @Scheduled(fixedDelay = 5000, initialDelay = 10000)
    public void run() {
        // Deactivate the promotion when it expires
        List<Discount> discounts = discountRepository.findByIsActive(true);
        discounts.forEach(discount -> {
            if (discount.getEndDate().before(new Date())) {
                this.deleteDiscount(discount.getId());
            }
        });
    }
}
