<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-01-22
  Time: 11:18 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!-- Page Title (Shop Alt)-->
<div class="bg-dark pt-4">
    <div class="container pt-2 pb-3 pt-lg-3 pb-lg-4">
        <div class="d-lg-flex justify-content-between pb-3">
            <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
                        <li class="breadcrumb-item"><a class="text-nowrap" href="/home">
                            <i class="ci-home"></i><spring:message code="global.home"/></a></li>
                        </li>
                        <li class="breadcrumb-item text-nowrap active" aria-current="page">
                            <spring:message code="global.search"/></li>
                    </ol>
                </nav>
            </div>
            <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
                <h1 class="h3 text-light mb-0">
                    <spring:message code="global.found"/> ${products.size()}
                    <spring:message code="global.results_with_keyword"/> "${keyword}"
                </h1>
            </div>
        </div>
    </div>
</div>
<%-- Products List --%>
<div class="container py-5 mb-2 mb-md-4">
    <!-- Products grid-->
    <div class="row mx-n2">
        <c:forEach items="${products}" var="item">
            <!-- Product-->
            <div class="col-lg-3 col-md-4 col-sm-6 px-2 mb-4">
                <div class="card product-card">
                    <c:if test="${item.discount != null}">
                    <span class="badge bg-danger badge-shadow">
                        <c:choose>
                            <c:when test="${pageContext.response.locale.language == 'vi'}">
                                Giảm
                                <fmt:formatNumber value="${item.discount.saleOff}" type="number"/>%
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${item.discount.saleOff}" type="number"/>% OFF
                            </c:otherwise>
                        </c:choose>
                    </span>
                    </c:if>
                    <a class="card-img-top d-block overflow-hidden" href="/product-detail/${item.slug}">
                        <img src="${item.image}" alt="${item.name}" class="p-5">
                    </a>
                    <div class="card-body py-2">
                        <a class="product-meta d-block fs-xs pb-1" href="#">
                            <c:choose>
                                <c:when test="${pageContext.response.locale.language == 'vi'}">
                                    ${item.category.nameVI}
                                </c:when>
                                <c:otherwise>
                                    ${item.category.nameEN}
                                </c:otherwise>
                            </c:choose>
                        </a>
                        <h3 class="product-title fs-sm">
                            <a href="/product-detail/${item.slug}">${item.name}</a>
                        </h3>
                        <div class="d-flex justify-content-between">
                            <div class="product-price">
                                        <span class="text-accent">
                                            <fmt:formatNumber
                                                    value="${item.price - (item.price * item.discount.saleOff / 100)}"
                                                    type="number"/>₫
                                        </span>
                                <c:if test="${item.discount != null}">
                                    <del class="fs-sm text-muted">
                                        <small>
                                            <fmt:formatNumber value="${item.price}" type="number"/>₫
                                        </small>
                                    </del>
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="card-body card-body-hidden">
                        <button class="btn btn-primary btn-sm d-block w-100 mb-2" type="button">
                            <i class="ci-cart fs-sm me-1"></i>
                            <spring:message code='global.add_to_cart'/>
                        </button>
                    </div>
                </div>
                <hr class="d-sm-none">
            </div>
        </c:forEach>
    </div>
</div>
