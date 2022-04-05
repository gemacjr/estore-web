package com.eshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "\"User\"")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id", nullable = false)
    private Integer id;

    @Column(name = "Username", nullable = false, length = 50)
    private String username;

    @Column(name = "Password", nullable = false, length = 128)
    private String password;

    @Column(name = "Fullname", nullable = false, length = 128)
    private String fullname;

    @Column(name = "Email", nullable = false, length = 128)
    private String email;

    @Column(name = "Address")
    private String address;

    @Column(name = "PhoneNumber", length = 10)
    private String phoneNumber;

    @Column(name = "Photo", length = 128)
    private String photo;

    @Column(name = "CreatedDate", nullable = false)
    private Timestamp createdDate;

    @Column(name = "Enabled", nullable = false)
    private boolean enabled = true;

    @OneToOne(mappedBy = "user")
    private VerificationToken verificationToken;

    @JsonIgnore
    @OneToMany(mappedBy = "user")
    private List<ShoppingCart> shoppingCarts = new ArrayList<>();

    @JsonIgnore
    @OneToMany(mappedBy = "user")
    private List<Order> orders = new ArrayList<>();

    @JsonIgnore
    @OneToMany(mappedBy = "user", fetch = FetchType.EAGER)
    private Set<Authority> authorities = new LinkedHashSet<>();

}