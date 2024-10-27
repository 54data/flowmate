<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
	    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <main class="d-flex" id="messageMain">
    	<div class="d-flex">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
		</div>
        <article>
            <div>
            		<h2>모든 프로젝트</h2>
            	</div>
            <div class="d-flex justify-content-between mt-4">
	            <div class="d-flex">
			        <select class="form-select" style="width: 94px;" id="myProjectSelect" name="myProjectSelect">
			            <option>이름</option>
			            <option>아이디</option>
			        </select>
	                <form class="d-flex searchForm ms-4">
	                    <input class="form-control me-sm-2 projectSearch" type="search" placeholder="프로젝트 이름을 검색해주세요" >
	                    <button type="submit" class="search">
	    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
							  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
	                    </button>
	                </form> 
	            </div>
	            <div>               
	                <button class="projectAdd me-3 btn btn-outline-primary">추가</button>
	                <button class="projectDisabled btn btn-outline-primary">비활성화</button>
	            </div>
            </div>
            <section>
				<table class="table text-center mt-5">
				  <tr>
				    <th class="text-center"> 
				      <input class="form-check-input me-1" type="checkbox" value="" id="selectChoice">
					  번호
				    </th>
				    <th>프로젝트명</th>
				    <th>
				    		등록일
				        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
				        </svg>				    	
				    	</th>
				    <th>
				    		업데이트일
				        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
				        </svg>				    		
				    	</th>
				    	
				    <th>
				    		마감일
				        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
				        </svg>				    		
				    	</th>
				    <th>
				    		참여인원
				        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
				        </svg>				    		
				    	</th>
				    <th>
				    		진행률
				        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16">
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
				    <th>설정</th>
				  </tr>
				  <tr>
				    <td style="padding-left: 30px !important;">
				      <input class="form-check-input" type="checkbox" value="" id="selectChoice">
				      <span>PR-001</span>
				    </td>
				    <td>프로젝트1</td>
				    <td>2024.10.01<br>09:10:33</td>
				    <td>2024.10.01<br>09:10:33</td>
				    <td>2024.10.01<br>09:10:33</td>
				    <td>3명</td>
				    <td>0%</td>
				    <td>진행중</td>
				    <td>
				      <a href="#" class="projectUpdate">[수정]</a>&ensp;
				      <a href="#" class="projectDisabledA">[비활성화]</a>
				    </td>
				  </tr>
				  <tr>
				    <td style="padding-left: 30px !important;">
				      <input class="form-check-input" type="checkbox" value="" id="selectChoice">
				      <span>PR-002</span>
				    </td>
				    <td>프로젝트2</td>
				    <td>2024.10.01<br>09:10:33</td>
				    <td>2024.10.01<br>09:10:33</td>
				    <td>2024.10.01<br>09:10:33</td>
				    <td>3명</td>
				    <td>80%</td>
				    <td>진행중</td>
				    <td>
				      <a href="#" class="projectUpdate">[수정]</a>&ensp;
				      <a href="#" class="projectDisabledA">[비활성화]</a>
				    </td>
				  </tr>
				</table>

            </section>
        </article>
    </main>
</body>
</html>