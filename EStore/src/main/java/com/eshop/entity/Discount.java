// Generated with g9.

package com.eshop.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@Entity
public class Discount {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id", nullable = false)
    private Integer id;

    @Column(name = "Name", nullable = false, length = 50)
    private String name;

    @Column(name = "SaleOff", nullable = false)
    private Double saleOff;

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Column(name = "StartDate", nullable = false)
    private Date startDate;

    @DateTimeFormat(pattern = "dd/MM/yyyy")
    @Column(name = "EndDate", nullable = false)
    private Date endDate;

    @Column(name = "IsActive", nullable = false)
    private Boolean isActive = false;

    @Column(name = "CreatedDate", nullable = false)
    private Date createdDate;

    @OneToMany(mappedBy = "discount", fetch = FetchType.EAGER)
    private List<Product> products = new ArrayList<>();

}
