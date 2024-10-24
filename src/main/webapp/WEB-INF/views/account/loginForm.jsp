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
<html>
	<head>
		<meta charset="UTF-8">
		<title>로그인</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
		<link href="${pageContext.request.contextPath}/resources/css/account.css" rel="stylesheet">
		<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
		<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">	
	</head>	
	<body>
		<div class="wrap">
			<div class="login-container">
				<div class="loginTop-container">
					<img src="${pageContext.request.contextPath}/resources/images/logo.png" class="login-logo">
					<div class="login-title">로그인</div>				
				</div>
				<form class="login-form" method="post" action="${pageContext.request.contextPath}/login">
					<input class="input-info" id="inputId" name="memberId" placeholder="Id(6~16자)" required>
					<input class="input-info" id="inputPwd" type="password" name="memberPw" placeholder="비밀번호(영문 소문자, 대문자, 특수문자 포함 8~16자)" required>
					<button id="login-btn" type="submit">로그인</button>			
				</form>
				<div class="signup-box">
					<div class="signup-info">아직 회원이 아니신가요?</div>
					<div class="signup-text" onclick="location.href='signupForm'">회원가입</div>						
				</div>
			</div>
		</div>
	</body>
</html>
