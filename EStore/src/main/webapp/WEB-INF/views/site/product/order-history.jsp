<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!-- Page Title-->
<div class="page-title bg-dark py-4">
    <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
        <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
                    <li class="breadcrumb-item">
                        <a class="text-nowrap" href="<c:url value="/home"/>"><i
                                class="ci-home"></i><spring:message code="global.home"/></a>
                    </li>
                    <li class="breadcrumb-item text-nowrap active" aria-current="page">
                        <spring:message code="home.order.ordersHistory"/>
                    </li>
                </ol>
            </nav>
        </div>
        <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0"><spring:message code="home.order.myOrders"/></h1>
        </div>
    </div>
</div>
<div class="container py-3 my-2 my-md-4">
    <div class="row">
        <!-- Content  -->
        <section class="col-lg-12">
            <!-- Orders list-->
            <div class="table-responsive fs-md mb-4">
                <table id="order-history-table" class="table table-hover mb-0">
                    <thead>
                    <tr>
                        <th><spring:message code="global.order"/> #</th>
                        <th><spring:message code="global.date_purchased"/></th>
                        <th><spring:message code="global.status"/></th>
                        <th><spring:message code="global.total"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td class="py-3">
                                <a class="nav-link-style fw-medium fs-sm"
                                   href="#order-details-${order.id}" data-bs-toggle="modal">${order.orderCode}</a>
                            </td>
                            <td class="py-3 text-capitalize">
                                <fmt:formatDate type = "both" pattern="dd/MM/yyyy hh:mm:ss" value = "${order.createdDate}" />
                            </td>
                            <td class="py-3">
                                <c:choose>
                                    <c:when test="${order.status == 0}">
                                        <span class="badge bg-info m-0"><spring:message code="global.in_progress"/></span>
                                    </c:when>
                                    <c:when test="${order.status == 1}">
                                        <span class="badge bg-success m-0"><spring:message code="global.delivered"/></span>
                                    </c:when>
                                    <c:when test="${order.status == 2}">
                                        <span class="badge bg-warning m-0"><spring:message code="global.delayed"/></span>
                                    </c:when>
                                    <c:when test="${order.status == 3}">
                                        <span class="badge bg-danger m-0"><spring:message code="global.canceled"/></span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td class="py-3"><fmt:formatNumber value="${order.getTotal()}"/>₫</td>
                        </tr>
                        <!-- Order Details Modal-->
                        <div class="modal fade" id="order-details-${order.id}" style="display: none;" aria-hidden="true">
                            <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title">
                                            <spring:message code="global.order_no"/> - ${order.orderCode}
                                        </h5>
                                        <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body pb-0">
                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                            <!-- Item-->
                                            <div class="order-detail-item d-sm-flex justify-content-between mb-4 pb-3 pb-sm-2 border-bottom">
                                                <div class="d-sm-flex text-center text-sm-start">
                                                    <a class="d-inline-block flex-shrink-0 mx-auto" href="/product-detail/${orderDetail.product.slug}" style="width: 10rem;">
                                                        <img src="${orderDetail.product.image}" class="p-2" style="width: 100px; height: 100px" alt="Product">
                                                    </a>
                                                    <div class="ps-sm-4 pt-2">
                                                        <h3 class="product-title fs-base mb-2">
                                                            <a href="/product-detail/${orderDetail.product.slug}">${orderDetail.product.name}</a></h3>
                                                        <div class="fs-lg text-accent pt-2">
                                                            <fmt:formatNumber value="${orderDetail.product.getPromotionalPrice()}"/>₫
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
                                                    <div class="text-muted mb-2"><spring:message code="global.quantity"/>:</div>
                                                        ${orderDetail.quantity}
                                                </div>
                                                <div class="pt-2 ps-sm-3 mx-auto mx-sm-0 text-center">
                                                    <div class="text-muted mb-2"><spring:message code="global.subtotal"/></div>
                                                    <fmt:formatNumber value="${orderDetail.getSubtotal()}"/>₫
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <!-- Footer-->
                                    <div class="modal-footer flex-wrap justify-content-end bg-secondary fs-md">
                                        <div class="px-2 py-1">
                                            <span class="text-muted"><spring:message code="global.total"/>:&nbsp;</span>
                                            <span class="fs-lg"> <fmt:formatNumber value="${order.getTotal()}"/>₫</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
    </div>
</div>