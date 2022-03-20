<%@ page import="java.util.Random" %><%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-18
  Time: 11:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<h2 class="h3 py-2 text-center text-sm-start">
    <spring:message code="admin.report.summaryStatistics"/>
</h2>
<div class="row mx-n2 pt-2">
    <div class="col-md-4 col-sm-6 px-2 mb-4">
        <div class="bg-secondary h-100 rounded-3 p-4 text-center">
            <h3 class="fs-sm text-muted"><spring:message code="admin.report.totalProducts"/></h3>
            <p class="h2 mb-2">${products.size()}</p>
        </div>
    </div>
    <div class="col-md-4 col-sm-6 px-2 mb-4">
        <div class="bg-secondary h-100 rounded-3 p-4 text-center">
            <h3 class="fs-sm text-muted"><spring:message code="admin.report.totalOrders"/></h3>
            <p class="h2 mb-2">${orders.size()}</p>
        </div>
    </div>
    <div class="col-md-4 col-sm-12 px-2 mb-4">
        <div class="bg-secondary h-100 rounded-3 p-4 text-center">
            <h3 class="fs-sm text-muted"><spring:message code="admin.report.totalRevenue"/> (VND)</h3>
            <p class="h2 mb-2"><fmt:formatNumber value="${revenue}" type="number"/></p>
        </div>
    </div>
</div>
<!-- Masonry grid -->
<div class="masonry-grid" data-columns="2">
    <!-- Item -->
    <div class="masonry-grid-item">
        <div class="card border-accent">
            <div class="card-body fs-sm">
                <div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom border-accent">
                    <h3 class="fs-sm m-0">
                        <spring:message code="admin.report.inventoryByCategory"/><span
                            class="fw-normal fs-xs text-muted"></span>
                    </h3>
                    <div class="d-flex flex-nowrap align-items-center">
                        <label class="form-label fw-normal text-nowrap mb-0 me-2"
                               for="select-brand">
                            <spring:message code="global.brand"/>
                        </label>
                        <select class="form-select form-select-sm" id="select-brand"
                                name="brandId">
                            <option value="default"><spring:message code="global.all"/></option>
                            <c:forEach items="${brands}" var="brand">
                                <option value="${brand.slug}" ${brand.slug == brandSlug ? 'selected': ''}>
                                        ${brand.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <table class="table table-accent table-bordered border-accent" id="inventory-by-category-table">
                    <thead>
                    <tr>
                        <th><spring:message code="global.name"/></th>
                        <th class="text-center"><spring:message code="global.totalPrice"/> (VND)</th>
                        <th class="text-center"><spring:message code="admin.report.productNumber"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="category" items="${categoryList}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${pageContext.response.locale.language == 'vi'}">
                                        ${category.nameVI}
                                    </c:when>
                                    <c:otherwise>
                                        ${category.nameEN}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <fmt:formatNumber value="${category.getTotalPrice()}"
                                    type="number"/></td>
                            <td class="text-center">${category.products.size()}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Item -->
    <div class="masonry-grid-item">
        <div class="card border-info">
            <div class="card-body fs-sm">
                <div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom border-accent">
                    <h3 class="fs-sm m-0">
                        <spring:message code="admin.report.sales"/><span
                            class="fw-normal fs-xs text-muted"></span>
                    </h3>
                    <!-- Date range -->
                    <div class="input-group ms-2" style="max-width: 350px">
                        <span class="input-group-text">
                            <i class="fa-duotone fa-calendar"></i>
                        </span>
                        <c:choose>
                            <c:when test="${not empty period}">
                                <input class="form-control form-control-sm" type="text" id="range-date"
                                       placeholder="${period}">
                            </c:when>
                            <c:otherwise>
                                <input class="form-control form-control-sm" type="text" id="range-date"
                                       placeholder="<spring:message code="admin.report.chooseATimePeriod"/>">
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <table class="table table-info table-bordered border-info" id="sale-report-table">
                    <thead>
                    <tr>
                        <th><spring:message code="admin.report.productType"/></th>
                        <th class="text-center"><spring:message code="admin.report.revenue"/></th>
                        <th class="text-center"><spring:message code="global.quantity"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="saleReport" items="${saleReports}">
                        <tr>
                            <td>${saleReport.category.nameVI}</td>
                            <td class="text-center"><fmt:formatNumber value="${saleReport.revenue}" type="number"/> </td>
                            <td class="text-center">${saleReport.quantity}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- Item -->
    <div class="masonry-grid-item">
        <div class="card border-danger">
            <div class="card-body fs-sm">
                <div class="d-flex justify-content-between align-items-center pb-3 mb-3 border-bottom border-danger">
                    <h3 class="fs-sm m-0">
                        <spring:message code="global.order"/><span
                            class="fw-normal fs-xs text-muted"></span>
                    </h3>
                </div>
                <table class="table table-danger table-bordered border-danger" id="order-statistics-table">
                    <thead>
                    <tr>
                        <th><spring:message code="global.status"/></th>
                        <th class="text-center"><spring:message code="global.quantity"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${inventoryByOrders}">
                        <c:choose>
                            <c:when test="${order.status == 0}">
                                <tr class="table-accent">
                            </c:when>
                            <c:when test="${order.status == 1}">
                                <tr class="table-success">
                            </c:when>
                            <c:when test="${order.status == 2}">
                                <tr class="table-warning">
                            </c:when>
                            <c:when test="${order.status == 3}">
                                <tr class="table-danger">
                            </c:when>
                        </c:choose>
                        <td>
                            <c:choose>
                                <c:when test="${order.status == 0}">
                                    <span class="badge fs-ms rounded-pill bg-info m-0"><spring:message code="global.in_progress"/></span>
                                </c:when>
                                <c:when test="${order.status == 1}">
                                    <span class="badge fs-ms rounded-pill bg-success m-0"><spring:message code="global.delivered"/></span>
                                </c:when>
                                <c:when test="${order.status == 2}">
                                    <span class="badge fs-ms rounded-pill bg-warning m-0"><spring:message code="global.delayed"/></span>
                                </c:when>
                                <c:when test="${order.status == 3}">
                                    <span class="badge fs-ms rounded-pill bg-danger m-0"><spring:message code="global.canceled"/></span>
                                </c:when>
                            </c:choose>
                        </td>
                        <td class="text-center">${order.quantity}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function (event) {
        var scrollpos = sessionStorage.getItem('scrollpos');
        if (scrollpos) window.scrollTo(0, scrollpos);
        sessionStorage.removeItem('scrollpos');
    });

    window.onbeforeunload = function (e) {
        sessionStorage.setItem('scrollpos', window.scrollY);
    };
</script>

