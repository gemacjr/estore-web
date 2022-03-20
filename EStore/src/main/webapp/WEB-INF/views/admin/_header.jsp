<%--
  Created by IntelliJ IDEA.
  User: MinhNH
  Date: 2022-02-10
  Time: 2:47 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Dashboard header-->
<div class="page-title-overlap bg-accent pt-4">
  <div class="container-fluid d-flex flex-wrap flex-sm-nowrap justify-content-center justify-content-sm-between align-items-center pt-2">
    <div class="d-flex align-items-center pb-3">
      <div class="img-thumbnail rounded-circle position-relative flex-shrink-0" style="width: 6.375rem;">
        <img class="rounded-circle" src="/assets/user/img/avatar/${currentUser.photo}" alt="${currentUser.fullname}">
      </div>
      <div class="ps-3">
        <h3 class="text-light fs-lg mb-0">${currentUser.fullname}</h3>
        <span class="d-block text-light fs-ms opacity-60 py-1">${currentUser.email}</span>
      </div>
    </div>
    <div class="d-flex justify-content-center align-items-center mb-3">
      <a class="bg-light rounded-pill p-2 me-2" href="?lang=vi"><span class="fi fi-vn"></span></a>
      <a class="bg-light rounded-pill p-2 me-5" href="?lang=en"><span class="fi fi-us"></span></a>
      <a class="bg-light rounded p-2" href="/home">
        <img class="" src="${pageContext.request.contextPath}/assets/user/img/logo.png" width="142"></a>
      </a>
    </div>
  </div>
</div>
