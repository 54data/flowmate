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
		<div class="d-flex d-flex mt-4 ms-3 me-3 flex-column flex-grow-1">
        		<div class="d-flex justify-content-between align-items-center" style="height: 40px;">
            		<h2>팀원 목록</h2>
        		</div>
            <div class="d-flex mt-4 justify-content-between">
            		<div class="d-flex">
	                <select class="form-select" >
	                  <option>아이디</option>
	                  <option>이름</option>
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
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    			부서
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
						        </button>
		   						  <ul class="dropdown-menu">
								    <li><a class="dropdown-item" href="#">전략1부</a></li>
								    <li><a class="dropdown-item" href="#">공공사업1 Div</a></li>
								  </ul>	
				            </th>
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    			직책
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
						        </button>
		   						  <ul class="dropdown-menu">
								    <li><a class="dropdown-item" href="#">사원</a></li>
								    <li><a class="dropdown-item" href="#">대리</a></li>
								    <li><a class="dropdown-item" href="#">팀장</a></li>
								    <li><a class="dropdown-item" href="#">과장</a></li>
								    <li><a class="dropdown-item" href="#">차장</a></li>
								    <li><a class="dropdown-item" href="#">부장</a></li>
								  </ul>		
				            </th>
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    			권한
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
						        </button>
		   						  <ul class="dropdown-menu">
								    <li><a class="dropdown-item" href="#">개발자</a></li>
								    <li><a class="dropdown-item" href="#">프로젝트 관리자</a></li>
								  </ul>							        
				            </th> 
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
</body>
</html>