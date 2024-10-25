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
	        		<h2>결재</h2>					    
	        </div>
	         <div class="d-flex mt-4 justify-content-start">
	             <select class="form-select" >
	               <option>담당자</option>
	               <option>아이디</option>
	               <option>작업ID</option>
	               <option>작업명</option>
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
	         <div class="d-flex justify-content-between border-bottom mt-4">
                <ul class="nav nav-underline listActive text-center ">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/project/projectApproval"><span class="nav-link text-secondary fw-semibold" aria-current="page" style="width: 100px" >결재 내역(2)</span></a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/project/projectApprovalStay"><span class="nav-link active" style="width: 100px" aria-current="page" >결재 요청(1)</span></a>
                    </li>
                </ul>
	         	<div>
	         		<button class="approval-accpet btn btn-outline-primary ms-3 text-danger">승인</button>
		         	<button class="approval-rejection btn btn-outline-primary ms-3 text-info">반려</button>
	         	</div>	         	
	         </div>
				<table class="table text-center mt-5">
			        <tr>
			          			            <th>
			        			<input class=" form-check-input messageCheckbox" type="checkbox" value="" id="flexCheckDefault">
			        		</th>				            		
			            	<th>	아이디</th>
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
			            	<th>설정</th>      					            					            	
			        </tr>
			        <tr>
			        		<td>
			        			<input class="form-check-input messageCheckbox" type="checkbox" value="" id="flexCheckDefault">
			        		</td>					        						            
			            <td> heawon01</td>
			            <td>김해원</td>
			            <td>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
								<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
							</svg>
			            		TASK-1
			            	</td>
			            <td>요구사항 분석</td>
			            <td>테스트</td>
			       		<td>이행</td>
			       		<td>
			       			2024.10.05
			       		</td>			 
			       		<td><span class="text-danger fw-bold">[승인]</span>&nbsp;/&nbsp;<span class="text-info fw-bold">[반려]</span></td>				 				       						       						       		
			        </tr>        				        			        
				</table>
			</div>
		</div>
</body>
</html>