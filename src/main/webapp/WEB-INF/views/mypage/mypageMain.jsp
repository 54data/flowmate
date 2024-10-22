<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/mypageMain.css" rel="stylesheet">
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	    	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>
	    	<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"></script>
    		<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css" rel="stylesheet">
</head>
<body>
<body id="mainContainer">

	<%@ include file="/WEB-INF/views/common/header.jsp" %>

    <main class="mainpage">
        <aside class="sideBar">
            <ul class="sideList">
                <li><a href="#"><i class="bi bi-layout-three-columns"></i>대시보드</a></li>
                <li><a href="#"><i class="bi bi-terminal"></i>모든 프로젝트</a></li>
                <li><a href="#"><i class="bi bi-bag-plus-fill"></i>나의 작업</a></li>
                <li><a href="#"><i class="bi bi-hexagon"></i>이슈</a></li>
                <li><a href="#"><i class="bi bi-envelope"></i>쪽지함</a></li>
                <li><a href="#"><i class="bi bi-gear-wide"></i>개인정보 수정</a></li>
            </ul>
        </aside>
    <article>
        <div class="mainText align-items-center">
            <span class="ms-2">아무개님 좋은 아침입니다.🌻</span>
            <a href="#" class="memberEdit">개인정보 수정 <i class="bi bi-chevron-right"></i></a>
         </div>   
        <section>
            <div class="card-container topCard">
                <div class="card">
                    <div class="card-body projectName pe-0 ps-0 align-items-center">
                        <i class="bi bi-caret-down-square-fill"></i>
                        <span class="pw-semiBold text-dark ">(가제)프로젝트 1</span>
                    </div>
                    <div class="card projectStep total btn">
                        <p>전체 작업<br><span>3</span></p>
                    </div>
                    <div class="card projectStep planned btn">
                        <p>예정<br> <span>1</span></p>
                    </div>
                    <div class="card projectStep inProgress btn">
                        <p>진행 중<br><span>2</span></p>
                    </div>
                    <div class="card projectStep complete btn">
                        <p>완료<br><span>2</span></p>
                    </div>
                    <div class="card projectStep issue btn">
                        <p>이슈<br><span>0</span></p>
                    </div>
                    <div class="card projectStep onHold btn">
                        <p>보류<br><span>0</span></p>
                    </div>
                </div>
            </div>
            <div class="card-container leftTopCard">
                <div class="card">
                    <div class="card-body flex-wrap">
                        <div class="d-flex justify-content-between ">
                            <span class="projectTotal">내 프로젝트</span>
                            <a href="#" class="projectTotalA"><span>모든 프로젝트 보기 <i class="bi bi-chevron-right"></i></span></a>
                        </div>
                        <div class="d-flex justify-content-between ">
                            <ul>
                                <li class="d-flex ">
                                    <button><i class="bi bi-plus"></i></button>
                                    <span class="projectNew">새 프로젝트</span>
                                </li>
                                <a href="#">
                                <li class="d-flex justify-content-between li-project text-start">
                                    <span class="projectName">프로젝트 1</span>
                                    <span class="projectDate">2024.10.11&nbsp;-&nbsp;2024.11.26</span>
                                </li>
                                </a>
                                <a href="#">
                                <li class="d-flex justify-content-between li-project text-start">
                                    <span class="projectName">프로젝트 2</span>
                                    <span class="projectDate">2024.10.11&nbsp;-&nbsp;2024.11.26</span>
                                </li>
                                </a>
                                <a href="#">
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

            <div class="card-container rightTopCard">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-start taskTitle">
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
		                              </li>
	                             </div> 
	                            <a href="#" class="d-flex projectTotalA"><span class="d-flex">모든 작업 보기<i class="bi bi-chevron-right d-flex alin"></i></span> </a>
                        
                        </div>
                        <ul class="nav nav-underline listActive">
                            <li class="nav-item">
                                <span class="nav-link active" aria-current="page" >진행 작업</span>
                            </li>
                            <li class="nav-item">
                                <span class="nav-link text-secondary fw-semibold" aria-current="page" >지연 작업</span>
                            </li>
                        </ul>
                        <div class="myTask">
                            <ul>
                                <a href="#">
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
                                <a href="#">
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
                                <a href="#">
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
            
          <div class="card-container leftBottomCard">
			    <div class="d-flex card flex-wrap align-content-start">
			        <div class="card-body d-flex justify-content-between align-items-center pt-0 letterBoxDiv">
			            <span class="letterBox fw-bold">쪽지함</span>
			            <a href="#" class="letterAll d-flex align-items-center ml-auto">
			                <span>쪽지함으로 이동</span>
			                <i class="bi bi-chevron-right"></i>
			            </a>
			        </div>
			        <div class="card-body pt-0">
			            <div class="letterInfo d-flex align-items-center">
			                <i class="bi bi-person-circle"></i>
			                <span class="sender">홍길동</span> 
			                <span class="letterContent fw-light">저번에 요청드렸던 보고서입니다. 확인하...</span>
			            </div>
			            <div class="letterInfo d-flex align-items-center">
			                <i class="bi bi-person-circle"></i>
			                <span class="sender">홍길동</span> 
			                <span class="letterContent fw-light">저번에 요청드렸던 보고서입니다. 확인하...</span>
			            </div>
			        </div>
			    </div> 
			</div>
            <div class="card-container rightBottomCard">
                <div class="card">
                    <div class="card-body pt-0 pb-0">
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
                            <div class="scheduelDetail">
                                <p class="m-0"><i class="bi bi-circle"></i>마이페이지 유스케이스 작성<br></p>
                                <span>2024.10.11(금)</span>
                            </div>
                        </div>
                    </div>
                 </div>
            </div>  
            </section>
        </article>
    </main>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/mypage.js"></script>
</body>
</html>