<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <main id="systemAdminMain">
        <span class="memberManageSpan">구성원 관리</span>
        <div class="d-flex text-center  mt-4 tabList">
            <a class="d-flex align-items-center" href="${pageContext.request.contextPath}/mypage/adminPage">
                <div class="d-flex justify-content-center align-items-center manageTab">
                    <span>정상 (1)</span>
                </div>
            </a>
            <a class="d-flex align-items-center " href="${pageContext.request.contextPath}/mypage/adminPageDisable">
                <div class="d-flex justify-content-center align-items-center manageTab active">
                    <span>이용중지 (0)</span>
                </div>
            </a>
            <a class="d-flex align-items-center" href="${pageContext.request.contextPath}/mypage/adminPageStay">
            <div class="d-flex justify-content-center align-items-center manageTab">
                <span>가입대기 (1)</span>
            </div>
            </a>
            <hr class="d-flex">
        </div>

          <section class="manageList">
			<div class="d-flex justify-content-between align-items-center">
			    <div class="d-flex align-items-center">
			        <select class="form-select p-0 pe-4" id="manageSelect" name="manageSelect">
			            <option>이름</option>
			            <option>아이디</option>
			        </select>
			
			        <form class="d-flex" method="get" action="#" id="manageSearch">
			            <input class="form-control me-sm-2 search" type="search" placeholder="검색어를 입력 해주세요" >
			            <button type="submit" class="btnSearch">
	    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
							  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
			            </button>
			        </form>
			    </div>			
			</div>
				<table class="table mt-4 text-center">
				        <tr>
				            <th>아이디</th>
				            <th>이름</th>
				            <th>
				           		 부서
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
		   						  <ul class="dropdown-menu">
								    <li><a class="dropdown-item" href="#">전략1부</a></li>
								    <li><a class="dropdown-item" href="#">공공사업1 Div</a></li>
								  </ul>		
				            		
				            </th>
				            <th>
				            		직책
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
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
				            		가입일
						        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>				            
				            	</th>
				            <th>권한</th>
				            <th>상태</th>
				        </tr>
				        <tr>
				            <td>KimHeawon01</td>
				            <td>김해원</td>
				            <td>공공사업1 Div</td>
				            <td>사원</td>
				            <td>
				                <span>2024.10.24</span><br>
				                <span>13:23:34</span>
				            </td>
				            <td>프로젝트 관리자</td>
				            <td>
								<p class="mb-0">이용중지&nbsp;[ <a href="#">해제</a> / <a href="#">삭제 ]</a></p>				            </td>
				        </tr>
				</table>
          </section>
    </main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>         
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>