<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<button type="button" class="btn btn-outline-primary ms-3" data-bs-toggle="modal" data-bs-target="#taskCreating" id="topTaskCreat" >작업 추가</button>
<%--모달 시작 --%>

<div class="modal fade" id="taskCreating" tabindex="-1" aria-labelledby="작업 추가" aria-hidden="true" >
	<div class="modal-dialog modal-xl">
		<div class="modal-content p-2">
            <div class="modal-header">
            		<div class="taskIds" style="display: none;">
            		<span class="task-pj-id me-2"></span><span>/</span><span class="fmt-task-id ms-2"></span>
            		</div>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body d-flex w-100 justify-content-between">
            	<div class="modal-left d-flex flex-column">
            		<input type="text" class="task-name h2 p-2" placeholder="작업명을 입력하세요." name="taskName"/>
            		<div class="d-flex mb-3 mt-3">
            			<button type="button" class="task-add-attachment btn">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16">
								<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
							</svg>
            				첨부
            			</button>
            			<button type="button" class="task-add-issue btn ms-3">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-diagram-3 me-1" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M6 3.5A1.5 1.5 0 0 1 7.5 2h1A1.5 1.5 0 0 1 10 3.5v1A1.5 1.5 0 0 1 8.5 6v1H14a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0V8h-5v.5a.5.5 0 0 1-1 0v-1A.5.5 0 0 1 2 7h5.5V6A1.5 1.5 0 0 1 6 4.5zM8.5 5a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5zM0 11.5A1.5 1.5 0 0 1 1.5 10h1A1.5 1.5 0 0 1 4 11.5v1A1.5 1.5 0 0 1 2.5 14h-1A1.5 1.5 0 0 1 0 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5A1.5 1.5 0 0 1 7.5 10h1a1.5 1.5 0 0 1 1.5 1.5v1A1.5 1.5 0 0 1 8.5 14h-1A1.5 1.5 0 0 1 6 12.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm4.5.5a1.5 1.5 0 0 1 1.5-1.5h1a1.5 1.5 0 0 1 1.5 1.5v1a1.5 1.5 0 0 1-1.5 1.5h-1a1.5 1.5 0 0 1-1.5-1.5zm1.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
							</svg>
            				이슈 추가
            			</button>
            		</div>
            		<div class="mb-3">
	            		<div class="modal-section-text mb-2">작업 설명</div>
	            		<div class="w-100">
	            			<textarea class="task-content form-control border p-3" placeholder="작업 설명을 입력하세요." id="task-textarea" name="taskContent"></textarea>
					    </div>
					</div>
            		<div class="mb-3">
	            		<div class="modal-section-text mb-2">이행 사항</div>
	            		<div class="w-100">
	            			<textarea class="task-log form-control border p-3" placeholder="이행 사항을 입력하세요." id="task-textarea"  name="taskLog"></textarea>
					    </div>
					</div>
            		<div class="mb-3">
            			<div class="d-flex align-items-center">
		            		<div class="modal-section-text">첨부파일</div>
							<span class="badge rounded-pill bg-light ms-2 file-count file-count">0</span>
		            		<div class="task-file-input-btn ms-auto">
								<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-plus" viewBox="0 0 12 12">
									<path d="M6 0a1 1 0 0 1 1 1v4h4a1 1 0 0 1 0 2h-4v4a1 1 0 0 1-2 0V7H1a1 1 0 0 1 0-2h4V1a1 1 0 0 1 1-1z"/>
								</svg>
							</div>
							<input class="task-file-input form-control" type="file" style="display:none" multiple name="taskAttach">
						</div>
						<div class="task-file-preview">

						</div>
					</div>
					
					
           			<div class="mb-3" style="display:none" id="task-issue">
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
							<div class="issuelist w-100 d-flex align-items-center border p-2 px-3 justify-content-between">
								<span class="task-issue-id">ISSUE-1</span>
								<span class="task-issue-title">경쟁사 분석 관련 이해관계자 인터뷰 섭외 요청</span>
								<div class="task-issue-state d-flex align-items-center justify-content-between">
					                <svg xmlns="http://www.w3.org/2000/svg" width="23" height="23" fill="#6A6A6A" class="bi bi-person-circle iconSize" viewBox="0 0 16 16">
					                	<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0"/>
					                	<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1"/>
									</svg>
									<div class="dropdown">
										<button class="task-issue-state-btn btn btn-secondary dropdown-toggle p-0" type="button" style="color: #FF5959;" data-bs-toggle="dropdown" aria-expanded="false">미해결</button>
										<ul class="dropdown-menu">
											<li><button class="dropdown-item" id="taskIssueState" type="button" data-color="#FF5959" style="color: #FF5959;">미해결</button></li>
											<li><button class="dropdown-item" id="taskIssueState" type="button" data-color="#0C66E4" style="color: #0C66E4;">해결</button></li>
										</ul>
									</div>
						        </div>
							</div>
						</div>
					</div>
					<%--이슈에요 --%>
					
            	</div>
            	<div class="modal-right d-flex flex-column">
            		<div class="project-modal-right-btns d-flex align-items-center mb-3">
						<div class="dropdown" >
						    <button id="taskStatusButton" class="btn btn-info dropdown-toggle me-3" type="button" data-bs-toggle="dropdown" aria-expanded="false"  aria-disabled="true" style="display: none;">진행 중</button>
						    <ul class="dropdown-menu" id="taskStatusMenu">
						        <li><button id="taskStatus" class="dropdown-item tStatus" type="button" data-status="진행 중" data-color="info">
						            <span class="badge rounded-pill bg-info">진행 중</span>
						        </button></li>
						        <li><button id="taskStatus" class="dropdown-item tStatus" type="button" data-status="보류" data-color="warning">
						            <span class="badge rounded-pill bg-warning">보류</span>
						        </button></li>
						        <li><button id="taskStatus" class="dropdown-item tStatus" type="button" data-status="완료" data-color="success">
						            <span class="badge rounded-pill bg-success">완료</span>
						        </button></li>
						    </ul>
						</div>
						
						<input type="hidden" id="taskStatusInput" name="taskState" value="진행 중">
						
	            		<button type="submit" class="taskSubmit btn btn-outline-primary" >작업 생성</button>
	            		<button class="btn btn-outline-primary task-update-btn me-3" style="display: none;">작업 수정</button>
	            		<sec:authorize access="hasRole('ROLE_PM')">
					    <button class="taskDisabled btn btn-outline-danger" type="button" id="disableTaskButton" style="display: none;">
					       	 비활성화
					    </button>
					</sec:authorize>
	            	</div>
	            	
				<div class="task-request-div flex-column border pt-3 mb-3" style="display:none;">
				    <div class="project-modal-details ms-4 mb-3">상태 변경 사유</div>
				    <hr>
				    <div class="d-flex flex-wrap justify-content-end align-items-center">
				        <textarea class="task-request form-control border-0 p-3 bg-white" style="resize: none; outline: none; box-shadow: none" placeholder="사유를 입력하세요" id="task-textarea" name=""></textarea>
				        <span class="project-modal-details ms-3">글자수 : </span>
				        <span id="taskRequestLength" class="project-modal-details text-start me-auto ms-3">0</span> 
				        <button class="task-request-btn btn btn-outline-primary m-3">요청</button>
				    </div>
				</div>
	            	

	            	
	            	<div class="project-modal-details d-flex flex-column border pt-3">
	            		<div class="align-items-center d-flex ms-4 mb-3 justify-content-between">
	            		세부 사항
	            		</div>
	            		<div class="border-bottom"></div>
	            		<div class="d-flex flex-column justify-contents-center">
	            		<sec:authorize access="hasRole('ROLE_PM')">
		            		<div class="mx-4 my-3 d-flex align-items-center">
		            			<span class="details-text">담당자</span>
		            			<div class="task-manager w-100">
									<select class="task-manager-select w-100" name="states[]" >
									</select>
							<input type="hidden" id="selectedMemberId" name="memberId" value="<sec:authentication property='name' />">								</div>
		            		</div>
		            	</sec:authorize>	
	            		<sec:authorize access="hasRole('ROLE_DEV') and not(hasRole('ROLE_PM'))">
		            		<div class="mx-4 my-3 d-flex align-items-center dev_selected" style="display: none !important;" data-role="DEV">
		            			<span class="details-text">담당자</span>
		            			<div class="task-manager w-100">
									<select class="task-manager-select w-100"  name="states[]" >
									</select>
   					 	<input type="hidden" id="selectedMemberId" name="memberId" value="<sec:authentication property='name' />">							</div>
		            		</div>
		            	</sec:authorize>	  
	            		<sec:authorize access="hasRole('ROLE_DEV')">
   					 <input type="hidden" id="selectedMemberId" name="memberId" value="<sec:authentication property='name' />">
		            	</sec:authorize>	
		            	
				        <div class="mx-4 my-3 d-flex align-items-center">
				            <span class="details-text flex-shrink-0">단계</span>
				            <div class="d-flex align-items-center flex-grow-1">
				                <select class="task-step me-3 w-50" name="taskStepId">
				                    <option selected="selected" value="분석">분석</option>
				                    <option value="설계">설계</option>
				                    <option value="개발">개발</option>
				                    <option value="테스트">테스트</option>
				                    <option value="이행">이행</option>
				                </select>
				                <input type="text" disabled class="task-step-date-range w-50" id="daterangepicker" name="daterangepicker" value="" placeholder="날짜를 선택하세요"/>
				                <input type="hidden" id="taskStepStartDate" name="stepStartDate">
				                <input type="hidden" id="taskStepDueDate" name="stepDueDate">
				            </div>
				        </div>
	            			<div class="mx-4 my-3 d-flex align-items-center">
		            			<span class="task-details-text">작업 기간</span>
		            			<input type="text" class="task-date-range m-0" id="daterangepicker" name="daterangepicker" value="" />
		            			    <%-- 시작일, 종료일 안보이게 추가  --%>
							    <input type="hidden" id="taskStartDate" name="taskStartDate">
							    <input type="hidden" id="taskDueDate" name="taskDueDate">
		            		</div>
		            		<div class="mx-4 my-3 d-flex align-items-center">
		            			<span class="task-details-text">우선순위</span>
         						<select class="task-priority-option w-100" name="taskPriority">
        							    <option value="없음">없음</option>
								    <option value="긴급">긴급</option>
								  	<option value="높음">높음</option>
								</select>
		            		</div>
		            		<input type="hidden" id="taskId" name="taskId">
		            	</div>
	            	</div>
            	</div>
            </div>
        </div>
	</div>
</div>