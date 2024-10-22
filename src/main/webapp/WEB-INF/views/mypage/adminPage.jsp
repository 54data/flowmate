<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/admin.css" rel="stylesheet">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <main id="systemAdminMain">
        <span class="memberManageSpan">구성원 관리</span>
        <div class="d-flex text-center  mt-4 tabList">
            <a class="d-flex align-items-center manageTab" href="#">
                <div class="d-flex justify-content-center align-items-center manageTab active">
                    <span>정상 (1)</span>
                </div>
            </a>
            <a class="d-flex align-items-center manageTab" href="#">
                <div class="d-flex justify-content-center align-items-center manageTab">
                    <span>이용중지 (0)</span>
                </div>
            </a>
            <a class="d-flex align-items-center manageTab" href="#">
            <div class="d-flex justify-content-center align-items-center manageTab">
                <span>가입대기 (1)</span>
            </div>
            </a>
            <hr class="d-flex">
        </div>

          <section class="manageList">
			<div class="d-flex justify-content-between align-items-center">
			    <div class="d-flex align-items-center">
			        <select class="form-select p-0 pe-4" id="manageSelect" name="manageSelect">
			            <option selected>이름</option>
			            <option>2</option>
			            <option>3</option>
			            <option>4</option>
			            <option>5</option>
			        </select>
			
			        <form class="d-flex" method="get" action="#">
			            <input class="form-control me-sm-2" type="search" placeholder="검색어를 입력 해주세요">
			            <button type="submit" class="btnSearch">검색</button>
			        </form>
			    </div>
			
			    <button class="fw-bold memberPlus ms-auto"><i class="bi bi-plus-lg"></i>구성원 등록</button>
			</div>
				<table class="table mt-4 text-center">
				        <tr>
				            <th>아이디</th>
				            <th>이름</th>
				            <th>부서</th>
				            <th>직책</th>
				            <th>가입일</th>
				            <th>권한</th>
				            <th>상태</th>
				        </tr>
				        <tr>
				            <td>KimHeawon01</td>
				            <td>김해원</td>
				            <td>공공사업1 Div</td>
				            <td>사원</td>
				            <td>
				                <span>2024.10.24</span><br>
				                <span>13:23:34</span>
				            </td>
				            <td>프로젝트 관리자</td>
				            <td>
				                <p class="mb-0">정상&emsp;<a href="#" class="memberDisable">[이용중지]</a></p>
				            </td>
				        </tr>
				</table>
          </section>
    </main>
</body>
</html>