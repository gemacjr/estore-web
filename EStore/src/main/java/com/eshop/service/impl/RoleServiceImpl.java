package com.eshop.service.impl;

import com.eshop.entity.Role;
import com.eshop.repository.RoleRepository;
import com.eshop.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleRepository roleRepo;

    @Override
    public List<Role> getAll() {
        return roleRepo.findAll();
    }
}
