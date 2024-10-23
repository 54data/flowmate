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
            		<h2>모든 작업 목록</h2>					    
            </div>
            <div class="d-flex mt-4 justify-content-start">
                <select class="form-select" >
                  <option>이름</option>
                  <option>제목</option>
                  <option>프로젝트 번호</option>
                  <option>등록일</option>
                  <option>상태</option>
                  <option>단계</option>
                </select>
                <form class="d-flex justify-content-end" class="searchForm">
                    <input class="form-control me-sm-2 ms-4" type="search" placeholder="검색어를  입력해주세요" >
                    <button type="submit" class="search ">
    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
						  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
                    </button>
                </form>
            </div>
				<table class="table text-center mt-5">
				        <tr>
				            <th>작업번호</th>
				            <th>작업일</th>
				            <th>작성 단계</th>
				            <th>담당자</th>
				            <th>시잘일</th> 
				            <th>마감일</th>
				            	<th>우선 순위</th>
				        </tr>
				        <tr>
				            <td>
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-square me-1" viewBox="0 0 16 16">
								  <path d="M3.626 6.832A.5.5 0 0 1 4 6h8a.5.5 0 0 1 .374.832l-4 4.5a.5.5 0 0 1-.748 0z"/>
								  <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm15 0a1 1 0 0 0-1-1H2a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1z"/>
								</svg>
				            		Task-1 (2)
				            	</td>
				            <td>요구사항 분석</td>
				            <td>분석</td>
				            <td>김해원 외 2명</td>
				            <td>2024.10.10</td>
				       		<td>2024.11.26</td>
				       		<td>
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-brightness-alt-high" viewBox="0 0 16 16" stroke="red" stroke-width="1">
								  <path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4m0 1a3 3 0 0 1 2.959 2.5H5.04A3 3 0 0 1 8 8"/>
								</svg>
								&emsp;
				             	<span class="text-danger fw-medium">긴급</span>       		
				       		</td>				       		
				        </tr>
				        <tr>
				            <td>Task-2</td>
				            <td>프로젝트 유스케이스</td>
				            <td>분석</td>
				            <td>김해원 외 2명</td>
				            <td>2024.10.10</td>
				       		<td>2024.11.26</td>
				       		<td>
				                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" stroke="#FF7D04" class="bi bi-arrow-up" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
								</svg>
								&emsp;
				                <span class="text-warning fw-medium"">높음</span>   		
				       		</td>				       		
				        </tr>				        
				</table>
			</div>
		</div>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>    
</body>
</html>