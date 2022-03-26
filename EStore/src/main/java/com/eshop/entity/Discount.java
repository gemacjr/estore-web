// Generated with g9.

package com.eshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.io.Serial;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@Entity
public class Discount implements Serializable {
    @Serial
    private static final long serialVersionUID = 4419901573202170305L;

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

    @JsonIgnore
    @OneToMany(mappedBy = "discount", fetch = FetchType.EAGER)
    private List<Product> products = new ArrayList<>();

}
