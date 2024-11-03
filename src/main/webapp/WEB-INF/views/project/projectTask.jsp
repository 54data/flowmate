<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/projectBoard.css" rel="stylesheet">		
</head>
<body>
		<div id="header">
			<%@ include file="/WEB-INF/views/common/header.jsp" %>
		</div>
		<div class="project-board d-flex">
			<%@ include file="projectSidebar.jsp" %>
			<div class="d-flex d-flex mt-4 ms-4 me-4 flex-column flex-grow-1 min-vh-100">
            <div class="d-flex justify-content-between align-items-center" style="height: 40px;">
            		<h2 class="ptitle">작업 목록</h2>					    
            </div>
            <div class="d-flex mt-4 justify-content-start">
                <select class="form-select" >
                  <option>작업명</option>
                  <option>작업 ID</option>
                  <option>담당자</option>
                </select>
                <form class="searchForm d-flex justify-content-end">
                    <input class="form-control me-sm-2 ms-4" type="search" placeholder="검색어를 입력해주세요" >
                    <button type="submit" class="search ">
    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
						  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
                    </button>
                </form>
            </div>
				<table class="table text-center mt-5">
				<thead>
				        <tr>
				            <th>작업번호</th>
				            <th>작업명</th>
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		단계
						        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
						        </button>
		  						   <ul class="dropdown-menu ">
							     <li><a class="dropdown-item" href="#">분석</a></li>
		    					     <li><a class="dropdown-item" href="#">설계</a></li>
							     <li><a class="dropdown-item" href="#">개발</a></li>
							     <li><a class="dropdown-item" href="#">테스트</a></li>   					         					     
							     <li><a class="dropdown-item" href="#">이행</a></li>
							   </ul>					            
				            </th>
				            <th>담당자</th>
				            <th>
				            		시작일
						        <svg data-column="5" xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="dateSort bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>				            		
				            	</th> 
				            <th>
				            		마감일
						        <svg data-column="6" xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="dateSort bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>				            		
				            	</th> 
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		우선순위
						        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
						        </button>
		  						   <ul class="dropdown-menu ">
							     <li><a class="dropdown-item" href="#">긴급</a></li>
		    					     <li><a class="dropdown-item" href="#">높음</a></li>
							     <li><a class="dropdown-item" href="#">보통</a></li>
							     <li><a class="dropdown-item" href="#">낮음</a></li>   					         					     
							     <li><a class="dropdown-item" href="#">비활성화</a></li>
							   </ul>		
				            	</th>
				        </tr>
				       </thead>     	
				        <tbody>
				        <c:forEach var="proTask" items="${projTask}">
				        <tr class="task-updateModal" data-bs-toggle="modal" data-bs-target="#taskCreating" data-task-id="${proTask.taskId}" style="cursor: pointer;">
				            <td>${proTask.fmtTaskId}</td>
				            <td>${proTask.taskName}</td>
				            <td>${proTask.stepName}</td>
				            <td>${proTask.memberName}</td>
				            <td>${proTask.taskStartDate}</td>
				       		<td>${proTask.taskDueDate}</td>
				       		<td>
				       			<c:if test="${proTask.taskPriority=='높음'}">
					                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" stroke="#FF7D04" class="bi bi-arrow-up" viewBox="0 0 16 16">
									  <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
									</svg>
									&nbsp;
								</c:if>
				       			<c:if test="${proTask.taskPriority=='긴급'}">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#EC1E1E" class="bi bi-brightness-alt-high-fill" viewBox="0 0 16 16">
										<path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4"/>
									</svg>
									&nbsp;
								</c:if>
								<c:if test="${proTask.taskPriority=='높음'}">
				                		<span class="text-warning fw-medium">${proTask.taskPriority}</span>   		
				                </c:if>
   								<c:if test="${proTask.taskPriority=='긴급'}">
				                		<span class="text-danger fw-medium">${proTask.taskPriority}</span>   		
				                </c:if>
				                <c:if test="${proTask.taskPriority=='없음'}">
				                		<span class="text-dark fw-medium">${proTask.taskPriority}</span>   		
				                </c:if>
				       		</td>				       		
				        </tr>
				        </c:forEach>
				        </tbody>				        
				</table>
			</div>
		</div>
<div class="taskUpdateModal" style="display: none;">		
 <%@ include file="/WEB-INF/views/task/taskCreating.jsp" %>
</div>
<script src="${pageContext.request.contextPath}/resources/js/taskCreating.js"></script>

</body>
</html>