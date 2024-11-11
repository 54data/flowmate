<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항</title> 
    <link href="${pageContext.request.contextPath}/resources/css/notice.css" rel="stylesheet"> 
</head>
<body>
    <div id="header">
        <%@ include file="/WEB-INF/views/common/header.jsp"%>
    </div>
    <div class="project-board d-flex">
        <%@ include file="../project/projectSidebar.jsp"%>
        <div class="d-flex mt-4 ms-4 me-4 flex-column flex-grow-1 min-vh-100">
            <div class="d-flex justify-content-between align-items-center" style="height: 40px;">
                <h2 class="ptitle">공지사항</h2>
                <c:if test="${loginUserId == sessionScope.projectData.memberId}">
					<div class="d-flex justify-content-end">
	                    <div class="p-2">
	                        <button type="button" class="btn btn-outline-primary ms-1" id="noticeEdit-btn" onclick="location.href='updateNoticeForm?projectId=${projectId}&noticeId=${notice.noticeId}'">수정</button>
	                    </div>
	                    <div class="p-2">
	                        <button type="button" class="btn btn-outline-danger ms-1" id="noticeDisable-btn" data-project-id="${projectId}" data-notice-id="${notice.noticeId}">비활성화</button>
	                    </div>
	                </div>
                </c:if>
            </div>
			<input type="hidden" name="noticeId" value="${notice.noticeId}">
            <div class="mt-4">
                <div class="notice-content mb-3">
                    <div id="notice-top-menu" class="d-flex align-items-center">
                        <input type="text" class="form-control detailTitle" id="noticeUpdateTitle" name="noticeTitle" placeholder="제목을 입력하세요" maxlength="50" value="${notice.noticeTitle}" disabled>
                    </div>
                    <div class="contents d-flex flex-row">
						<div class="p-2 notice-regdate">
							작성일 | <fmt:parseDate value="${notice.noticeRegdate}" var="registered" pattern="yyyyMMddHHmmss" />
							<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
						</div>
						<div class="p-2 notice-hitnum">조회 | ${notice.noticeHitnum}</div>
                    </div>
                    <div class="contents mt-2 form-control" id="noticeDetailContent">
						<c:out value="${notice.noticeContent}" escapeXml="false" />                    
					</div>
                </div>
            </div>
            <div class="d-flex align-items-center mb-3 attach">
                <div class="modal-section-text">첨부파일</div>
                <span class="badge rounded-pill file-count bg-light ms-2">${fileCount}</span>
                <div class="notice-file-input-btn ms-auto">
		       </div>
            </div>
            <div class="file-preview mb-3" data-files="${noticeFiles}">
			    <c:forEach var="file" items="${noticeFiles}">
			        <div class="notice-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
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
            <div style="display: flex; justify-content: center;">
					<button type="button" id="list-btn" onclick="location.href='noticeList?projectId=${projectId}'">목록보기</button>
			</div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/js/notice.js"></script>
</body>
</html>
