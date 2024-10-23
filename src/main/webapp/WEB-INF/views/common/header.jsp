<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>헤더</title>
		<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	</head>
<body>
	<header class="d-flex align-items-center border-bottom">
		<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="flowMate" class="logo">
		<div class="flex-grow-1 ms-3 pe-4 d-flex align-items-center justify-content-between">
			<div class="d-flex align-items-center">
				<div class="dropdown me-3">
					<a class="project-toggle dropdown-toggle pb-3 fw-semibold" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">프로젝트</a>
					<div class="dropdown-menu">
			            <a class="dropdown-item" href="#">Action</a>
			            <div class="dropdown-divider"></div>
			            <a class="dropdown-item" href="#">모든 프로젝트 보기</a>
		            </div>
		        </div>
	        	<%@ include file="/WEB-INF/views/project/projectCreating.jsp" %>
	        </div>
	        <div class="header-right d-flex align-items-center">
		        <div class="fw-semibold">로그아웃</div>
		        <a href="${pageContext.request.contextPath}/mypage/messageBox">
			        <div class="messages-icon ms-4">
		                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-envelope iconSize" viewBox="0 0 16 16">
		                	<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"/>
						</svg>
					</div>
				</a>
				<a href="${pageContext.request.contextPath}">
					<div class="mypage-icon ms-4">
		                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
		                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
		                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
						</svg>
					</div>
				</a>
	        </div>
		</div>
	</header>
</body>
</html>