<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/mypageSideBar.css" rel="stylesheet">
	    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <main class="d-flex" id="myTaskMain">
    	<div class="d-flex">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
		</div>
        <article class="mt-4 ms-4 pe-4">
            <div class="ptitle h2 m-0">나의 작업</div>
            <div class="d-flex mt-4 justify-content-between">
                <select class="form-select" id="taskSelect">
                  <option>작업명</option>
                  <option>작업ID</option>
                  <option>프로젝트ID</option>
                  <option>프로젝트 명</option>
                </select>
                <form class="d-flex justify-content-end" class="searchForm">
                    <input class="form-control me-sm-2" type="search" placeholder="작업 이름을 검색해주세요" >
                    <button type="submit" class="leftSearch">
    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
						  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
                    </button>
                </form>
            </div>
            <section>
				<table class="table text-center mt-5">
				        <tr>
				            <th>번호</th>
				            <th>작업명</th>
				            <th>프로젝트 번호</th>
				            <th>프로젝트명</th>
				            <th>
				            		등록일
	                            	<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mt-auto mb-auto" viewBox="0 0 16 16">
								  <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
								</svg>
				            	</th> 
				            <th>
				            		마감일
				            		<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mt-auto mb-auto" viewBox="0 0 16 16">
								  <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
								</svg>
				            	</th>
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
							    		상태
							        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
							          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
							        </svg>
						        </button>
		  						   <ul class="dropdown-menu ">
							     <li><a class="dropdown-item" href="#">예정</a></li>
		    					     <li><a class="dropdown-item" href="#">진행 중</a></li>
							     <li><a class="dropdown-item" href="#">완료</a></li>
							     <li><a class="dropdown-item" href="#">보류</a></li>   					         					     
							     <li><a class="dropdown-item" href="#">비활성화</a></li>
							   </ul>				            		
				            	</th>
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		단계
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
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
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		우선순위
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
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
				        <tr>
				            <td>PA-003</td>
				            <td>작업 1</td>
				            <td>PR-003</td>
				            <td>프로젝트 1</td>
				            <td>2024.10.01</td>
				            <td>2024.10.31</td>
				            <td>예정</td>
				            <td>분석</td>
				            <td>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-brightness-alt-high" viewBox="0 0 16 16" stroke="red" stroke-width="1">
							  <path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4m0 1a3 3 0 0 1 2.959 2.5H5.04A3 3 0 0 1 8 8"/>
							</svg>
							&emsp;
				                <span class="text-danger fw-medium">긴급</span>
				            </td>
				        </tr>
				        <tr>
				            <td>PA-004</td>
				            <td>작업2</td>
				            <td>PR-004</td>
				            <td>프로젝트2</td>
				            <td>2024.10.14</td>
				            <td>2024.11.30</td>
				            <td>진행 중</td>
				            <td>개발</td>
				            <td>
				                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" stroke="#FF7D04" class="bi bi-arrow-up" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
								</svg>
								&emsp;
				                <span class="text-warning fw-medium"">높음</span>
				            </td>
				        </tr>
				</table>
            </section>
        </article>
    </main>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>    
</body>
</html>