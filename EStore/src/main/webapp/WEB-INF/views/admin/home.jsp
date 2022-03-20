<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <tiles:insertAttribute name="head" />
</head>

<body class="handheld-toolbar-enabled">
<input type="hidden" id="lang" value="${pageContext.response.locale.language}">
<input type="hidden" id="baseUrl" value="${pageContext.request.contextPath}">
<main class="page-wrapper">
    <tiles:insertAttribute name="header" />
    <div class="container-fluid mb-5 pb-3">
        <div class="bg-light shadow-lg rounded-3 overflow-hidden">
            <div class="row g-0">
                <!-- Sidebar-->
                <aside class="col-lg-2">
                    <tiles:insertAttribute name="aside" />
                </aside>
                <!-- Content-->
                <section class="col-lg-10 p-4">
                    <tiles:insertAttribute name="content" />
                </section>
            </div>
        </div>
    </div>
</main>
<tiles:insertAttribute name="script" />
<script src="${pageContext.request.contextPath}/assets/admin/js/main.js"></script>
</body>
</html>
