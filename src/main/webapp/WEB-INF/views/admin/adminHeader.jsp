<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>헤더</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/select2/select2.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/datatables/datatables.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	</head>
<body>
	<header class="d-flex align-items-center">
		<div class="logo-container border-end h-100 d-flex align-items-center">
			<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="flowMate" class="logo" onclick="location.href='${pageContext.request.contextPath}/admin/adminPage'" style="cursor:pointer;">
		</div>
		<div class="header-contents border-bottom flex-grow-1 ps-4 pe-4 d-flex align-items-center justify-content-between h-100">
	        <div class="header-right d-flex align-items-center ms-auto">
		        <sec:authorize access="isAnonymous()">
			        <div class="fw-semibold" onclick="location.href='${pageContext.request.contextPath}/account/loginForm'" style="cursor:pointer;">로그인</div>
			    </sec:authorize>    
			    <sec:authorize access="isAuthenticated()">
			        <div class="fw-semibold" onclick="location.href='${pageContext.request.contextPath}/logout'" style="cursor:pointer;">로그아웃</div>
			    </sec:authorize>   
	        </div>
		</div>
	</header>
	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/select2/select2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/datatables/datatables.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
</body>
</html>