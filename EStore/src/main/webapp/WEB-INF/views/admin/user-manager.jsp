<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-20
  Time: 1:06 AM
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
        <spring:message code="admin.userPage.title"/><span
            class="badge bg-faded-accent fs-sm text-body align-middle ms-2">${users.size()}</span>
    </h2>
    <div data-bs-toggle="tooltip" data-bs-placement="left" title="<spring:message code="admin.userPage.add"/>">
        <a class="link-success" href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#user-modal">
            <i class="fs-2 fa-regular fa-circle-plus"></i>
        </a>
    </div>
</div>
<!-- Table -->
<div class="table-responsive">
    <table class="table border-danger" id="user-manager-table">
        <thead>
        <tr>
            <th>#</th>
            <th><spring:message code="global.avatar"/></th>
            <th><spring:message code="global.full_name"/></th>
            <th><spring:message code="global.username"/></th>
            <th><spring:message code="global.email"/></th>
            <th class="text-center"><spring:message code="global.role"/></th>
            <th class="text-center"><spring:message code="global.activated"/></th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${users}">
            <tr>
                <th class="align-middle" scope="row">${stt = stt + 1}</th>
                <td class="align-middle">
                    <img class="img-fluid rounded-circle" src="/assets/user/img/avatar/${user.photo}" style="width: 70px" alt="${user.fullname}">
                </td>
                <td class="align-middle">
                        ${user.fullname}
                </td>
                <td class="align-middle">
                        ${user.username}
                </td>
                <td class="align-middle">
                        ${user.email}
                </td>
                <td class="align-middle text-center">
                    <c:choose>
                        <c:when test="${user.admin}">
                            <span class="badge bg-accent">Admin</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-warning">User</span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="align-middle text-center">
                    <c:choose>
                        <c:when test="${user.enabled}">
                            <span class="text-success"><i class="fa-solid fa-check"></i></span>
                        </c:when>
                        <c:otherwise>
                            <span class="text-danger"><i class="fa-solid fa-xmark"></i></span>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td class="align-middle">
                    <div class="d-flex justify-content-center">
                        <a class="btn bg-faded-accent btn-icon me-2" href="javascript:void(0)" data-bs-toggle="modal"
                           data-bs-target="#user-modal-${user.id}">
                            <i class="fa-regular fa-pen-to-square"></i>
                        </a>
                        <c:if test="${user.email != pageContext.request.userPrincipal.name}">
                            <a class="btn bg-faded-danger btn-icon" href="javascript:void(0)" onclick="removeUser('${user.id}')">
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
<div class="modal fade" id="user-modal" data-bs-focus="false" data-bs-backdrop="static" data-bs-keyboard="false"
     tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <spring:message code="admin.userPage.userInfo"/>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body tab-content py-4">
                <form id="save-user-frm" class="save-user needs-validation" novalidate>
                    <div class="d-flex justify-content-end align-items-center mb-3">
                        <!-- Switch -->
                        <div class="form-check form-switch me-3">
                            <input type="checkbox" class="form-check-input" id="unp-user-enabled" name="enabled" checked>
                            <label class="form-check-label" for="unp-user-enabled">
                                <spring:message code="admin.userPage.activeAccount"/>
                            </label>
                        </div>
                        <!-- Switch -->
                        <div class="form-check form-switch">
                            <input type="checkbox" class="form-check-input" id="unp-user-is-admin" name="isAdmin">
                            <label class="form-check-label" for="unp-user-is-admin">
                                <spring:message code="admin.userPage.adminRights"/>
                            </label>
                        </div>
                    </div>
                    <!-- Drag and drop file upload -->
                    <label class="form-label"><spring:message code="global.avatar"/></label>
                    <div class="file-drop-area mb-3">
                        <div class="file-drop-preview img-thumbnail rounded avatar-preview">
                            <img src="/assets/user/img/avatar/default.png" alt="default">
                        </div>
                        <div class="file-drop-icon ci-cloud-upload"></div>
                        <span class="file-drop-message"><spring:message code="admin.upload.message"/></span>
                        <input type="file" class="file-drop-input" id="unp-user-photo" name="photo">
                        <button type="button" class="file-drop-btn btn btn-primary btn-sm" id="upload-photo-btn">
                            <spring:message code="admin.upload.dropButton"/>
                        </button>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="unp-user-username" class="form-label"><spring:message code="global.username"/></label>
                            <input class="form-control" type="text" id="unp-user-username" name="username" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="unp-user-password" class="form-label"><spring:message code="global.password"/></label>
                            <input class="form-control" type="password" id="unp-user-password" name="password" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="unp-user-email" class="form-label"><spring:message code="global.email"/></label>
                            <input class="form-control" type="email" id="unp-user-email" name="email" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="unp-user-fullname" class="form-label"><spring:message code="global.full_name"/></label>
                            <input class="form-control" type="text" id="unp-user-fullname" name="fullname" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="unp-user-address" class="form-label"><spring:message code="global.address"/></label>
                            <input class="form-control" type="text" id="unp-user-address" name="address" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="unp-user-phone-number" class="form-label"><spring:message
                                    code="global.phone_number"/></label>
                            <input class="form-control" type="text" id="unp-user-phone-number" name="phoneNumber" required>
                            <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer btn-group">
                <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                    <spring:message code="global.close"/>
                </button>
                <button type="submit" class="btn btn-primary btn-sm btn-save-user-submit" id="btn-save-user" form="save-user-frm">
                    <spring:message code="global.save"/>
                </button>
            </div>
        </div>
    </div>
</div>

<c:forEach items="${users}" var="user">
    <div class="modal fade" id="user-modal-${user.id}" data-bs-focus="false" data-bs-backdrop="static"
         data-bs-keyboard="false"
         tabindex="-1" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <spring:message code="admin.userPage.userInfo"/>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body tab-content py-4">
                    <form id="save-user-frm-${user.id}" class="save-user needs-validation" novalidate>
                        <input type="hidden" value="${user.id}" name="id">
                        <div class="d-flex justify-content-end align-items-center mb-3">
                            <!-- Switch -->
                            <div class="form-check form-switch me-3">
                                <input type="checkbox" class="form-check-input" id="unp-user-enabled-${user.id}"
                                       name="enabled" ${user.enabled ? 'checked' : ''}>
                                <label class="form-check-label" for="unp-user-enabled-${user.id}">
                                    <spring:message code="admin.userPage.activeAccount"/>
                                </label>
                            </div>
                            <!-- Switch -->
                            <div class="form-check form-switch">
                                <input type="checkbox" class="form-check-input" id="unp-user-is-admin-${user.id}"
                                       name="isAdmin" ${user.admin ? 'checked' : ''}>
                                <label class="form-check-label" for="unp-user-is-admin-${user.id}">
                                    <spring:message code="admin.userPage.adminRights"/>
                                </label>
                            </div>
                        </div>
                        <!-- Drag and drop file upload -->
                        <label class="form-label"><spring:message code="global.avatar"/></label>
                        <div class="file-drop-area mb-3">
                            <div class="file-drop-preview img-thumbnail rounded avatar-preview">
                                <img src="/assets/user/img/avatar/${user.photo}" alt="${user.photo}">
                            </div>
                            <div class="file-drop-icon ci-cloud-upload"></div>
                            <span class="file-drop-message"><spring:message code="admin.upload.message"/></span>
                            <input type="file" class="file-drop-input" id="unp-user-photo-${user.id}" name="photo">
                            <button type="button" class="file-drop-btn btn btn-primary btn-sm"
                                    id="upload-photo-btn-${user.id}">
                                <spring:message code="admin.upload.dropButton"/>
                            </button>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="unp-user-username-${user.id}" class="form-label"><spring:message
                                        code="global.username"/></label>
                                <input class="form-control" type="text" id="unp-user-username-${user.id}"
                                       name="username" value="${user.username}" disabled>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="unp-user-password-${user.id}" class="form-label"><spring:message
                                        code="global.password"/></label>
                                <input class="form-control" type="password" id="unp-user-password-${user.id}"
                                       name="password" value="${user.password}" required>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="unp-user-email-${user.id}" class="form-label"><spring:message
                                        code="global.email"/></label>
                                <input class="form-control" type="email" id="unp-user-email-${user.id}" name="email"
                                       value="${user.email}" disabled>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="unp-user-fullname-${user.id}" class="form-label"><spring:message
                                        code="global.full_name"/></label>
                                <input class="form-control" type="text" id="unp-user-fullname-${user.id}"
                                       name="fullname" value="${user.fullname}" required>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="unp-user-address-${user.id}" class="form-label"><spring:message
                                        code="global.address"/></label>
                                <input class="form-control" type="text" id="unp-user-address-${user.id}" name="address"
                                       value="${user.address}" required>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="unp-user-phone-number-${user.id}" class="form-label"><spring:message
                                        code="global.phone_number"/></label>
                                <input class="form-control" type="text" id="unp-user-phone-number-${user.id}"
                                       name="phoneNumber" value="${user.phoneNumber}" required>
                                <div class="invalid-tooltip"><spring:message code="NotBlank.field"/></div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer btn-group">
                    <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">
                        <spring:message code="global.close"/>
                    </button>
                    <button type="submit" class="btn btn-primary btn-sm btn-save-user-submit" id="btn-save-user-${user.id}"
                            form="save-user-frm-${user.id}">
                        <spring:message code="global.save"/>
                    </button>
                </div>
            </div>
        </div>
    </div>
</c:forEach>
