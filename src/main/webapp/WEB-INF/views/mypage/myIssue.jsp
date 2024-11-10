<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>나의 이슈</title>
	<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<main class="d-flex" id="issueMain">
   		<div class="d-flex">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
        </div>
        <article class="mt-4 ms-4 pe-4">
        	<div class="ptitle h2 m-0">나의 이슈</div>
            <div class="d-flex mt-4">
                <select class="form-select" id="myIssueSelect">
                	<option selected>이슈명</option>
                	<option>프로젝트 ID</option>
                	<option>프로젝트명</option>
                	<option>연결 작업</option>
                </select>
                <form class="searchForm d-flex justify-content-end" id="myIssueForm">
                	<input class="form-control me-sm-2 ms-4" type="search" id="myIssueInput" placeholder="검색어를 입력해주세요" >
                	<button type="button" class="search ">
                		<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
                			<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
                    </button>
                </form>
            </div>
            <section>
                <table class="table text-center" id="myIssueList">
                	<thead>
	                    <tr>
	                        <th>이슈명</th>
	                        <th>프로젝트 ID</th>
	                        <th>프로젝트명</th>
	                        <th>연결 작업</th>
							<th>등록일</th> 
				            <th>상태
				            	<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
					    			<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
					    				<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
					        		</svg>
					        	</button>
					        	<ul class="dropdown-menu" id="myIssueStateMenu">
					        	</ul>				            		
				            </th>		            	
	                    </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="myIssue" items="${myIssueList}">
                   			<tr>
			        			<td class="my-issue-title" data-project-id="${myIssue.projectId}" data-issue-id="${myIssue.issueId}">${myIssue.issueTitle}</td>
			        			<td>
			        				<a href="${pageContext.request.contextPath}/project/projectBoard?projectId=${myIssue.projectId}">${myIssue.projectId}</a>
			        			</td>
			        			<td>
			        				<a href="${pageContext.request.contextPath}/project/projectBoard?projectId=${myIssue.projectId}">${myIssue.projectName}</a>
			        			</td>
			        			<td>${myIssue.relatedTask}</td>
			        			<td>${myIssue.fmtIssueRegdate}</td>
			        			<td style="color: ${myIssue.issueState eq '미해결' ? '#FF5959' : '#0C66E4'}; font-weight: 500;">${myIssue.issueState}</td>
			        		</tr>
                    	</c:forEach>
                    </tbody>
                </table>
            </section>
        </article>
    </main>
    <script src="${pageContext.request.contextPath}/resources/js/myIssue.js"></script>
</body>
</html>