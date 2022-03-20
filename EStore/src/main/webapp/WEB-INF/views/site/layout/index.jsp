<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

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
		<tiles:insertAttribute name="body" />
	</main>
	<tiles:insertAttribute name="footer" />
	<tiles:insertAttribute name="script" />
</body>
</html>