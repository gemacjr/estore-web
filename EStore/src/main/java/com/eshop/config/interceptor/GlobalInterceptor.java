package com.eshop.config.interceptor;

import com.eshop.dto.CategoryDTO;
import com.eshop.dto.ShoppingCartDTO;
import com.eshop.entity.Discount;
import com.eshop.entity.ShoppingCart;
import com.eshop.entity.User;
import com.eshop.service.CartService;
import com.eshop.service.CategoryService;
import com.eshop.service.DiscountService;
import com.eshop.service.UserService;
import com.eshop.utils.MapperUtils;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;

@Component
public class GlobalInterceptor implements HandlerInterceptor {
    @Autowired
    private CategoryService categoryService;

    @Autowired
    private DiscountService discountService;

    @Autowired
    private CartService cartService;

    @Autowired
    private UserService userService;

    @Autowired
    private ModelMapper mapper;

    @Override
    public boolean preHandle(HttpServletRequest request,
                             HttpServletResponse response, Object handler) throws Exception {
        request.setAttribute("uri", request.getRequestURI());
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest req, HttpServletResponse res,
            Object handler, ModelAndView mv) throws Exception {
        /* Current user */
        User currentUser = userService.getCurrentUser();
        if (currentUser != null) {
            req.setAttribute("currentUser", currentUser);
        }

        /* Category */
        req.setAttribute("categories", MapperUtils.mapAll(categoryService.getAll(), CategoryDTO.class));
        /* Cart */
        List<ShoppingCart> list = cartService.getCartByUser(currentUser);
        List<ShoppingCartDTO> productsInCart = list.stream()
                .map(cart -> mapper.map(cart, ShoppingCartDTO.class)).toList();
        Double totalPrice = productsInCart.stream()
                .mapToDouble(ShoppingCartDTO::getUnitPrice).sum();
        Integer totalQuantity = productsInCart.stream()
                .mapToInt(ShoppingCartDTO::getQuantity).sum();
        req.setAttribute("totalPrice", totalPrice);
        req.setAttribute("totalQuantity", totalQuantity);
        req.setAttribute("productsInCart", productsInCart);


        /* Vô hiệu hoá các khuyến mãi đã hết hạn */
        List<Discount> discounts = discountService.getByActivated();
        discounts.forEach(discount -> {
            if (discount.getEndDate().before(new Date())) {
                discountService.delete(discount.getId());
            }
        });
    }
}
