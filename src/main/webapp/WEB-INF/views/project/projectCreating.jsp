<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>프로젝트 생성</title>
	</head>
	<body>
		<div class="modal fade" id="projectCreating" tabindex="-1" aria-labelledby="프로젝트 생성" aria-hidden="true">
			<input type="hidden" id="projectId" value="${projectData.projectId}">
			<div class="modal-dialog modal-xl">
				<div class="modal-content p-2">
		            <div class="modal-header">
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body d-flex w-100 justify-content-between">
		            	<div class="modal-left d-flex flex-column">
		            		<input type="text" class="project-name h2 p-2" placeholder="프로젝트명을 입력하세요." value="${projectData.projectName}" maxlength="33"/>
		            		<div class="d-flex mb-3 mt-3">
		            			<button type="button" class="add-attachment btn me-3">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16">
										<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
									</svg>
		            				첨부
		            			</button>
		            			<button type="button" class="add-issue btn" data-issue-mode="create">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3" viewBox="0 0 16 16">
										<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
									</svg>
		            				이슈 추가
		            			</button>
		            		</div>
		            		<div class="mb-3">
			            		<div class="modal-section-text mb-2">프로젝트 설명</div>
			            		<div class="w-100">
			            			<textarea class="project-content form-control border p-3" placeholder="프로젝트 설명을 입력하세요." id="project-textarea">${projectData.projectContent}</textarea>
							    </div>
							</div>
		            		<div class="mb-3">
		            			<div class="d-flex align-items-center">
				            		<div class="modal-section-text">첨부파일</div>
									<span class="project-files-length badge rounded-pill bg-light ms-2">0</span>
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
									<div class="issuelist w-100 d-flex align-items-center flex-column">
									</div>
								</div>
							</div>
		            	</div>
		            	<div class="modal-right d-flex flex-column">
		            		<div class="project-modal-right-btns d-flex align-items-start mb-3">
								<div class="project-status-dropdown dropdown">
								    <button id="projectStatusButton" class="btn btn-info dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">진행 중</button>
								    <ul class="dropdown-menu">
								        <li><button id="projectStatus" class="dropdown-item" type="button" data-status="진행 중" data-color="info">
								            <span class="badge rounded-pill bg-info">진행 중</span>
								        </button></li>
								        <li><button id="projectStatus" class="dropdown-item" type="button" data-status="보류" data-color="warning">
								            <span class="badge rounded-pill bg-warning">보류</span>
								        </button></li>
								        <li><button id="projectStatus" class="dropdown-item" type="button" data-status="완료" data-color="success">
								            <span class="badge rounded-pill bg-success">완료</span>
								        </button></li>
								        <li><button id="projectStatus" class="dropdown-item" type="button" data-status="예정" data-color="dark" style="pointer-events: none;">
								        	<span class="badge rounded-pill bg-dark">예정</span>
								        </button></li>
								    </ul>
								</div>
			            		<button type="button" id="projectBtn" class="project-creating-btn btn btn-outline-primary">프로젝트 생성</button>
			            		<button type="button" id="projectDeactivateBtn" class="project-deactivating-btn btn btn-outline-danger ms-3">비활성화</button>
			            	</div>
			            	<div class="project-modal-details d-flex flex-column border pt-3">
			            		<div class="ms-4 mb-3">세부 사항</div>
			            		<div class="border-bottom"></div>
			            		<div class="d-flex flex-column justify-contents-center">
				            		<div class="mx-4 mb-3 mt-4 d-flex align-items-center">
				            			<span class="details-text">기간</span>
				            			<input type="text" class="project-range m-0" id="daterangepicker" name="daterangepicker" value="" />
				            		</div>
				            		<div class="mx-4 my-3 d-flex align-items-center">
				            			<span class="details-text">팀원</span>
				            			<div class="project-teams w-100">
											<select class="project-team-select w-100" name="states[]" multiple="multiple">
											</select>
										</div>
				            		</div>
									<div class="mx-4 my-3 d-flex align-items-center">
				            			<span class="details-text">단계</span>
				            			<div class="project-steps d-flex flex-column w-100">
					            			<div class="project-step-select d-flex align-items-center w-100">
						            			<select class="project-step">
												  	<option selected="selected">분석</option>
												  	<option>설계</option>
												  	<option>개발</option>
												  	<option>테스트</option>
												  	<option>이행</option>
												</select>
	        									<input type="text" class="task-range" id="daterangepicker" name="daterangepicker" value="" placeholder="날짜를 선택하세요"/>
												<button class="btn btn-sm delete-step ms-1 btn-close project-step-close" style="visibility: hidden;"></button>
											</div>
					            			<div class="project-step-select d-flex align-items-center mt-1 w-100">
						            			<select class="project-step">
												  	<option>분석</option>
												  	<option selected="selected">설계</option>
												  	<option>개발</option>
												  	<option>테스트</option>
												  	<option>이행</option>
												</select>
	        									<input type="text" class="task-range" id="daterangepicker" name="daterangepicker" value="" />
	        									<button class="btn btn-sm delete-step ms-1 btn-close project-step-close"></button>
											</div>
					            			<div class="project-step-select d-flex align-items-center mt-1 w-100">
						            			<select class="project-step">
												  	<option>분석</option>
												  	<option>설계</option>
												  	<option selected="selected">개발</option>
												  	<option>테스트</option>
												  	<option>이행</option>
												</select>
	        									<input type="text" class="task-range" id="daterangepicker" name="daterangepicker" value="" />
	        									<button class="btn btn-sm delete-step ms-1 btn-close project-step-close"></button>
											</div>
					            			<div class="project-step-select d-flex align-items-center mt-1 w-100">
						            			<select class="project-step">
												  	<option>분석</option>
												  	<option>설계</option>
												  	<option>개발</option>
												  	<option selected="selected">테스트</option>
												  	<option>이행</option>
												</select>
	        									<input type="text" class="task-range" id="daterangepicker" name="daterangepicker" value="" />
												<button class="btn btn-sm delete-step ms-1 btn-close project-step-close"></button>
											</div>
					            			<div class="project-step-select d-flex align-items-center mt-1 w-100">
						            			<select class="project-step">
												  	<option>분석</option>
												  	<option>설계</option>
												  	<option>개발</option>
												  	<option>테스트</option>
												  	<option selected="selected">이행</option>
												</select>
	        									<input type="text" class="task-range" id="daterangepicker" name="daterangepicker" value="" />
												<button class="btn btn-sm delete-step ms-1 btn-close project-step-close"></button>
											</div>
											<div class="add-task-step-btn d-flex align-items-center mt-1 w-100">
												<button type="button" class="add-task-step btn flex-fill">
													<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
														<path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
													</svg>
													단계 추가
												</button>
												<button class="btn btn-sm delete-step ms-1 btn-close project-step-close" style="visibility: hidden;"></button>
											</div>
										</div>
				            		</div>
				            	</div>
			            	</div>
		            	</div>
		            </div>
		        </div>
			</div>
		</div>
	</body>
</html>