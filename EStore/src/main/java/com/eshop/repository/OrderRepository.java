package com.eshop.repository;

import com.eshop.dto.OrderReport;
import com.eshop.dto.SaleReport;
import com.eshop.entity.Order;
import com.eshop.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Integer> {
    List<Order> findByUser(User user);

    @Query(
        """
        select new OrderReport (o.status, count(o))
        from Order o
        group by o.status
        """
    )
    List<OrderReport> findOrderReports();

    @Query(
            """
            select new SaleReport (od.product.category, sum(od.quantity * od.price), sum(od.quantity))
            from OrderDetail od
            where od.order.status = 1
            group by od.product.category
            """
    )
    List<SaleReport> findSaleReports();

    @Query(
            """
            select new SaleReport (od.product.category, sum(od.quantity * od.price), sum(od.quantity))
            from OrderDetail od
            where od.order.status = 1 and od.order.createdDate >= ?1 and od.order.createdDate <= ?2
            group by od.product.category
            """
    )
    List<SaleReport> findSaleReports(Date startDate, Date endDate);
}