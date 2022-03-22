package com.eshop.controller.admin;

import com.eshop.dto.*;
import com.eshop.entity.Brand;
import com.eshop.entity.Discount;
import com.eshop.entity.Product;
import com.eshop.entity.User;
import com.eshop.service.*;
import com.eshop.utils.MapperUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.ParseException;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/dashboard")
public class AdminController {
    @Autowired
    private UserService userService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductService productService;
    @Autowired
    private BrandService brandService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private DiscountService discountService;

    @RequestMapping("")
    public String showDashboardPage() {
        return "redirect:dashboard/report";
    }

    @RequestMapping("/category-management")
    public String showCategoryManager(Model model) {
        model.addAttribute("stt", 0);
        return "admin/category-manager";
    }

    @RequestMapping("/brand-management")
    public String showBrandManager(Model model) {
        List<Brand> brands = brandService.getAll();
        model.addAttribute("brands", brands);
        model.addAttribute("stt", 0);
        return "admin/brand-manager";
    }

    @RequestMapping("/product-management")
    public String showProductManager(Model model, @RequestParam Optional<String> category, @RequestParam Optional<String> brand) {
        String categorySlug = category.orElseGet(() -> categoryService.getAll().get(0).getSlug());
        List<Brand> brandsByCategory = brandService.getByCategory(categorySlug);

        String brandSlug = brand.orElseGet(() -> brandsByCategory.get(0).getSlug());
        model.addAttribute("brandsByCategory", brandsByCategory);
        model.addAttribute("brands", brandService.getAll());

        List<Discount> discounts = discountService.getActivedOrderBySaleOffAsc(true);
        model.addAttribute("discounts", discounts);

        List<Product> products = productService.getByCategoryAndBrand(categorySlug, brandSlug);
        model.addAttribute("products", products);

        model.addAttribute("categorySlug", categorySlug);
        model.addAttribute("brandSlug", brandSlug);
        return "admin/product-manager";
    }

    @RequestMapping("/report")
    public String showReportPage(Model model, @RequestParam Optional<String> brand,
                                 @RequestParam Optional<String> startDate, @RequestParam Optional<String> endDate) throws ParseException {
        List<OrderDTO> orders = MapperUtils.mapAll(orderService.getAll(), OrderDTO.class);
        double revenue = orders.stream().filter(order -> order.getStatus() == 1).mapToDouble(OrderDTO::getTotal).sum();
        model.addAttribute("orders", orders);
        model.addAttribute("revenue", revenue);
        model.addAttribute("products", productService.getAll());

        // Tồn kho theo danh mục
        List<BrandDTO> brands = MapperUtils.mapAll(brandService.getAll(), BrandDTO.class);
        List<CategoryDTO> categoryList = null;
        if (brand.isPresent()) {
            String brandSlug = brand.get();
            categoryList = MapperUtils.mapAll(categoryService.getByBrand(brandSlug), CategoryDTO.class);
            model.addAttribute("brandSlugSelected", brandSlug);
        } else {
            categoryList = MapperUtils.mapAll(categoryService.getAll(), CategoryDTO.class);
        }
        model.addAttribute("brands", brands);
        model.addAttribute("categoryList", categoryList);

        // Thống kê đơn hàng
        List<OrderReport> inventoryByOrders = orderService.getOrderReports();
        model.addAttribute("inventoryByOrders", inventoryByOrders);

        // Thống kê doanh thu
        List<SaleReport> saleReports = null;
        if (startDate.isPresent() && endDate.isPresent()) {
            saleReports = orderService.getSaleReports(DateUtils.parseDate(startDate.get(), "dd/MM/yyyy"), DateUtils.parseDate(endDate.get(), "dd/MM/yyyy"));
            model.addAttribute("period", startDate.get() + " - " + endDate.get());
        } else {
            saleReports = orderService.getSaleReports();
        }
        model.addAttribute("saleReports", saleReports);
        return "admin/report";
    }

    @RequestMapping("/user-management")
    public String showUserManagementPage(Model model) {
        List<User> users = userService.getAll();
        model.addAttribute("users", users);
        return "admin/user-manager";
    }

    @RequestMapping("/discount-management")
    public String showDiscountManagementPage(Model model) {
        List<Discount> discounts = discountService.getActivedOrderByCreateDateDesc(true);
        model.addAttribute("discounts", discounts);
        return "admin/discount-manager";
    }

}
