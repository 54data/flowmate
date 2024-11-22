<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="now" value="<%=new java.util.Date()%>" />
<fmt:formatDate var="nowDateStr" value="${now}" pattern="yyyy.MM.dd" />
<fmt:parseDate var="nowDate" value="${nowDateStr}" pattern="yyyy.MM.dd" />

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
			<div class="project-stats d-flex w-100 align-items-center pe-4 mb-4 flex-column" style="height: 83.33px !important;">
				<div class="d-flex align-items-center w-100 h-100 px-4 border justify-content-center">
            		<div class="project-progress d-flex align-items-center col justify-content-center">
            			<div class="me-4 h5">프로젝트 진행률</div>
            			<div class="project-progress-bar progress" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
            			<div class="progress-bar project-progress-bar-width" style="min-width:35px; width: ${projectTaskCnt.projectProgress}%" data-rate="${projectTaskCnt.projectProgress}">${projectTaskCnt.projectProgress}%</div>
           			</div>
       			</div>
       			<div class="project-task-stats h5 text-center col">
       				완료 작업 현황
       				<span class="ms-4">${projectTaskCnt.doneTaskCnt} / ${projectTaskCnt.totalTaskCnt}</span>
   				</div>
   				<div class="project-schedule h5 col text-center">
   					프로젝트 일정
   					<span class="ms-4">D ${projectDateRange}</span>
   				</div>
   				<div class="d-flex align-items-center col justify-content-center text-center">
   					<c:forEach var="projectStep" items="${projectStepList}" varStatus="status">
   						<fmt:parseDate var="stepStartDate" value="${projectStep.stepStartDate}" pattern="yyyyMMddHHmmss"/>
   						<fmt:parseDate var="stepDueDate" value="${projectStep.stepDueDate}" pattern="yyyyMMddHHmmss"/>
   						<fmt:formatDate value="${stepStartDate}" pattern="yyyy.MM.dd" var="startDate"/>
   						<fmt:formatDate value="${stepDueDate}" pattern="yyyy.MM.dd" var="dueDate"/>
   						<c:choose>
   							<c:when test="${nowDate >= stepStartDate && nowDate <= stepDueDate}">
   								<div class="d-flex flex-column justify-content-center text-center">
	   								<div>
	   									<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
	   										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
	                                    </svg>
	                                </div>
	                                <div class="rounded-circle d-flex justify-content-center align-items-center" style="width: 55px; height: 42px; font-size: 14px; font-weight: 500; background-color:#e0ecff; margin-bottom: 16px;">${projectStep.stepName}</div>
                                </div>
                           </c:when>
                           <c:otherwise>
                               <div class="rounded-circle d-flex justify-content-center align-items-center border" style="width: 55px; height: 42px; font-size: 14px; font-weight: 500; border-color:#DEDEE0 !important; margin-top: 8px;">${projectStep.stepName}</div>
                           </c:otherwise>
                        </c:choose>
                        <c:if test="${!status.last}">
                        	<div class="" style="height: 1px; width: 10px; margin-top: 8px; background-color:#DEDEE0"></div>
                       	</c:if>
                     </c:forEach>
                  </div>
               </div>
				<div class="mt-3 w-100 border pt-3 px-3">
			        <div class="row d-flex align-items-center justify-content-center text-center w-100 m-0" id="charts-container">
			        </div>
			    </div>
			    <div class="mt-3 w-100 d-flex justify-content-between" id="bar-container">
			    	<div class="isu-bar border p-3 col-2">
			    	</div>
			    	<div class="projectMemberStats border col-5">
			    		<div class="d-flex justify-content-center mt-4 mb-3 w-100" style="font-weight: 600;">
			    			담당자별 작업 & 이슈 현황
			    		</div>
			    		<table id="projectStatsMembers" class="table text-center w-100">
			    			<thead>
			    				<tr>
			    					<th>담당자</th>
			    					<th>부서</th>
			    					<th>직책</th>
			    					<th>작업 현황</th>
			    					<th>이슈 현황</th>
			    				</tr>
			    			</thead>
			    			<tbody>
			    				<c:forEach var="memberTaskStats" items="${memberTaskStatsList}">
				    				<tr>
				    					<td>${memberTaskStats.memberName}</td>
				    					<td>${memberTaskStats.memberDept}</td>
				    					<td>${memberTaskStats.memberRank}</td>
				    					<td>${memberTaskStats.memberTaskCnt}</td>
				    					<td>${memberTaskStats.memberIsuCnt}</td>
				    				</tr>
			    				</c:forEach>
			    			</tbody>
			    		</table>
			    	</div>
			    	<div class="delayTasks col border p-3">
			    	</div>
			    </div>
			</div>
	    </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/projectStats.js"></script>
</body>
</html>