<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
</head>
<body>
	<div class="flowmate-sidebar d-flex flex-column pt-3 border-end">
		<a href="${pageContext.request.contextPath}/admin/adminPage">	
			<div class="sidebar-menu d-flex align-items-center mb-1">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check2-all me-3" viewBox="0 0 16 16">
				  <path d="M12.354 4.354a.5.5 0 0 0-.708-.708L5 10.293 1.854 7.146a.5.5 0 1 0-.708.708l3.5 3.5a.5.5 0 0 0 .708 0zm-4.208 7-.896-.897.707-.707.543.543 6.646-6.647a.5.5 0 0 1 .708.708l-7 7a.5.5 0 0 1-.708 0"/>
				  <path d="m5.354 7.146.896.897-.707.707-.897-.896a.5.5 0 1 1 .708-.708"/>
				</svg>
				<span class="sidebar-menu-text ms-1">정상</span>
			</div>
		</a>
		<a href="${pageContext.request.contextPath}/admin/adminPageDisable">		
			<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-circle me-3" viewBox="0 0 16 16">
				  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
				  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
				</svg>
				<span class="sidebar-menu-text ms-1">비활성화</span>
			</div>
		</a>
		<a href="${pageContext.request.contextPath}/admin/adminPageStay">		
			<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-three-dots me-3" viewBox="0 0 16 16">
				  <path d="M3 9.5a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3m5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3m5 0a1.5 1.5 0 1 1 0-3 1.5 1.5 0 0 1 0 3"/>
				</svg>
				<span class="sidebar-menu-text ms-1">가입대기</span>
			</div>
		</a>
	</div>
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/mypage.js"></script> 
 --%>	<script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
</body>
</html>