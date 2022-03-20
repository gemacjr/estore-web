// Generated with g9.

package com.eshop.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@Entity
public class Brand {
    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="Id", unique=true, nullable=false, precision=10)
    private int id;
    @Column(name="Name", nullable=false, length=50)
    private String name;
    @Column(name = "Slug", nullable = false, length = 50)
    private String slug;
    @OneToMany(mappedBy = "brand")
    private List<Product> products = new ArrayList<>();

}
