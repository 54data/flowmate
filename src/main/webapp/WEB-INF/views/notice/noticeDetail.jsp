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
				<div class="me-auto p-2"><h2>공지사항</h2></div>
				<div class="p-2"><button type="button" class="info-btn" onclick="location.href='noticeForm'">수정</button></div>
				<div class="p-2"><button type="button" class="info-btn">비활성화</button></div>
			</div>
			<div class="divider"></div>
			<div class="notice-content">
				<div id="detail-notice-title">프로젝트 주요 일정 변경 안내</div>
				<div class="d-flex flex-row mb-2 notice-info">
					<div class="p-2 notice-regdate">작성일 | 2024.10.10</div>
					<div class="p-2 notice-hitnum">조회 | 20</div>
				</div>
				<div class="contents">
					<div class="detail-notice-contents">
							안녕하세요, 팀원 여러분.<br>
							프로젝트 진행 중 몇 가지 주요 일정이 변경되었음을 안내드립니다. 변경 사항은 다음과 같습니다.<br>
							<br>
							기능 개발 완료 기한<br>
							변경 전: 2024년 11월 15일<br>
							변경 후: 2024년 11월 30일<br>
							<br>
							QA 테스트 시작일<br>
							변경 전: 2024년 11월 20일<br>
							변경 후: 2024년 12월 5일<br>
							<br>
							일정에 맞춰 원활하게 작업할 수 있도록 협조 부탁드립니다.<br>
							변경된 일정에 대한 질문이나 의견이 있으시면 언제든지 말씀해 주세요.<br>
					</div>
	    		</div>
			</div>
			<div class="attachedFile"><input class="form-control" type="file" id="formFile" maxlength="2000" disabled></div>
			<div style="display: flex; justify-content: center;">
				<button type="button" id="list-btn" onclick="location.href='noticeList'">목록보기</button>
			</div>
		</form>
	</div>
	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
</body>
</html>

