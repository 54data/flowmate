<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>(가제) 프로젝트 이름</title>
		<link href="${pageContext.request.contextPath}/resources/css/projectBoard.css" rel="stylesheet">
	</head>
	<body>
		<div id="header">
			<%@ include file="/WEB-INF/views/common/header.jsp" %>
		</div>
		<div class="project-board d-flex">
			<div class="project-sidebar d-flex pt-4 border-end">
				<%@ include file="projectSidebar.jsp" %>
			</div>
			<div class="d-flex mt-4 ms-3 flex-column flex-grow-1">
				<div class="d-flex align-items-center w-100 pe-4 pb-3">
					<h2 class="board-project-name m-0 me-auto">(가제) 프로젝트 이름</h2>
				    <div class="d-flex align-items-center">
				    	<div class="d-flex align-items-center">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock me-2" viewBox="0 0 16 16">
								<path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
							    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"/>
						    </svg>
						    <span><small>53일</small></span>
					    </div>
					    <button type="button" class="btn btn-outline-primary ms-3">설정</button>
					    <button type="button" class="btn btn-outline-primary ms-3">작업 추가</button>
					</div>
				</div>
				<div class="boardlist d-flex w-100 pe-2">
					<div class="board d-flex me-3 flex-column col-1 flex-fill">
						<div class="d-flex align-items-center justify-content-between mb-1">
							<div class="task-progress progress w-100" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
								<div class="progress-bar" style="width: 25%"></div>
							</div>
							<span class="board-task-progress">25%</span>
						</div>
						<div class="board-content d-flex flex-column min-vh-100 w-100 p-2 pt-2">
							<div class="d-inline-flex w-100 align-items-center">
								<div class="me-auto">
									<span class="board-step fw-semibold ms-1 me-2">분석</span>
									<span class="board-cnt">2</span>
								</div>
								<span class="board-date me-1">2024.10.15 - 2024.10.20</span>
							</div>
							<button type="button" class="add-task btn mt-2 mb-3 d-flex align-items-center justify-content-center">
								<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
									<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
								</svg>
								작업 추가
							</button>
							<div class="task shadow-sm p-3 mb-3">
								<div class="d-flex flex-column justify-content-between h-100">
									<div class="d-flex align-items-center">
										<div class="h5 me-2">요구사항 분석</div>
										<div class="task-state border rounded-pill px-2">결재 중</div>
										<div class="task_priority ms-auto">
											<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#EC1E1E" class="bi bi-brightness-alt-high-fill" viewBox="0 0 16 16">
												<path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4"/>
											</svg>
										</div>
									</div>
									<div class="d-flex align-items-center">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
											<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
										</svg>
										<div class="task_id">TASK-1</div>
										<div class="d-flex ms-auto">
											<div class="task-issue d-flex align-items-center">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
													<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
												</svg>
												<span class="ms-1 me-3">3</span>
											</div>
							                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
							                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
							                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
											</svg>
										</div>
									</div>
								</div>
							</div>
							<div class="task shadow-sm p-3 mb-3">
								<div class="d-flex flex-column justify-content-between h-100">
									<div class="d-flex align-items-center">
										<div class="h5 me-2">기능명세서 작성</div>
										<div class="task-state rounded-pill px-2 bg-warning text-white">보류</div>
										<div class="task_priority ms-auto">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#ff7d04" class="bi bi-arrow-up" viewBox="0 0 16 16">
											  <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
											</svg>
										</div>
									</div>
									<div class="d-flex align-items-center">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#4BADE8" class="bi bi-check-square-fill me-2" viewBox="0 0 16 16">
											<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
										</svg>
										<div class="task_id">TASK-2</div>
										<div class="d-flex ms-auto">
											<div class="task-issue d-flex align-items-center">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
													<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
												</svg>
												<span class="ms-1 me-3">1</span>
											</div>
							                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
							                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
							                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
											</svg>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="board d-flex me-3 flex-column col-1 flex-fill">
						<div class="d-flex align-items-center justify-content-between mb-1">
							<div class="task-progress progress w-100" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
								<div class="progress-bar" style="width: 0%"></div>
							</div>
							<span class="board-task-progress">0%</span>
						</div>
						<div class="board-content d-flex flex-column min-vh-100 w-100 p-2 pt-2">
							<div class="d-inline-flex w-100 align-items-center">
								<div class="me-auto">
									<span class="board-step fw-semibold ms-1 me-2">설계</span>
									<span class="board-cnt">2</span>
								</div>
								<span class="board-date me-1">2024.10.15 - 2024.10.20</span>
							</div>
							<button type="button" class="add-task btn mt-2 d-flex align-items-center justify-content-center">
								<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
									<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
								</svg>
								작업 추가
							</button>
						</div>
					</div>
					<div class="board d-flex me-3 flex-column col-1 flex-fill">
						<div class="d-flex align-items-center justify-content-between mb-1">
							<div class="task-progress progress w-100" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
								<div class="progress-bar" style="width: 0%"></div>
							</div>
							<span class="board-task-progress">0%</span>
						</div>
						<div class="board-content d-flex flex-column min-vh-100 w-100 p-2 pt-2">
							<div class="d-inline-flex w-100 align-items-center">
								<div class="me-auto">
									<span class="board-step fw-semibold ms-1 me-2">개발</span>
									<span class="board-cnt">2</span>
								</div>
								<span class="board-date me-1">2024.10.15 - 2024.10.20</span>
							</div>
							<button type="button" class="add-task btn mt-2 d-flex align-items-center justify-content-center">
								<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
									<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
								</svg>
								작업 추가
							</button>
						</div>
					</div>
					<div class="board d-flex me-3 flex-column col-1 flex-fill">
						<div class="d-flex align-items-center justify-content-between mb-1">
							<div class="task-progress progress w-100" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
								<div class="progress-bar" style="width: 0%"></div>
							</div>
							<span class="board-task-progress">0%</span>
						</div>
						<div class="board-content d-flex flex-column min-vh-100 w-100 p-2 pt-2">
							<div class="d-inline-flex w-100 align-items-center">
								<div class="me-auto">
									<span class="board-step fw-semibold ms-1 me-2">테스트</span>
									<span class="board-cnt">2</span>
								</div>
								<span class="board-date me-1">2024.10.15 - 2024.10.20</span>
							</div>
							<button type="button" class="add-task btn mt-2 d-flex align-items-center justify-content-center">
								<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
									<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
								</svg>
								작업 추가
							</button>
						</div>
					</div>
					<div class="board d-flex me-3 flex-column col-1 flex-fill">
						<div class="d-flex align-items-center justify-content-between mb-1">
							<div class="task-progress w-100" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
								<div class="progress-bar" style="width: 0%"></div>
							</div>
							<span class="board-task-progress">0%</span>
						</div>
						<div class="board-content d-flex flex-column min-vh-100 w-100 p-2 pt-2">
							<div class="d-inline-flex w-100 align-items-center">
								<div class="me-auto">
									<span class="board-step fw-semibold ms-1 me-2">이행</span>
									<span class="board-cnt">2</span>
								</div>
								<span class="board-date me-1">2024.10.15 - 2024.10.20</span>
							</div>
							<button type="button" class="add-task btn mt-2 d-flex align-items-center justify-content-center">
								<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
									<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
								</svg>
								작업 추가
							</button>
						</div>
					</div>
				</div>
		    </div>
		</div>
	</body>
</html>