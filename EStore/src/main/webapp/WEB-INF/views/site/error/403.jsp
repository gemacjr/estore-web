<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-09
  Time: 11:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<div class="container py-5 mb-lg-3">
    <div class="row justify-content-center pt-lg-4 text-center">
        <div class="col-lg-5 col-md-7 col-sm-9">
            <img class="d-block mx-auto mb-5" src="/assets/user/img/pages/404.png" width="340"
                 alt="<spring:message code='home.error.forbidden.title'/>">
            <h1 class="h3"><spring:message code='home.error.forbidden.title'/></h1>
            <h3 class="h5 fw-normal mb-4"><spring:message code='home.error.forbidden.message'/></h3>
            <p class="fs-md mb-4" style="cursor: pointer" onclick="window.history.go(-1); return false;">
                <u><i class="text-body ci-arrow-left-circle me-1"></i><spring:message code='home.error.goBack'/></u>
            </p>
        </div>
    </div>
</div>