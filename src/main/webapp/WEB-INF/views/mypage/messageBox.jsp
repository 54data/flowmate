<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/messageBox.css" rel="stylesheet">
	    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<main class="d-flex" id="messageMain">
	<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
        <article>
            <div>
                <ul class="nav nav-underline listActive">
                    <li class="nav-item">
                        <span class="nav-link active" aria-current="page" >수신 쪽지</span>
                    </li>
                    <li class="nav-item">
                        <span class="nav-link text-secondary fw-semibold" aria-current="page" >발신 쪽지</span>
                    </li>
                </ul>
            </div>
            <section>
                <div class="form-check justify-content-between d-flex">
                    <input class="form-check-input" type="checkbox" value="" id="selectChoice">
                    <label class="form-check-label mb-3 ms-3 fw-semibold d-flex align-items-center fw-medium" for="flexCheckDefault" for="selectChoice">
						<button class="msgDelete">선택 삭제</button>
                    </label>
                    <div class="ms-auto text-end">
                    <button type="button" class="send p-0 fw-medium"><i class="bi bi-send"></i> 쪽지 보내기</button>
                    </div>
                  </div>
                  
				<div class="messageList mt-4">
			<%for(int i=0;i<3;i++) {%><%--jstl로 변경 예정 --%>
        			<a href="${pageContext.request.contextPath}/mypage/messageDetail">
				    <div class="message">
				        <div class="d-flex justify-content-between align-items-center">
				            <div class="d-flex align-items-center">
				                <input class="form-check-input messageCheckbox" type="checkbox" value="" id="flexCheckDefault">
				                <span class="sender ms-3 text-dark fw-bold">안중건</span>
				            </div>
				            <span class="text-end receiveDate">2024-10-10 15:15</span>
				        </div>
				        <div class="d-flex mt-2 justify-content-between">
				            <p class="messageContext">
						                현재 맡고 계신 [작업/기능 이름]의 진행 상황이 궁금합니다. QA 일정에 맞추어 작업이 잘 진행되고 있는지 확인해 주시면 감사하겠습니다.
						         <br>혹시 어려운 점이나 추가적인 지원이 필요하시면 언제든지 말씀해 주세요.
				            </p>
				            <p class="text-end">
				                <a href="#" class="reply">답장</a>
				            </p>
				        </div>   
				    </div>   
				    </a>
				    <%} %>
				</div>

            </section>    
        </article>
    </main>
</body>
</html>