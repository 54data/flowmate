<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/messageBox.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<script
	src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<main class="d-flex" id="messageMain">
	<div class="d-flex">
		<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp"%>
	</div>
	<article class="mt-4 ms-4 pe-4">
		<div>
			<ul class="nav nav-underline listActive">
				<a href="${pageContext.request.contextPath}/message/messageBox">
					<li class="nav-item"><span
						class="nav-link <c:if test="${currentPage == 'receive'}">active</c:if>"
						aria-current="page">수신 쪽지</span></li>
				</a>
				<a href="${pageContext.request.contextPath}/message/messageSentBox">
					<li class="nav-item"><span
						class="nav-link <c:if test="${currentPage == 'sent'}">active</c:if> text-secondary fw-semibold ms-4"
						aria-current="page">발신 쪽지</span></li>
				</a>
			</ul>
		</div>
		<section class="mi-section p-3 m-0">
			<div class="messageInfo my-2">
				<div>
					<p>
						<span class="me-3 sender">보낸 사람</span><span class="senderName">${messageDetail.senderName }</span><span
							class="ms-1 senderId">(${messageDetail.messageSenderId })</span>
					</p>
				</div>
				<div class=" d-flex justify-content-between align-items-center">
					<p class="m-0">
						<span class="me-2 reciver">받는 사람</span>
						<c:forEach var="receiver" items="${receiverList}">
							<span class="ms-1 reciverName">${receiver.receiverName}</span>
							<span class="ms-1 reciverId">(${receiver.receiverId})</span>
						</c:forEach>
					</p>
					<fmt:parseDate var="messageSentDate"
						value="${messageDetail.messageSentDate}" pattern="yyyyMMddHHmmss" />
					<fmt:formatDate value="${messageSentDate}"
						pattern="yyyy.MM.dd. HH:mm:ss" var="sentDate" />
					<p class="m-0 fw-medium messageDate">${sentDate }</p>
				</div>
			</div>
		</section>
		<section class="md-section p-3 py-4 m-0">
			<p class="meesageDetail m-0">${messageDetail.messageContent}</p>
		</section>
            <div class="d-flex align-items-center mb-3 mt-3 attach">
                <div class="modal-section-text">첨부파일</div>
                <span class="badge rounded-pill file-count bg-light ms-2">${fileCount}</span>
                <div class="notice-file-input-btn ms-auto">
		       </div>
            </div>
            <div class="file-preview mb-3" data-files="${msgFiles}">
			    <c:forEach var="file" items="${msgFiles}">
			        <div class="msg-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
			            ${file.fileName}
			            <button type="button" class="btn-download ms-2" onclick="location.href='downloadFile?fileId=${file.fileId}'" style="background-color:white; border:none">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-down" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M3.5 6a.5.5 0 0 0-.5.5v8a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-8a.5.5 0 0 0-.5-.5h-2a.5.5 0 0 1 0-1h2A1.5 1.5 0 0 1 14 6.5v8a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-8A1.5 1.5 0 0 1 3.5 5h2a.5.5 0 0 1 0 1z"/>
							  <path fill-rule="evenodd" d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
							</svg>				     	
						</button>
			        </div>
			    </c:forEach>
            </div>
		<div class="d-flex justify-content-between">
			<button type="button" class="showList btn btn-outline-primary">목록보기</button>
			<div>
				<c:if test="${currentPage == 'sent'}">
					<button type="button"
						class="md-delete sender me-4 btn btn-outline-danger"
						data-message-id="${messageDetail.messageId}">삭제</button>
				</c:if>
				<c:if test="${currentPage != 'sent'}">
					<button type="button"
						class="md-delete receiver me-4 btn btn-outline-danger"
						data-message-id="${messageDetail.messageId}">삭제</button>
				</c:if>
				<c:if test="${currentPage != 'sent'}">
					<button type="button" class="md-reply btn btn-outline-primary">답장</button>
				</c:if>
			</div>
		</div>
	</article>
	</main>
	<script
		src="${pageContext.request.contextPath}/resources/js/messageBox.js"></script>
</body>
</html>