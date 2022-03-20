<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!-- Navbar Electronics Store-->
<header class="shadow-sm">
    <!-- Remove "navbar-sticky" class to make navigation bar scrollable with the page.-->
    <div class="navbar-sticky bg-light">
        <div class="navbar navbar-expand-lg navbar-light">
            <div class="container">
                <a class="navbar-brand d-none d-sm-block me-3 flex-shrink-0" href="/home">
                    <img src="${pageContext.request.contextPath}/assets/user/img/logo.png" width="142"></a>
                <a class="navbar-brand d-sm-none me-2" href="/home">
                    <img src="${pageContext.request.contextPath}/assets/user/img/logo.png" width="74">
                </a>
                <!-- Search -->
                <form action="/product-search" method="GET" class="input-group d-none d-lg-flex flex-nowrap mx-4" id="search-form">
                    <input class="form-control rounded-start w-100" id="search-input" type="text" name="keyword" value="${keyword}"
                        placeholder="<spring:message code='global.search_of_products'/>">
                    <button class="btn btn-primary" type="submit" id="search-button">
                        <i class="ci-search"></i>
                    </button>
                </form>
                <!-- Toolbar-->
                <div class="navbar-toolbar d-flex flex-shrink-0 align-items-center">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarCollapse">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <a class="navbar-tool navbar-stuck-toggler" href="#">
                        <span class="navbar-tool-tooltip">Toggle menu</span>
                        <div class="navbar-tool-icon-box">
                            <i class="navbar-tool-icon ci-menu"></i>
                        </div>
                    </a>
                    <div class="navbar-tool dropdown ms-3">
                        <a class="navbar-tool-icon-box bg-secondary dropdown-toggle" href="/shopping-cart">
                            <i class="navbar-tool-icon ci-cart"></i>
                            <c:if test="${totalQuantity != 0}">
                                <span class="navbar-tool-label">${totalQuantity}</span>
                            </c:if>
                        </a>
                        <c:if test="${totalPrice != 0}">
                            <a class="navbar-tool-text" href="/shopping-cart">
                                <small><spring:message code="global.my_cart"/></small>
                                <fmt:formatNumber value="${totalPrice}" pattern="#,##0"/>₫
                            </a>
                        </c:if>
                        <!-- Cart dropdown-->
                        <c:choose>
                            <c:when test="${productsInCart.size() > 0}">
                                <div class="dropdown-menu dropdown-menu-end">
                                    <div class="widget widget-cart px-3 pt-2 pb-3" style="width: 20rem;">
                                        <div style="height: 15rem;" data-simplebar data-simplebar-auto-hide="false">
                                            <c:forEach items="${productsInCart}" var="cart">
                                                <div class="widget-cart-item py-2 border-bottom">
                                                    <button class="btn-close text-danger btn-remove-cart"
                                                            onclick="removeForCart('${cart.id}')" type="button">
                                                        <span aria-hidden="true">&times;</span>
                                                    </button>
                                                    <div class="d-flex align-items-center">
                                                        <a class="d-block flex-shrink-0"
                                                           href="/product-detail/${cart.product.slug}">
                                                            <img src="${cart.product.image}" class="p-1"
                                                                 style="width: 64px; height: 64px" alt="Product">
                                                        </a>
                                                        <div class="ps-2">
                                                            <h6 class="widget-product-title">
                                                                <a href="/product-detail/${cart.product.slug}">${cart.product.name}</a>
                                                            </h6>
                                                            <div class="widget-product-meta">
                                                        <span class="text-accent me-2">
                                                            <fmt:formatNumber value="${cart.product.getPromotionalPrice()}"
                                                                              pattern="#,##0"/>₫
                                                        </span>
                                                                <span class="text-muted">x ${cart.quantity}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <div class="d-flex flex-wrap justify-content-between align-items-center py-3">
                                            <div class="fs-sm me-2 py-2">
                                        <span class="text-muted">
                                            <spring:message code="global.subtotal"/>:</span>
                                                <span class="text-accent fs-base ms-1">
                                            <fmt:formatNumber value="${totalPrice}" pattern="#,##0"/>₫
                                        </span>
                                            </div>
                                        </div>
                                        <div class="btn-group w-100">
                                            <a class="btn btn-outline-secondary btn-sm" href="/shopping-cart">
                                                <i class="ci-cart me-2 fs-base align-middle"></i>
                                                <spring:message code="global.view_cart"/>
                                                <i class="ci-arrow-right ms-1 me-n1"></i>
                                            </a>
                                            <a class="btn btn-primary btn-sm" href="/checkout-detail">
                                                <i class="ci-card me-2 fs-base align-middle"></i>
                                                <spring:message code="global.checkout"/>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="dropdown-menu dropdown-menu-end text-center py-4 px-3">
                                    <div style="width: 16rem;"><img class="d-inline-block mb-2"
                                                                    src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKAAAACcCAIAAAB3FTesAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyhpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMTQ1IDc5LjE2MzQ5OSwgMjAxOC8wOC8xMy0xNjo0MDoyMiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTkgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDMxMDBDQzcwRTEyMTFFQTlDN0JDNTAzRUUyMzIxMDMiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDMxMDBDQzgwRTEyMTFFQTlDN0JDNTAzRUUyMzIxMDMiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDozMkIwRDVENDBFMEYxMUVBOUM3QkM1MDNFRTIzMjEwMyIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0MzEwMENDNjBFMTIxMUVBOUM3QkM1MDNFRTIzMjEwMyIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Pk3kXrQAABTwSURBVHja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"
                                                                    width="40" alt="Empty cart">
                                        <p class="fs-sm text-muted mb-0">
                                            <spring:message code="hd.cartEmpty"/>
                                        </p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
        <div class="navbar navbar-expand-lg navbar-light navbar-stuck-menu mt-n2 pt-0 pb-2">
            <div class="container">
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <!-- Search -->
                    <form action="/product-search" method="POST" class="input-group d-lg-none my-3" >
                        <input class="form-control rounded-start" type="text" name="keyword" value="${keyword}"
                            placeholder="<spring:message code='global.search_of_products'/>">
                        <button class="btn btn-primary" type="submit">
                            <i class="ci-search"></i>
                        </button>
                    </form>
                    <!-- Departments menu-->
                    <ul class="navbar-nav navbar-mega-nav pe-lg-2 me-lg-2">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle ps-lg-0" href="#" data-bs-toggle="dropdown"
                                data-bs-auto-close="outside">
                                <i class="ci-menu align-middle mt-n1 me-2"></i><spring:message code="hd.mn.nav1" />
                            </a>
                            <ul class="dropdown-menu">
                                <c:forEach items="${categories}" var="category">
                                    <c:if test="${category.products.size() > 0}">
                                        <a href="/product-list/${category.slug}" class="dropdown-item">
                                            <c:choose>
                                                <c:when test="${pageContext.response.locale.language == 'vi'}">
                                                    ${category.nameVI}
                                                </c:when>
                                                <c:otherwise>
                                                    ${category.nameEN}
                                                </c:otherwise>
                                            </c:choose>
                                        </a>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </li>
                    </ul>
                    <!-- Primary menu-->
                    <ul class="navbar-nav">
                        <li class="nav-item active">
                            <a class="nav-link" href="/home">
                                <spring:message code="hd.mn.nav2" />
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <spring:message code="hd.mn.nav3" />
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <spring:message code="hd.mn.nav4" />
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">
                                <spring:message code="hd.mn.nav5" />
                            </a>
                        </li>
                    </ul>
                    <!-- Primary menu-->
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"
                               data-bs-auto-close="outside" aria-expanded="true">
                                <i class="icon fa-regular fa-globe"></i><spring:message code="hd.mn.nav6" />
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" data-bs-popper="none">
                                <li>
                                    <a class="dropdown-item" href="?lang=vi">
                                        <span class="icon fi fi-vn"></span>Tiếng Việt
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="?lang=en">
                                        <span class="icon fi fi-us"></span>English
                                    </a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item active dropdown" id="nav-user">
                            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"
                               data-bs-auto-close="outside" aria-expanded="true">
                                <sec:authorize access="isAuthenticated()">
                                    <input type="hidden" id="isLogin" value="true"/>
                                    <i class="icon fa-regular fa-circle-user"></i><spring:message code="global.welcome" />
                                	<sec:authentication property="principal"/>
                                </sec:authorize>
                                <sec:authorize access="!isAuthenticated()">
                                    <input type="hidden" id="isLogin" value="false"/>
                                    <i class="icon fa-regular fa-circle-user"></i><spring:message code="global.account"/>
                                </sec:authorize>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" data-bs-popper="none">
                                <sec:authorize access="!isAuthenticated()">
                                    <li>
                                        <a class="dropdown-item" href="/login">
                                            <spring:message code="global.sign_in"/>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="/forgot-password">
                                            <spring:message code="global.forgot_password"/>
                                        </a>
                                    </li>
                                    <div class="dropdown-divider"></div>
                                    <li>
                                        <a class="dropdown-item" href="/register">
                                            <spring:message code="global.sign_up"/>
                                        </a>
                                    </li>
                                </sec:authorize>
                                <sec:authorize access="isAuthenticated()">
                                    <li>
                                        <a class="dropdown-item" href="/shopping-cart">
                                            <spring:message code="global.my_cart"/>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="/order-history">
                                            <spring:message code="home.order.ordersHistory"/>
                                        </a>
                                    </li>
                                    <div class="dropdown-divider"></div>
                                    <li>
                                        <a class="dropdown-item" href="/change-password">
                                            <spring:message code="global.change_password"/>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="/user-profile">
                                            <spring:message code="global.profile_info"/>
                                        </a>
                                    </li>
                                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                                        <div class="dropdown-divider"></div>
                                        <li>
                                            <a class="dropdown-item" href="/dashboard">
                                                <spring:message code="global.dashboard"/>
                                            </a>
                                        </li>
                                    </sec:authorize>
                                    <div class="dropdown-divider"></div>
                                    <li>
                                        <form:form
                                                action="${pageContext.request.contextPath}/logout"
                                                method="post">
                                            <input type="submit" class="dropdown-item" value="<spring:message code="global.sign_out"/>">
                                        </form:form>
                                    </li>
                                </sec:authorize>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>
