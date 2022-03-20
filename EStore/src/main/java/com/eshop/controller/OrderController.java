package com.eshop.controller;

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
@RequestMapping("/order")
public class OrderController {
    @Autowired
    OrderService orderService;
    @Autowired
    MessageUtils messageUtils;
    @Autowired
    ModelMapper mapper;

    @SuppressWarnings("rawtypes")
	@PostMapping("/add")
    public ResponseEntity addOrder(@RequestBody Map<String, Object> data) {
        Map<String, Object> response = new HashMap<>();
        String fullname = (String) data.get("fullname");
        String phoneNumber = (String) data.get("phoneNumber");
        String address = (String) data.get("address");
        String email = (String) data.get("email");
        try {
            orderService.createOrder(fullname, email, address, phoneNumber);
            response.put("status", "success");
            response.put("message", messageUtils.getMessage("Order.addToOrder.success"));
            return ResponseEntity.ok().body(response);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
}
