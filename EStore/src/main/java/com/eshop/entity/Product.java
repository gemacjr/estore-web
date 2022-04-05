// Generated with g9.

package com.eshop.entity;

import com.eshop.dto.ProductUpdated;
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

@NoArgsConstructor
@AllArgsConstructor
@Getter @Setter
@Entity
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id", nullable = false)
    private Integer id;

    @Column(name = "Name", nullable = false, length = 50)
    private String name;

    @Column(name = "Slug", nullable = false, length = 50)
    private String slug;

    @Column(name = "Image", nullable = false, length = 150)
    private String image;

    @Column(name = "ImagePreview1", nullable = false, length = 150)
    private String imagePreview1;

    @Column(name = "ImagePreview2", nullable = false, length = 150)
    private String imagePreview2;

    @Column(name = "ImagePreview3", nullable = false, length = 150)
    private String imagePreview3;

    @Column(name = "ImagePreview4", nullable = false, length = 150)
    private String imagePreview4;

    @Column(name = "VideoPreview", nullable = false, length = 150)
    private String videoPreview;

    @Lob
    @Column(name = "Description", nullable = false)
    private String description;

    @Column(name = "Quantity", nullable = false)
    private Integer quantity;

    @Column(name = "Price", nullable = false)
    private Double price;

    @Column(name = "CreatedDate", nullable = false)
    private Timestamp createdDate;

    @Column(name = "Available", nullable = false)
    private Integer available;

    @ManyToOne(optional = false)
    @JoinColumn(name = "CategoryId", nullable = false)
    private Category category;

    @ManyToOne(optional = false)
    @JoinColumn(name = "BrandId", nullable = false)
    private Brand brand;

    @ManyToOne
    @JoinColumn(name = "DiscountId")
    private Discount discount;

    @JsonIgnore
    @OneToMany(mappedBy = "product")
    private List<OrderDetail> orderDetails = new ArrayList<>();

    @JsonIgnore
    @OneToMany(mappedBy = "product")
    private Set<ShoppingCart> shoppingCarts = new LinkedHashSet<>();

    public ProductUpdated toProductUpdated () {
        ProductUpdated productUpdated = new ProductUpdated();
        productUpdated.setId(this.getId());
        productUpdated.setName(this.getName());
        productUpdated.setSlug(this.getSlug());
        productUpdated.setImage(this.getImage());
        productUpdated.setImagePreview1(this.getImagePreview1());
        productUpdated.setImagePreview2(this.getImagePreview2());
        productUpdated.setImagePreview3(this.getImagePreview3());
        productUpdated.setImagePreview4(this.getImagePreview4());
        productUpdated.setVideoPreview(this.getVideoPreview());
        productUpdated.setDescription(this.getDescription());
        productUpdated.setQuantity(this.getQuantity());
        productUpdated.setPrice(this.getPrice());
        productUpdated.setCreatedDate(this.getCreatedDate());
        productUpdated.setAvailable(this.getAvailable());
        productUpdated.setCategorySlug(this.getCategory().getSlug());
        productUpdated.setBrandSlug(this.getBrand().getSlug());
        productUpdated.setDiscountId(this.getDiscount() == null ? null : this.getDiscount().getId());
        return productUpdated;
    }

}
