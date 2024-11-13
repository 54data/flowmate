<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀원 목록</title>
	<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet">
</head>
<body>
	<div id="header">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
	</div>
	<div class="project-board d-flex">
		<%@ include file="projectSidebar.jsp" %>
		<div class="d-flex d-flex mt-4 ms-4 me-4 flex-column flex-grow-1 min-vh-100">
			<div class="d-flex justify-content-between align-items-center" style="height: 40px;">
				<h2 class="ptitle">팀원 목록</h2>
        	</div>
            <div class="d-flex mt-4 justify-content-start">
                <select class="form-select" id="projectMemberSelect">
                	<option selected>아이디</option>
                	<option>이름</option>
                </select>
                <form class="searchForm d-flex justify-content-end" id="projectMemberForm">
                	<input class="form-control me-sm-2 ms-4" type="search" id="projectMemberInput" placeholder="검색어를 입력해주세요" >
                	<button type="button" class="search ">
                		<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
                			<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
                    </button>
                </form>
            </div>
				<table id="projectMemberList" class="table text-center">
					<thead>
						<tr>
							<th>아이디</th>
				            <th>이름</th>
				            <th>부서
					            <button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
					    			<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
					    				<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
					        		</svg>
					        	</button>
					        	<ul class="dropdown-menu" id="projectMemberDeptMenu">
					        	</ul>
				            </th>
				            <th>직책
					            <button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
					    			<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
					    				<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
					        		</svg>
					        	</button>
					        	<ul class="dropdown-menu" id="projectMemberRankMenu">
					        	</ul>
				            </th>
				            <th>쪽지</th>
				        </tr>
			        </thead>
			        <tbody>
				        <c:forEach var="projectMember" items="${projectMemberList}">
			        		<tr>
					            <td class="reciverId">${projectMember.memberId}</td>
					            <td>${projectMember.memberName}${projectMember.isPm != 'PM' ? '' : ' (PM)'}</td>
					            <td>${projectMember.memberDept}</td>
					            <td>${projectMember.memberRank}</td>
					            <td><span class="send-msg">[ 전송 ]</span></td>
				            </tr>
			            </c:forEach>
		            </tbody>
	            </table>
            </div>
        </div>
       	<script src="${pageContext.request.contextPath}/resources/js/projectMember.js"></script>
</body>
</html>