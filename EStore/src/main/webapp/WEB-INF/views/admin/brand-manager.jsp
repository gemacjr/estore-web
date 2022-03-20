<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-12
  Time: 7:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!-- Modal -->
<div class="modal fade" id="brandModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <spring:message code="global.brand"/>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body tab-content py-4">
                <form id="brand-info-frm" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label for="name" class="form-label"><spring:message code="global.name"/></label>
                        <input class="form-control" type="text" id="name" onkeyup="autoSlug('name', 'slug')" required>
                        <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                    </div>
                    <div class="mb-3">
                        <label for="slug" class="form-label">Slug</label>
                        <input class="form-control" type="text" id="slug" required>
                        <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                    </div>
                </form>
            </div>
            <div class="modal-footer btn-group">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                    <spring:message code="global.close"/>
                </button>
                <button type="submit" class="btn btn-primary btn-sm" id="btn-submit" form="brand-info-frm">
                    <spring:message code="global.save"/>
                </button>
            </div>
        </div>
    </div>
</div>
<!-- Title-->
<div class="d-sm-flex flex-wrap justify-content-between align-items-center border-bottom pb-4 mb-4">
    <h2 class="h3 m-0 text-center text-sm-start">
        <spring:message code="admin.brandPage.title"/><span
            class="badge bg-faded-accent fs-sm text-body align-middle ms-2">${brands.size()}</span>
    </h2>
    <div data-bs-toggle="tooltip" data-bs-placement="left" title="<spring:message code="admin.brandPage.add"/>">
        <a class="link-success" href="javascript:void(0)" data-bs-toggle="modal" onclick="newBrand()"
           data-bs-target="#brandModal">
            <i class="fs-2 fa-regular fa-circle-plus"></i>
        </a>
    </div>
</div>
<!-- Color borders on tables -->
<div class="table-responsive">
    <table class="table border-accent" id="brand-table">
        <thead>
        <tr>
            <th>#</th>
            <th><spring:message code="global.name"/></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="brand" items="${brands}">
            <tr>
                <th class="align-middle" scope="row">${stt = stt + 1}</th>
                <td class="align-middle">${brand.name}</td>
                <td class="align-middle fs-5">
                    <div class="d-flex justify-content-center">
                        <a class="link-info me-2" href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#brandModal"
                           onclick="getBrand('${brand.slug}')">
                            <i class="fa-regular fa-pen-to-square"></i>
                        </a>
                        <a class="link-danger" href="#" onclick="removeBrand('${brand.slug}')">
                            <i class="fa-regular fa-circle-minus"></i>
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>