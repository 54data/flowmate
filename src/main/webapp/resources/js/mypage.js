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