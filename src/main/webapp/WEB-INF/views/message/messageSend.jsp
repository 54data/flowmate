<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/messageBox.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/select2/select2.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">	
</head>
<body id="sendBody" class="d-flex justify-content-center">
	<div id="messagePop" class="d-flex justify-content-center p-3 pt-2">
	<form id="sendMessage" method="post" enctype="multipart/form-data">
		<div class="d-flex align-items-center">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
			  <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z"/>
			</svg>
			<h5 class="ms-3 mb-2 mt-2">쪽지 보내기</h5>
		</div>
		<div class="d-flex align-items-center mt-1 mb-1 w-100">
			<span class="ms-reciver col-2">받는 사람</span>
			<div class="ms-reciverSelect w-100">
				<select class="reciver-select w-100" name="states[]" multiple="multiple">
					<option value="AL">김김김</option>
					<option value="WY">해해해</option>
					<option value="WY">원원원</option>
					<option value="WY">황황황</option>
					<option value="WY">예예예</option>
					<option value="WY">린린린</option>
					<option value="WY">안안안</option>
					<option value="WY">중중중</option>
					<option value="WY">건건건</option>
					<option value="WY">아무개</option>
					<option value="WY">홍길동</option>
					<option value="WY">피크민</option>
					<option value="WY">짱구</option>
				</select>
			</div>
		</div>
		<div class="mt-3">
			<div class="modal-section-text mb-1"><h5 class="mb-2 mt-2">내용</h5></div>
			<div class="w-100">
				<textarea class="message-content form-control border p-3 bg-white" placeholder="내용을 입력하세요." id="project-textarea"></textarea>
			</div>
		</div>
		<div class="mt-2">
			<div class="d-flex align-items-center" style="height: 40px;">
		 		<div><h5>첨부파일</h5></div>
				<span class="badge rounded-pill bg-light ms-2">0</span>
				<div class="file-input-btn ms-auto">
					<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
						<path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
					</svg>
				</div>
				<input class="message-file-input form-control" type="file" style="display:none" multiple>
			</div>
			<div class="message-file-preview d-flex">
			</div>
		</div>		
		<div>
			<button class="mt-3 btn btn-outline-primary">보내기</button>
		</div>
	</form>	
	</div>
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/select2/select2.min.js"></script>	
<script src="${pageContext.request.contextPath}/resources/js/messageSend.js"></script>	
</body>
</html>