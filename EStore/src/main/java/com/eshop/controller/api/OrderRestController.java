package com.eshop.controller.api;

import com.eshop.entity.Order;
import com.eshop.service.OrderService;
import com.eshop.utils.MessageUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/order")
public class OrderRestController {
    @Autowired
    OrderService orderService;
    @Autowired
    MessageUtils messageUtils;
    @Autowired
    ModelMapper mapper;

    @SuppressWarnings("rawtypes")
	@PostMapping
    public ResponseEntity<Order> addOrder(@RequestBody Map<String, Object> data) {
        Map<String, Object> response = new HashMap<>();

        String fullname = (String) data.get("fullname");
        String phoneNumber = (String) data.get("phoneNumber");
        String address = (String) data.get("address");
        String email = (String) data.get("email");

        Order result = orderService.createOrder(fullname, email, address, phoneNumber);
        return result != null ? ResponseEntity.ok(result) : ResponseEntity.badRequest().build();
    }
}
