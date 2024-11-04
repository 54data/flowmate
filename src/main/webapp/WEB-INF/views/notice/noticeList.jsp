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
	<div id="header">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
	</div>
	<div class="project-board d-flex">
		<%@ include file="../project/projectSidebar.jsp"%>
		<div
			class="d-flex d-flex mt-4 ms-4 me-4 flex-column flex-grow-1 min-vh-100">
			<div class="d-flex justify-content-between align-items-center"
				style="height: 40px;">
				<h2 class="ptitle">공지사항 목록</h2>
				<button onclick="location.href='noticeForm?projectId=${projectId}'" class="btn btn-outline-primary ms-3">공지사항 등록</button>
			</div>
			<div class="d-flex mt-4 justify-content-start">
				<select class="form-select">
					<option>제목</option>
					<option>작성자</option>
				</select>
				<form class="searchForm d-flex justify-content-end">
					<input class="form-control me-sm-2 ms-4" type="search"
						placeholder="검색어를 입력해주세요">
					<button type="submit" class="search ">
						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14"
							fill="currentColor" class="bi bi-search" stroke="#b0b0b0"
							stroke-width="2" viewBox="-1 -1 20 20">
						  <path
								d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
						</svg>
					</button>
				</form>
			</div>
			<table class="table text-center mt-5">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>등록일</th>
					<th>작성자</th>
					<th>조회수</th>
				</tr>
				<c:forEach items="${noticeList}" var="notice">
					<tr onclick="location.href='noticeDetail?projectId=${projectId}&noticeId=${notice.noticeId}'">
						<td>${notice.noticeNum}</td>
						<td>${notice.noticeTitle}</td>
						<td>
							<fmt:parseDate value="${notice.noticeRegdate}" var="registered" pattern="yyyyMMddHHmmss" /> 
							<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
						</td>
						<td>${notice.memberId}</td>
						<td>${notice.noticeHitnum}</td>
					</tr>
				</c:forEach>
			</table>
			<div class="paging">
				<c:if test="${noticeList != null}">
					<ul class="pagination pagination-sm">
						<c:if test="${pager.groupNo > 1}">
							<li class="page-item"><a class="page-link"
								href="noticeList?projectId=${projectId}&pageNo=${pager.startPageNo-1}">&laquo;</a></li>
						</c:if>
						<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}"
							step="1" var="i">
							<c:if test="${pager.pageNo == i}">
								<li class="page-item active"><a class="page-link"
									href="noticeList?projectId=${projectId}&pageNo=${i}">${i}</a></li>
							</c:if>
							<c:if test="${pager.pageNo != i}">
								<li class="page-item"><a class="page-link"
									href="noticeList?projectId=${projectId}&pageNo=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${pager.groupNo < pager.totalGroupNo}">
							<li class="page-item"><a class="page-link"
								href="noticeList?projectId=${projectId}&pageNo=${pager.endPageNo+1}">&raquo;</a></li>
						</c:if>
					</ul>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>