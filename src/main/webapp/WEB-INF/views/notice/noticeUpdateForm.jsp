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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
</head>
<body>
	<div class="noticeForm-container">
		<form onsubmit="return validateForm();">
			<div class="d-flex mb-3 notice-top">
				<div class="me-auto p-2"><h4>공지사항</h4></div>
				<div class="p-2"><button type="submit" class="info-btn">등록</button></div>
				<div class="p-2"><button type="button" class="info-btn">비활성화</button></div>
			</div>
			<div class="divider"></div>
			<div class="notice-content">
				<div id="notice-title"><input type="text" class="form-control" placeholder="제목을 입력하세요" maxlength="30"></div>
				<div class="d-flex flex-row mb-2 notice-info">
					<div class="p-2 notice-regdate">작성일 | 2024.10.10</div>
					<div class="p-2 notice-hitnum">조회 | 20</div>
				</div>
				<div class="divider"></div>
				<div class="contents">
					<textarea class="form-control" id="exampleTextarea" rows="20"></textarea>
	    		</div>
			</div>
			<div class="divider"></div>
			<div class="attachedFile"><input class="form-control" type="file" id="formFile" maxlength="2000"></div>
			<div class="divider"></div>
			<div style="display: flex; justify-content: center;">
				<button type="button" id="list-btn">목록보기</button>
			</div>
		</form>
	</div>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
</body>
</html>

