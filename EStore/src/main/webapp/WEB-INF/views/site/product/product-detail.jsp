<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<!-- Page Title-->
<c:choose>
    <c:when test="${pageContext.response.locale.language == 'vi'}">
        <c:set var = "categoryName" value = "${product.category.nameVI}"/>
    </c:when>
    <c:otherwise>
        <c:set var = "categoryName" value = "${product.category.nameEN}"/>
    </c:otherwise>
</c:choose>
<div class="page-title-overlap bg-dark pt-4">
    <div class="container d-lg-flex justify-content-between py-2 py-lg-3">
        <div class="order-lg-2 mb-3 mb-lg-0 pt-lg-2">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb breadcrumb-light flex-lg-nowrap justify-content-center justify-content-lg-start">
                    <li class="breadcrumb-item">
                        <a class="text-nowrap" href="/home"><i class="ci-home"></i><spring:message code="global.home"/></a>
                    </li>
                    <li class="breadcrumb-item">
                        <a class="text-nowrap" href="/product-list/${product.category.slug}">${categoryName}</a>
                    </li>
                    <li class="breadcrumb-item">
                        <a class="text-nowrap" href="/product-list/${product.category.slug}?brand=${product.brand.slug}">
                            ${product.brand.name}
                        </a>
                    </li>
                    <%--<li class="breadcrumb-item text-nowrap active" aria-current="page">${product.name}</li>--%>
                </ol>
            </nav>
        </div>
        <div class="order-lg-1 pe-lg-4 text-center text-lg-start">
            <h1 class="h3 text-light mb-0">${product.name}</h1>
        </div>
    </div>
</div>
<div class="container">
    <!-- Gallery + details-->
    <div class="bg-light shadow-lg rounded-3 px-4 py-3 mb-5">
        <div class="px-lg-3">
            <div class="row">
                <!-- Product gallery-->
                <div class="col-lg-7 pe-lg-0 pt-lg-4">
                    <div class="product-gallery">
                        <div class="product-gallery-preview order-sm-2">
                            <div class="product-gallery-preview-item d-flex align-items-center active" id="first">
                                <img class="image-zoom" src="${product.imagePreview1}"
                                     data-zoom="${product.imagePreview1}" alt="${product.name}">
                                <div class="image-zoom-pane"></div>
                            </div>
                            <div class="product-gallery-preview-item d-flex align-items-center" id="second">
                                <img class="image-zoom" src="${product.imagePreview2}"
                                     data-zoom="${product.imagePreview2}" alt="${product.name}">
                                <div class="image-zoom-pane"></div>
                            </div>
                            <div class="product-gallery-preview-item d-flex align-items-center" id="third">
                                <img class="image-zoom" src="${product.imagePreview3}"
                                     data-zoom="${product.imagePreview3}" alt="${product.name}">
                                <div class="image-zoom-pane"></div>
                            </div>
                            <div class="product-gallery-preview-item d-flex align-items-center" id="fourth">
                                <img class="image-zoom" src="${product.imagePreview4}"
                                     data-zoom="${product.imagePreview4}" alt="${product.name}">
                                <div class="image-zoom-pane"></div>
                            </div>
                        </div>
                        <div class="product-gallery-thumblist order-sm-1">
                            <c:if test="${not empty product.imagePreview1}">
                                <a class="product-gallery-thumblist-item active" href="#first">
                                    <img class="h-100" src="${product.imagePreview1}" alt="Product thumb">
                                </a>
                            </c:if>
                            <c:if test="${not empty product.imagePreview2}">
                                <a class="product-gallery-thumblist-item" href="#second">
                                    <img class="h-100" src="${product.imagePreview2}" alt="Product thumb">
                                </a>
                            </c:if>
                            <c:if test="${not empty product.imagePreview3}">
                                <a class="product-gallery-thumblist-item" href="#third">
                                    <img class="h-100" src="${product.imagePreview3}" alt="Product thumb">
                                </a>
                            </c:if>
                            <c:if test="${not empty product.imagePreview4}">
                                <a class="product-gallery-thumblist-item" href="#fourth">
                                    <img class="h-100" src="${product.imagePreview4}" alt="Product thumb">
                                </a>
                            </c:if>
                            <c:if test="${not empty product.videoPreview}">
                                <a class="product-gallery-thumblist-item video-item"
                                   href="https://www.youtube.com/watch?v=${product.videoPreview}">
                                    <div class="product-gallery-thumblist-item-text">
                                        <i class="ci-video"></i>Video
                                    </div>
                                </a>
                            </c:if>
                        </div>
                    </div>
                </div>
                <!-- Product details -->
                <div class="col-lg-5 pt-4 pt-lg-0">
                    <div class="product-details ms-auto pb-3 mt-4 d-flex flex-column h-100">
                        <div class="mb-3">
                            <span class="h3 fw-normal text-accent me-1">
                                <fmt:formatNumber
                                        value="${product.price - (product.price * product.discount.saleOff / 100)}"
                                        type="number"/>₫
                            </span>
                            <c:if test="${product.discount != null}">
                                <del class="text-muted fs-lg me-3">
                                    <fmt:formatNumber value="${product.price}" type="number"/>₫
                                </del>
                                <span class="badge bg-danger badge-shadow align-middle mt-n2">
                                    <c:choose>
                                        <c:when test="${pageContext.response.locale.language == 'vi'}">
                                            Giảm
                                            <fmt:formatNumber value="${product.discount.saleOff}" type="number"/>%
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${product.discount.saleOff}" type="number"/>% OFF
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </c:if>

                        </div>
                        <div class="mb-3 flex-grow-1">
                            <div class="position-relative me-n4 mb-3">
                                <h6 class="fs-base mb-2 pb-1"><spring:message code="global.product_info"/></h6>
                                <c:choose>
                                    <c:when test="${product.available==0}">
                                        <div class="product-badge product-available mt-n1">
                                            <i class="ci-security-check"></i><spring:message
                                                code="global.in_stock"/>
                                        </div>
                                    </c:when>
                                    <c:when test="${product.available==1}">
                                        <div class="product-badge product-not-available mt-n1">
                                            <i class="ci-security-close"></i><spring:message
                                                code="global.out_of_stock"/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="product-badge product-not-available mt-n1">
                                            <i class="ci-security-prohibition"></i><spring:message
                                                code="global.sold_out"/>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="fs-sm text-muted">
                                ${product.description}
                            </div>
                        </div>
                        <c:if test="${product.available == 0}">
                            <form class="mb-grid-gutter">
                                <div class="mb-3 d-flex align-items-center">
                                    <select class="form-select me-3" style="width: 5rem;" id="select-quantity">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                        <option value="5">5</option>
                                    </select>
                                    <button class="btn btn-primary btn-shadow d-block w-100" type="button" onclick="addToCart('${product.id}')">
                                        <i class="ci-cart fs-lg me-2"></i>
                                        <spring:message code="global.add_to_cart"/>
                                    </button>
                                </div>
                            </form>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Product carousel-->
<div class="container pt-lg-2 pb-5 mb-md-3">
    <h2 class="h3 text-center pb-4"><spring:message code="global.you_may_also_like" /></h2>
    <div class="tns-carousel tns-controls-static tns-controls-outside">
        <div class="tns-carousel-inner"
             data-carousel-options="{&quot;items&quot;: 2, &quot;controls&quot;: true, &quot;nav&quot;: false, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2, &quot;gutter&quot;: 18},&quot;768&quot;:{&quot;items&quot;:3, &quot;gutter&quot;: 20}, &quot;1100&quot;:{&quot;items&quot;:4, &quot;gutter&quot;: 30}}}">
            <c:forEach items="${discountProducts}" var="product">
                <!-- Product-->
                <div>
                    <div class="card product-card">
                    <span class="badge bg-danger badge-shadow">
                        <c:choose>
                            <c:when test="${pageContext.response.locale.language == 'vi'}">
                                Giảm
                                <fmt:formatNumber value="${product.discount.saleOff}" type="number" />%
                            </c:when>
                            <c:otherwise>
                                <fmt:formatNumber value="${product.discount.saleOff}" type="number" />% OFF
                            </c:otherwise>
                        </c:choose>
                    </span>
                        <div class="square-size-by-length d-flex align-items-center">
                            <a class="card-img-top d-block overflow-hidden" href="/product-detail/${product.slug}">
                                <img src="${product.image}" alt="${product.name}" class="p-5">
                            </a>
                        </div>
                        <div class="card-body py-2">
                            <a class="product-meta d-block fs-xs pb-1" href="#">
                                <c:choose>
                                    <c:when test="${pageContext.response.locale.language == 'vi'}">
                                        ${product.category.nameVI}
                                    </c:when>
                                    <c:otherwise>
                                        ${product.category.nameEN}
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <h3 class="product-title fs-sm">
                                <a href="/product-detail/${product.slug}">${product.name}</a>
                            </h3>
                            <div class="d-flex justify-content-between">
                                <div class="product-price">
                                <span class="text-accent">
                                    <fmt:formatNumber value="${product.getPromotionalPrice()}" type="number" />₫
                                </span>
                                    <del class="fs-sm text-muted">
                                        <small><fmt:formatNumber value="${product.price}" type="number" />₫</small>
                                    </del>
                                </div>
                            </div>
                        </div>
                        <div class="card-body card-body-hidden">
                            <button class="btn btn-primary btn-sm d-block w-100 mb-2" type="button"
                                    onclick="addToCart('${product.id}')">
                                <i class="ci-cart fs-sm me-1"></i>
                                <spring:message code='global.add_to_cart'/>
                            </button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>