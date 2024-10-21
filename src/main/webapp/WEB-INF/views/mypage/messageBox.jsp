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
        <aside class="sideBar">
            <ul class="sideList">
                <li><a href="#"><i class="bi bi-layout-three-columns"></i>대시보드</a></li>
                <li><a href="#"><i class="bi bi-terminal"></i>모든 프로젝트</a></li>
                <li><a href="#"><i class="bi bi-bag-plus-fill"></i>나의 작업</a></li>
                <li><a href="#"><i class="bi bi-hexagon"></i>나의 이슈</a></li>
                <li><a href="#"><i class="bi bi-envelope"></i>쪽지함</a></li>
                <li><a href="#"><i class="bi bi-gear-wide"></i>개인정보 수정</a></li>
            </ul>
        </aside>
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
                <div class="form-check d-flex">
                    <input class="form-check-input" type="checkbox" value="" id="selectChoice">
                    <label class="form-check-label ms-3 fw-semibold d-flex align-items-center fw-medium" for="flexCheckDefault" for="selectChoice">
                       	 선택 삭제
                    </label>
                    <button class="delete">삭제</button>
                    <div class="ms-auto text-end">
                    <button type="button" class="send p-0 fw-medium"><i class="bi bi-send"></i> 쪽지 보내기</button>
                    </div>
                  </div>

                  <div class="messageList mt-4">  
                    <div class="message">
                        <div class="d-flex">
                            <input class="form-check-input messageCheckbox" type="checkbox" value="" id="flexCheckDefault">
                                <span class="sender ms-3">안중건</span>
                                <span class="text-end receiveDate">2024-10-10 15:15</span>
                        </div>
                        <div class="d-flex mt-2">
                            <p class="messageContext  col-10">
				                                현재 맡고 계신 [작업/기능 이름]의 진행 상황이 궁금합니다. QA 일정에 맞추어 작업이 잘 진행되고 있는지 확인해 주시면 감사하겠습니다.
				                                혹시 어려운 점이나 추가적인 지원이 필요하시면 언제든지 말씀해 주세요.
                            </p>
                            <p class="text-end">
                                <a href="#" class="reply">답장</a>
                            </p>
                        </div>    
                    </div>   
                    <!--두번째 편지-->
                    <div class="message">
                        <div class="d-flex">
                            <input class="form-check-input messageCheckbox" type="checkbox" value="" id="flexCheckDefault">
                                <span class="sender ms-3">안중건</span>
                                <span class="text-end receiveDate">2024-10-10 15:15</span>
                        </div>
                        <div class="d-flex mt-2">
                            <p class="messageContext  col-10">
			                                현재 맡고 계신 [작업/기능 이름]의 진행 상황이 궁금합니다. QA 일정에 맞추어 작업이 잘 진행되고 있는지 확인해 주시면 감사하겠습니다.
			                                혹시 어려운 점이나 추가적인 지원이 필요하시면 언제든지 말씀해 주세요.
                            </p>
                            <p class="text-end">
                                <a href="#" class="reply">답장</a>
                            </p>
                        </div>    
                    </div>
                </div>  
            </section>    
        </article>
    </main>
</body>
</html>