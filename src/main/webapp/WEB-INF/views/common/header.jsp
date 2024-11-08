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
		<link href="${pageContext.request.contextPath}/resources/daterangepicker/daterangepicker.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/select2/select2.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/datatables/datatables.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/projectCreating.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/issueCreating.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	</head>
<body>
	<header class="d-flex align-items-center">
		<div class="logo-container border-end h-100 d-flex align-items-center">
			<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="flowMate" class="logo" onclick="location.href='${pageContext.request.contextPath}'" style="cursor:pointer;">
		</div>
		<div class="header-contents border-bottom flex-grow-1 ps-4 pe-4 d-flex align-items-center justify-content-between h-100">
			<div class="d-flex align-items-center">
				<div class="dropdown me-3">
					<a class="project-toggle dropdown-toggle pb-3 fw-semibold" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">프로젝트</a>
					<ul class="dropdown-menu">
		            	<li>
		            		<small class="dropdown-header" style="font-weight: 700; color: #55595c; font-size: 12px;">
		            			최근 조회
		            		</small>
		            		<c:choose>
		            			<c:when test="${not empty projectData}">
				            		<a class="dropdown-item" href="${pageContext.request.contextPath}/project/projectBoard?projectId=${projectData.projectId}" style="font-weight: 400;">
				            		${projectData.projectName} (${projectData.projectId})<span class="badge rounded-pill bg-info ms-2">${projectData.projectState}</span>
				            		</a>
				            	</c:when>
				            	<c:otherwise>
				            		<span class="dropdown-item">없음</span>
				            	</c:otherwise>
				            </c:choose>
			            </li>
			            <li class="dropdown-divider"></li>
			            <li>
			            	<a class="dropdown-item" href="${pageContext.request.contextPath}/mypage/myProject">참여 프로젝트 보기</a>
			            <li>
		            </ul>
		        </div>
		        <sec:authorize access="hasRole('ROLE_PM')">
		        	<button type="button" class="new-project btn btn-outline-primary ms-3" data-bs-toggle="modal" data-bs-target="#projectCreating" data-mode="create">
		        		새 프로젝트
		        	</button>
		        </sec:authorize>
	        	<%@ include file="/WEB-INF/views/project/projectCreating.jsp" %>
	        </div>
	        <div class="header-right d-flex align-items-center">
		        <sec:authorize access="isAnonymous()">
			        <div class="fw-semibold" onclick="location.href='${pageContext.request.contextPath}/account/loginForm'" style="cursor:pointer;">로그인</div>
			    </sec:authorize>    
			    <sec:authorize access="isAuthenticated()">
			        <div class="fw-semibold" onclick="location.href='${pageContext.request.contextPath}/logout'" style="cursor:pointer;">로그아웃</div>
			    </sec:authorize>   
		        <a href="${pageContext.request.contextPath}/message/messageBox">
			        <div class="messages-icon ms-4">
		                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-envelope iconSize" viewBox="0 0 16 16">
		                	<path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"/>
						</svg>
						<span class="badge rounded-pill bg-danger msg-badge"></span>
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
	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/daterangepicker/moment.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/daterangepicker/daterangepicker.js"></script>
	<script src="${pageContext.request.contextPath}/resources/select2/select2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/datatables/datatables.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/projectCreating.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/issueCreating.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script src="https://cdn.jsdelivr.net/sockjs/1.1.4/sockjs.min.js"></script>
</body>
</html>