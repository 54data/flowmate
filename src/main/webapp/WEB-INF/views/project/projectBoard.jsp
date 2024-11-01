<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="projectStepCnt" value="${fn:length(projectStepList)}"/>
<c:set var="remainStepCnt" value="${5 - projectStepCnt}"/>
					
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>${projectData.projectName}</title>
		<link href="${pageContext.request.contextPath}/resources/css/projectBoard.css" rel="stylesheet">
	</head>
	<body>
		<div id="header">
			<%@ include file="/WEB-INF/views/common/header.jsp" %>
		</div>
		<div class="project-board d-flex">
			<%@ include file="projectSidebar.jsp" %>
			<div class="d-flex mt-4 ms-4 flex-column flex-grow-1">
				<div class="d-flex align-items-center w-100 pe-4 pb-4">
					<h2 class="board-project-name m-0 me-auto">${projectData.projectName}</h2>
				    <div class="d-flex align-items-center">
					    <button type="button" class="btn btn-outline-primary ms-3">설정</button>
					    <%@ include file="/WEB-INF/views/task/taskCreating.jsp" %>
					</div>
				</div>
				<div class="project-stats d-flex w-100 align-items-center pe-4 mb-4">
					<div class="d-flex align-items-center w-100 h-100 p-4 border justify-content-between">
						<div class="project-progress d-flex align-items-center">
							<div class="me-auto h5 w-100">프로젝트 진행률</div>
							<div class="project-progress-bar progress" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
								<div class="progress-bar" style="width: 75%">75%</div>
							</div>
						</div>
						<div class="project-task-stats h5 text-center">
							완료 작업 현황
							<span class="ms-4">3/40</span>
						</div>
						<div class="project-schedule h5">
							프로젝트 일정
							<span class="ms-4">D ${projectDateRange}</span>
						</div>
					</div>
				</div>
				<div class="boardlist d-flex w-100 pe-2">
					<c:forEach var="projectStep" items="${projectStepList}">
				        <fmt:parseDate var="stepStartDate" value="${projectStep.stepStartDate}" pattern="yyyyMMddHHmmss"/>
				        <fmt:parseDate var="stepDueDate" value="${projectStep.stepDueDate}" pattern="yyyyMMddHHmmss"/>
				        <fmt:formatDate value="${stepStartDate}" pattern="yyyy.MM.dd" var="startDate"/>
				        <fmt:formatDate value="${stepDueDate}" pattern="yyyy.MM.dd" var="dueDate"/>
						<div class="board d-flex me-3 flex-column col-1 flex-fill">
							<div class="board-content d-flex flex-column min-vh-100 w-100 p-2 pt-2">
								<div class="d-inline-flex w-100 align-items-center">
									<div class="me-auto">
										<span class="board-step fw-semibold ms-1 me-2">${projectStep.stepName}</span>
										<span class="board-cnt">2</span>
									</div>
									<span class="board-date me-1">${startDate} - ${dueDate}</span>
								</div>
								<div class="d-flex align-items-center justify-content-between mt-2 mb-4 pb-2">
									<div class="task-progress progress w-100" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
										<div class="progress-bar" style="width: 25%"></div>
									</div>
									<span class="board-task-progress">25%</span>
								</div>
								<div class="task shadow-sm p-3 mb-3">
									<div class="d-flex flex-column justify-content-between h-100">
										<div class="d-flex align-items-start h-auto">
											<div class="board-task-title me-2">요구사항 분석</div>
											<div class="task-state border rounded-pill px-2">결재 중</div>
											<div class="ms-auto">
												<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#EC1E1E" class="bi bi-brightness-alt-high-fill" viewBox="0 0 16 16">
													<path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4"/>
												</svg>
											</div>
										</div>
										<div class="d-flex align-items-center">
											<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
												<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
											</svg>
											<div class="task_id">TASK-1</div>
											<div class="d-flex ms-auto">
												<div class="task-issue d-flex align-items-center">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
														<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
													</svg>
													<span class="ms-1 me-3">3</span>
												</div>
								                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
								                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
								                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
												</svg>
											</div>
										</div>
									</div>
								</div>
								<div class="task shadow-sm p-3 mb-3">
									<div class="d-flex flex-column justify-content-between h-100">
										<div class="d-flex align-items-start h-auto">
											<div class="board-task-title me-2">기능명세서 작성</div>
											<div class="task-state rounded-pill px-2 bg-warning text-white">보류</div>
											<div class="ms-auto">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#ff7d04" class="bi bi-arrow-up" viewBox="0 0 16 16">
												  <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
												</svg>
											</div>
										</div>
										<div class="d-flex align-items-center">
											<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
												<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
											</svg>
											<div class="task_id">TASK-2</div>
											<div class="d-flex ms-auto">
												<div class="task-issue d-flex align-items-center">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
														<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
													</svg>
													<span class="ms-1 me-3">1</span>
												</div>
								                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
								                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
								                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
												</svg>
											</div>
										</div>
									</div>
								</div>
								<div class="task shadow-sm p-3 mb-3">
									<div class="d-flex flex-column justify-content-between h-100">
										<div class="d-flex align-items-start h-auto">
											<div class="board-task-title me-2">DB 스키마 설계</div>
											<div class="task-state border rounded-pill px-2">결재 중</div>
											<div class="ms-auto">
												<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#6DB822" class="bi bi-dash-lg" viewBox="0 0 16 16">
													<path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11A.5.5 0 0 1 2 8"/>
												</svg>
											</div>
										</div>
										<div class="d-flex align-items-center">
											<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
												<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
											</svg>
											<div class="task_id">TASK-3</div>
											<div class="d-flex ms-auto">
												<div class="task-issue d-flex align-items-center">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
														<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
													</svg>
													<span class="ms-1 me-3">3</span>
												</div>
								                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
								                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
								                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
												</svg>
											</div>
										</div>
									</div>
								</div>
								<div class="task shadow-sm p-3 mb-3 h-auto">
									<div class="d-flex flex-column justify-content-between h-100">
										<div class="d-flex align-items-start mb-3">
											<div class="board-task-title me-2">프로젝트 생성 기능 개발</div>
											<div class="task-state border rounded-pill px-2">결재 중</div>
											<div class="ms-auto">
												<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#706F74" class="bi bi-arrow-down" viewBox="0 0 16 16">
													<path fill-rule="evenodd" d="M8 1a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L7.5 13.293V1.5A.5.5 0 0 1 8 1"/>
												</svg>
											</div>
										</div>
										<div class="d-flex align-items-center">
											<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
												<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
											</svg>
											<div class="task_id">TASK-4</div>
											<div class="d-flex ms-auto">
												<div class="task-issue d-flex align-items-center">
													<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
														<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
													</svg>
													<span class="ms-1 me-3">3</span>
												</div>
								                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
								                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
								                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
												</svg>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
					<c:if test="${remainStepCnt > 0}">
				        <c:forEach begin="0" end="${remainStepCnt - 1}">
							<div class="board d-flex me-3 flex-column col-1 flex-fill" style="display:none;"></div>
				        </c:forEach>
				    </c:if>
				</div>
		    </div>
		</div>
		<script src="${pageContext.request.contextPath}/resources/js/taskCreating.js"></script>
	</body>
</html>