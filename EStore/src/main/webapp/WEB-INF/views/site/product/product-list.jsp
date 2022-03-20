<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Page Title-->
<div class="page-title-overlap bg-dark pt-4">
    <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
        <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
                    <li class="breadcrumb-item">
                        <a class="text-nowrap" href="/home"><i class="ci-home"></i>
                            <spring:message code="global.home"/></a>
                    </li>
                    <li class="breadcrumb-item text-nowrap active" aria-current="page">
                        <c:choose>
                            <c:when test="${pageContext.response.locale.language == 'vi'}">
                                ${category.nameVI}
                            </c:when>
                            <c:otherwise>
                                ${category.nameEN}
                            </c:otherwise>
                        </c:choose>
                    </li>
                </ol>
            </nav>
        </div>
        <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0">
                <c:choose>
                    <c:when test="${pageContext.response.locale.language == 'vi'}">
                        ${category.nameVI}
                    </c:when>
                    <c:otherwise>
                        ${category.nameEN}
                    </c:otherwise>
                </c:choose>
            </h1>
        </div>
    </div>
</div>
<div class="container pb-5 mb-2 mb-md-4">
    <div class="row">
        <!-- Sidebar-->
        <aside class="col-lg-3">
            <!-- Sidebar-->
            <div class="offcanvas offcanvas-collapse bg-white w-100 rounded-3 shadow-lg py-1" id="shop-sidebar"
                 style="max-width: 22rem;">
                <div class="offcanvas-header align-items-center shadow-sm">
                    <h2 class="h5 mb-0">
                        <spring:message code="global.filters"/>
                    </h2>
                    <button class="btn-close ms-auto" type="button" data-bs-dismiss="offcanvas"
                            aria-label="Close"></button>
                </div>
                <div class="offcanvas-body py-grid-gutter px-lg-grid-gutter">
                    <!-- Categories-->
                    <div class="widget widget-categories ">
                        <h3 class="widget-title">
                            <spring:message code="global.categories"/>
                        </h3>
                        <div class="widget widget-links widget-filter">
                            <div class="input-group input-group-sm mb-2">
                                <input class="widget-filter-search form-control rounded-end" type="text"
                                       placeholder="<spring:message code='global.search' />">
                                <i class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
                            </div>
                            <ul class="widget-list widget-filter-list pt-1" data-simplebar
                                data-simplebar-auto-hide="false">
                                <c:forEach items="${categories}" var="category">
                                    <c:if test="${category.products.size() > 0}">
                                        <li class="widget-list-item widget-filter-item">
                                            <a class="widget-list-link d-flex justify-content-between align-items-center"
                                               href="/product-list/${category.slug}">
                                            <span class="widget-filter-item-text">
                                                <c:choose>
                                                    <c:when test="${pageContext.response.locale.language == 'vi'}">
                                                        ${category.nameVI}
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${category.nameEN}
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                            <span class="fs-xs text-muted ms-3">${category.products.size()}</span>
                                            </a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <c:if test="${brands.size() != 0}">
                        <!-- Filter by Brand-->
                        <div class="widget widget-categories mt-4 pt-4 mb-4 border-top">
                            <h3 class="widget-title">
                                <spring:message code="global.brand"/>
                            </h3>
                            <div class="widget widget-links widget-filter">
                                <div class="input-group input-group-sm mb-2">
                                    <input class="widget-filter-search form-control rounded-end" type="text"
                                           placeholder="<spring:message code='global.search' />">
                                    <i class="ci-search position-absolute top-50 end-0 translate-middle-y fs-sm me-3"></i>
                                </div>
                                <ul class="widget-list widget-filter-list pt-1" data-simplebar
                                    data-simplebar-auto-hide="false">
                                    <c:forEach items="${brands}" var="brand">
                                        <li class="widget-list-item widget-filter-item">
                                            <a class="widget-list-link d-flex justify-content-between align-items-center"
                                               href="/product-list/${category.slug}?brand=${brand.slug}">
                                            <span class="widget-filter-item-text">
                                                    ${brand.name}
                                            </span>
                                            <span class="fs-xs text-muted ms-3">${brand.getNumberBrandByCategory(category.id)}</span>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
        </aside>
        <!-- Content  -->
        <section class="col-lg-9">
            <!-- Toolbar-->
            <div class="d-flex justify-content-center justify-content-sm-between align-items-center pt-2 pb-4 pb-sm-5">
                <div class="d-flex flex-wrap">
                    <div class="d-flex align-items-center flex-nowrap me-3 me-sm-4 pb-3">
                        <label class="text-light opacity-75 text-nowrap fs-sm me-2 d-none d-sm-block" for="sorting">
                            <spring:message code="global.sort_by"/>
                        </label>
                        <select class="form-select" id="sorting" data-action="${category.slug}">
                            <option ${direction=="ASC"?'selected':''} value="ASC">A - Z</option>
                            <option ${direction=="DESC"?'selected':''} value="DESC">Z - A</option>
                        </select>
                        <span class="fs-sm text-light opacity-75 text-nowrap ms-2 d-none d-md-block">
                            <spring:message code="global.of"/> ${productPage.totalElements}
                            <spring:message code="global.products"/>
                        </span>
                    </div>
                </div>
                <div class="d-flex pb-3">
                    <div onclick="changePageNumber('${productPage.number - 1}', '${category.slug}')">
                        <a class="nav-link-style nav-link-light me-3" href="javascript:void(0)">
                            <i class="ci-arrow-left"></i>
                        </a>
                    </div>
                    <span class="fs-md text-light">${productPage.number+1} / ${productPage.totalPages}</span>
                    <div onclick="changePageNumber('${productPage.number + 1}', '${category.slug}')">
                        <a class="nav-link-style nav-link-light ms-3"
                           href="javascript:void(0)">
                            <i class="ci-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>
            <c:if test="${productPage.totalPages != 0}">
                <!-- Products grid-->
                <div class="row mx-n2">
                    <c:forEach items="${productPage.content}" var="item">
                        <!-- Product-->
                        <div class="col-md-4 col-sm-6 px-2 mb-4">
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
                                <div class="square-size-by-length d-flex align-items-center">
                                    <a class="card-img-top d-block overflow-hidden" href="/product-detail/${item.slug}">
                                        <img src="${item.image}" alt="${item.name}" class="p-5">
                                    </a>
                                </div>
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
                                    <button class="btn btn-primary btn-sm d-block w-100 mb-2" type="button"
                                            onclick="addToCart('${item.id}')">
                                        <i class="ci-cart fs-sm me-1"></i>
                                        <spring:message code='global.add_to_cart'/>
                                    </button>
                                </div>
                            </div>
                            <hr class="d-sm-none">
                        </div>
                    </c:forEach>
                </div>
                <hr class="my-3">
                <!-- Pagination-->
                <nav class="d-flex justify-content-between pt-2" aria-label="Page navigation">
                    <ul class="pagination">
                        <li class="page-item" onclick="changePageNumber('${productPage.number - 1}', '${category.slug}')">
                            <a class="page-link" href="javascript:void(0)">
                                <i class="ci-arrow-left me-2"></i>
                                <spring:message code='global.prev'/>
                            </a>
                        </li>
                    </ul>
                    <ul class="pagination">
                        <li class="page-item d-sm-none">
                            <span class="page-link page-link-static">${productPage.number+1} / ${productPage.totalPages}</span>
                        </li>
                        <c:forEach var="item" begin="0" end="${productPage.totalPages-1}">
                            <li class="page-item ${productPage.number == item ? 'active' : ''} d-none d-sm-block"
                                onclick="changePageNumber('${item}', '${category.slug}')">
                                <a class="page-link" href="javascript:void(0)">${item + 1}</a>
                            </li>
                        </c:forEach>
                    </ul>
                    <ul class="pagination">
                        <li class="page-item"
                            onclick="changePageNumber('${productPage.number + 1}', '${category.slug}')">
                            <a class="page-link" href="javascript:void(0)"
                               aria-label="Next">
                                <spring:message code='global.next'/>
                                <i class="ci-arrow-right ms-2"></i>
                            </a>
                        </li>
                    </ul>
                </nav>
            </c:if>
        </section>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function(event) {
        var scrollpos = sessionStorage.getItem('scrollpos');
        if (scrollpos) window.scrollTo(0, scrollpos);
        sessionStorage.removeItem('scrollpos');
    });

    window.onbeforeunload = function(e) {
        sessionStorage.setItem('scrollpos', window.scrollY);
    };
</script>