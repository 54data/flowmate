<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link href="${pageContext.request.contextPath}/resources/css/mypageMain.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css" rel="stylesheet">
</head>

<body class="d-flex flex-column">

	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	<div class="d-flex min-vh-100">
	   	<div class="d-flex">
			<%@ include file="/WEB-INF/views/mypage/mypageSideBar.jsp" %>
		</div>
	    <article class="mt-4 ms-4">
	        <div class="mainText align-items-center w-100 pe-4">
	            <span class="ptitle h2 m-0">${userName}님 좋은 아침입니다.🌻</span>
	            	<a href="${pageContext.request.contextPath}/mypage/messageBox" class="projectTotalA">
	            		<span class="d-flex">
	            			<span style="font-size: 12px; font-weight: 300;">개인정보 수정</span>
							<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
								<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>
							</svg>
						</span>
					</a>
	         </div>   
	        <section class="w-100">
	            <div class="card-container topCard w-100 pe-4">
	                <div class="card w-100">
	                    <div class="card-body projectName d-flex pe-0 ps-0 align-items-center justify-content-center text-center">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-down-square-fill" viewBox="0 0 16 16" style-">
								<path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm4 4a.5.5 0 0 0-.374.832l4 4.5a.5.5 0 0 0 .748 0l4-4.5A.5.5 0 0 0 12 6z"/>
							</svg>
	                        <span class="pw-semiBold ms-2">(가제) 프로젝트 1</span>
	                    </div>
	                    <a href="${pageContext.request.contextPath}/mypage/myTask">
	                    <div class="card projectStep total"><%--각 카드 클릭시 작업 상태에 맞게 필터링 되게 --%>
	                        <p>전체 작업<br><span style="color: #6A6A6A;">3</span></p>
	                    </div>
	                    </a>
	                    <a href="${pageContext.request.contextPath}/mypage/myTask">
	                    <div class="card projectStep planned">
	                        <p>예정<br> <span>1</span></p>
	                        <div class="card percent justify-content-center p-0">33%</div>
	                    </div>
	                    </a>
	                    <a href="${pageContext.request.contextPath}/mypage/myTask">
	                    <div class="card projectStep inProgress">
	                        <p>진행 중<br><span>2</span></p>
	                        <div class="card percent justify-content-center p-0">66%</div>                        
	                    </div>
	                    </a>
	                    <a href="${pageContext.request.contextPath}/mypage/myTask">
	                    <div class="card projectStep complete">
	                        <p>완료<br><span>2</span></p>
	                        <div class="card percent justify-content-center p-0">0%</div>                        
	                    </div>
	                    </a>
	                    <a href="${pageContext.request.contextPath}/mypage/myIssue">
	                    <div class="card projectStep issue">
	                        <p>이슈<br><span>0</span></p>
	                    </div>
	                    </a>
	                    <a href="${pageContext.request.contextPath}/mypage/myTask">
	                    <div class="card projectStep onHold">
	                        <p>보류<br><span>0</span></p>
	                    </div>
	                    </a>
	                </div>
	            </div>
	            <div class="mt-2 mb-2 w-100 d-flex justify-content-between">
		            <div class="card-container leftTopCard me-3">
		                <div class="mypage-card py-3 px-4 w-100">
		                    <div class="card-body flex-wrap">
		                        <div class="d-flex justify-content-between align-items-center">
		                            <span class="projectTotal">내 프로젝트</span>
		                            <a href="${pageContext.request.contextPath}/mypage/myProject" class="projectTotalA">
		                            	<span class="d-flex">모든 프로젝트 보기 
		                            		<i class="bi bi-chevron-right"></i>
		                            	</span>
		                            </a>
		                        </div>
		                        <div class="d-flex justify-content-between">
		                            <ul>
		                                <li class="d-flex align-items-center">
		                                    <button class="p-0 m-0"><i class="bi bi-plus"></i></button>
		                                    <span class="projectNew">새 프로젝트</span>
		                                </li>
		                                <a href="${pageContext.request.contextPath}/project/projectBoard">
		                                <li class="d-flex justify-content-between li-project text-start">
		                                    <span class="projectName">프로젝트 1</span>
		                                    <span class="projectDate">2024.10.11&nbsp;-&nbsp;2024.11.26</span>
		                                </li>
		                                </a>
		                                <a href="${pageContext.request.contextPath}/project/projectBoard">
		                                <li class="d-flex justify-content-between li-project text-start">
		                                    <span class="projectName">프로젝트 2</span>
		                                    <span class="projectDate">2024.10.11&nbsp;-&nbsp;2024.11.26</span>
		                                </li>
		                                </a>
		                                <a href="${pageContext.request.contextPath}/project/projectBoard">
		                                <li class="d-flex justify-content-between li-project text-start">
		                                    <span class="projectName">프로젝트 3</span>
		                                    <span class="projectDate">2024.10.11&nbsp;-&nbsp;2024.11.26</span>
		                                </li>
		                                </a>
		                            </ul>
		                        </div>
		                    </div>
		
		                 </div>
		            </div> 
		            <div class="card-container rightTopCard pe-4">
		                <div class="mypage-card py-3 px-4 w-100 h-100">
		                    <div class="card-body flex-wrap">
		                        <div class="d-flex justify-content-between align-items-center">
		                           		<div class="d-flex">
				                            <span class="projectTotal ">내가 담당중인 작업</span>
				                            <li class="nav-item dropdown d-flex">
				                                <a class="nav-link dropdown-toggle taskDropdown" data-bs-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">오늘</a>
				                                <div class="dropdown-menu">
				                                  <h6 class="dropdown-header">Dropdown header</h6>
				                                  <a class="dropdown-item" href="#">Action</a>
				                                  <a class="dropdown-item" href="#">Another action</a>
				                                  <a class="dropdown-item" href="#">Something else here</a>
				                                  <div class="dropdown-divider"></div>
				                                  <a class="dropdown-item" href="#">Separated link</a>
				                                 </div>
				                              </li>
			                             </div> 
		                            <a href="${pageContext.request.contextPath}/mypage/myTask" class="projectTotalA">
		                            	<span class="d-flex">모든 작업 보기
			                            	<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
	  											<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>
											</svg>
										</span>
		                            </a>
		                        </div>
									<div class="d-flex text-center tabList">
									            <a class="d-flex align-items-center" href="#">
									                <div class="d-flex justify-content-center align-items-center taskTab active">
									                    <span>진행 작업</span>
									                </div>
									            </a>
									            <a class="d-flex align-items-center" href="#">
									                <div class="d-flex justify-content-center align-items-center taskTab">
									                    <span>지연 작업</span>
									                </div>
									            </a>
									</div>            
		                        <div class="myTask">
		                            <ul>
		                                <a href="${pageContext.request.contextPath}/mypage/myTask">
											<li class="d-flex justify-content-between align-items-center">
											    <div class="d-flex align-items-center">
											        <i class="bi bi-circle-fill"></i>
											        <span class="d-flex projectState">진행 중</span>
											        <span class="projectContent">요구사항 분석</span>
											    </div>
											    <div class="d-flex align-items-center">
											        <span class="projectDate">2024.10.26</span>
											    </div>    
											</li>
		                                </a>
		                                <a href="${pageContext.request.contextPath}/mypage/myTask">
											<li class="d-flex justify-content-between align-items-center">
											    <div class="d-flex align-items-center">
											        <i class="bi bi-circle-fill"></i>
											        <span class="d-flex projectState">진행 중</span>
											        <span class="projectContent">프로젝트 관리 유스케이스 작성 분석</span>
											    </div>
											    <div class="d-flex align-items-center">
											        <span class="projectDate">2024.10.26</span>
											    </div>    
											</li>
		                                </a>
		                                <a href="${pageContext.request.contextPath}/mypage/myTask">
											<li class="d-flex justify-content-between align-items-center">
											    <div class="d-flex align-items-center">
											        <i class="bi bi-circle-fill plannedCircle"></i>
											        <span class="d-flex projectState">예정</span>
											        <span class="projectContent">이슈 관리 유스케이스 작성</span>
											    </div>
											    <div class="d-flex align-items-center">
											        <span class="projectDate">2024.10.20</span>
											    </div>    
											</li>
		                                </a>
		                            </ul>
		                        </div>
		                    </div>
		                 </div>
		            </div>
		      </div>
		      <div class="mt-2 mb-2 w-100 d-flex justify-content-between">
		          <div class="card-container leftBottomCard me-3">
					    <div class="mypage-card py-3 px-4 w-100">
					        <div class="card-body d-flex justify-content-between align-items-center pt-0 letterBoxDiv w-100">
					            <span class="letterBox fw-bold">쪽지함</span>
		                            <a href="${pageContext.request.contextPath}/mypage/messageBox" class="projectTotalA">
		                            	<span class="d-flex">쪽지함으로 이동
			                            	<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
	  											<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>
											</svg>
										</span>
		                            </a>
					        </div>
					        <div class="card-body pt-0 w-100">
					        <a href="${pageContext.request.contextPath}/mypage/messageBox">
					            <div class="letterInfo d-flex align-items-center">
					                <i class="bi bi-person-circle" style="color: #6A6A6A;"></i>
					                <span class="sender">홍길동</span> 
					                <span class="letterContent">저번에 요청드렸던 보고서입니다. 확인하...</span>
					            </div>
					        </a>
					        <a href="${pageContext.request.contextPath}/mypage/messageBox">    
					            <div class="letterInfo d-flex align-items-center">
					                <i class="bi bi-person-circle" style="color: #6A6A6A;"></i>
					                <span class="sender">홍길동</span> 
					                <span class="letterContent">저번에 요청드렸던 보고서입니다. 확인하...</span>
					            </div>
					        </a>
					        </div>
					    </div> 
					</div>
		            <div class="card-container rightBottomCard pe-4">
		                <div class="mypage-card py-3 px-4">
		                    <div class="card-body pt-0 pb-0 w-100">
		                        <div class="mb-4 d-flex align-items-center">
		                            <span class="fw-bold scheduel">일정</span>
		                            <div class="today d-flex align-items-center justify-content-center">
		                                <i class="bi bi-circle-fill"></i>오늘
		                            </div>
		                        </div>
		                        <div class="d-flex">
		                            <div id='calendar-container' class="d-flex justify-content-end">
		                                <div id='calendar'></div>
		                            </div>      
		                            <div class="scheduelDetail w-100 d-flex justify-content-between">
		                                <p class="ms-3"><i class="bi bi-circle"></i>마이페이지 유스케이스 작성<br></p>
		                                <span>2024.10.11 (금)</span>
		                            </div>
		                        </div>
		                    </div>
		                 </div>
		            </div>  
		        </div>
		    </section>
	    </article>
	</div>
	<script src="${pageContext.request.contextPath}/resources/js/mypage.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
</body>
</html>