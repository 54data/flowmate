<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:set var="loginUserId">
	<sec:authentication property="principal.username"/>
</c:set>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
	</head>
	<body>				
		<div class="flowmate-sidebar d-flex flex-column pt-3 border-end min-vh-100">
			<a href="${pageContext.request.contextPath}/">		
				<div class="home-menu d-flex align-items-center mb-1">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-door-fill me-3" viewBox="0 0 16 16">
						<path d="M6.5 14.5v-3.505c0-.245.25-.495.5-.495h2c.25 0 .5.25.5.5v3.5a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4a.5.5 0 0 0 .5-.5"/>
					</svg>
					<span class="sidebar-menu-text ms-1">마이페이지</span>
				</div>
			</a>
			<div class="sidebar-menu-group-text mt-4">프로젝트 메뉴</div>
			<a href="${pageContext.request.contextPath}/project/projectBoard?projectId=${projectId}">		
				<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-layout-three-columns me-3" viewBox="0 0 16 16">
						<path d="M0 1.5A1.5 1.5 0 0 1 1.5 0h13A1.5 1.5 0 0 1 16 1.5v13a1.5 1.5 0 0 1-1.5 1.5h-13A1.5 1.5 0 0 1 0 14.5zM1.5 1a.5.5 0 0 0-.5.5v13a.5.5 0 0 0 .5.5H5V1zM10 15V1H6v14zm1 0h3.5a.5.5 0 0 0 .5-.5v-13a.5.5 0 0 0-.5-.5H11z"/>
					</svg>
					<span class="sidebar-menu-text ms-1">프로젝트 보드</span>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/project/projectTask?projectId=${projectId}">			
				<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-briefcase me-3" viewBox="0 0 16 16">
					  <path d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v8A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-8A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5m1.886 6.914L15 7.151V12.5a.5.5 0 0 1-.5.5h-13a.5.5 0 0 1-.5-.5V7.15l6.614 1.764a1.5 1.5 0 0 0 .772 0M1.5 4h13a.5.5 0 0 1 .5.5v1.616L8.129 7.948a.5.5 0 0 1-.258 0L1 6.116V4.5a.5.5 0 0 1 .5-.5"/>
					</svg>
					<span class="sidebar-menu-text ms-1">작업 목록</span>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/project/projectIssue?projectId=${projectId}">			
				<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hexagon me-3" viewBox="0 0 16 16">
					  <path d="M14 4.577v6.846L8 15l-6-3.577V4.577L8 1zM8.5.134a1 1 0 0 0-1 0l-6 3.577a1 1 0 0 0-.5.866v6.846a1 1 0 0 0 .5.866l6 3.577a1 1 0 0 0 1 0l6-3.577a1 1 0 0 0 .5-.866V4.577a1 1 0 0 0-.5-.866z"/>
					</svg>
					<span class="sidebar-menu-text ms-1">이슈 목록 </span>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/project/projectApprovalList?projectId=${projectId}">			
				<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-journal-check me-3" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M10.854 6.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 8.793l2.646-2.647a.5.5 0 0 1 .708 0"/>
					  <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2"/>
					  <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1z"/>
					</svg>
					<span class="sidebar-menu-text ms-1">결재 목록</span>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/project/projectMember?projectId=${projectId}"">				
				<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-people me-3" viewBox="0 0 16 16">
					  <path d="M15 14s1 0 1-1-1-4-5-4-5 3-5 4 1 1 1 1zm-7.978-1L7 12.996c.001-.264.167-1.03.76-1.72C8.312 10.629 9.282 10 11 10c1.717 0 2.687.63 3.24 1.276.593.69.758 1.457.76 1.72l-.008.002-.014.002zM11 7a2 2 0 1 0 0-4 2 2 0 0 0 0 4m3-2a3 3 0 1 1-6 0 3 3 0 0 1 6 0M6.936 9.28a6 6 0 0 0-1.23-.247A7 7 0 0 0 5 9c-4 0-5 3-5 4q0 1 1 1h4.216A2.24 2.24 0 0 1 5 13c0-1.01.377-2.042 1.09-2.904.243-.294.526-.569.846-.816M4.92 10A5.5 5.5 0 0 0 4 13H1c0-.26.164-1.03.76-1.724.545-.636 1.492-1.256 3.16-1.275ZM1.5 5.5a3 3 0 1 1 6 0 3 3 0 0 1-6 0m3-2a2 2 0 1 0 0 4 2 2 0 0 0 0-4"/>
					</svg>
					<span class="sidebar-menu-text ms-1">팀원 목록</span>
				</div>
			</a>
			<a href="${pageContext.request.contextPath}/notice/noticeList?projectId=${projectId}">				
				<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle me-3" viewBox="0 0 16 16">
					  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
					  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
					</svg>
					<span class="sidebar-menu-text ms-1">공지사항</span>
				</div>
			</a>		
			<a href="${pageContext.request.contextPath}/project/projectStats?projectId=${projectId}"">			
				<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-file-bar-graph me-3" viewBox="0 0 16 16">
					  <path d="M4.5 12a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-.5.5zm3 0a.5.5 0 0 1-.5-.5v-4a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v4a.5.5 0 0 1-.5.5zm3 0a.5.5 0 0 1-.5-.5v-6a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-.5.5z"/>
					  <path d="M4 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm0 1h8a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1"/>
					</svg>
					<span class="sidebar-menu-text ms-1">프로젝트 통계</span>
				</div>
			</a>
			<c:if test="${loginUserId == projectData.memberId}">
				<div class="mt-1 border-top">
				<div class="sidebar-menu-group-text mt-4">프로젝트 관리</div>
					<a href="${pageContext.request.contextPath}/project/projectApprovalStay?projectId=${projectId}">			
						<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-journal-bookmark-fill me-3" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M6 1h6v7a.5.5 0 0 1-.757.429L9 7.083 6.757 8.43A.5.5 0 0 1 6 8z"/>
								<path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2"/>
								<path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1z"/>
							</svg>
							<span class="sidebar-menu-text ms-1">결재 관리</span>
						</div>
					</a>
					<a href="${pageContext.request.contextPath}/project/projectMemberManage?projectId=${projectId}">			
						<div class="sidebar-menu d-flex align-items-center mb-1 mt-1">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill-gear me-3" viewBox="0 0 16 16">
								<path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0m-9 8c0 1 1 1 1 1h5.256A4.5 4.5 0 0 1 8 12.5a4.5 4.5 0 0 1 1.544-3.393Q8.844 9.002 8 9c-5 0-6 3-6 4m9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382zM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0"/>
							</svg>
							<span class="sidebar-menu-text ms-1">팀원 관리</span>
						</div>
					</a>
				</div>
			</c:if>
		</div>
	</body>
	<c:set var="loginUserId" value="${pageContext.request.userPrincipal.name}" />
	<c:set var="projectMemberId" value="${sessionScope.projectData.memberId}" />
	
	<script type="text/javascript">
	    const loginUserId = '${loginUserId}';
	    const projectMemberId = '${projectMemberId}';
	</script>
</html>