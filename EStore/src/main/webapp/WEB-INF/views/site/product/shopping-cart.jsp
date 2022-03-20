<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Page Title-->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<div class="page-title-overlap bg-dark pt-4">
    <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
        <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
                    <li class="breadcrumb-item"><a class="text-nowrap" href="/home">
                        <i class="ci-home"></i><spring:message code="global.home"/></a></li>
                    <li class="breadcrumb-item text-nowrap active" aria-current="page">
                        <spring:message code="global.cart"/></li>
                </ol>
            </nav>
        </div>
        <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0"><spring:message code="global.your_cart"/></h1>
        </div>
    </div>
</div>
<div class="container pb-5 mb-2 mb-md-4">
    <div class="row">
        <!-- List of items-->
        <section class="${productsInCart.size() > 0 ? 'col-lg-8' : 'col-lg-12'}">
            <div class="d-flex justify-content-between align-items-center pt-3 pb-4 pb-sm-5 mt-1">
                <h2 class="h6 text-light mb-0"><spring:message code="home.shoppingCart.products"/></h2>
                <a class="btn btn-outline-primary btn-sm ps-2" href="/product-list">
                    <i class="ci-arrow-left me-2"></i><spring:message code="home.shoppingCart.continueShopping"/></a>
            </div>
            <c:forEach items="${productsInCart}" var="cart">
                <!-- Item-->
                <div class="d-sm-flex justify-content-between align-items-center my-2 pb-3 border-bottom">
                    <div class="d-block d-sm-flex align-items-center text-center text-sm-start"><a
                            class="d-inline-block flex-shrink-0 mx-auto me-sm-4" href="/product-detail/${cart.product.slug}">
                        <img src="${cart.product.image}" class="p-3" style="width: 130px; height: 130px" alt="Product"></a>
                        <div class="pt-2">
                            <h3 class="product-title fs-base mb-2"><a
                                    href="/product-detail/${cart.product.slug}">${cart.product.name}</a>
                            </h3>
                            <div class="fs-lg text-accent pt-2">
                                <fmt:formatNumber value="${cart.product.getPromotionalPrice()}"/>₫
                                <del class="fs-sm text-muted">
                                    <small><fmt:formatNumber value="${cart.product.price}" type="number" />₫</small>
                                </del>
                            </div>
                        </div>
                    </div>
                    <div class="pt-2 pt-sm-0 ps-sm-3 mx-auto mx-sm-0 text-center text-sm-start"
                         style="max-width: 9rem;">
                        <label class="form-label" for="quantity${cart.id}"><spring:message
                                code="home.shoppingCart.quantity"/></label>
                        <input class="form-control" type="number" id="quantity${cart.id}" onchange="updateQuantity(${cart.id}, this.value)"
                               oninput="validity.valid||(value='');" min="1" value="${cart.quantity}">
                        <button class="btn btn-link px-0 text-danger" onclick="removeForCart('${cart.id}')" type="button">
                            <i class="ci-close-circle me-2"></i><span class="fs-sm"><spring:message
                                code="home.shoppingCart.remove"/></span>
                        </button>
                    </div>
                </div>
            </c:forEach>
        </section>

        <c:if test="${productsInCart.size() > 0}">
            <!-- Sidebar-->
            <aside class="col-lg-4 pt-4 pt-lg-0 ps-xl-5">
                <div class="bg-white rounded-3 shadow-lg p-4">
                    <div class="py-2 px-xl-2">
                        <div class="text-center mb-4 pb-3 border-bottom">
                            <h2 class="h6 mb-3 pb-1"><spring:message code="home.shoppingCart.subtotal"/></h2>
                            <h3 class="fw-normal"><fmt:formatNumber value="${totalPrice}"/>₫</h3>
                        </div>
                        <a class="btn btn-primary btn-shadow d-block w-100 mt-4" href="/checkout-detail"
                           id="checkout-button">
                            <i class="ci-card fs-lg me-2"></i><spring:message code="home.shoppingCart.checkout"/></a>
                    </div>
                </div>
            </aside>
        </c:if>
    </div>
</div>