<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>이슈 생성 모달</title>
	</head>
	<body>
		<div class="modal fade" id="issueCreating" tabindex="-1" aria-labelledby="이슈 생성" aria-hidden="true">
			<div class="modal-dialog modal-xl">
				<div class="modal-content p-2">
		            <div class="modal-header">
	            		<input type="hidden" id="projectId" value="${projectId}">
	            		<div id="loginMemberId" style="display: none;"><sec:authentication property="principal.username"/></div>
	            		<div class="issueInfo" style="display: none;">
		            		<span class="task-pj-id">PROJ-1</span>
		            		<span class="ms-2 me-2">/</span>
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="#4BADE8" class="bi bi-check-square-fill me-1" viewBox="0 0 16 16">
								<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2zm10.03 4.97a.75.75 0 0 1 .011 1.05l-3.992 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.75.75 0 0 1 1.08-.022z"/>
							</svg>
		            		<span class="fmt-task-id">ISSUE-1</span>
		            	</div>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		            </div>
		            <div class="modal-body d-flex w-100 justify-content-between">
		            	<div class="modal-left d-flex flex-column">
		            		<input type="text" class="issue-name h2 p-2" placeholder="이슈명을 입력하세요." maxlength="33"/>
		            		<div class="d-flex mb-3 mt-3">
		            			<button type="button" class="issue-add-attachment btn me-3">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16">
										<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
									</svg>
		            				첨부
		            			</button>
		            		</div>
		            		<div class="mb-3">
			            		<div class="modal-section-text mb-2">이슈 설명</div>
			            		<div class="w-100">
			            			<textarea class="issue-content form-control border p-3" placeholder="이슈 설명을 입력하세요." id="issue-textarea"></textarea>
							    </div>
							</div>
							<div class="mb-3">
		            			<div class="d-flex align-items-center">
				            		<div class="modal-section-text">첨부파일</div>
									<span class="issue-files-length badge rounded-pill bg-light ms-2">0</span>
				            		<div class="issue-file-input-btn ms-auto">
										<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
											<path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
										</svg>
									</div>
									<input class="issue-file-input form-control" type="file" style="display:none" multiple>
								</div>
								<div class="issue-file-preview">
								</div>
							</div>
							<div>
								<div class="d-flex align-items-center flex-column">
									<div class="d-flex align-items-center border-bottom w-100 pb-2">
				            			<div class="modal-section-text">댓글</div>
				            			<span class="issue-comments-length badge rounded-pill bg-light ms-2">0</span>
				            		</div>
				            		<form class="issue-comment-form d-flex w-100 mt-3">
				            			<input type="text" class="issue-comment p-2 w-100" placeholder="내용을 입력해주세요.">
				            			<button type="submit" class="issue-comment-submit-btn">
				            				등록
				            			</button>
				            		</form>
								</div>
							</div>
		            	</div>
		            	<div class="modal-right d-flex flex-column">
		            		<div class="issue-modal-right-btns d-flex align-items-start mb-3">
								<div class="issue-status-dropdown dropdown" style="display: none;">
									<button id="issueStatusButton" class="btn btn-info dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">해결</button>
									<ul class="dropdown-menu">
								        <li><button id="issueStatus" class="dropdown-item" type="button" data-status="미해결" data-color="warning">
								            <span class="badge rounded-pill bg-warning">미해결</span>
								        </button></li>
								        <li><button id="issueStatus" class="dropdown-item" type="button" data-status="해결" data-color="success">
								            <span class="badge rounded-pill bg-success">해결</span>
								        </button></li>
								    </ul>
								</div>
								<button type="button" id="issueBtn" class="issue-creating-btn btn btn-outline-primary">이슈 생성</button>
			            		<button type="button" id="issueDeactivateBtn" class="issue-deactivating-btn btn btn-outline-danger ms-3" style="display: none;">비활성화</button>
							</div>
							<div class="issue-modal-details d-flex flex-column border pt-3">
		            			<div class="ms-4 mb-3">세부 사항</div>
		            			<div class="border-bottom"></div>
								<div class="px-4 py-4 d-flex flex-column justify-contents-center">
				            		<div class="mb-3 d-flex align-items-center">
				            			<span class="details-text">담당자</span>
				            			<div class="issue-member w-100">
											<select class="issue-member-select w-100" name="states[]">
											</select>
										</div>
				            		</div>
				            		<div class="my-3 d-flex align-items-center">
				            			<span class="details-text">연결 작업</span>
				            			<div class="issue-related-tasks w-100">
											<select class="issue-related-tasks-select w-100" name="states[]">
											</select>
										</div>
				            		</div>
									<div class="mt-3 d-flex align-items-center">
				            			<span class="details-text">등록일자</span>
				            			<span class="today-regdate"></span>
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