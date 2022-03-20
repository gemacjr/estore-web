package com.eshop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serial;
import java.io.Serializable;

@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class OrderReport implements Serializable {
    @Serial
    private static final long serialVersionUID = 2519303109255895880L;
    @Id
    private int status;
    private Long quantity;
}
