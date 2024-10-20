<!-- 태그 주석  (응답에 포함)-->
<%-- JSP 주석 (응답에 포함이 되지 않는다) --%>

<%-- 페이지 지시자 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- 
language : 프로그래밍 언어의 종류
pageEncoding : JSP 소스를 작성할 때 사용할 문자셋(다국어 이용 => UTF-8), 생략시 contentType의 charset을 따라간다
contentType : JSP의 실행 결과(응답 내용)의 종류(MIME타입; charset=응답을 구성하는 문자셋), 생략불가
MIME타입: 실행 후 만들어지는 응답의 종류 ex)대분류/소분류
--%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 목록</title>	
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.css">
		<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">	    
	</head>
	
	<body>
		<div class="notice-container">
			<div class="notice-top">
				<h2>공지사항</h2>
				<button onclick="location.href='noticeForm'" class="info-btn">공지사항 등록</button>
			</div>
			<table class="table table-hover">
			  <thead>
			    <tr onclick="location.href='noticeDetail'">
			      <th scope="col" class="notice-id">번호</th>
			      <th scope="col" class="notice-title">제목</th>
			      <th scope="col" class="notice-date">등록일</th>
			      <th scope="col" class="notice-hitCount">조회수</th>
			    </tr>
			  </thead>
			  <tbody>
				<tr onclick="location.href='noticeDetail'">
				  <td scope="col" class="notice-id">1</td>
				  <td scope="col" class="notice-title">프로젝트 주요 일정 변경 안내</td>
				  <td scope="col" class="notice-date">2024.10.10</td>
				  <td scope="col" class="notice-hitCount">10</td>
				</tr>
				<tr onclick="location.href='noticeDetail'">
				  <td scope="col" class="notice-id">2</td>
				  <td scope="col" class="notice-title">프로젝트 주요 일정 변경 안내</td>
				  <td scope="col" class="notice-date">2024.10.10</td>
				  <td scope="col" class="notice-hitCount">10</td>
				</tr>
				<tr onclick="location.href='noticeDetail'">
				  <td scope="col" class="notice-id">3</td>
				  <td scope="col" class="notice-title">프로젝트 주요 일정 변경 안내</td>
				  <td scope="col" class="notice-date">2024.10.10</td>
				  <td scope="col" class="notice-hitCount">10</td>
				</tr>
				<tr onclick="location.href='noticeDetail'">
				  <td scope="col" class="notice-id">4</td>
				  <td scope="col" class="notice-title">프로젝트 주요 일정 변경 안내</td>
				  <td scope="col" class="notice-date">2024.10.10</td>
				  <td scope="col" class="notice-hitCount">10</td>
				</tr>
				<tr onclick="location.href='noticeDetail'">
				  <td scope="col" class="notice-id">5</td>
				  <td scope="col" class="notice-title">프로젝트 주요 일정 변경 안내</td>
				  <td scope="col" class="notice-date">2024.10.10</td>
				  <td scope="col" class="notice-hitCount">10</td>
				</tr>																			  	
			  </tbody>
			</table>
		</div>
		
		<div class="paging">
		  <ul class="pagination pagination-sm">
		    <li class="page-item disabled">
		      <a class="page-link" href="#">&laquo;</a>
		    </li>
		    <li class="page-item active">
		      <a class="page-link" href="#">1</a>
		    </li>
		    <li class="page-item">
		      <a class="page-link" href="#">2</a>
		    </li>
		    <li class="page-item">
		      <a class="page-link" href="#">3</a>
		    </li>
		    <li class="page-item">
		      <a class="page-link" href="#">4</a>
		    </li>
		    <li class="page-item">
		      <a class="page-link" href="#">5</a>
		    </li>
		    <li class="page-item">
		      <a class="page-link" href="#">&raquo;</a>
		    </li>
		  </ul>
		</div>
		
		<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
	</body>
</html>

