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
		<title>회원가입</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
		<link href="${pageContext.request.contextPath}/resources/css/account.css" rel="stylesheet">
		<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
		<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">	
	</head>
	
	<body>
		<div class="wrap">
			<div class="signup-container">
				<div class="loginTop-container">
					<img src="${pageContext.request.contextPath}/resources/images/logo.png" class="login-logo">
					<div class="login-title">회원가입</div>				
				</div>
				<form class="signup-form" method="post" action="signup">
					<input class="input-info" id="inputName" name="memberName" placeholder="이름" required>
					<input class="input-info" id="inputId" name="memberId" placeholder="ID(6~16자)" required>
					<input class="input-info" id="inputPwd" name="memberPw" placeholder="비밀번호(영문 소문자, 대문자, 특수문자 포함 8~16자)" required>
					<input class="input-info" id="inputPwdChk" placeholder="비밀번호 확인" required>
					<select class="input-info" id="inputDept" name="memberDeptId">
						<option value="101001">공공사업1팀</option>
						<option value="101002">공공사업2팀</option>
						<option value="101003">공공사업3팀</option>					
					</select>
					<select class="input-info" id="inputRank" name="memberRankId">
						<option value="102001">부장</option>
						<option value="102002">차장</option>
						<option value="102003">과장</option>			
						<option value="102004">팀장</option>
						<option value="102005">대리</option>
						<option value="102006">사원</option>										
													
					</select>
					<select class="input-info" id="inputRole" name="memberRoleId">
						<option value="100003">개발자</option>
						<option value="100001">프로젝트 관리자</option>
					</select>
					<div class="signup-box">
						<button id="signup-btn" type="submit">회원가입</button>						
					</div>
				</form>
			</div>
		</div>
	</body>
</html>

