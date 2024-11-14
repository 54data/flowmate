$(document).ready(function() {
	
    const today = moment().format("YYYYMMDDHHmmss");

    // 페이지 로드 시 오늘 날짜 일정 가져오기
    dateSchduel(today);
	
    var calendarEl = $('#calendar')[0];
    var calendar = new FullCalendar.Calendar(calendarEl, {
        locale: 'ko',
        expandRows: true,
        initialView: 'dayGridMonth',
        headerToolbar: {
            left: 'prev',
            center: 'title',
            right: 'next'
        },
        dayCellContent: function(e) {
            e.dayNumberText = e.dayNumberText.replace("일", "");
        },
        events: [
            {
                title: 'Event 1',
                start: '2024-10-20',
                end: '2024-11-01',
                editable: false,
                allDay: true,
                display: 'block',
                backgroundColor: 'red',
                textColor: 'white'
            }
        ],
        dateClick: function(info) {   
        		$('.fc-daygrid-day-number').removeClass('highlight');
        	
            $('.fc-day-today .fc-daygrid-day-number').removeClass('highlight');
            

            const selectedDay = $(`[data-date="${info.dateStr}"] .fc-daygrid-day-number`);
            if (selectedDay.length) { 
                selectedDay.addClass('highlight'); 
            }
            let selectDate = moment(info.dateStr).format('YYYYMMDDHHmmss');
            console.log(selectDate);

            dateSchduel(selectDate);
        }
    });

    calendar.render();
    
    function loadTasks(type) {
        $.ajax({
            url: '/flowmate/myTasks',
            method: 'GET',
            data: { type: type },
            success: function(data) {
                $('#taskListContainer').html(data);  // 결과를 특정 영역에 삽입
            },
            error: function() {
                console.error('작업 목록을 가져오는 중 오류가 발생했습니다.');
            }
        });
    }
    loadTasks('today');  
    // 진행 작업 버튼 클릭 시
    $('#showTodayTasks').on('click', function(e) {
        e.preventDefault();
        loadTasks('today');
        $('#todayTaskTab').addClass('active');
        $('#delayTaskTab').removeClass('active');
    });

    // 지연 작업 버튼 클릭 시
    $('#showDelayTasks').on('click', function(e) {
        e.preventDefault();
        loadTasks('delayed');
        $('#todayTaskTab').removeClass('active');
        $('#delayTaskTab').addClass('active');

    });
    
	$('#myTaskTable').DataTable({
		searching: false,
	});
	
	setTimeout(function() {
		$('.my-project-state-dropdown').first().trigger('click');
    }, 0);
	
	$(document).on('click', '.my-project-state-dropdown', function(e) {
		e.preventDefault();
	    const selectedText = $(this).contents().get(0).nodeValue.trim();
	    $('#mainProjectDropdownBtn').text(selectedText);
	    const projectId = $(this).data('projectId');
	    $('#mainProjectDropdownBtn').data('projectId', projectId);
	    
	    $('#myTotalCntLink').attr('href', function() {
	        return $(this).attr('href').split('?')[0] + '?projectId=' + projectId;
	    });
	    $('#myPlannedCntLink').attr('href', function() {
	        return $(this).attr('href').split('?')[0] + '?state=예정&projectId=' + projectId;
	    });
	    $('#myInProgressCntLink').attr('href', function() {
	        return $(this).attr('href').split('?')[0] + '?state=진행 중&projectId=' + projectId;
	    });
	    $('#myCompleteCntLink').attr('href', function() {
	        return $(this).attr('href').split('?')[0] + '?state=완료&projectId=' + projectId;
	    });
	    $('#myHoldCntLink').attr('href', function() {
	        return $(this).attr('href').split('?')[0] + '?state=보류&projectId=' + projectId;
	    });
	    $('#myIssueCntLink').attr('href', function() {
	        return $(this).attr('href').split('?')[0] + '?projectId=' + projectId;
	    });
	    
	    $.ajax({
	    	url: '../../flowmate/getMyProjectStats',
	    	data: {projectId : projectId},
	    	success: function(myProjectStats) {
	    		console.log(myProjectStats);
	    		$('#myTotalCnt span').text(myProjectStats.myTotalTaskCnt);
	    		$('#myPlannedCnt span').text(myProjectStats.myTbTaskCnt);
	    		$('.planned-pct').text(myProjectStats.myTbTaskRatio + '%');
	    		$('#myInProgressCnt span').text(myProjectStats.myInprogressTaskCnt);
	    		$('.inProgress-pct').text(myProjectStats.myInprogressTaskRatio + '%');
	    		$('#myCompleteCnt span').text(myProjectStats.myDoneTaskCnt);
	    		$('.complete-pct').text(myProjectStats.myDoneTaskRatio + '%');
	    		$('#myIssueCnt span').text(myProjectStats.myTotalIsuCnt);
	    		$('#myHoldCnt span').text(myProjectStats.myHoldTaskCnt);
	    	}
	    });
	});
});

function dateSchduel(date){
	    $.ajax({
			url: '/flowmate/selectSchduel',
			data:{selectDate: date},
			success: function(response){
					console.log(response)
	            const scheduleDetails =  Object.values(response);
	            const scheduleContainer = $('.scheduelDetail');
	            scheduleContainer.empty(); 
	            const schedules = `
	                <ul class="list-unstyled" id="scheduleList">
	                </ul>
	            `;
	
	            if (scheduleDetails && scheduleDetails.length > 0) {
	                scheduleDetails.forEach(task => {
	                	
	                  
	                    const schedules = `
						<li class="d-flex justify-content-between align-items-center mb-2 me-3">
						    <a href="/flowmate/project/projectBoard?projectId=${task.projectId}&taskId=${task.taskId}" class="d-flex justify-content-between align-items-center w-100">
						        <span class="d-flex align-items-center">
						            <i class="bi bi-circle"></i> ${task.taskName}
						        </span>
						        <span class="d-flex align-items-center" style="font-size:12px; color:#a6a6a6;">
						            ${moment(task.taskDueDate, "YYYYMMDD").format("YYYY.MM.DD")}
						        </span>
						    </a>
						</li>
	                    `;
	                    scheduleContainer.append(schedules);
	                });
	            } else {
	
	            		console.log("일정 데이터 없음"); 
	                scheduleContainer.html('<p class="ms-3">일정이 없습니다.</p>');
	            }
	  
			}
	});
}
