package com.eshop.service.impl;

import com.eshop.entity.Authority;
import com.eshop.repository.AuthorityRepository;
import com.eshop.service.AuthorityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthorityServiceImpl implements AuthorityService {
    @Autowired
    private AuthorityRepository authorityRepo;

    @Override
    public List<Authority> getAll() {
        return authorityRepo.findAll();
    }

    @Override
    public Authority save(Authority authority) {
        return authorityRepo.save(authority);
    }

    @Override
    public void delete(Long authorityId) {
        authorityRepo.deleteById(authorityId);
    }
}
