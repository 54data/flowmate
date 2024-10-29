<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>  
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.css">
</head>
<body>
	<div id="header">
		<%@ include file="/WEB-INF/views/common/header.jsp" %>
	</div>
	<div class="project-board d-flex">
		<div class="d-flex">
			<%@ include file="/WEB-INF/views/project/projectSidebar.jsp" %>
		</div>

		<div class="noticeForm-container">
			<c:if test="${empty notice}">
				<form onsubmit="return validateForm();" method="post" action="insertNotice" enctype="multipart/form-data">
					<div class="d-flex mb-3 notice-top">
						<h2>공지사항</h2>
					</div>
					<div class="notice-content">
						<div id="notice-top-menu">
							<input type="text" class="form-control" id="notice-title-input" name="noticeTitle" placeholder="제목을 입력하세요" maxlength="50">
							<span id="titleLength">(0/50)</span>
						</div>
						<div class="contents">
							<textarea class="form-control" id="exampleTextarea" rows="20" name="noticeContent" placeholder="내용을 입력하세요" maxlength="2000"></textarea>
			    		</div>
					</div>
					<div class="d-flex align-items-center">
						<div class="modal-section-text">첨부파일</div>
						<span class="badge rounded-pill bg-light ms-2">0</span>
						<div class="notice-file-input-btn ms-auto">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
								<path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
							</svg>
						</div>
						<input class="notice-file-input form-control" type="file" name="noticeAttach[]" style="display:none" multiple>
					</div>
					<div class="file-preview">
					</div>
	 				<div class="d-flex justify-content-end" id="submit-btn"><button type="submit" class="info-btn">등록</button></div>			
				</form>
			</c:if>
			<c:if test="${not empty notice}">
				<form onsubmit="return validateForm();" method="post" action="updateNotice" enctype="multipart/form-data">
					<div class="d-flex mb-3 notice-top">
						<h2>공지사항</h2>
					</div>
					<input type="hidden" name="noticeId" value="${notice.noticeId}">
					<div class="notice-content">
						<div id="notice-top-menu">
							<input type="text" class="form-control" id="notice-title-input" name="noticeTitle" placeholder="제목을 입력하세요" maxlength="50" value="${notice.noticeTitle}">
							<span id="titleLength">(0/50)</span>
						</div>
						<div class="contents">
							<textarea class="form-control" id="exampleTextarea" rows="20" name="noticeContent" placeholder="내용을 입력하세요" maxlength="2000">${notice.noticeContent}</textarea>
			    		</div>
					</div>
					<div class="d-flex align-items-center">
						<div class="modal-section-text">첨부파일</div>
						<span class="badge rounded-pill bg-light ms-2">0</span>
						<div class="notice-file-input-btn ms-auto" style="cursor:pointer;">
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
								<path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
							</svg>
						</div>
						<input class="notice-file-input form-control" type="file" name="noticeAttach" style="display:none" multiple>
					</div>
					<div class="file-preview" data-files="${noticeFiles}">
					    <c:forEach var="file" items="${noticeFiles}">
					        <div class="notice-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
					            ${file.fileName}
					            <button type="button" class="file-remove btn-close ms-2" data-index="${file.fileId}"></button>
					        </div>
					    </c:forEach>
					</div>
					<div class="d-flex justify-content-end" id="submit-btn"><button type="submit" class="info-btn">등록</button></div>			
				</form>
			</c:if>	
		</div>
	</div>
	<script src="${pageContext.request.contextPath}/resources/sweetalert2/sweetalert2.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
</body>
</html>

