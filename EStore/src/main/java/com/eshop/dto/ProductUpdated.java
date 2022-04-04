package com.eshop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;
import java.sql.Timestamp;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductUpdated implements Serializable {
    @Serial
    private static final long serialVersionUID = -1631116986209408405L;
    private Integer id;
    private String name;
    private String slug;
    private String image = "https://firebasestorage.googleapis.com/v0/b/poly-java-6-43318.appspot.com/o/box-512.png?alt=media&token=8f9eb547-8a18-44be-a35d-f5b74edcaf48";
    private String imagePreview1 = "https://firebasestorage.googleapis.com/v0/b/poly-java-6-43318.appspot.com/o/box-512.png?alt=media&token=8f9eb547-8a18-44be-a35d-f5b74edcaf48";
    private String imagePreview2 = "https://firebasestorage.googleapis.com/v0/b/poly-java-6-43318.appspot.com/o/box-512.png?alt=media&token=8f9eb547-8a18-44be-a35d-f5b74edcaf48";
    private String imagePreview3 = "https://firebasestorage.googleapis.com/v0/b/poly-java-6-43318.appspot.com/o/box-512.png?alt=media&token=8f9eb547-8a18-44be-a35d-f5b74edcaf48";
    private String imagePreview4 = "https://firebasestorage.googleapis.com/v0/b/poly-java-6-43318.appspot.com/o/box-512.png?alt=media&token=8f9eb547-8a18-44be-a35d-f5b74edcaf48";
    private String videoPreview;
    private String description;
    private Integer quantity;
    private Double price;
    private Integer available;
    private String categorySlug;
    private String brandSlug;
    private Integer discountId;
    private Timestamp createdDate;

}
