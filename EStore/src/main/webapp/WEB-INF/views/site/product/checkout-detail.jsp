<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-08
  Time: 10:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!-- Page Title-->
<div class="page-title-overlap bg-dark pt-4">
    <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
        <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
                    <li class="breadcrumb-item"><a class="text-nowrap" href="/home">
                        <i class="ci-home"></i><spring:message code="global.home"/></a>
                    </li>
                    <li class="breadcrumb-item text-nowrap active" aria-current="page">
                        <spring:message code="global.checkout"/>
                    </li>
                </ol>
            </nav>
        </div>
        <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0"><spring:message code="global.checkout"/></h1>
        </div>
    </div>
</div>
<div class="container pb-5 mb-2 mb-md-4">
    <div class="row">
        <section class="col-lg-8">
            <!-- Steps-->
            <div class="steps steps-light pt-2 pb-3 mb-5">
                <a class="step-item active" href="/shopping-cart">
                    <div class="step-progress"><span class="step-count">1</span></div>
                    <div class="step-label"><i class="ci-cart"></i><spring:message code="global.cart"/></div>
                </a>
                <a class="step-item active current" href="checkout-details.html">
                    <div class="step-progress"><span class="step-count">2</span></div>
                    <div class="step-label">
                        <i class="ci-user-circle"></i><spring:message code="global.detail"/>
                    </div>
                </a>
            </div>
            <!-- Shipping address-->
            <form id="checkout-frm" class="needs-validation" novalidate>
                <h2 class="h6 pt-1 pb-3 mb-3 border-bottom"><spring:message code="home.checkout.shipmentDetails"/></h2>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="mb-3">
                            <label class="form-label" for="checkout-fullname"><spring:message code="global.full_name"/></label>
                            <input class="form-control" type="text" id="checkout-fullname" value="${user.fullname}" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.fullName"/></div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="mb-3">
                            <label class="form-label" for="checkout-email"><spring:message code="global.email"/></label>
                            <input class="form-control" type="email" id="checkout-email" value="${user.email}" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.email"/></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <div class="mb-3">
                            <label class="form-label" for="checkout-address"><spring:message code="global.address"/></label>
                            <input class="form-control" type="text" id="checkout-address" value="${user.address}" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.address"/></div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="mb-3">
                            <label class="form-label" for="checkout-phone"><spring:message code="global.phone_number"/></label>
                            <input class="form-control" type="number" id="checkout-phone" value="${user.phoneNumber}" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.phoneNumber"/></div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Navigation (desktop)-->
            <div class="d-none d-lg-flex pt-4 mt-3">
                <div class="w-50 pe-3">
                    <a class="btn btn-secondary d-block w-100" href="/shopping-cart">
                        <i class="ci-arrow-left mt-sm-0 me-1"></i><span
                            class="d-none d-sm-inline"><spring:message code="home.checkout.backToCart"/></span><span
                            class="d-inline d-sm-none"><spring:message code="global.back"/></span>
                    </a>
                </div>
                <div class="w-50 ps-2">
                    <button class="btn btn-primary d-block w-100" form="checkout-frm" type="submit">
                        <span class="d-none d-sm-inline">
                            <spring:message code="home.checkout.completeOrder"/>
                        </span><span class="d-inline d-sm-none">
                            <spring:message code="global.next"/>
                        </span><i class="ci-arrow-right mt-sm-0 ms-1"></i>
                    </button>
                </div>
            </div>
        </section>
        <!-- Sidebar-->
        <aside class="col-lg-4 pt-4 pt-lg-0 ps-xl-5">
            <div class="bg-white rounded-3 shadow-lg p-4 ms-lg-auto">
                <div class="py-2 px-xl-2">
                    <div class="widget mb-3">
                        <h2 class="widget-title text-center"><spring:message code="home.checkout.orderSummary"/></h2>
                        <c:forEach items="${productsInCart}" var="cart">
                            <div class="d-flex align-items-center py-2 border-bottom">
                                <a class="d-block flex-shrink-0" href="/product-detail/${cart.product.slug}">
                                    <img src="${cart.product.image}" width="64" alt="Product">
                                </a>
                                <div class="ps-2">
                                    <h6 class="widget-product-title">
                                        <a href="/product-detail/${cart.product.slug}">${cart.product.name}</a></h6>
                                    <div class="widget-product-meta">
                                        <span class="text-accent me-2">
                                            <fmt:formatNumber value="${cart.product.getPromotionalPrice()}" pattern="#,##0"/>₫
                                        </span>
                                        <span class="text-muted">x ${cart.quantity}</span></div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <h3 class="fw-normal text-center my-4"><fmt:formatNumber value="${totalPrice}" pattern="#,##0"/>₫</h3>
                </div>
            </div>
        </aside>
    </div>
    <!-- Navigation (mobile)-->
    <div class="row d-lg-none">
        <div class="col-lg-8">
            <div class="d-flex pt-4 mt-3">
                <div class="w-50 pe-3">
                    <a class="btn btn-secondary d-block w-100" href="/shopping-cart">
                        <i class="ci-arrow-left mt-sm-0 me-1"></i>
                        <span class="d-none d-sm-inline"><spring:message code="home.checkout.backToCart"/></span>
                        <span class="d-inline d-sm-none"><spring:message code="global.back"/></span></a></div>
                <div class="w-50 ps-2">
                    <button class="btn btn-primary d-block w-100" form="checkout-frm" type="submit">
                        <span class="d-none d-sm-inline">
                            <spring:message code="home.checkout.completeOrder"/>
                        </span>
                        <span class="d-inline d-sm-none">
                            <spring:message code="global.next"/>
                        </span><i class="ci-arrow-right mt-sm-0 ms-1"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
