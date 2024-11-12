<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="${pageContext.request.contextPath}/resources/css/messageBox.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/common.css"
	rel="stylesheet">
</head>
<body>
	<%@ include file="/WEB-INF/views/common/header.jsp"%>
	<main class="d-flex" >
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
		<div class="d-flex mt-4 justify-content-start">
			<form class="searchForm d-flex justify-content-end"
				action="${pageContext.request.contextPath}/message/messageSearch"
				method="get">
				<select class="form-select" name="searchType">
					<option value="${currentPage == 'sent' ?    'receiver' : 'sender'}">이름</option>
					<option value="content">내용</option>
				</select> <input type="hidden" name="currentPage" value="${currentPage}">
				<input class="form-control me-sm-2 ms-4" type="search"
					placeholder="검색어를 입력해주세요" name="keyword">
				<button type="submit" class="search">
					<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14"
						fill="currentColor" class="bi bi-search" stroke="#b0b0b0"
						stroke-width="2" viewBox="-1 -1 20 20">
			            <path
							d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
			        </svg>
				</button>
			</form>
			<div class="ms-auto text-end">
				<button type="button"
					class="send p-0 fw-medium btn btn-outline-primary">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-send me-2" viewBox="0 0 16 16">
						  <path
							d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576zm6.787-8.201L1.591 6.602l4.339 2.76z" />
						</svg>
					쪽지 보내기
				</button>
			</div>
		</div>
		<section>
			<div class="form-check d-flex">
				<input class="form-check-input" type="checkbox" value=""
					id="selectChoice"> <label
					class="form-check-label mb-3 ms-3 fw-semibold d-flex align-items-center fw-medium"
					for="flexCheckDefault" for="selectChoice"> <c:if
						test="${currentPage == 'sent'}">
						<button class=" msgDelete msgDelete-sender p-0"
							id="msgDelete-sender">선택 삭제</button>
					</c:if> <c:if test="${currentPage != 'sent'}">
						<button class=" msgDelete msgDelete-receiver p-0"
							id="msgDelete-receiver">선택 삭제</button>
					</c:if>
				</label>
			</div>

			<div class="messageList mt-2">
			<c:if test="${msgList == null || msgList.isEmpty()}">
			    <p class="text-center mt-5 fw-bold">결과가 없습니다.</p>
			</c:if>
				<c:forEach items="${msgList}" var="msgList">
					<a	class="col-10"
						href="${pageContext.request.contextPath}/message/messageDetail?messageId=${msgList.messageId}&currentPage=${currentPage}">
						<div class="message">
							<div class="d-flex justify-content-between align-items-center">
								<div class="d-flex align-items-center">
									<input class="form-check-input messageCheckbox m-0"
										type="checkbox" value="" id="flexCheckDefault"> <input
										type="hidden" name="messageId" value="${msgList.messageId}">
									<c:if test="${currentPage == 'sent'}">
										<c:set var="namesList" value="${fn:split(msgList.receiverName, ',')}" />
										<c:if test="${fn:length(namesList) > 1}">
										    <span class="receiver ms-3 text-dark fw-bold ">${namesList[0]} 외 ${fn:length(namesList) - 1}명</span>
										</c:if>
										<c:if test="${fn:length(namesList) == 1}">
										    <span class="receiver ms-3 text-dark fw-bold ">${namesList[0]}</span>
										</c:if>
									</c:if>
									<c:if test="${currentPage != 'sent'}">
										<span class="sender ms-3 text-dark fw-bold">${msgList.senderName}</span>
									</c:if>
									<c:if test="${currentPage == 'sent'}">
									    <br>
									    <c:set var="receiverList" value="${fn:split(msgList.messageReceiverId, ',')}" />
									    
									    <span class="sender-id ms-1">
									        (${receiverList[0]}
									        <c:if test="${fn:length(receiverList) > 1}">
									        		...
									        </c:if>)
									    </span>
									</c:if>
									<c:if test="${currentPage != 'sent'}">
										<span class="sender-id ms-1">(${msgList.messageSenderId})</span>
									</c:if>
									<c:if test="${msgList.messageReadDate == null }">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" stroke="#e6e6e6"
											class="bi bi-envelope ms-3" viewBox="0 0 16 16">
										<path
												d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z" />
									</svg>
									</c:if>
									<c:if test="${msgList.messageReadDate != null }">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" stroke="#e6e6e6"
											class="bi bi-envelope-open ms-3" viewBox="0 0 16 16">
									  <path
												d="M8.47 1.318a1 1 0 0 0-.94 0l-6 3.2A1 1 0 0 0 1 5.4v.817l5.75 3.45L8 8.917l1.25.75L15 6.217V5.4a1 1 0 0 0-.53-.882zM15 7.383l-4.778 2.867L15 13.117zm-.035 6.88L8 10.082l-6.965 4.18A1 1 0 0 0 2 15h12a1 1 0 0 0 .965-.738ZM1 13.116l4.778-2.867L1 7.383v5.734ZM7.059.435a2 2 0 0 1 1.882 0l6 3.2A2 2 0 0 1 16 5.4V14a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V5.4a2 2 0 0 1 1.059-1.765z" />
									</svg>
									</c:if>
								</div>
								<fmt:parseDate var="messageSentDate"
									value="${msgList.messageSentDate}" pattern="yyyyMMddHHmmss" />
								<fmt:formatDate value="${messageSentDate}"
									pattern="yyyy.MM.dd. HH:mm:ss" var="sentDate" />
								<span class="text-end receiveDate">${sentDate }</span>
							</div>
							<div class="d-flex mt-2 justify-content-between">
								<p class="messageContext col-10">${msgList.messageContent}</p>
								<p class="text-end col-1">
									<c:if test="${currentPage != 'sent'}">
										<a href="#" class="reply">답장</a>
									</c:if>
								</p>
							</div>
						</div>
					</a>
				</c:forEach>
				<%--페이징 처리 부분 --%>
				<c:if test="${msgList != null && not empty msgList}">
				<div class="d-flex justify-content-center mt-5">
					<ul class="pagination">
						<li class="page-item"><c:if
								test="${not empty keyword || not empty searchType}">
								<a class="page-link"
									href="${pageContext.request.contextPath}/message/messageSearch?searchType=${searchType}&keyword=${keyword}&pageNo=1&currentPage=${currentPage}">처음</a>
							</c:if> <c:if test="${empty keyword && empty searchType}">
								<a class="page-link"
									href="${pageContext.request.contextPath}/message/${currentPage == 'sent' ? 'messageSentBox' : 'messageBox'}?pageNo=1">처음</a>
							</c:if></li>

						<c:if test="${pager.groupNo > 1}">
							<li class="page-item"><c:if
									test="${not empty keyword || not empty searchType}">
									<a class="page-link"
										href="${pageContext.request.contextPath}/message/messageSearch?searchType=${searchType}&keyword=${keyword}&pageNo=${pager.startPageNo - 1}&currentPage=${currentPage}">이전</a>
								</c:if> <c:if test="${empty keyword && empty searchType}">
									<a class="page-link"
										href="${pageContext.request.contextPath}/message/${currentPage == 'sent' ? 'messageSentBox' : 'messageBox'}?pageNo=${pager.startPageNo - 1}">이전</a>
								</c:if></li>
						</c:if>

						<c:forEach var="i" begin="${pager.startPageNo}"
							end="${pager.endPageNo}">
							<li class="page-item ${pager.pageNo == i ? 'active' : ''}">
								<c:if test="${not empty keyword || not empty searchType}">
									<a class="page-link"
										href="${pageContext.request.contextPath}/message/messageSearch?searchType=${searchType}&keyword=${keyword}&pageNo=${i}&currentPage=${currentPage}">${i}</a>
								</c:if> <c:if test="${empty keyword && empty searchType}">
									<a class="page-link"
										href="${pageContext.request.contextPath}/message/${currentPage == 'sent' ? 'messageSentBox' : 'messageBox'}?pageNo=${i}">${i}</a>
								</c:if>
							</li>
						</c:forEach>

						<c:if test="${pager.groupNo < pager.totalGroupNo}">
							<li class="page-item"><c:if
									test="${not empty keyword || not empty searchType}">
									<a class="page-link"
										href="${pageContext.request.contextPath}/message/messageSearch?searchType=${searchType}&keyword=${keyword}&pageNo=${pager.endPageNo + 1}&currentPage=${currentPage}">다음</a>
								</c:if> <c:if test="${empty keyword && empty searchType}">
									<a class="page-link"
										href="${pageContext.request.contextPath}/message/${currentPage == 'sent' ? 'messageSentBox' : 'messageBox'}?pageNo=${pager.endPageNo + 1}">다음</a>
								</c:if></li>
						</c:if>

						<li class="page-item"><c:if
								test="${not empty keyword || not empty searchType}">
								<a class="page-link"
									href="${pageContext.request.contextPath}/message/messageSearch?searchType=${searchType}&keyword=${keyword}&pageNo=${pager.totalPageNo}&currentPage=${currentPage}">
									마지막</a>
							</c:if> <c:if test="${empty keyword && empty searchType}">
								<a class="page-link"
									href="${pageContext.request.contextPath}/message/${currentPage == 'sent' ? 'messageSentBox' : 'messageBox'}?pageNo=${pager.totalPageNo}">
									마지막
								</a>
							</c:if></li>
					</ul>
				</div>
				</c:if>
				<%--페이징 끝 --%>
			</div>
		</section>
	</article>
	</main>
	<script
		src="${pageContext.request.contextPath}/resources/js/messageBox.js"></script>
</body>
</html>