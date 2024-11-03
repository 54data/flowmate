<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet">
</head>
<body>
	<div class="flowmate-sidebar d-flex flex-column pt-3 border-end">
		<a href="${pageContext.request.contextPath}/admin/adminPage">	
			<div class="sidebar-menu d-flex align-items-center mb-1">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-layout-three-columns me-3" viewBox="0 0 16 16">
					<path d="M0 1.5A1.5 1.5 0 0 1 1.5 0h13A1.5 1.5 0 0 1 16 1.5v13a1.5 1.5 0 0 1-1.5 1.5h-13A1.5 1.5 0 0 1 0 14.5zM1.5 1a.5.5 0 0 0-.5.5v13a.5.5 0 0 0 .5.5H5V1zM10 15V1H6v14zm1 0h3.5a.5.5 0 0 0 .5-.5v-13a.5.5 0 0 0-.5-.5H11z"/>
				</svg>
				<span class="sidebar-menu-text ms-1">정상</span>
			</div>
		</a>
		<a href="${pageContext.request.contextPath}/admin/adminPageDisable">		
			<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-terminal me-3" viewBox="0 0 16 16">
					<path d="M6 9a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 0 1h-3A.5.5 0 0 1 6 9M3.854 4.146a.5.5 0 1 0-.708.708L4.793 6.5 3.146 8.146a.5.5 0 1 0 .708.708l2-2a.5.5 0 0 0 0-.708z"/>
					<path d="M2 1a2 2 0 0 0-2 2v10a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2zm12 1a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V3a1 1 0 0 1 1-1z"/>
				</svg>
				<span class="sidebar-menu-text ms-1">비활성화</span>
			</div>
		</a>
		<a href="${pageContext.request.contextPath}/admin/adminPageStay">		
			<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bag-plus-fill me-3" viewBox="0 0 16 16">
				    <path fill-rule="evenodd" d="M10.5 3.5a2.5 2.5 0 0 0-5 0V4h5zm1 0V4H15v10a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V4h3.5v-.5a3.5 3.5 0 1 1 7 0M8.5 8a.5.5 0 0 0-1 0v1.5H6a.5.5 0 0 0 0 1h1.5V12a.5.5 0 0 0 1 0v-1.5H10a.5.5 0 0 0 0-1H8.5z"/>
				</svg>
				<span class="sidebar-menu-text ms-1">가입대기</span>
			</div>
		</a>
	</div>
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/mypage.js"></script> 
 --%>	<script src="${pageContext.request.contextPath}/resources/js/admin.js"></script>
</body>
</html>