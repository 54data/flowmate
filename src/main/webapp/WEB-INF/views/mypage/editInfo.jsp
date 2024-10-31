<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="${pageContext.request.contextPath}/resources/css/mypage.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
   <main class="d-flex" id="editInfo">
   		<div class="d-flex">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
        </div>
        <article class="mt-4 ms-4 pe-4">
        	<section>
            <div class="ptitle h2 m-0" id="myinfo-title">개인정보 수정</div>
				<form class="info-change-form" method="post" action="updateInfo">
					<div class="myinfo-list">
						<div class="myinfo-name">
							<div class="myinfo-col">이름</div>
							<div>${member.memberName}</div>
						</div>
						<div class="myinfo-id">
							<div class="myinfo-col">아이디</div>
							<div class="myinfo-id-row">
								<span id="myinfo-getId">${member.memberId}</span>
							</div>
						</div>
						<div class="myinfo-dept">
							<span class="myinfo-col">부서</span>
							<div class="inputMessage">
							<select class="form-select" id="inputDept" name="memberDeptId">
								<option value="101001" ${member.memberDeptId == '101001' ? 'selected' : ''}>공공사업1팀</option>
								<option value="101002" ${member.memberDeptId == '101002' ? 'selected' : ''}>공공사업2팀</option>
								<option value="101003" ${member.memberDeptId == '101003' ? 'selected' : ''}>공공사업3팀</option>					
							</select>
							<div id="inputPhoneMessage" class="errorMessage"></div>
							</div>
						</div>
						<div class="myinfo-rank">
							<span class="myinfo-col">직급</span>
							<div class="inputMessage">
								<select class="form-select" id="inputRank" name="memberRankId">
									<option value="102001" ${member.memberRankId == '102001' ? 'selected' : ''}>부장</option>
									<option value="102002" ${member.memberRankId == '102002' ? 'selected' : ''}>차장</option>
									<option value="102003" ${member.memberRankId == '102003' ? 'selected' : ''}>과장</option>			
									<option value="102004" ${member.memberRankId == '102004' ? 'selected' : ''}>팀장</option>
									<option value="102005" ${member.memberRankId == '102005' ? 'selected' : ''}>대리</option>
									<option value="102006" ${member.memberRankId == '102006' ? 'selected' : ''}>사원</option>										
								</select>
								<div id="inputEmailMessage" class="errorMessage"></div>
							</div>
						</div>
						<div class="myinfo-role">
							<span class="myinfo-col">권한</span>
							<div class="inputMessage">
								<select class="form-select" id="inputRole" name="memberRoleId">
									<option value="100003" ${member.memberRoleId == '100003' ? 'selected' : ''}>개발자</option>
									<option value="100001" ${member.memberRoleId == '100001' ? 'selected' : ''}>프로젝트 관리자</option>
								</select>
								<div id="inputEmailMessage" class="errorMessage"></div>
							</div>
						</div>
						<div class="myinfo-role">
							<span class="myinfo-col">비밀번호 변경</span>
							<div class="inputMessage">
								<button class="btn btn-outline-primary ms-3" id="edit-pwd-btn" type="button">비밀번호 변경하기</button>
							</div>
						</div>						
						<div class="myinfo-edit">
 							<button type="submit" class="btn btn-outline-primary ms-3">확인</button>
						</div>
					</div>
				</form>
			</section>
        </article>
    </main>
    <script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/mypage.js"></script>
</body>
</html>