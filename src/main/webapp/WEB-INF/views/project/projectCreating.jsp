<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>프로젝트 생성</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
	</head>
	<body>
		<button type="button" class="new-project btn btn-outline-primary ms-3" data-bs-toggle="modal" data-bs-target="#projectCreating">
		    새 프로젝트
		</button>
		<div class="modal fade" id="projectCreating" tabindex="-1" aria-labelledby="프로젝트 생성" aria-hidden="true">
			<div class="modal-dialog modal-xl">
				<div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="exampleModalLabel">프로젝트 생성</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body">
		               	내용
		            </div>
<!-- 		            <div class="modal-footer"> -->
<!-- 		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button> -->
<!-- 		                <button type="button" class="btn btn-primary">저장</button> -->
<!-- 		            </div> -->
		        </div>
			</div>
		</div>
		<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
	</body>
</html>