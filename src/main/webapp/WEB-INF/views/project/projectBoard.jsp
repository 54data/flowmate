<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
					<h2 class="board-project-name m-0 me-auto">
						${projectData.projectName}
						<button type="button" class="project-info-btn btn ms-3" data-bs-toggle="modal" data-bs-target="#projectCreating" data-mode="read" 
							data-project-id="${projectData.projectId}" data-project-name="${projectData.projectName}" data-project-content="${projectData.projectContent}"
					    	data-project-start-date="${projectData.projectStartDate}" data-project-due-date="${projectData.projectDueDate}" 
					    	data-project-state="${projectData.projectState}">
							<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-info-circle me-1" viewBox="0 0 16 16" style="margin-bottom: 2px;">
								<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
								<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
							</svg>
							정보
						</button>
					</h2>
				    <div class="d-flex align-items-center">
					    <button 
					    	type="button" class="project-edit-btn btn btn-outline-primary ms-3" data-bs-toggle="modal" data-bs-target="#projectCreating" data-mode="edit"
					    	data-project-id="${projectData.projectId}" data-project-name="${projectData.projectName}" data-project-content="${projectData.projectContent}"
					    	data-project-start-date="${projectData.projectStartDate}" data-project-due-date="${projectData.projectDueDate}" 
					    	data-project-state="${projectData.projectState}">설정</button>
					    <%@ include file="/WEB-INF/views/task/taskCreating.jsp" %>
					</div>
				</div>
				<div class="project-stats d-flex w-100 align-items-center pe-4 mb-4">
					<div class="d-flex align-items-center w-100 h-100 p-4 border justify-content-between">
						<div class="project-progress d-flex align-items-center">
							<div class="me-auto h5 w-100">프로젝트 진행률</div>
							<div class="project-progress-bar progress" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
								<div class="progress-bar project-progress-bar-width" style="min-width:35px; width: ${projectTaskCnt.projectProgress}%" data-rate="${projectTaskCnt.projectProgress}">${projectTaskCnt.projectProgress}%</div>
							</div>
						</div>
						<div class="project-task-stats h5 text-center">
							완료 작업 현황
							<span class="ms-4">${projectTaskCnt.doneTaskCnt}/${projectTaskCnt.totalTaskCnt}</span>
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
				        <c:set var="now" value="<%=new java.util.Date()%>" />
						<fmt:formatDate var="nowDateStr" value="${now}" pattern="yyyy.MM.dd" />
						<fmt:parseDate var="nowDate" value="${nowDateStr}" pattern="yyyy.MM.dd" />
						<div class="board d-flex me-3 flex-column col-1 flex-fill">
							<c:choose>
								<c:when test="${nowDate >= stepStartDate && nowDate <= stepDueDate}">
									<div class="board-content d-flex flex-column min-vh-100 w-100 p-2 pt-2" style="background-color: #EDF2FA;">
								</c:when>
								<c:otherwise>
									<div class="board-content d-flex flex-column min-vh-100 w-100 p-2 pt-2">
								</c:otherwise>
							</c:choose>
								<div class="d-inline-flex w-100 align-items-center">
									<div class="me-auto">
										<span class="board-step fw-semibold ms-1 me-2">${projectStep.stepName}</span>
										<span class="board-cnt">${projectStep.totalStepTaskCnt}</span>
									</div>
									<span class="board-date me-1">${startDate} - ${dueDate}</span>
								</div>
								<div class="d-flex align-items-center justify-content-between mt-2 mb-4 pb-2">
									<div class="task-progress progress w-100" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
										<div class="progress-bar" style="width: ${projectStep.stepProgress}%" data-rate="${projectStep.stepProgress}"></div>
									</div>
									<span class="board-task-progress">${projectStep.stepProgress}%</span>
								</div>
								<c:forEach var="projectTask" items="${projectTaskList}">
									<c:if test="${projectTask.stepName == projectStep.stepName}">
										<div class="task shadow-sm p-3 mb-3 task-updateModal"  data-bs-toggle="modal" data-bs-target="#taskCreating" data-task-id="${projectTask.taskId}" style="cursor: pointer;">
											<div class="d-flex flex-column justify-content-between h-100">
												<div class="d-flex align-items-start h-auto">
													<div class="board-task-title me-2">${projectTask.taskName}</div>
													<c:choose>
												        <c:when test="${projectTask.taskState == '보류'}">
															<div class="task-state rounded-pill px-2 bg-warning text-white">보류</div>
												        </c:when>
												    </c:choose>
													<div class="ms-auto">
														<c:choose>
													        <c:when test="${projectTask.taskPriority == '긴급'}">
																<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#EC1E1E" class="bi bi-brightness-alt-high-fill" viewBox="0 0 16 16">
																	<path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4"/>
																</svg>
													        </c:when>
													        <c:when test="${projectTask.taskPriority == '높음'}">
													            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#ff7d04" class="bi bi-arrow-up" viewBox="0 0 16 16">
																	<path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
																</svg>
													        </c:when>
													    </c:choose>
													</div>
												</div>
												<div class="d-flex align-items-center">
													<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
														<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
													</svg>
													<div class="task_id">${projectTask.fmtTaskId}</div>
													<div class="d-flex ms-auto">
														<div class="task-issue d-flex align-items-center
															<c:choose>
																<c:when test="${projectTask.issueCnt == 0}">d-none</c:when>
															</c:choose>">
															<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
																<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
															</svg>
															<span class="ms-1 me-3">${projectTask.issueCnt}</span>
														</div>
														<div class="board-task-member-name border rounded-pill px-2">${projectTask.memberName}</div>
													</div>
												</div>
											</div>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</div>
		    </div>
		</div>
		<script src="${pageContext.request.contextPath}/resources/js/taskCreating.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/projectBoard.js"></script>
	</body>
</html>