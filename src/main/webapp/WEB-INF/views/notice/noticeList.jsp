<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 목록</title>	
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.css">
	</head>
	
	<body>
		<div id="header">
			<%@ include file="/WEB-INF/views/common/header.jsp" %>
		</div>
		<div class="project-board d-flex">
			<div class="d-flex">
				<%@ include file="/WEB-INF/views/project/projectSidebar.jsp" %>
			</div>
			<div class="notice-container">
				<div class="notice-top">
					<h2>공지사항</h2>
					<button onclick="location.href='noticeForm'" class="info-btn">공지사항 등록</button>
				</div>
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col" class="notice-id">번호</th>
							<th scope="col" class="notice-title">제목</th>
							<th scope="col" class="notice-date">등록일</th>
							<th scope="col" class="notice-writer">작성자</th>
							<th scope="col" class="notice-hitCount">조회수</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${noticeList}" var="notice">
						<tr onclick="location.href='noticeDetail?noticeId=${notice.noticeId}'">
							<td scope="col" class="notice-id">${notice.noticeNum}</td>
							<td scope="col" class="notice-title">${notice.noticeTitle}</td>
							<td scope="col" class="notice-date">
								<fmt:parseDate value="${notice.noticeRegdate}" var="registered" pattern="yyyyMMddHHmmss" />
								<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
							</td>
							<td scope="col" class="notice-writer">${notice.memberId}</td>
							<td scope="col" class="notice-hitCount">${notice.noticeHitnum}</td>
						</tr>
					</c:forEach>																			  	
					</tbody>
				</table>
				<div class="paging">
					<c:if test="${noticeList != null}">
						<ul class="pagination pagination-sm">
						<c:if test="${pager.groupNo > 1}">
							<li class="page-item">
						      <a class="page-link" href="noticeList?pageNo=${pager.startPageNo-1}">&laquo;</a>
						    </li>
						</c:if>				
						<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
							<c:if test="${pager.pageNo == i}">
								<li class="page-item active">
									<a class="page-link" href="noticeList?pageNo=${i}">${i}</a>
								</li>
							</c:if>
							<c:if test="${pager.pageNo != i}">
								<li class="page-item">
									<a class="page-link" href="noticeList?pageNo=${i}">${i}</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${pager.groupNo < pager.totalGroupNo}">
							<li class="page-item">
								<a class="page-link" href="noticeList?pageNo=${pager.endPageNo+1}">&raquo;</a>
							</li>
						</c:if>
						</ul>
					</c:if>
				</div>
			</div>
			
		</div>		
		<script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
	</body>
</html>

