package com.eshop.service.impl;

import com.eshop.dto.OrderReport;
import com.eshop.dto.SaleReport;
import com.eshop.entity.*;
import com.eshop.repository.OrderDetailRepository;
import com.eshop.repository.OrderRepository;
import com.eshop.repository.ShoppingCartRepository;
import com.eshop.repository.UserRepository;
import com.eshop.service.OrderService;
import com.eshop.utils.MailUtils;
import com.eshop.utils.ParamUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    OrderDetailRepository orderDetailRepo;
    @Autowired
    UserRepository userRepo;
    @Autowired
    ShoppingCartRepository cartRepo;
    @Autowired
    ModelMapper mapper;
    @Autowired
    ParamUtils paramUtils;
    @Autowired
    MailUtils mailUtils;

    @Override
    public List<Order> getByUser() {
        return orderRepository.findByUser(userRepo.findByEmail(SecurityContextHolder.getContext().getAuthentication().getName()));
    }

    @Override
    public List<Order> getAll() {
        return orderRepository.findAll();
    }

    @Override
    public List<OrderReport> getOrderReports() {
        return orderRepository.findOrderReports();
    }

    @Override
    public List<SaleReport> getSaleReports() {
        return orderRepository.findSaleReports();
    }

    @Override
    public List<SaleReport> getSaleReports(Date startDate, Date endDate) {
        return orderRepository.findSaleReports(startDate, endDate);
    }

    @Override
    @Transactional
    public void createOrder(String fullname, String email, String address, String phoneNumber) {
        User user = userRepo.findByEmail(SecurityContextHolder.getContext().getAuthentication().getName());

        // Create order
        Order order = new Order();
        order.setUser(user);
        order.setCreatedDate(new Timestamp(System.currentTimeMillis()));
        order.setOrderCode(RandomStringUtils.randomAlphanumeric(11));
        order.setStatus(0);
        order.setFullname(fullname);
        order.setEmail(email);
        order.setAddress(address);
        order.setPhoneNumber(phoneNumber);
        Order savedOrder = orderRepository.save(order);

        // Create order details
        List<ShoppingCart> productsInCart = cartRepo.findByUser(user);
        for (ShoppingCart product : productsInCart) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(savedOrder);
            orderDetail.setProduct(product.getProduct());
            orderDetail.setQuantity(product.getQuantity());
            orderDetail.setPrice(product.getProduct().getPrice());
            orderDetailRepo.save(orderDetail);
        }

        // Delete all products in cart
        cartRepo.deleteAll(productsInCart);

        try {
            String link = paramUtils.getSiteURL() + "/order-history";
            MailInfo mailInfo = new MailInfo();
            mailInfo.setFrom(MailUtils.FROM);
            mailInfo.setTo(email);
            mailInfo.setSubject("Order confirmation letter");
            mailInfo.setBody(
                    """
                        <p>Hello,</p>
                        <p>Your order has been placed.</p>
                        <p>Your order code is <a href="${link}">${codeOrder}</a></p>
                        <br>
                    """ .replace("${link}", link)
                            .replace("${codeOrder}", order.getOrderCode())
            );
            mailUtils.push(mailInfo);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
