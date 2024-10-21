<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>프로젝트 생성</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/header.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/common.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/projectCreating.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/datepicker/bootstrap-datepicker.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/select2/select2.min.css" rel="stylesheet" />
	</head>
	<body>
		<button type="button" class="new-project btn btn-outline-primary ms-3" data-bs-toggle="modal" data-bs-target="#projectCreating">
		    새 프로젝트
		</button>
		<div class="modal fade" id="projectCreating" tabindex="-1" aria-labelledby="프로젝트 생성" aria-hidden="true">
			<div class="modal-dialog modal-xl">
				<div class="modal-content p-2">
		            <div class="modal-header">
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body d-flex w-100 justify-content-between">
		            	<div class="modal-left d-flex flex-column">
		            		<h2 class="board-project-name m-0">(가제) 프로젝트 이름</h2>
		            		<div class="d-flex mb-3 mt-3">
		            			<button type="button" class="add-attachment btn">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16">
										<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
									</svg>
		            				첨부
		            			</button>
		            			<button type="button" class="add-issue btn ms-3">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
										<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
									</svg>
		            				이슈 추가
		            			</button>
		            		</div>
		            		<div class="mb-3">
			            		<div class="modal-section-text mb-2">설명</div>
			            		<div class="w-100">
			            			<textarea class="project-content form-control border p-3" placeholder="프로젝트 설명을 입력하세요." id="project-textarea"></textarea>
							    </div>
							</div>
		            		<div class="mb-3">
		            			<div class="d-flex align-items-center">
				            		<div class="modal-section-text">첨부파일</div>
									<span class="badge rounded-pill bg-light ms-2">0</span>
				            		<div class="file-input-btn ms-auto">
										<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
											<path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
										</svg>
									</div>
									<input class="project-file-input form-control" type="file" style="display:none" multiple>
								</div>
								<div class="file-preview">
								</div>
							</div>
	            			<div class="mb-3">
	            				<div class="d-flex align-items-center">
				            		<div class="modal-section-text mb-2">이슈</div>
								</div>
								<div class="d-flex flex-column">
									<div class="issue-progress w-100 d-flex mb-2 align-items-center justify-content-between">
										<div class="progress" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">
											<div class="progress-bar" style="width: 25%"></div>
										</div>
										<span class="board-progress">100%</span>
									</div>
									<div class="issuelist d-flex d-flex align-items-center justify-content-between border p-2 px-3">
										<span class="issue-id">ISSUE-1</span>
										<span class="issue_title">경쟁사 분석 관련 이해관계자 인터뷰 섭외 요청</span>
										<div class="d-flex align-items-center">
							                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
							                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
							                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
											</svg>
											<div class="dropdown ms-3">
												<a class="dropdown-toggle pb-2 fw-semibold" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">진행중</a>
												<div class="issue-state dropdown-menu">
										            <a class="dropdown-item" href="#">진행중</a>
										            <div class="dropdown-divider"></div>
										            <a class="dropdown-item" href="#">보류</a>
										            <div class="dropdown-divider"></div>
										            <a class="dropdown-item" href="#">완료</a>
									            </div>
									        </div>
								        </div>
									</div>
								</div>
							</div>
		            	</div>
		            	<div class="modal-right d-flex flex-column">
		            		<div class="project-modal-right-btns d-flex align-items-center mb-3">
								<div class="dropdown">
									<button class="btn btn-secondary dropdown-toggle border" type="button" data-bs-toggle="dropdown" aria-expanded="false">
										진행 중
									</button>
									<ul class="dropdown-menu">
										<li><button class="dropdown-item" type="button">보류</button></li>
										<li><button class="dropdown-item" type="button">완료</button></li>
									</ul>
								</div>
			            		<button type="button" class="btn btn-outline-primary ms-3">프로젝트 생성</button>
			            	</div>
			            	<div class="project-modal-details d-flex flex-column border pt-3">
			            		<div class="ms-4 mb-3">세부 사항</div>
			            		<div class="border-bottom"></div>
			            		<div class="d-flex flex-column justify-contents-center">
				            		<div class="ms-4 mb-3 mt-3 d-flex align-items-center">
				            			<span class="date-text">시작일</span>
				            			<input type="text" class="start-date form-control py-0 border text-center" id="startDatepicker">
				            		</div>
				            		<div class="ms-4 mb-3 mt-3 d-flex align-items-center">
				            			<span class="date-text">마감일</span>
				            			<input type="text" class="end-date form-control py-0 border text-center col-7" id="endDatepicker">
				            		</div>
				            		<div class="ms-4 mb-3 mt-3 d-flex align-items-center">
				            			<span class="col-3">팀원</span>
				            		</div>
				            		<div class="ms-4 mb-3 mt-3 d-flex align-items-center">
				            			<span class="col-3">단계</span>
				            			<div class="col-7">
				            			</div>
				            		</div>
				            	</div>
			            	</div>
		            	</div>
		            </div>
		        </div>
			</div>
		</div>
		<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/projectCreating.js"></script>
		<script src="${pageContext.request.contextPath}/resources/datepicker/bootstrap-datepicker.js"></script>
		<script src="${pageContext.request.contextPath}/resources/datepicker/bootstrap-datepicker.ko.min.js"></script>
		<script src="${pageContext.request.contextPath}/resources/select2/select2.min.js"></script>
	</body>
</html>