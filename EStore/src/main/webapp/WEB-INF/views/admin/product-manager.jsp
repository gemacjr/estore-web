<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-11
  Time: 2:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- Modal -->
<div class="modal fade" id="productDetailModal" data-bs-focus="false" data-bs-backdrop="static"
     data-bs-keyboard="false" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <spring:message code="admin.productPage.editModal.title"/>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body tab-content py-4">
                <form id="create-product-frm" class="needs-validation" method="post" enctype="multipart/form-data" novalidate>
                    <div class="d-sm-flex flex-wrap justify-content-end align-items-center pb-2">
                        <div class="d-flex flex-nowrap align-items-center py-2">
                            <label class="form-label fw-normal text-nowrap mb-0 me-2"
                                   for="unp-category">
                                <spring:message code="global.category"/>
                            </label>
                            <select class="form-select form-select-sm me-2" id="unp-category"
                                    name="categoryId">
                                <c:forEach items="${categories}" var="category">
                                    <option value="${category.id}">
                                        <c:choose>
                                            <c:when test="${pageContext.response.locale.language == 'vi'}">
                                                ${category.nameVI}
                                            </c:when>
                                            <c:otherwise>
                                                ${category.nameEN}
                                            </c:otherwise>
                                        </c:choose>
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="d-flex flex-nowrap align-items-center me-3">
                            <label class="form-label fw-normal text-nowrap mb-0 me-2"
                                   for="unp-brand">
                                <spring:message code="global.brand"/>
                            </label>
                            <select class="form-select form-select-sm" id="unp-brand"
                                    name="brandId">
                                <c:forEach items="${brands}" var="brand">
                                    <option value="${brand.id}">
                                            ${brand.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <input type="hidden" name="id"/>
                    <div class="mb-3 pb-2">
                        <label class="form-label" for="unp-product-name">
                            <spring:message code="admin.productPage.productName"/>
                        </label>
                        <input class="form-control" type="text" id="unp-product-name"
                               name="name" onkeyup="autoSlug('unp-product-name', 'unp-product-slug')"
                               required>
                    </div>
                    <div class="mb-3 pb-2">
                        <label class="form-label" for="unp-product-slug">
                            <spring:message code="admin.productPage.productSlug"/>
                        </label>
                        <input class="form-control" type="text" id="unp-product-slug" name="slug" required>
                        <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                    </div>
                    <div class="file-drop-area mb-3" onclick="changeProductImage(this)">
                        <div class="file-drop-preview img-thumbnail rounded">
                            <img class="unp-product-img" src="/assets/user/img/plus_icon.png" alt="Product image">
                        </div>
                        <button class="file-drop-btn btn btn-primary btn-sm mb-2" type="button"
                                onclick="changeProductImage(this)">
                            <spring:message code="admin.productPage.uploadProductPhoto.button"/>
                        </button>
                        <input type="hidden" name="image" class="product-img">
                        <div class="form-text"><spring:message
                                code="admin.productPage.uploadProductPhoto.note"/></div>
                    </div>
                    <div class="row mb-3 justify-content-center">
                        <div class="col-md-2" data-bs-toggle="tooltip"
                             title="<spring:message code="admin.productPage.productPicture"/>">
                            <input type="hidden" name="imagePreview1" class="product-preview">
                            <img class="img-thumbnail product-thumbnail"
                                 src="/assets/user/img/plus_icon.png" alt="Product preview image 1">
                        </div>
                        <div class="col-md-2" data-bs-toggle="tooltip"
                             title="<spring:message code="admin.productPage.productPicture"/>">
                            <input type="hidden" name="imagePreview2" class="product-preview">
                            <img class="img-thumbnail product-thumbnail"
                                 src="/assets/user/img/plus_icon.png" alt="Product preview image 2">
                        </div>
                        <div class="col-md-2" data-bs-toggle="tooltip"
                             title="<spring:message code="admin.productPage.productPicture"/>">
                            <input type="hidden" name="imagePreview3" class="product-preview">
                            <img class="img-thumbnail product-thumbnail"
                                 src="/assets/user/img/plus_icon.png" alt="Product preview image 3">
                        </div>
                        <div class="col-md-2" data-bs-toggle="tooltip"
                             title="<spring:message code="admin.productPage.productPicture"/>">
                            <input type="hidden" name="imagePreview4" class="product-preview">
                            <img class="img-thumbnail product-thumbnail"
                                 src="/assets/user/img/plus_icon.png" alt="Product preview image 4">
                        </div>
                        <div class="col-md-4" data-bs-toggle="tooltip"
                             title="<spring:message code="admin.productPage.productReviewVideo"/>"
                             id="unp-product-video-thumbnail">
                            <input type="hidden" name="videoPreview" class="product-preview">
                            <img class="img-thumbnail product-video-thumbnail"
                                 src="/assets/user/img/video-play-button.png" alt="Video preview">
                        </div>
                    </div>
                    <div class="mb-3 pb-2">
                        <label class="form-label" for="unp-product-description">
                            <spring:message code="admin.productPage.productDescription"/>
                        </label>
                        <textarea class="form-control" rows="4" id="unp-product-description"
                                  name="description" required></textarea>
                    </div>
                    <div class="mb-3 pb-2">
                        <label class="form-label" for="unp-discount">
                            <spring:message code="global.promotion"/>
                        </label>
                        <select class="form-select" id="unp-discount" name="discountId">
                            <option value=""><spring:message code="global.no_promotion"/></option>
                            <c:forEach items="${discounts}" var="discount">
                                <option value="${discount.id}">
                                        <fmt:formatNumber value="${discount.saleOff}" type="number"/>%
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3 pb-2">
                        <label class="form-label me-4">
                            <spring:message code="admin.productPage.productStatus"/>
                        </label>
                        <!-- Inline radio buttons -->
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="in-stock"
                                   value="0" name="available" checked required>
                            <label class="form-check-label" for="in-stock">
                                <spring:message code="admin.productPage.inStock"/>
                            </label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" id="out-of-stock"
                                   value="1" name="available" required>
                            <label class="form-check-label" for="out-of-stock">
                                <spring:message code="admin.productPage.outOfStock"/>
                            </label>
                        </div>
                        <div class="form-check form-check-inline"
                             onclick="visibilityProductAvailable(false, '${product.id}')">
                            <input class="form-check-input" type="radio" id="sold-out"
                                   value="2" name="available" required>
                            <label class="form-check-label" for="sold-out">
                                <spring:message code="admin.productPage.soldOut"/>
                            </label>
                        </div>
                    </div>
                    <div class="row"
                         id="product-available">
                        <div class="col-sm-6 mb-3">
                            <label class="form-label" for="unp-product-quantity">
                                <spring:message code="admin.productPage.productQuantity"/>
                            </label>
                            <div class="input-group"><span class="input-group-text"><i
                                    class="fa-solid fa-input-numeric"></i></span>
                                <input class="form-control" min="0" type="number"
                                       id="unp-product-quantity"
                                       name="quantity" name="quantity">
                            </div>
                        </div>
                        <div class="col-sm-6 mb-3">
                            <label class="form-label" for="unp-product-price">
                                <spring:message code="admin.productPage.productPrice"/>
                            </label>
                            <div class="input-group"><span class="input-group-text"><i
                                    class="fa-solid fa-money-bill-simple"></i></span>
                                <input class="form-control number-input" type="number"
                                       id="unp-product-price"
                                       name="price">
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer btn-group">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                    <spring:message code="global.close"/>
                </button>
                <button type="submit" class="btn btn-primary btn-sm" form="create-product-frm">
                    <spring:message code="global.save"/>
                </button>
            </div>
        </div>
    </div>
</div>
<c:forEach var="product" items="${products}">
    <div class="modal fade" id="productDetailModal${product.id}" data-bs-backdrop="static" data-bs-focus="false"
         data-bs-keyboard="false" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <spring:message code="admin.productPage.editModal.title"/>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body tab-content py-4">
                    <form id="edit-product-frm-${product.id}" class="product-frm needs-validation" novalidate>
                        <div class="d-sm-flex flex-wrap justify-content-end align-items-center pb-2">
                            <div class="d-flex flex-nowrap align-items-center py-2">
                                <label class="form-label fw-normal text-nowrap mb-0 me-2"
                                       for="unp-category-${product.id}">
                                    <spring:message code="global.category"/>
                                </label>
                                <select class="form-select form-select-sm me-2" id="unp-category-${product.id}"
                                        name="categoryId">
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.id}" ${category.slug == product.category.slug ? 'selected': ''}>
                                            <c:choose>
                                                <c:when test="${pageContext.response.locale.language == 'vi'}">
                                                    ${category.nameVI}
                                                </c:when>
                                                <c:otherwise>
                                                    ${category.nameEN}
                                                </c:otherwise>
                                            </c:choose>
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="d-flex flex-nowrap align-items-center me-3">
                                <label class="form-label fw-normal text-nowrap mb-0 me-2"
                                       for="unp-brand-${product.id}">
                                    <spring:message code="global.brand"/>
                                </label>
                                <select class="form-select form-select-sm" id="unp-brand-${product.id}"
                                        name="brandId">
                                    <c:forEach items="${brands}" var="brand">
                                        <option value="${brand.id}" ${brand.slug == product.brand.slug ? 'selected': ''}>
                                                ${brand.name}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <input type="hidden" name="id" value="${product.id}"/>
                        <div class="mb-3 pb-2">
                            <label class="form-label" for="unp-product-name-${product.id}">
                                <spring:message code="admin.productPage.productName"/>
                            </label>
                            <input class="form-control" type="text" id="unp-product-name-${product.id}"
                                   value="${product.name}" name="name"
                                   onkeyup="autoSlug('unp-product-name-${product.id}', 'unp-product-slug-${product.id}')"
                                   required>
                        </div>
                        <div class="mb-3 pb-2">
                            <label class="form-label" for="unp-product-slug-${product.id}">
                                <spring:message code="admin.productPage.productSlug"/>
                            </label>
                            <input class="form-control" type="text" id="unp-product-slug-${product.id}"
                                   value="${product.slug}" data-slug="${product.slug}" name="slug" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                        <div class="file-drop-area mb-3" onclick="changeProductImage(this)">
                            <div class="file-drop-preview img-thumbnail rounded">
                                <img class="unp-product-img" src="${product.image}" alt="${product.name}">
                            </div>
                            <button class="file-drop-btn btn btn-primary btn-sm mb-2" type="button"
                                    onclick="changeProductImage(this)">
                                <spring:message code="admin.productPage.uploadProductPhoto.button"/>
                            </button>
                            <input type="hidden" name="image" class="product-img" value="${product.image}">
                            <div class="form-text"><spring:message
                                    code="admin.productPage.uploadProductPhoto.note"/></div>
                        </div>
                        <div class="row mb-3 justify-content-center">
                            <div class="col-md-2" data-bs-toggle="tooltip"
                                 title="<spring:message code="admin.productPage.productPicture"/>">
                                <input type="hidden" name="imagePreview1" class="product-preview"
                                       value="${product.imagePreview1}">
                                <img class="img-thumbnail product-thumbnail"
                                     id="unp-product-thumbnail-${product.id}"
                                     src="${not empty product.imagePreview1 ? product.imagePreview1 : '/assets/user/img/plus_icon.png'}"
                                     alt="${product.name}">
                            </div>
                            <div class="col-md-2" data-bs-toggle="tooltip"
                                 title="<spring:message code="admin.productPage.productPicture"/>">
                                <input type="hidden" name="imagePreview2" class="product-preview"
                                       value="${product.imagePreview2}">
                                <img class="img-thumbnail product-thumbnail"
                                     id="unp-product-thumbnail-${product.id}"
                                     src="${not empty product.imagePreview2 ? product.imagePreview2 : '/assets/user/img/plus_icon.png'}"
                                     alt="${product.name}">
                            </div>
                            <div class="col-md-2" data-bs-toggle="tooltip"
                                 title="<spring:message code="admin.productPage.productPicture"/>">
                                <input type="hidden" name="imagePreview3" class="product-preview"
                                       value="${product.imagePreview3}">
                                <img class="img-thumbnail product-thumbnail"
                                     id="unp-product-thumbnail-${product.id}"
                                     src="${not empty product.imagePreview3 ? product.imagePreview3 : '/assets/user/img/plus_icon.png'}"
                                     alt="${product.name}">
                            </div>
                            <div class="col-md-2" data-bs-toggle="tooltip"
                                 id="unp-product-thumbnail-${product.id}"
                                 title="<spring:message code="admin.productPage.productPicture"/>">
                                <input type="hidden" name="imagePreview4" class="product-preview"
                                       value="${product.imagePreview4}">
                                <img class="img-thumbnail product-thumbnail"
                                     src="${not empty product.imagePreview4 ? product.imagePreview4 : '/assets/user/img/plus_icon.png'}"
                                     alt="${product.name}">
                            </div>
                            <div class="col-md-4" data-bs-toggle="tooltip"
                                 title="<spring:message code="admin.productPage.productReviewVideo"/>"
                                 id="unp-product-video-thumbnail-${product.id}">
                                <input type="hidden" name="videoPreview" class="product-preview"
                                       value="${product.videoPreview}">
                                <img class="img-thumbnail product-video-thumbnail"
                                     src="https://img.youtube.com/vi/${product.videoPreview}/maxresdefault.jpg"
                                     alt="${product.name}" data-id="${product.videoPreview}">
                            </div>
                        </div>
                        <div class="mb-3 pb-2">
                            <label class="form-label" for="unp-product-description-${product.id}">
                                <spring:message code="admin.productPage.productDescription"/>
                            </label>
                            <textarea class="form-control" rows="4" id="unp-product-description-${product.id}"
                                      name="description" required>${product.description}</textarea>
                        </div>
                        <div class="mb-3 pb-2">
                            <label class="form-label" for="unp-discount-${product.id}">
                                <spring:message code="global.promotion"/>
                            </label>
                            <select class="form-select" id="unp-discount-${product.id}" name="discountId">
                                <option value=""><spring:message code="global.no_promotion"/></option>
                                <c:forEach items="${discounts}" var="discount">
                                    <option value="${discount.id}" ${discount.id == product.discount.id ? 'selected' : ''}>
                                        <fmt:formatNumber value="${discount.saleOff}" type="number"/>%
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3 pb-2">
                            <label class="form-label me-4">
                                <spring:message code="admin.productPage.productStatus"/>
                            </label>
                            <!-- Inline radio buttons -->
                            <div class="form-check form-check-inline"
                                 onclick="visibilityProductAvailable(true, '${product.id}')">
                                <input class="form-check-input" type="radio" id="in-stock-${product.id}"
                                       value="0"
                                       name="available" ${product.available == 0 ? 'checked' : ''}
                                       required>
                                <label class="form-check-label" for="in-stock-${product.id}">
                                    <spring:message code="admin.productPage.inStock"/>
                                </label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" id="out-of-stock-${product.id}"
                                       value="1"
                                       name="available"  ${product.available == 1 ? 'checked' : ''}
                                       required>
                                <label class="form-check-label" for="out-of-stock-${product.id}">
                                    <spring:message code="admin.productPage.outOfStock"/>
                                </label>
                            </div>
                            <div class="form-check form-check-inline"
                                 onclick="visibilityProductAvailable(false, '${product.id}')">
                                <input class="form-check-input" type="radio" id="sold-out-${product.id}"
                                       value="2"
                                       name="available"  ${product.available == 2 ? 'checked' : ''}
                                       required>
                                <label class="form-check-label" for="sold-out-${product.id}">
                                    <spring:message code="admin.productPage.soldOut"/>
                                </label>
                            </div>
                        </div>
                        <div class="row ${product.available != 0 ? 'd-none' : ''}"
                             id="product-available-${product.id}">
                            <div class="col-sm-6 mb-3">
                                <label class="form-label" for="unp-product-quantity-${product.id}">
                                    <spring:message code="admin.productPage.productQuantity"/>
                                </label>
                                <div class="input-group"><span class="input-group-text"><i
                                        class="fa-solid fa-input-numeric"></i></span>
                                    <input class="form-control" min="0" type="number"
                                           id="unp-product-quantity-${product.id}"
                                           name="quantity" value="${product.quantity}" name="quantity"
                                        ${product.available == 0 ? 'required' : 'disabled'}>
                                </div>
                            </div>
                            <div class="col-sm-6 mb-3">
                                <label class="form-label" for="unp-product-price-${product.id}">
                                    <spring:message code="admin.productPage.productPrice"/>
                                </label>
                                <div class="input-group"><span class="input-group-text"><i
                                        class="fa-solid fa-money-bill-simple"></i></span>
                                    <input class="form-control number-input" type="number"
                                           id="unp-product-price-${product.id}"
                                           value="<fmt:formatNumber value="${product.price}" type="number" pattern="#.###"/>"
                                           name="price" ${product.available == 0 ? 'required' : 'disabled'}>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer btn-group">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                        <spring:message code="global.close"/>
                    </button>
                    <button type="submit" class="btn btn-primary btn-sm" form="edit-product-frm-${product.id}">
                        <spring:message code="global.save"/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
<!-- Title-->
<div class="d-sm-flex flex-wrap justify-content-between align-items-center border-bottom pb-4 mb-4">
    <h2 class="h3 m-0 text-center text-sm-start">
        <spring:message code="admin.productPage.title"/>
    </h2>
    <div class="d-flex align-items-center">
        <div class="d-flex flex-nowrap align-items-center me-3">
            <label class="form-label fw-normal text-nowrap mb-0 me-2" for="category-selector">
                <spring:message code="global.category"/>
            </label>
            <select class="form-select form-select-sm" id="category-selector" onchange="getProducts()">
                <c:forEach items="${categories}" var="category">
                    <c:if test="${category.products.size() > 0}">
                        <option value="${category.slug}" ${category.slug == categorySlug ? 'selected': ''}>
                            <c:choose>
                                <c:when test="${pageContext.response.locale.language == 'vi'}">
                                    ${category.nameVI}
                                </c:when>
                                <c:otherwise>
                                    ${category.nameEN}
                                </c:otherwise>
                            </c:choose>
                        </option>
                    </c:if>
                </c:forEach>
            </select>
        </div>
        <div class="d-flex flex-nowrap align-items-center me-3">
            <label class="form-label fw-normal text-nowrap mb-0 me-2" for="brand-selector">
                <spring:message code="global.brand"/>
            </label>
            <select class="form-select form-select-sm" id="brand-selector" onchange="getProducts()">
                <c:forEach items="${brandsByCategory}" var="brand">
                    <option value="${brand.slug}" ${brand.slug == brandSlug ? 'selected': ''}>
                            ${brand.name}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div data-bs-toggle="tooltip" data-bs-placement="top" title="<spring:message code="admin.productPage.addProduct"/>">
            <a class="link-success" href="javascript:void(0)" onclick="newCategory()"
               data-bs-toggle="modal" data-bs-target="#productDetailModal"><i class="fs-2 fa-regular fa-circle-plus"></i></a>
        </div>
    </div>
</div>
<!-- Color borders on tables -->
<div class="table-responsive">
    <table class="table" id="product-table">
        <thead>
        <tr>
            <th><spring:message code="global.photo"/></th>
            <th><spring:message code="global.name"/></th>
            <th><spring:message code="global.brand"/></th>
            <th class="text-center"><spring:message code="global.quantity"/></th>
            <th class="text-center"><spring:message code="global.price"/></th>
            <th class="text-center"><spring:message code="global.status"/></th>
            <th class="text-center"><spring:message code="global.promotion"/></th>
            <th class="text-center"></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td class="align-middle">
                    <img class="img-fluid" src="${product.image}" alt="${product.name}" style="width: 100px; height: 100px"/>
                </td>
                <td class="align-middle">
                    <a class="link-primary" href="/product-detail/${product.slug}">${product.name}</a>
                </td>
                <td class="align-middle text-center">
                        ${product.brand.name}
                </td>
                <td class="align-middle text-center">
                        ${product.quantity}
                </td>
                <td class="align-middle text-center">
                    <fmt:formatNumber value="${product.price}" type="number"/>₫
                </td>
                <td class="align-middle text-center fs-lg">
                    <c:choose>
                        <c:when test="${product.available == 0}">
                            <span class="badge bg-success">
                                <spring:message code="global.in_stock"/>
                            </span>
                        </c:when>
                        <c:when test="${product.available == 1}">
                            <span class="badge bg-warning">
                                <spring:message code="global.out_of_stock"/>
                            </span>
                        </c:when>
                        <c:when test="${product.available == 2}">
                            <span class="badge bg-danger">
                                <spring:message code="global.sold_out"/>
                            </span>
                        </c:when>
                    </c:choose>
                </td>
                <td class="align-middle text-center fs-lg">
                    <c:if test="${not empty product.discount}">
                        <span class="badge bg-danger rounded-pill">
                            <fmt:formatNumber value="${product.discount.saleOff}" type="number"/>%
                        </span>
                    </c:if>
                </td>
                <td class="align-middle text-center fs-5">
                    <div class="d-flex justify-content-center">
                        <a class="btn bg-faded-accent btn-icon me-2" href="javascript:void(0)" data-bs-toggle="modal"
                           data-bs-target="#productDetailModal${product.id}">
                            <i class="fa-regular fa-pen-to-square"></i>
                        </a>
                        <a class="btn bg-faded-danger btn-icon" href="javascript:void(0)" onclick="removeProduct('${product.slug}')">
                            <i class="fa-regular fa-circle-minus"></i>
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>