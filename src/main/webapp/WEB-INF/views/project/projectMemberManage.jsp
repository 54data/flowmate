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
			<div class="project-sidebar d-flex pt-4 border-end">
				<%@ include file="projectSidebar.jsp" %>
			</div>
		<div class="d-flex d-flex mt-4 ms-3 me-3 flex-column flex-grow-1">
        		<div class="d-flex justify-content-between align-items-center" style="height: 40px;">
            		<h2>팀원 목록</h2>
        		</div>
            <div class="d-flex mt-4 justify-content-between">
            		<div class="d-flex">
	                <select class="form-select" >
	                  <option>이름</option>
	                  <option>제목</option>
	                  <option>프로젝트 번호</option>
	                  <option>등록일</option>
	                  <option>상태</option>
	                  <option>단계</option>
	                </select>
	                <form class="d-flex justify-content-end" class="searchForm">
	                    <input class="form-control me-sm-2 ms-4" type="search" placeholder="팀원을 검색해주세요" >
	                    <button type="submit" class="search ">
	    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
							  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
	                    </button>
	                </form>
                </div>
                <div>
                		<button class="btn btn-outline-primary member-add me-2">추가</button>
                		<button class="btn btn-outline-primary member-delete">삭제</button>
                </div>
            </div>
				<table class="table text-center mt-5">
				        <tr>
				        		<th>
				        			<input class="form-check-input messageCheckbox" type="checkbox" value="" id="flexCheckDefault">
				        		</th>
				            <th>아이디</th>
				            <th>이름</th>
				            <th>부서</th>
				            <th>직책</th>
				            <th>권한</th> 
				            <th>쪽지</th>
				        </tr>
				        <tr>
				        		<td>
			        				<input class="form-check-input messageCheckbox" type="checkbox" value="" id="flexCheckDefault">			        						        		
				        		</td>
				            <td>heawon01</td>
				            <td>김해원</td>
				            <td>전략1부</td>
				            <td>팀장</td>
				            <td>개발자</td>
				            <td>[<span class="join">참여</span> / <span class="denied">제외</span>]</td>
				        </tr>
				</table>
			</div>
		</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>    
</body>
</html>