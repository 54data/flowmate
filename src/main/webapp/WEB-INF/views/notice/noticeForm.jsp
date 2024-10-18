<!-- 태그 주석  (응답에 포함)-->
<%-- JSP 주석 (응답에 포함이 되지 않는다) --%>

<%-- 페이지 지시자 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
language : 프로그래밍 언어의 종류
pageEncoding : JSP 소스를 작성할 때 사용할 문자셋(다국어 이용 => UTF-8), 생략시 contentType의 charset을 따라간다
contentType : JSP의 실행 결과(응답 내용)의 종류(MIME타입; charset=응답을 구성하는 문자셋), 생략불가
MIME타입: 실행 후 만들어지는 응답의 종류 ex)대분류/소분류
--%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>  
	<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.css">
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">	    
</head>
<body>
	<div class="noticeForm-container">
		<form onsubmit="return validateForm();">
			<div class="d-flex mb-3 notice-top">
				<h2>공지사항</h2>
			</div>
			<div class="divider"></div>
			<div class="notice-content">
				<div id="notice-top-menu">
					<input type="text" class="form-control" id="notice-title-input" placeholder="제목을 입력하세요" maxlength="50">
					<span id="titleLength">(0/50)</span>
				</div>
				
				<div class="d-flex flex-row mb-2 notice-info">
					<div class="p-2 notice-regdate">작성일 | 2024.10.10</div>
					<div class="p-2 notice-hitnum">조회 | 20</div>
				</div>
				<div class="divider"></div>
				<div class="contents">
					<textarea class="form-control" id="exampleTextarea" rows="20" placeholder="내용을 입력하세요" maxlength="2000"></textarea>
	    		</div>
	    		<span id="contentsLength">(0/2000)</span>
			</div>
			<div class="divider"></div>
			<div class="attachedFile"><input class="form-control" type="file" id="formFile" ></div>
			<div class="divider"></div>
			<div class="d-flex justify-content-end"><button type="submit" class="info-btn">등록</button></div>			
		</form>
	</div>
	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
</body>
</html>

