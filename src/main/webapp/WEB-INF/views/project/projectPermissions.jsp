<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>접근 제한</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
	</head>
	<body>
		<div class="container">
        <!-- Access Denied Message -->
        <div class="alert alert-danger text-center" role="alert">
            <h4 class="alert-heading">접근이 제한되었습니다.</h4>
            <p>죄송합니다. 해당 프로젝트에 대한 접근 권한이 없습니다.</p>
            <p>이 페이지를 이용하려면 프로젝트에 대한 권한이 필요합니다. 권한이 없으므로 관리자에게 문의해 주세요.</p>
        </div>
        
        <!-- Button to go back to the previous page -->
        <div class="text-center">
            <button onclick="window.history.back();" class="btn btn-primary">이전 페이지로 돌아가기</button>
        </div>
    </div>
	</body>
</html>