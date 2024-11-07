<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
	<title>참여 프로젝트</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<div class="d-flex min-vh-100" id="messageMain">
		<div class="d-flex">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
		</div>
        <article class="mt-4 ms-4 pe-4">
            <div class="ptitle h2 m-0">참여 프로젝트</div>
            <div class="d-flex justify-content-between mt-4">
	            <div class="d-flex">
			        <select class="form-select" id="myProjectSelect" name="myProjectSelect">
			            <option selected>프로젝트명</option>
			            <option>프로젝트 ID</option>
			            <option>PM</option>
			        </select>
	                <form class="searchForm d-flex justify-content-end">
	                    <input class="form-control me-sm-2 ms-4" id="myProjectInput" type="search" placeholder="검색어를 입력해주세요">
	                    <button type="button" class="search ">
	                    	<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
	                    		<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
	                    </button>
	                </form>
	            </div>
            </div>
            <section>
				<table id="projectList" class="table text-center">
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
							<th>상태
								<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
									<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mb-1"  viewBox="0 0 16 16">
										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
						        </button>
						        <ul class="dropdown-menu">
								</ul>
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="myProject" items="${myProjectList}">
							<fmt:parseDate var="projectStartDate" value="${myProject.projectStartDate}" pattern="yyyyMMddHHmmss"/>
							<fmt:parseDate var="projectDueDate" value="${myProject.projectDueDate}" pattern="yyyyMMddHHmmss"/>
							<fmt:formatDate value="${projectStartDate}" pattern="yyyy.MM.dd" var="projectStartDate"/>
							<fmt:formatDate value="${projectDueDate}" pattern="yyyy.MM.dd" var="projectDueDate"/>
							<tr>
								<td >
									${myProject.projectId}
								</td>
								<td >
									<a href="${pageContext.request.contextPath}/project/projectBoard?projectId=${myProject.projectId}">
										${myProject.projectName}
									</a>
								</td>
								<td >${myProject.memberName}</td>
								<td >${projectStartDate}</td>
								<td >${projectDueDate}</td>
								<c:choose>
									<c:when test="${empty myProject.projectUpdateDate}">
										<td>-</td>
									</c:when>
									<c:otherwise>
										<fmt:parseDate var="projectUpdateDate" value="${myProject.projectUpdateDate}" pattern="yyyyMMddHHmmss"/>
										<fmt:formatDate value="${projectUpdateDate}" pattern="yyyy.MM.dd" var="projectUpdateDate"/>
										<td>${projectUpdateDate}</td>
									</c:otherwise>
								</c:choose>
								<td >${myProject.projectMcnt}</td>
								<td >${myProject.projectProgress}%</td>
								<td >${myProject.projectState}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</section>
		</article>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/myProject.js"></script>
</body>