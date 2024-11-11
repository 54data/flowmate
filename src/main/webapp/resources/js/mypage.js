$(document).ready(function() {
	var calendarEl = $('#calendar')[0];

	var calendar = new FullCalendar.Calendar(calendarEl, {
		locale : 'ko',
		expandRows : true,
		initialView : 'dayGridMonth',
		headerToolbar : {
			left : 'prev',
			center : 'title',
			right : 'next'
		},
		dayCellContent : function(e) {
			// 날짜 텍스트에서 "일"을 제거하고 숫자만 표시
			e.dayNumberText = e.dayNumberText.replace("일", "");
		},

		events : [ // 이벤트 샘플 데이터
		{
			title : 'Event 1',
			start : '2024-10-20',
			end : '2024-11-01',
			editable : false,
			allDay : true,
			display : 'block',
			backgroundColor : 'red',
			textColor : 'white'
		} ],
		dateClick : function(info) {
			// 날짜 클릭 시 상세 일정 표시
			alert('날짜 클릭됨: ' + info.dateStr);
		}
	});

	calendar.render();
});

$(document).ready(function() {
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
});

$(document).ready(function() {
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
	    
	    $.ajax({
	    	url: '../../flowmate/getMyProjectStats',
	    	data: {projectId : projectId},
	    	success: function(myProjectStats) {
	    		$('#myTotalCnt span').text(myProjectStats.myTotalTaskCnt);
	    		$('#myPlannedCnt span').text(myProjectStats.myTbTaskCnt);
	    		$('.planned-pct').text(myProjectStats.myTbTaskRatio + '%');
	    		$('#myInProgressCnt span').text(myProjectStats.myInprogressTaskCnt);
	    		$('.inProgress-pcts').text(myProjectStats.myInprogressTaskRatio + '%');
	    		$('#myCompleteCnt span').text(myProjectStats.myDoneTaskCnt);
	    		$('.complete-pct').text(myProjectStats.myDoneTaskRatio + '%');
	    		$('#myIssueCnt span').text(myProjectStats.myTotalIsuCnt);
	    		$('#myHoldCnt span').text(myProjectStats.myHoldTaskCnt);
	    	}
	    });
	});
});
