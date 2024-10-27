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
	        		<h2>결재 목록</h2>					    
	        </div>
	         <div class="d-flex mt-4 justify-content-start">
	             <select class="form-select" >
	               <option>아이디</option>
	               <option>담당자</option>
	               <option>작업ID</option>
	               <option>작업 명</option>
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
				            <th>아이디</th>
				            <th>이름</th>
				            <th>작업ID</th>
				            <th>작업명</th>
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		 현 단계
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
						    		 요청 단계
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
				            		요청일
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>				            		
				            	</th>
				            	<th>
				            		결재일
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>				            		
				            	</th>
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		 결재상태
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
						        </button>
	  						   <ul class="dropdown-menu ">
							     <li><a class="dropdown-item" href="#">승인</a></li>
		    					     <li><a class="dropdown-item" href="#">거절</a></li>
							     <li><a class="dropdown-item" href="#">대기중</a></li>							     
							   </ul>					            
				            </th>         					            					            	
				        </tr>
				        <tr>
				            <td>heawon01</td>
				            <td>김해원</td>
				            <td>
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
									<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
								</svg>
				            		TASK-1
				            	</td>
				            <td>요구사항 분석</td>
				            <td>분석</td>
				       		<td>설계</td>
				       		<td>2024.10.05</td>
				       		<td>2024.10.15</td>				 
				       		<td class="text-info fw-bold">승인</td>				 				       						       						       		
				        </tr>
				        <tr>
				            <td>yerin01</td>
				            <td>황예린</td>
				            <td>
    								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
									<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
								</svg>
				            		TASK-2
				            	</td>
				            <td>DB 설계</td>
				            <td>설계</td>
				       		<td>개발</td>
				       		<td>2024.10.05</td>
				       		<td>2024.10.15</td>				 
				       		<td class="text-danger fw-bold">거절</td>				 				       						       						       		
				        </tr>
				        <tr>
				            <td>junggun01</td>
				            <td>안중건</td>
				            <td>
    								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
									<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
								</svg>
				            		TASK-3
				            </td>
				            <td>기본 테스트</td>
				            <td>테스트</td>
				       		<td>이행</td>
				       		<td>2024.10.05</td>
				       		<td>2024.10.15</td>				 
				       		<td class="fw-bold">대기중</td>				 				       						       						       		
				        </tr>				        				        			        
				</table>
			</div>
		</div>
</body>
</html>