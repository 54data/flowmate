<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/messageBox.css" rel="stylesheet">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<main class="d-flex" id="messageMain">
		<div class="d-flex">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
        </div>
        <article class="mt-4 ms-4 pe-4">
            <div>
                <ul class="nav nav-underline listActive">
                    <li class="nav-item me-0">
                        <span class="nav-link active" aria-current="page" >수신 쪽지</span>
                    </li>
                    <li class="nav-item">
                        <span class="nav-link text-secondary fw-semibold" aria-current="page" >발신 쪽지</span>
                    </li>
                </ul>
            </div>
            <section class="mi-section p-3 m-0">
                <div class="messageInfo my-2">
                    <div>
                    <p><span class="me-3 sender">보낸 사람</span><span class="senderName">안중건</span><span class="ms-1 senderId">(junggeon96)</span></p>
                    </div>
						<div class="d-flex justify-content-between align-items-center">
						    <p class="m-0">
						        <span class="me-2 reciver">받는 사람</span>
						        <span class="ms-1 reciverName">김해원</span><span class="ms-1 reciverId">(heawwon97)</span>
						        <span class="ms-1 reciverName">황예린</span><span class="ms-1 reciverId">(yerin95)</span>
						    </p>
						    <p class="m-0 fw-medium messageDate">2024-10-10 15:15</p>
						</div>
                </div>
            </section>
            <section class="md-section p-3 py-4 m-0">
                <p class="meesageDetail m-0">
			                    안녕하세요.<br>
			                    다음 주 회의에서 발표할 자료를 준비 중인데, 테스트 결과 보고서가 필요합니다. 혹시 이전에 작성하신 문서나 데이터가 있다면 공유해 주실 수 있을까요?
                    <br>시간이 되실 때 알려주시면 정말 감사하겠습니다!
                </p>
            </section>    
			<div class="d-flex justify-content-between">
			    <button type="button" class="showList">목록보기</button>
			    <div>
			        <button type="button" class="md-delete me-4">삭제</button>
			        <button type="button" class="md-reply">답장</button>
			    </div>
			</div>
        </article>
    </main>
</body>
</html>