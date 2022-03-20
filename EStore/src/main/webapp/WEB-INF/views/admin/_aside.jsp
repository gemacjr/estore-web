<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-10
  Time: 3:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!-- Account menu toggler (hidden on screens larger 992px)-->
<div class="d-block d-lg-none p-4">
    <a class="btn btn-outline-accent d-block" href="#manage-menu" data-bs-toggle="collapse"><i
            class="ci-settings me-2"></i><spring:message code="global.manage"/></a>
    <a class="btn btn-outline-accent d-block" href="#statistic-menu" data-bs-toggle="collapse"><i
            class="ci-view-list me-2"></i><spring:message code="global.statistic"/></a>
    <a class="btn btn-outline-accent d-block" href="#account-menu" data-bs-toggle="collapse"><i
            class="ci-user-circle me-2"></i><spring:message code="global.account"/></a>
</div>
<!-- Actual menu-->
<div class="h-100 border-end mb-2">
    <div class="d-lg-block collapse" id="statistic-menu">
        <div class="bg-secondary p-4">
            <h3 class="fs-sm mb-0 text-muted"><spring:message code="global.statistic"/></h3>
        </div>
        <ul class="list-unstyled mb-0">
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center px-4 py-3" href="/dashboard/report">
                    <i class="ci-view-grid opacity-60 me-2"></i><spring:message code="admin.report.synthesis"/>
                </a>
            </li>
        </ul>
    </div>
    <div class="d-lg-block collapse" id="manage-menu">
        <div class="bg-secondary p-4">
            <h3 class="fs-sm mb-0 text-muted"><spring:message code="global.manage"/></h3>
        </div>
        <ul class="list-unstyled mb-0">
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center px-4 py-3" href="/dashboard/category-management">
                    <i class="ci-filter-alt opacity-60 me-2"></i><spring:message code="global.categories"/>
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center px-4 py-3" href="/dashboard/brand-management">
                    <i class="ci-globe opacity-60 me-2"></i><span class="m_title"><spring:message code="global.brand"/></span>
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center px-4 py-3" href="/dashboard/product-management">
                    <i class="ci-package opacity-60 me-2"></i><span class="m_title"><spring:message code="global.products"/></span>
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center px-4 py-3" href="/dashboard/user-management">
                    <i class="ci-user-circle opacity-60 me-2"></i><span class="m_title"><spring:message code="global.user"/></span>
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center px-4 py-3" href="/dashboard/discount-management">
                    <i class="ci-user-circle opacity-60 me-2"></i><span class="m_title"><spring:message code="global.promotion"/></span>
                </a>
            </li>
        </ul>
    </div>
    <div class="d-lg-block collapse" id="account-menu">
        <div class="bg-secondary p-4">
            <h3 class="fs-sm mb-0 text-muted"><spring:message code="global.account"/></h3>
        </div>
        <ul class="list-unstyled mb-0">
            <li class="mb-0">
                <a class="nav-link-style d-flex align-items-center px-4 py-3" href="/logout">
                    <i class="ci-sign-out opacity-60 me-2"></i><spring:message code="global.sign_out"/>
                </a>
            </li>
        </ul>
    </div>
    <hr>
</div>