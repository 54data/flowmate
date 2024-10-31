<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<link href="${pageContext.request.contextPath}/resources/css/project.css" rel="stylesheet">
		<link href="${pageContext.request.contextPath}/resources/css/projectBoard.css" rel="stylesheet">
   		<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
		
</head>
<body>
		<div id="header">
			<%@ include file="/WEB-INF/views/common/header.jsp" %>
		</div>
		<div class="project-board d-flex">
			<%@ include file="projectSidebar.jsp" %>
			<div class="d-flex d-flex mt-4 ms-4 me-4 flex-column flex-grow-1 min-vh-100">
            <div class="d-flex justify-content-between align-items-center" style="height: 40px;">
            		<h2 class="ptitle">작업 목록</h2>					    
            </div>
            <div class="d-flex mt-4 justify-content-start">
                <select class="form-select" >
                  <option>작업명</option>
                  <option>작업 ID</option>
                  <option>담당자</option>
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
				<table class="table text-center mt-5">
				<thead>
				        <tr>
				            <th>작업번호</th>
				            <th>작업명</th>
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		단계
						        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
						        </button>
		  						   <ul class="dropdown-menu ">
							     <li><a class="dropdown-item" href="#">분석</a></li>
		    					     <li><a class="dropdown-item" href="#">설계</a></li>
							     <li><a class="dropdown-item" href="#">개발</a></li>
							     <li><a class="dropdown-item" href="#">테스트</a></li>   					         					     
							     <li><a class="dropdown-item" href="#">이행</a></li>
							   </ul>					            
				            </th>
				            <th>담당자</th>
				            <th>
				            		시작일
						        <svg data-column="5" xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="dateSort bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>				            		
				            	</th> 
				            <th>
				            		마감일
						        <svg data-column="6" xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="dateSort bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>				            		
				            	</th> 
				            <th>
						    		<button class="btn dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
						    		우선순위
						        <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" class="bi bi-caret-down-fill "  viewBox="0 0 16 16">
						          <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
						        </svg>
						        </button>
		  						   <ul class="dropdown-menu ">
							     <li><a class="dropdown-item" href="#">긴급</a></li>
		    					     <li><a class="dropdown-item" href="#">높음</a></li>
							     <li><a class="dropdown-item" href="#">보통</a></li>
							     <li><a class="dropdown-item" href="#">낮음</a></li>   					         					     
							     <li><a class="dropdown-item" href="#">비활성화</a></li>
							   </ul>		
				            	</th>
				        </tr>
				       </thead>     	
				        <tbody>
				        <c:forEach var="proTask" items="${projTask}">
				        <tr>
				            <td>${proTask.taskId}</td>
				            <td>${proTask.taskName}</td>
				            <td>${proTask.taskStep}</td>
				            <td>${proTask.memberName}</td>
				            <td>${proTask.taskStartDate}</td>
				       		<td>${proTask.taskDueDate}</td>
				       		<td>
				                <svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" fill="currentColor" stroke="#FF7D04" class="bi bi-arrow-up" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
								</svg>
								&emsp;
				                <span class="text-warning fw-medium">${proTask.taskPriority}</span>   		
				       		</td>				       		
				        </tr>
				        </c:forEach>
				        </tbody>				        
				</table>
			</div>
		</div>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>
$(document).ready(function() {
    let Tasktable = $('.table').DataTable({
        paging: false,
        ordering: true, // 기본 정렬 활성화
        info: false,             
        searching: false,        
        lengthChange: false,
        columnDefs: [
            {
                targets: [0, 1, 2, 3, 6], // 시작일(4)과 마감일(5)을 제외한 나머지 열의 정렬 비활성화
                orderable: false 
            }
        ]
    });
    
    // 시작일과 마감일 아이콘 클릭 시 정렬
    $('.dateSort').on('click', function() {
        var column = $(this).data('column'); // 클릭한 아이콘의 data-column 속성 가져오기
        var currentOrder = Tasktable.order();

        if (currentOrder.length && currentOrder[0][0] === column && currentOrder[0][1] === 'asc') {
        		Tasktable.order([column, 'desc']).draw(); // 내림차순 정렬
        } else {
        		Tasktable.order([column, 'asc']).draw(); // 오름차순 정렬
        }
    });
});

</script>
</body>
</html>