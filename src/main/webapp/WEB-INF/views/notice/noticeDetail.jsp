<!-- 태그 주석  (응답에 포함)-->
<%-- JSP 주석 (응답에 포함이 되지 않는다) --%>

<%-- 페이지 지시자 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 
language : 프로그래밍 언어의 종류
pageEncoding : JSP 소스를 작성할 때 사용할 문자셋(다국어 이용 => UTF-8), 생략시 contentType의 charset을 따라간다
contentType : JSP의 실행 결과(응답 내용)의 종류(MIME타입; charset=응답을 구성하는 문자셋), 생략불가
MIME타입: 실행 후 만들어지는 응답의 종류 ex)대분류/소분류
--%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>
	<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
	<link href="${pageContext.request.contextPath}/resources/datepicker/bootstrap-datepicker.css" rel="stylesheet">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.css">
	<link href="${pageContext.request.contextPath}/resources/css/projectCreating.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">	    
</head>
<body>
	<div class="noticeForm-container">
		<form>
			<div class="d-flex mb-3 notice-top">
				<div class="me-auto p-2"><h2>공지사항</h2></div>
				<div class="p-2"><button type="button" class="info-btn" onclick="location.href='updateNoticeForm?noticeId=${notice.noticeId}'">수정</button></div>
				<div class="p-2"><button type="button" class="info-btn" onclick="location.href='enabledNotice?noticeId=${notice.noticeId}'">비활성화</button></div>
			</div>
			<div class="notice-content">
				<div id="detail-notice-title">${notice.noticeTitle}</div>
				<div class="d-flex flex-row mb-2 notice-info">					
					<div class="p-2 notice-regdate">
						작성일 | <fmt:parseDate value="${notice.noticeRegdate}" var="registered" pattern="yyyyMMddHHmmss" />
						<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
					</div>
					<div class="p-2 notice-hitnum">조회 | ${notice.noticeHitnum}</div>
				</div>
				<div class="contents">
					<div class="detail-notice-contents">
						${notice.noticeContent}
					</div>
	    		</div>
			</div>
			<div class="d-flex align-items-center">
				<div class="modal-section-text">첨부파일</div>
				<span class="badge rounded-pill bg-light ms-2">0</span>
				<div class="file-input-btn ms-auto">
					<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
						<path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
					</svg>
				</div>
				<input class="project-file-input form-control" type="file" style="display:none" multiple disabled>
			</div>
			<div class="file-preview">
				    <c:forEach var="file" items="${noticeFiles}">
				        <div class="project-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border">
				            <span>${file.fileName}</span>
				            <button type="button" class="btn-download ms-2" data-file-id="${file.fileId}">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-down" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M3.5 6a.5.5 0 0 0-.5.5v8a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-8a.5.5 0 0 0-.5-.5h-2a.5.5 0 0 1 0-1h2A1.5 1.5 0 0 1 14 6.5v8a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-8A1.5 1.5 0 0 1 3.5 5h2a.5.5 0 0 1 0 1z"/>
								  <path fill-rule="evenodd" d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
								</svg>				     	
							</button>
				        </div>
				    </c:forEach>
				
			</div>
 			<div style="display: flex; justify-content: center;">
				<button type="button" id="list-btn" onclick="location.href='noticeList'">목록보기</button>
			</div>
		</form>
	</div>
	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/projectCreating.js"></script>
	<script src="${pageContext.request.contextPath}/resources/datepicker/bootstrap-datepicker.js"></script>
	<script src="${pageContext.request.contextPath}/resources/datepicker/bootstrap-datepicker.ko.min.js"></script>
</body>
</html>

