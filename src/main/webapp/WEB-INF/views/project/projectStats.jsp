<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>프로젝트 통계</title>
	<link href="${pageContext.request.contextPath}/resources/css/projectBoard.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/projectStats.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="project-board d-flex">
		<%@ include file="projectSidebar.jsp" %>
		<div class="d-flex mt-4 ms-4 flex-column flex-grow-1">
			<div class="d-flex align-items-center w-100 pe-4 pb-4">
				<h2 class="board-project-name m-0 me-auto">
					${projectData.projectName}
				</h2>
		    </div>
			<div class="project-stats d-flex w-100 align-items-center pe-4 mb-4 flex-column">
				<div class="d-flex align-items-center w-100 p-4 border justify-content-between">
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
				<div class="mt-3 w-100 border pt-3 px-3">
			        <div class="row d-flex align-items-center justify-content-center text-center w-100 m-0" id="charts-container">
			        </div>
			    </div>
			    <div class="mt-3 w-100 d-flex justify-content-between" id="bar-container">
			    	<div class="isu-bar col-2 border p-3">
			    	</div>
			    	<div class="col-2">
			    	</div>
			    	<div class="col-6">
			    	</div>
			    </div>
			</div>
	    </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/projectStats.js"></script>
</body>
</html>