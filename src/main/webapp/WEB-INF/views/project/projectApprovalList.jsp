<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 목록</title>
<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<div class="d-flex min-vh-100">
		<div class="d-flex">
		<%@ include file="../project/projectSidebar.jsp"%>
		</div>
		<article class="mt-4 ms-4 pe-4">
			<h2 class="ptitle h2 m-0">결재 목록</h2>
			<div class="d-flex justify-content-between align-items-center">
				<div class="d-flex mt-4 justify-content-start">
					<select class="form-select" id="prjApprovedSelect" name="prjApprovedSelect">
						<option>작업 ID</option>
						<option>작업명</option>
						<option>담당자</option>
					</select>
					<form class="searchForm d-flex justify-content-end">
						<input class="form-control me-sm-2 ms-4" type="search" id="prjApprovedInput" placeholder="검색어를 입력해주세요">
						<button type="submit" class="search">
							<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14"
								fill="currentColor" class="bi bi-search" stroke="#b0b0b0"
								stroke-width="2" viewBox="-1 -1 20 20">
							  <path
									d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
							</svg>
						</button>
					</form>
				</div>
			</div>
			<section>
				<table id="prjApprovedList" class="table text-center">
					<thead>
						<tr>
							<th>작업ID</th>
							<th>작업명</th>
							<th>단계
								<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
									<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mb-1"  viewBox="0 0 16 16">
										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
						        </button>
						        <ul id="col2" class="dropdown-menu">
								</ul>
							</th>																
							<th>담당자</th>
							<th>현 상태
								<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
									<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mb-1"  viewBox="0 0 16 16">
										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
						        </button>
						        <ul id="col4" class="dropdown-menu">
								</ul>
							</th>								
							<th>요청 상태
								<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
									<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mb-1"  viewBox="0 0 16 16">
										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
						        </button>
						        <ul id="col5" class="dropdown-menu">
								</ul>
							</th>								
							<th>요청일</th>
							<th>결재일</th>
							<th>결재 내역
								<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
									<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mb-1"  viewBox="0 0 16 16">
										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
						        </button>
						        <ul id="col8" class="dropdown-menu">
								</ul>							
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${apprList}" var="approval">
							<tr>
								<td>${approval.fmtTaskId}</td>
								<td>${approval.taskName}</td>
								<td>${approval.stepName}</td>
								<td>${approval.requesterName}</td> 
								<td>${approval.currentState}</td>
								<td>${approval.approvalState}</td>
								<td>
									<fmt:parseDate value="${approval.approvalRequestDate}" var="registered" pattern="yyyyMMddHHmmss" /> 
									<fmt:formatDate value="${registered}" pattern="yyyy.MM.dd" />
								</td>
								<td>
 									<fmt:parseDate value="${approval.approvalResponseDate}" var="registered" pattern="yyyyMMddHHmmss" /> 
									<fmt:formatDate value="${registered}" pattern="yyyy.MM.dd" />
 								</td>								
								<td>${approval.approvalResponseResult}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</section>
 		</article>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/approval.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/approvalList.js"></script>
</body>
</html>