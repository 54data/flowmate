<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title>  
</head>
<body>
    <div id="header">
        <%@ include file="/WEB-INF/views/common/header.jsp"%>
    </div>
    <div class="project-board d-flex">
        <%@ include file="../project/projectSidebar.jsp"%>
        <div class="d-flex mt-4 ms-4 me-4 flex-column flex-grow-1 min-vh-100">
			<c:if test="${empty notice}">
				<div class="d-flex justify-content-between align-items-center" style="height: 40px;">
	                <h2 class="ptitle">공지사항</h2>
	                <div class="d-flex justify-content-end">
	                    <div class="p-2">
			                <button type="button" id="noticeInsert-btn" class="btn btn-outline-primary ms-3" data-project-id="${projectId}">등록</button>
	                    </div>
	                </div>
	            </div>
				<form id="insertForm">
		            <div class="mt-4">
		                <div class="notice-content mb-3">
		                    <div id="notice-top-menu" class="d-flex align-items-center">
		                        <input type="text" class="form-control" id="noticeTitle" name="noticeTitle" placeholder="제목을 입력하세요" maxlength="50">
		                        <span id="titleLength" class="ms-2">(0/50)</span>
		                    </div>
		                    <div class="contents mt-2">
		                        <textarea class="form-control" id="noticeContent" rows="20" name="noticeContent" placeholder="내용을 입력하세요" maxlength="2000"></textarea>
		                    </div>
		                </div>
		            </div>
		            <div class="d-flex align-items-center mb-3">
		                <div class="modal-section-text">첨부파일</div>
		                <span class="badge rounded-pill file-count bg-light ms-2">0</span>
		                <div class="notice-file-input-btn ms-auto" style="cursor:pointer;">
		                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
		                        <path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
		                    </svg>
		                </div>
		                <input class="notice-file-input form-control" type="file" id="noticeAttach" name="noticeAttach" style="display:none" multiple>
		            </div>
		            <div class="file-preview mb-3">
		                <!-- 첨부 파일 미리보기 영역 -->
		            </div>
<%-- 		            <div class="d-flex justify-content-end">
		                <button type="button" id="noticeInsert-btn" class="btn btn-outline-primary ms-3" data-project-id="${projectId}">등록</button>
		            </div>
 --%>	            </form>
			</c:if>
			
			<c:if test="${not empty notice}">
				<div class="d-flex justify-content-between align-items-center" style="height: 40px;">
	                <h2 class="ptitle">공지사항</h2>
	                <div class="d-flex justify-content-end">
	                    <div class="p-2">
							<button type="submit" id="noticeUpdate-btn" class="btn btn-outline-primary ms-3" data-project-id="${projectId}" data-notice-id="${notice.noticeId}">수정</button>
	                    </div>
	                </div>
	            </div>
				<form id="updatetForm">
					<input type="hidden" name="noticeId" value="${notice.noticeId}">
		            <div class="mt-4">
		                <div class="notice-content mb-3">
		                    <div id="notice-top-menu" class="d-flex align-items-center">
		                        <input type="text" class="form-control" id="noticeUpdateTitle" name="noticeTitle" placeholder="제목을 입력하세요" maxlength="50" value="${notice.noticeTitle}">
		                        <span id="titleLength" class="ms-2">(0/50)</span>
		                    </div>
		                    <div class="contents mt-2">
		                        <textarea class="form-control" id="noticeUpdateContent" rows="20" name="noticeContent" placeholder="내용을 입력하세요" maxlength="2000">${notice.noticeContent}</textarea>
		                    </div>
		                </div>
		            </div>
		            <div class="d-flex align-items-center mb-3">
		                <div class="modal-section-text">첨부파일</div>
		                <span class="badge rounded-pill file-count bg-light ms-2">0</span>
		                <div class="notice-file-input-btn ms-auto" style="cursor:pointer;">
		                    <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
		                        <path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
		                    </svg>
		                </div>
		                <input class="notice-file-input form-control" type="file" id="noticeUpdateAttach" name="noticeAttach" style="display:none" multiple>
		            </div>
		            <div class="file-preview mb-3" data-files="${noticeFiles}">
					    <c:forEach var="file" items="${noticeFiles}">
					        <div class="notice-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
					            ${file.fileName}
					            <button type="button" class="file-remove btn-close ms-2" data-index="${file.fileId}"></button>
					        </div>
					    </c:forEach>
		            </div>
<%-- 		            <div class="d-flex justify-content-end">
						<button type="submit" id="noticeUpdate-btn" class="btn btn-outline-primary ms-3" data-project-id="${projectId}" data-notice-id="${notice.noticeId}">수정</button>
		            </div>
 --%>	            </form>
			</c:if>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
</body>
</html>
