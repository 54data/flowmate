<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구성원 관리_정상</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/adminHeader.jsp"%>
	<div class="d-flex min-vh-100">
		<div class="d-flex">
			<%@ include file="/WEB-INF/views/admin/adminSideBar.jsp"%>
		</div>
		<article class="mt-4 ms-4 pe-4">
			<h2 class="ptitle h2 m-0">구성원관리_정상</h2>
				<div class="d-flex justify-content-start mt-4 align-items-center">
				<!-- <div class="d-flex mt-4 justify-content-between"> -->
					<select class="form-select" id="adminPageSelecet" name="adminPageSelecet">
						<option>아이디</option>
						<option>이름</option>
					</select>
					<form class="searchForm d-flex justify-content-end">
						<input class="form-control me-sm-2 ms-4" type="search" id="adminPageInput"  placeholder="검색어를 입력해주세요">
						<button type="submit" class="search">
							<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14"
								fill="currentColor" class="bi bi-search" stroke="#b0b0b0"
								stroke-width="2" viewBox="-1 -1 20 20">
								  <path
									d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0" />
								</svg>
						</button>
					</form>
					<button type="button" class="btn btn-outline-primary ms-auto" id="update-btn">확인</button>
				<!-- </div> -->
				</div>		
			<section>
				<table class="table text-center" id="adminPageTable">
					<thead>
						<tr>
							<th>아이디</th>
							<th>이름</th>
							<th>부서
<!-- 								<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
									<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mb-1"  viewBox="0 0 16 16">
										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
						        </button>
						        <ul class="dropdown-menu">
								</ul>	 -->						
							</th>
							<th>직책
<!-- 								<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
									<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mb-1"  viewBox="0 0 16 16">
										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
						        </button>
						        <ul class="dropdown-menu">
								</ul> -->							
							</th>
							<th>가입일</th>
							<th>권한
<!-- 								<button class="btn dropdown-toggle p-0 ms-auto" data-bs-toggle="dropdown" aria-expanded="false">
									<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mb-1"  viewBox="0 0 16 16">
										<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
						        </button>
						        <ul class="dropdown-menu">
								</ul> -->							
							</th>
							<th>수정일</th>
							<th>처리</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${enableMembers}" var="enableMember">
							<tr>
								<td>${enableMember.memberId}</td>
								<td>${enableMember.memberName}</td>
								<td>
									<select class="form-select" id="inputDept" name="memberDeptId">
										<option value="101001" data-text="공공사업1팀"
											${enableMember.memberDeptId == '101001' ? 'selected' : ''}>공공사업1팀</option>
										<option value="101002" data-text="공공사업2팀"
											${enableMember.memberDeptId == '101002' ? 'selected' : ''}>공공사업2팀</option>
										<option value="101003" data-text="공공사업3팀"
											${enableMember.memberDeptId == '101003' ? 'selected' : ''}>공공사업3팀</option>
									</select>
								</td>
								<td>
									<select class="form-select" id="inputRank" name="memberRankId">
										<option value="102001" 
											${enableMember.memberRankId == '102001' ? 'selected' : ''}>부장</option>
										<option value="102002"
											${enableMember.memberRankId == '102002' ? 'selected' : ''}>차장</option>
										<option value="102003"
											${enableMember.memberRankId == '102003' ? 'selected' : ''}>과장</option>
										<option value="102004"
											${enableMember.memberRankId == '102004' ? 'selected' : ''}>팀장</option>
										<option value="102005"
											${enableMember.memberRankId == '102005' ? 'selected' : ''}>대리</option>
										<option value="102006"
											${enableMember.memberRankId == '102006' ? 'selected' : ''}>사원</option>
									</select>
								</td>
								<td>
									<span> 
										<fmt:parseDate
											value="${enableMember.memberRegdate}" var="registered"
											pattern="yyyyMMddHHmmss" /> 
										<fmt:formatDate
											value="${registered}" pattern="yyyy.MM.dd" />
									</span>
								</td>
								<td>
									<select class="form-select" id="inputRole" name="memberRoleId">
										<option value="100003"
											${enableMember.memberRoleId == '100003' ? 'selected' : ''}>DEV</option>
										<option value="100001"
											${enableMember.memberRoleId == '100001' ? 'selected' : ''}>PM</option>
									</select>
								</td>
								<c:choose>
									<c:when test="${empty enableMember.memberUpdateDate}">
										<td>-</td>
									</c:when>
									<c:otherwise>
										<td>
											<span>
												<fmt:parseDate value="${enableMember.memberUpdateDate}" var="registered" pattern="yyyyMMddHHmmss" /> 
												<fmt:formatDate value="${registered}" pattern="yyyy.MM.dd" />
											</span>
										</td>
									</c:otherwise>
								</c:choose>
								<td>
									<p class="mb-0">
										<span class="deactivate-btn"
											data-member-id="${enableMember.memberId}"
											style="cursor: pointer;">[ 비활성화 ]</span>
									</p>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</section>
		</article>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/adminPage.js"></script>
</body>
</html>