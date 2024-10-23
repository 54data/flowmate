<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/myIssue.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/resources/css/mypageSideBar.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
   <main class="d-flex" id="issueMain">
<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>   
        <article>
            <div><span class="myIssueTitle">나의 이슈</span></div>
            <div class="d-flex mt-4 justify-content-between">
                <select class="form-select" id="taskSelect">
                  <option>전체 프로젝트</option>
                  <option>번호</option>
                  <option>프로젝트 번호</option>
                  <option>등록일</option>
                  <option>연결 작업</option>
                  <option>상태</option>
                  <option>단계</option>
                </select>
                <form class="d-flex justify-content-end" class="searchForm">
                    <input class="form-control me-sm-2 issueSearch" type="search" placeholder="이슈 이름을 검색해주세요" >
                    <button type="submit" class="search">
    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
						  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
                    </button>
                </form>
            </div>
            <section>
                <table class="table text-center mt-5">
                    <tr>
                        <th>
                        		번호
	    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
							  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
                        	</th>
                        <th>제목</th>
                        <th>
                        		프로젝트 번호
	    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
							  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
							</svg>
                        	</th>
                        <th>프로젝트 제목</th>
                        <th>등록일</th> 
                        <th>연결작업</th>
                        <th>단계</th>
                        <th>상태</th>
                    </tr>
                    <tr>
                        <td>IS-003</td>
                        <td>이슈1</td>
                        <td>PR-003</td>
                        <td>프로젝트1</td>
                        <td>2024.10.14</td>
                        <td>작업1</td>
                        <td>분석</td>
                        <td>해결</td>
                    </tr>
                    <tr>
                        <td>IS-004</td>
                        <td>이슈2</td>
                        <td>PR-004</td>
                        <td>프로젝트2</td>
                        <td>2024.10.01</td>
                        <td>작업2</td>
                        <td>설계</td>
                        <td>해결</td>
                    </tr>
                </table>
            </section>
        </article>
    </main>
</body>
</html>