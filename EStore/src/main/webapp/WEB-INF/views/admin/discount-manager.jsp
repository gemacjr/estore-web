<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-21
  Time: 8:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!-- Title-->
<div class="d-sm-flex flex-wrap justify-content-between align-items-center border-bottom pb-4 mb-4">
    <h2 class="h3 m-0 text-center text-sm-start">
        <spring:message code="admin.discountPage.title"/><span
            class="badge bg-faded-accent fs-sm text-body align-middle ms-2">${discounts.size()}</span>
    </h2>
    <div data-bs-toggle="tooltip" data-bs-placement="left" title="<spring:message code="admin.discountPage.addPromotion"/>">
        <a class="link-success" href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#promotionModal">
            <i class="fs-2 fa-regular fa-circle-plus"></i>
        </a>
    </div>
</div>
<!-- Color borders on tables -->
<div class="table-responsive">
    <table class="table border-danger" id="discount-table">
        <thead>
        <tr>
            <th>#</th>
            <th><spring:message code="admin.discountPage.programName"/></th>
            <th class="align-middle text-center"><spring:message code="admin.discountPage.startDate"/></th>
            <th class="align-middle text-center"><spring:message code="admin.discountPage.endDate"/></th>
            <th class="align-middle text-center"><spring:message code="admin.discountPage.saleOff"/></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="discount" items="${discounts}">
            <tr>
                <td class="align-middle text-center">${stt = stt + 1}</td>
                <td class="align-middle text-center">${discount.name}</td>
                <td class="align-middle text-center">
                    <fmt:formatDate pattern="dd-MM-yyyy" value="${discount.startDate}"/>
                </td>
                <td class="align-middle text-center">
                    <fmt:formatDate pattern="dd-MM-yyyy" value="${discount.endDate}"/>
                </td>
                <td class="align-middle text-center">
                        <span class="badge bg-danger rounded-pill">
                            <fmt:formatNumber value="${discount.saleOff}" type="number"/>%
                        </span>
                </td>
                <td class="align-middle text-center">
                    <div class="d-flex justify-content-center">
                        <a class="btn bg-faded-accent btn-icon me-2" href="javascript:void(0)"
                           data-bs-toggle="modal" data-bs-target="#promotionModal${discount.id}">
                            <i class="fa-regular fa-pen-to-square"></i>
                        </a>
                        <c:if test="${user.email != pageContext.request.userPrincipal.name}">
                            <a class="btn bg-faded-danger btn-icon" href="javascript:void(0)"
                                onclick="removeDiscount('${discount.id}')">
                                <i class="fa-regular fa-circle-minus"></i>
                            </a>
                        </c:if>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<!-- Modal -->
<div class="modal fade" id="promotionModal${discount.id}" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <spring:message code="global.promotion"/>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body tab-content py-4">
                <form id="new-promotion-frm" class="promotion-form needs-validation" novalidate>
                    <div class="row">
                        <div class="mb-3 col-md-6">
                            <label for="name" class="form-label">
                                <spring:message code="admin.discountPage.programName"/>
                            </label>
                            <input class="form-control" type="text" id="name" name="name" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                        <div class="mb-3 col-md-6">
                            <label for="saleOff" class="form-label">
                                <spring:message code="admin.discountPage.saleOff"/>
                            </label>
                            <div class="input-group">
                                <input class="form-control" type="text" id="saleOff" name="saleOff" required>
                                <span class="input-group-text"><i class="ci-percent"></i></span>
                            </div>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="mb-3 col-md-6">
                            <!-- Date picker -->
                            <label class="form-label"><spring:message code="admin.discountPage.startDate"/></label>
                            <div class="input-group">
                                <input class="form-control date-picker rounded pe-5" type="text"
                                       placeholder="dd/mm/yyyy"
                                       data-datepicker-options='{"altInput": true, "altFormat": "d/m/Y", "dateFormat": "d/m/Y"}'
                                       name="startDate" >
                                <i class="fi-calendar position-absolute top-50 end-0 translate-middle-y me-3"></i>
                            </div>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                        <div class="mb-3 col-md-6">
                            <!-- Date picker -->
                            <label class="form-label"><spring:message code="admin.discountPage.startDate"/></label>
                            <div class="input-group">
                                <input class="form-control date-picker rounded pe-5" type="text"
                                       placeholder="dd/mm/yyyy"
                                       data-datepicker-options='{"altInput": true, "altFormat": "d/m/Y", "dateFormat": "d/m/Y"}'
                                       name="endDate" c>
                                <i class="fi-calendar position-absolute top-50 end-0 translate-middle-y me-3"></i>
                            </div>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer btn-group">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                    <spring:message code="global.close"/>
                </button>
                <button type="submit" class="btn btn-primary btn-sm" id="add-submit-btn" form="new-promotion-frm">
                    <spring:message code="global.save"/>
                </button>
            </div>
        </div>
    </div>
</div>
<c:forEach var="discount" items="${discounts}">
    <div class="modal fade" id="promotionModal${discount.id}" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <spring:message code="global.promotion"/>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body tab-content py-4">
                    <form id="edit-promotion-frm-${discount.id}" class="promotion-form needs-validation">
                        <input type="hidden" name="id" value="${discount.id}">
                        <div class="row">
                            <div class="mb-3 col-md-6">
                                <label for="name-${discount.id}" class="form-label">
                                    <spring:message code="admin.discountPage.programName"/>
                                </label>
                                <input class="form-control" type="text" id="name-${discount.id}"
                                       value="${discount.name}" name="name" required>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                            <div class="mb-3 col-md-6">
                                <label for="saleOff-${discount.id}" class="form-label">
                                    <spring:message code="admin.discountPage.saleOff"/>
                                </label>
                                <div class="input-group">
                                    <input class="form-control" type="text" id="saleOff-${discount.id}"
                                           value="<fmt:formatNumber value="${discount.saleOff}" type="number"/>"
                                           name="saleOff" required>
                                    <span class="input-group-text"><i class="ci-percent"></i></span>
                                </div>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="mb-3 col-md-6">
                                <!-- Date picker -->
                                <label class="form-label"><spring:message code="admin.discountPage.startDate"/></label>
                                <div class="input-group">
                                    <input class="form-control date-picker rounded pe-5" type="text"
                                           placeholder="dd/mm/yyyy"
                                           data-datepicker-options='{"altInput": true, "altFormat": "d/m/Y", "dateFormat": "d/m/Y",
                                            "defaultDate": "<fmt:formatDate value="${discount.startDate}" pattern="dd/MM/yyyy"/>"}'
                                           name="startDate" required>
                                    <i class="fi-calendar position-absolute top-50 end-0 translate-middle-y me-3"></i>
                                </div>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                            <div class="mb-3 col-md-6">
                                <!-- Date picker -->
                                <label class="form-label"><spring:message code="admin.discountPage.endDate"/></label>
                                <div class="input-group">
                                    <input class="form-control date-picker rounded pe-5" type="text"
                                           placeholder="dd/mm/yyyy"
                                           data-datepicker-options='{"altInput": true, "altFormat": "d/m/Y", "dateFormat": "d/m/Y",
                                            "defaultDate": "<fmt:formatDate value="${discount.endDate}" pattern="dd/MM/yyyy"/>"}'
                                           name="endDate" required>
                                    <i class="fi-calendar position-absolute top-50 end-0 translate-middle-y me-3"></i>
                                </div>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer btn-group">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                        <spring:message code="global.close"/>
                    </button>
                    <button type="submit" class="btn btn-primary btn-sm" id="edit-submit-btn"
                            form="edit-promotion-frm-${discount.id}">
                        <spring:message code="global.save"/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
