<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="${pageContext.request.contextPath}/resources/css/messageBox.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
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
					<a href="${pageContext.request.contextPath}/message/messageBox">
	                    <li class="nav-item">
	                        <span class="nav-link active" aria-current="page" >수신 쪽지</span>
	                    </li>
                    </a>
					<a href="${pageContext.request.contextPath}/message/messageSentBox">                    
	                    <li class="nav-item">
	                        <span class="nav-link text-secondary fw-semibold ms-4" aria-current="page" >발신 쪽지</span>
	                    </li>
                    </a>
                </ul>
            </div>
            <div class="d-flex mt-4 justify-content-start">
                <select class="form-select" >
                  <option>이름</option>
                  <option>내용</option>
                </select>
                <form class="searchForm d-flex justify-content-end">
                    <input class="form-control me-sm-2 ms-4" type="search" placeholder="검색어를 입력해주세요" >
                    <button type="submit" class="search ">
    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
						  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
                    </button>
                </form>
                    <div class="ms-auto text-end">
					<button type="button" class="send p-0 fw-medium btn btn-outline-primary">
	                    	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send me-2" viewBox="0 0 16 16">
						  <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z"/>
						</svg>
                    		쪽지 보내기
                    </button>
                    </div>
            </div>            
            <section>
                <div class="form-check d-flex">
                    <input class="form-check-input" type="checkbox" value="" id="selectChoice">
                    <label class="form-check-label mb-3 ms-3 fw-semibold d-flex align-items-center fw-medium" for="flexCheckDefault" for="selectChoice">
						<button class="msgDelete p-0">선택 삭제</button>
                    </label>
                  </div>
                  
				<div class="messageList mt-2">
			<%for(int i=0;i<3;i++) {%><%--jstl로 변경 예정 --%>
        			<a href="${pageContext.request.contextPath}/message/messageDetail">
				    <div class="message">
				        <div class="d-flex justify-content-between align-items-center">
				            <div class="d-flex align-items-center">
				                <input class="form-check-input messageCheckbox m-0" type="checkbox" value="" id="flexCheckDefault">
				                <span class="sender ms-3 text-dark fw-bold">안중건</span>
				                <span class="sender-id ms-1">(junggeon01)</span>				                
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" stroke="#e6e6e6" class="bi bi-envelope-open ms-3" viewBox="0 0 16 16">
								  <path d="M8.47 1.318a1 1 0 0 0-.94 0l-6 3.2A1 1 0 0 0 1 5.4v.817l5.75 3.45L8 8.917l1.25.75L15 6.217V5.4a1 1 0 0 0-.53-.882zM15 7.383l-4.778 2.867L15 13.117zm-.035 6.88L8 10.082l-6.965 4.18A1 1 0 0 0 2 15h12a1 1 0 0 0 .965-.738ZM1 13.116l4.778-2.867L1 7.383v5.734ZM7.059.435a2 2 0 0 1 1.882 0l6 3.2A2 2 0 0 1 16 5.4V14a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V5.4a2 2 0 0 1 1.059-1.765z"/>
								</svg>				                
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
<script src="${pageContext.request.contextPath}/resources/js/messageBox.js"></script>	 
</body>
</html>