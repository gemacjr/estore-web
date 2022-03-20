package com.eshop.service;

import com.eshop.dto.OrderReport;
import com.eshop.dto.SaleReport;
import com.eshop.entity.Order;

import java.util.Date;
import java.util.List;

public interface OrderService {
    List<Order> getByUser();
    List<Order> getAll();
    List<OrderReport> getOrderReports();
    List<SaleReport> getSaleReports();
    List<SaleReport> getSaleReports(Date startDate, Date endDate);
    void createOrder(String fullname, String email, String address, String phoneNumber);
}
