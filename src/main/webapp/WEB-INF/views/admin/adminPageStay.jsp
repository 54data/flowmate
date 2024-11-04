<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/admin/adminHeader.jsp" %>
    <main class="d-flex" id="adminPageMain">
    	<div class="d-flex">
			<%@ include file="/WEB-INF/views/admin/adminSideBar.jsp" %>
		</div>
        <article class="mt-4 ms-4 pe-4">
			<div class="d-flex justify-content-between align-items-center" style="height: 40px;">
           		<h2 class="ptitle h2 m-0">구성원 관리</h2>					    
           		<button type="button" class="btn btn-outline-primary ms-3" id="update-btn">확인</button>
            </div>
            <div class="d-flex mt-4">
                <select class="form-select" id="taskSelect">
                  <option>아이디</option>
                  <option>이름</option>
                  <option>부서</option>
                  <option>직책</option>
                  <option>가입일</option>
                  <option>권한</option>
                  <option>수정일</option>
                  <option>처리</option>
                </select>
                <form class="searchForm d-flex justify-content-end">
                    <input class="form-control me-sm-2 ms-4" type="search" placeholder="검색어를 입력해주세요" >
                    <button type="submit" class="search ">
    						<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" class="bi bi-search" stroke="#b0b0b0" stroke-width="2" viewBox="-1 -1 20 20">
						  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
						</svg>
                    </button>
                </form>
            </div>
            <section>
				<table class="table text-center mt-5">
				        <tr>
				            <th>아이디</th>
				            <th>이름</th>
				            <th>
				            	<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				            		부서
					            	<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mt-auto mb-auto" viewBox="0 0 16 16">
									  <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
									</svg>
								</button>
								<ul class="dropdown-menu">
							    	<li><a class="dropdown-item" href="#">공공사업1팀</a></li>
									<li><a class="dropdown-item" href="#">공공사업2팀</a></li>
									<li><a class="dropdown-item" href="#">공공사업3팀</a></li>
							   	</ul>				            		
				            </th>
				            <th>
				            	<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
				            	직책
				            	<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill mt-auto mb-auto" viewBox="0 0 16 16">
									<path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
								</svg>
								</button>
								<ul class="dropdown-menu">
							    	<li><a class="dropdown-item" href="#">부장</a></li>
									<li><a class="dropdown-item" href="#">차장</a></li>
									<li><a class="dropdown-item" href="#">과장</a></li>
									<li><a class="dropdown-item" href="#">차장</a></li>
									<li><a class="dropdown-item" href="#">대리</a></li>
									<li><a class="dropdown-item" href="#">사원</a></li>
							   	</ul>				            		
				            </th>
				            <th>가입일</th> 
				            <th>
								<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
									권한
								<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
								     <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
								</svg>
						        </button>
		  						<ul class="dropdown-menu ">
							    	<li><a class="dropdown-item" href="#">PM</a></li>
									<li><a class="dropdown-item" href="#">DEV</a></li>
							   	</ul>				            		
				            </th>
				            <th>수정일</th>
				            <th>
						    	<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		처리
						        </button>
				            </th>
				        </tr>
				        <c:forEach items="${waitingMembers}" var="waitingMember">
				        <tr>
				            <td>${waitingMember.memberId}</td>
				            <td>${waitingMember.memberName}</td>
				            <td>
				            	<select class="form-select" id="inputDept" name="memberDeptId">
									<option value="101001" ${waitingMember.memberDeptId == '101001' ? 'selected' : ''}>공공사업1팀</option>
									<option value="101002" ${waitingMember.memberDeptId == '101002' ? 'selected' : ''}>공공사업2팀</option>
									<option value="101003" ${waitingMember.memberDeptId == '101003' ? 'selected' : ''}>공공사업3팀</option>			
								</select>
							</td>
				            <td>
				            	<select class="form-select" id="inputRank" name="memberRankId">
									<option value="102001" ${waitingMember.memberRankId == '102001' ? 'selected' : ''}>부장</option>
									<option value="102002" ${waitingMember.memberRankId == '102002' ? 'selected' : ''}>차장</option>
									<option value="102003" ${waitingMember.memberRankId == '102003' ? 'selected' : ''}>과장</option>			
									<option value="102004" ${waitingMember.memberRankId == '102004' ? 'selected' : ''}>팀장</option>
									<option value="102005" ${waitingMember.memberRankId == '102005' ? 'selected' : ''}>대리</option>
									<option value="102006" ${waitingMember.memberRankId == '102006' ? 'selected' : ''}>사원</option>										
								</select>
				            </td>
				            <td>
				            	<span>
					            	<fmt:parseDate value="${waitingMember.memberRegdate}" var="registered" pattern="yyyyMMddHHmmss" />
									<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
				            	</span>
							</td>
				            <td>
				            	<select class="form-select" id="inputRole" name="memberRoleId">
									<option value="100003" ${waitingMember.memberRoleId == '100003' ? 'selected' : ''}>DEV</option>
									<option value="100001" ${waitingMember.memberRoleId == '100001' ? 'selected' : ''}>PM</option>
								</select>
				            </td>
				            <td>
								<span> 
									<fmt:parseDate value="${waitingMember.memberUpdateDate}" var="registered" pattern="yyyyMMddHHmmss" /> 
									<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
								</span>
							</td>						
				            
				            <td>
					            <p class="mb-0">
									<span class="activate-btn" data-member-id="${disableMember.memberId}" style="cursor: pointer;">[ 승인 ]</span>
					            	<span class="decline-btn" data-member-id="${waitingMember.memberId}" style="cursor: pointer;">[ 거절 ]</span>
					            </p>
							</td>
				        </tr>
				        </c:forEach>
				</table>
            </section>
        </article>
    </main>
</body>
</html>