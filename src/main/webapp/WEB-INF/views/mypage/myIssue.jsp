<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
   <main class="d-flex" id="issueMain">
	    	<div class="d-flex pt-4 border-end">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
		</div>
        <article>
            <div><h2>나의 이슈</h2></div>
            <div class="d-flex mt-4 justify-content-between">
                <select class="form-select" id="taskSelect">
                  <option>이슈ID</option>
                  <option selected>이슈명</option>
                  <option>프로젝트 ID</option>
                  <option>프로젝트명</option>
                  <option>연결 작업 ID</option>
                  <option>연결 작업 명</option>
                </select>
                <form class="d-flex justify-content-end" class="searchForm">
                    <input class="form-control me-sm-2" type="search" placeholder="이슈 이름을 검색해주세요" >
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
                        <th>이슈명</th>
                        <th>프로젝트 번호</th>
                        <th>프로젝트명</th>
                        <th>
                        		등록일
					        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
					          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
					        </svg>                        		
                        </th> 
                        <th>연결작업</th>
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
					    		유형
					        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
					          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
					        </svg>
					        </button>
					   	   <ul class="dropdown-menu ">
						     <li><a class="dropdown-item" href="#">프로젝트 이슈</a></li>
	    					     <li><a class="dropdown-item" href="#">작업 이슈</a></li>
						   </ul>					            
			            </th>			            	
                    </tr>
                    <tr>
                        <td>IS-003</td>
                        <td>이슈1</td>
                        <td>PR-003</td>
                        <td>프로젝트1</td>
                        <td>2024.10.14</td>
                        <td>작업1</td>
                        <td>분석</td>
                        <td>해결</td>
                        <td>프로젝트 이슈</td>                        
                    </tr>
                    <tr>
                        <td>IS-004</td>
                        <td>이슈2</td>
                        <td>PR-004</td>
                        <td>프로젝트2</td>
                        <td>2024.10.01</td>
                        <td>작업2</td>
                        <td>설계</td>
                        <td>해결</td>
                        <td>프로젝트 이슈</td>                        
                    </tr>
                </table>
            </section>
        </article>
    </main>
</body>
</html>