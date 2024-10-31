<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
	<title>모든 프로젝트</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="d-flex min-vh-100" id="messageMain">
		<div class="d-flex">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
		</div>
        <article class="mt-4 ms-4 pe-4">
            <div class="ptitle h2 m-0">모든 프로젝트</div>
            <div class="d-flex justify-content-between mt-4">
	            <div class="d-flex">
			        <select class="form-select" id="myProjectSelect" name="myProjectSelect">
			            <option>이름</option>
			            <option>아이디</option>
			        </select>
	                <form class="searchForm d-flex justify-content-end">
	                    <input class="form-control me-sm-2 ms-4" type="search" placeholder="검색어를 입력해주세요">
	                    <button type="submit" class="search ">
	                    	<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
	                    		<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
	                    </button>
	                </form>
	            </div>
            </div>
            <section>
				<table id="projectList" class="table text-center mt-5">
					<thead>
						<tr>
							<th>프로젝트 ID</th>
							<th>프로젝트명</th>
							<th>PM</th>
							<th>시작일</th>
							<th>마감일</th>
							<th>업데이트일</th>
							<th>참여인원</th>
							<th>진행률</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="myProject" items="${myProjectList}">
							<fmt:parseDate var="projectStartDate" value="${myProject.projectStartDate}" pattern="yyyyMMddHHmmss"/>
							<fmt:parseDate var="projectDueDate" value="${myProject.projectDueDate}" pattern="yyyyMMddHHmmss"/>
							<fmt:parseDate var="projectUpdateDate" value="${myProject.projectUpdateDate}" pattern="yyyyMMddHHmmss"/>
							<fmt:formatDate value="${projectStartDate}" pattern="yyyy.MM.dd" var="projectStartDate"/>
							<fmt:formatDate value="${projectDueDate}" pattern="yyyy.MM.dd" var="projectDueDate"/>
							<fmt:formatDate value="${projectUpdateDate}" pattern="yyyy.MM.dd" var="projectUpdateDate"/>
							<tr>
								<td>
									<a href="${pageContext.request.contextPath}/project/projectBoard?projectId=${myProject.projectId}">
										${myProject.projectId}
									</a>
								</td>
								<td>
									<a href="${pageContext.request.contextPath}/project/projectBoard?projectId=${myProject.projectId}">
										${myProject.projectName}
									</a>
								</td>
								<td>${myProject.memberName}</td>
								<td>${projectStartDate}</td>
								<td>${projectDueDate}</td>
								<td>${projectUpdateDate}</td>
								<td>${myProject.projectMcnt}</td>
								<td>${myProject.projectProgress}%</td>
								<td>${myProject.projectState}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</section>
		</article>
	</div>
</body>
<!-- 				  <tr> -->
<!-- 				    <th class="text-center">  -->
<!-- 				      <input class="form-check-input me-1" type="checkbox" value="" id="selectChoice"> -->
<!-- 					  번호 -->
<!-- 				    </th> -->
<!-- 				    <th>프로젝트명</th> -->
<!-- 				    <th> -->
<!-- 				    		등록일 -->
<!-- 				        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"> -->
<!-- 				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/> -->
<!-- 				        </svg>				    	 -->
<!-- 				    	</th> -->
<!-- 				    <th> -->
<!-- 				    		업데이트일 -->
<!-- 				        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"> -->
<!-- 				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/> -->
<!-- 				        </svg>				    		 -->
<!-- 				    	</th> -->
				    	
<!-- 				    <th> -->
<!-- 				    		마감일 -->
<!-- 				        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"> -->
<!-- 				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/> -->
<!-- 				        </svg>				    		 -->
<!-- 				    	</th> -->
<!-- 				    <th> -->
<!-- 				    		참여인원 -->
<!-- 				        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"> -->
<!-- 				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/> -->
<!-- 				        </svg>				    		 -->
<!-- 				    	</th> -->
<!-- 				    <th> -->
<!-- 				    		진행률 -->
<!-- 				        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill" viewBox="0 0 16 16"> -->
<!-- 				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/> -->
<!-- 				        </svg>				    		 -->
<!-- 				    	</th> -->
<!-- 				    <th> -->
<!-- 				    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false"> -->
<!-- 				    		상태 -->
<!-- 				        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16"> -->
<!-- 				          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/> -->
<!-- 				        </svg> -->
<!-- 				        </button> -->
<!--   						   <ul class="dropdown-menu "> -->
<!-- 					     <li><a class="dropdown-item" href="#">예정</a></li> -->
<!--     					     <li><a class="dropdown-item" href="#">진행 중</a></li> -->
<!-- 					     <li><a class="dropdown-item" href="#">완료</a></li> -->
<!-- 					     <li><a class="dropdown-item" href="#">보류</a></li>   					         					      -->
<!-- 					     <li><a class="dropdown-item" href="#">비활성화</a></li> -->
<!-- 					   </ul>						    		 -->
<!-- 				    </th> -->
<!-- 				    <th>설정</th> -->
<!-- 				  </tr> -->
<!-- 				  <tr> -->
<!-- 				    <td style="padding-left: 30px !important;"> -->
<!-- 				      <input class="form-check-input" type="checkbox" value="" id="selectChoice"> -->
<!-- 				      <span>PR-001</span> -->
<!-- 				    </td> -->
<!-- 				    <td>프로젝트1</td> -->
<!-- 				    <td>2024.10.01<br>09:10:33</td> -->
<!-- 				    <td>2024.10.01<br>09:10:33</td> -->
<!-- 				    <td>2024.10.01<br>09:10:33</td> -->
<!-- 				    <td>3명</td> -->
<!-- 				    <td>0%</td> -->
<!-- 				    <td>진행중</td> -->
<!-- 				    <td> -->
<!-- 				      <a href="#" class="projectUpdate">[수정]</a>&ensp; -->
<!-- 				      <a href="#" class="projectDisabledA">[비활성화]</a> -->
<!-- 				    </td> -->
<!-- 				  </tr> -->
<!-- 				  <tr> -->
<!-- 				    <td style="padding-left: 30px !important;"> -->
<!-- 				      <input class="form-check-input" type="checkbox" value="" id="selectChoice"> -->
<!-- 				      <span>PR-002</span> -->
<!-- 				    </td> -->
<!-- 				    <td>프로젝트2</td> -->
<!-- 				    <td>2024.10.01<br>09:10:33</td> -->
<!-- 				    <td>2024.10.01<br>09:10:33</td> -->
<!-- 				    <td>2024.10.01<br>09:10:33</td> -->
<!-- 				    <td>3명</td> -->
<!-- 				    <td>80%</td> -->
<!-- 				    <td>진행중</td> -->
<!-- 				    <td> -->
<!-- 				      <a href="#" class="projectUpdate">[수정]</a>&ensp; -->
<!-- 				      <a href="#" class="projectDisabledA">[비활성화]</a> -->
<!-- 				    </td> -->
<!-- 				  </tr> -->
<!-- 				</table> -->
<!--             </section> -->
<!--         </article> -->
<!--     </main> -->
<!-- </body> -->
<!-- </html> -->