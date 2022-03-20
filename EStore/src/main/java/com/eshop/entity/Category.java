// Generated with g9.

package com.eshop.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serial;
import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Setter @Getter
@Entity
public class Category {
	@Serial
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id", nullable = false)
    private Integer id;

    @Column(name = "NameVI", nullable = false, length = 50)
    private String nameVI;

    @Column(name = "NameEN", nullable = false, length = 50)
    private String nameEN;

    @Column(name = "Slug", nullable = false, length = 50)
    private String slug;

    @OneToMany(mappedBy = "category")
    private List<Product> products = new ArrayList<>();

}
