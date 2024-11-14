// DataTables 한글 세팅
$.extend($.fn.dataTable.defaults, {
	lengthChange: false,
	language: {
	    emptyTable: '데이터가 없습니다',
	    info: '_START_ - _END_ / _TOTAL_',
	    infoEmpty: '0 - 0 / 0',
	    infoFiltered: '(총 _MAX_ 개)',
	    infoThousands: ',',
	    lengthMenu: '페이지당 줄수 _MENU_',
	    loadingRecords: '읽는중...',
	    processing: '처리중...',
	    search: '검색:',
	    zeroRecords: '검색 결과가 없습니다',
	    paginate: {
	        first: '처음',
	        last: '마지막',
	        next: '다음',
	        previous: '이전'
	    },
	    aria: {
	        sortAscending: ': 오름차순 정렬',
	        sortDescending: ': 내림차순 정렬'
	    },
	    buttons: {
	        copyKeys: 'ctrl키 나 u2318 + C키로 테이블 데이터를 시스템 복사판에서 복사하고 취소하려면 이 메시지를 클릭하거나 ESC키를 누르면 됩니다.',
	        copySuccess: {
	            _: '%d행을 복사판에서 복사됨',
	            1: '1행을 복사판에서 복사됨'
	        },
	        copyTitle: '복사판에서 복사',
	        csv: 'CSV',
	        pageLength: {
	            '-1': '모든 행 보기',
	            _: '%d행 보기'
	        },
	        pdf: 'PDF',
	        print: '인쇄',
	        collection: '집합 <span class="ui-button-icon-primary ui-icon ui-icon-triangle-1-s"></span>',
	        colvis: '컬럼 보기',
	        colvisRestore: '보기 복원',
	        copy: '복사',
	        excel: '엑셀'
	    },
	    searchBuilder: {
	        add: '조건 추가',
	        button: {
	            0: '빌더 조회',
	            _: '빌더 조회(%d)'
	        },
	        clearAll: '모두 지우기',
	        condition: '조건',
	        data: '데이터',
	        deleteTitle: '필터 규칙을 삭제',
	        logicAnd: 'And',
	        logicOr: 'Or',
	        title: {
	            0: '빌더 조회',
	            _: '빌더 조회(%d)'
	        },
	        value: '값'
	    },
	    autoFill: {
	        cancel: '취소',
	        fill: '모든 셀에서 <i>%d<i>을(를) 삽입</i></i>',
	        fillHorizontal: '수평 셀에서 값을 삽입',
	        fillVertical: '수직 셀에서 값을 삽입'
	    },
	    datetime: {
	        previous: '이전',
	        next: '다음',
	        hours: '시',
	        minutes: '분',
	        seconds: '초',
	        unknown: '-',
	        amPm: [
	            '오전',
	            '오후'
	        ],
	        weekdays: [
	            '일',
	            '월',
	            '화',
	            '수',
	            '목',
	            '금',
	            '토'
	        ],
	        months: [
	            '1월',
	            '2월',
	            '3월',
	            '4월',
	            '5월',
	            '6월',
	            '7월',
	            '8월',
	            '9월',
	            '10월',
	            '11월',
	            '12월'
	        ]
	    },
	    editor: {
	        close: '닫기',
	        create: {
	            button: '추가',
	            title: '항목 추가',
	            submit: '완료'
	        },
	        edit: {
	            button: '수정',
	            title: '항목 수정',
	            submit: '완료'
	        },
	        remove: {
	            button: '삭제',
	            title: '항목 삭제',
	            submit: '완료'
	        },
	        error: {
	            system: '에러가 발생하였습니다 (&lt;a target="\\" rel="nofollow" href="\\"&gt;자세한 정보&lt;/a&gt;).'
	        }
	    }
	}
});

function getIssue(projectId, taskId) {
	$.ajax({
		url: '../../flowmate/issue/getIssueList',
		data: {
			projectId: projectId,
			taskId : taskId
		},
        success: function(issueList) {
        	console.log('이슈리스트' + issueList);
        	if (issueList.length > 0) {
        		$('#task-issue').show();
        		$('.project-issue').show();
        	} else {
        		$('#task-issue').hide();
        		$('.project-issue').hide();
        	}
            const issueListContainer = $('.issuelist'); 
            issueListContainer.empty(); 
            issueList.forEach(issue => {
                const issueHtml = `
                    <div class="issue-list-item w-100 d-flex align-items-center border p-2 px-3 justify-content-between">
                        <span class="issue-id" style="font-weight:500;" data-issue-id="${issue.issueId}">${issue.fmtIssueId}</span>
                        <span class="issue-title" style="font-weight:500;" data-issue-id="${issue.issueId}">${issue.issueTitle}</span>
                        <div class="issue-state d-flex align-items-center justify-content-between">
                            <div class="issue-member-name border rounded-pill px-2" style="font-size:12px;">${issue.memberName}</div>
                            <div class="issue-state-btn p-0" style="color: ${issue.issueState === '미해결' ? '#FF5959' : '#0C66E4'};" data-bs-toggle="dropdown" aria-expanded="false">${issue.issueState}</div>
                        </div>
                    </div>
                `;
                issueListContainer.append(issueHtml);
            });
        }
	});
	
	$.ajax({
		url: '../../flowmate/issue/getIssueCnt',
		data: {
			projectId: projectId,
			taskId : taskId
		},
		success: function(issueProgress) {
	        $('.issue-progress-bar-length').css('width', issueProgress + '%');
	        $('.issue-progress-bar-cnt').text(issueProgress + '%');
		}
	});
	
	$(document).off('click', '.task-add-issue').on('click', '.task-add-issue', function() {
	    $('.show-issue-modal').data('triggeredBy', $(this).data('issueMode'));
	    $('.show-issue-modal').data('taskId', taskId);
	    $('.show-issue-modal').trigger('click');
    });
}

/*$(document).ready(function() {
    // STOMP WebSocket 연결 설정
    var socket = new SockJS('/flowmate/ws/notifications'); // STOMP용 WebSocket 엔드포인트
    var stompClient = Stomp.over(socket); // STOMP 클라이언트 생성

    stompClient.connect({}, function(frame) {
        console.log('STOMP Connected: ' + frame);

        // '/topic/notifications' 주제 구독
        stompClient.subscribe('/topic/notifications', function(notification) {
            var message = JSON.parse(notification.body);
            msgAlram(message); // STOMP 알림 표시 함수 호출
        });
    }, function(error) {
        console.error("STOMP 연결 오류:", error);
    });

    // STOMP 연결 종료 시 이벤트
    socket.onclose = function(event) {
        console.log('STOMP WebSocket 연결이 종료되었습니다.');
        console.log('연결 상태:', event);
    };
});*/

$(document).ready(function() {
    // WebSocket 연결 설정
	// new WebSocket('ws://192.168.0.176:8080/localhost:8080/flowmate/ws/sailing') - 다른 PC와 연결 시 
	// 동일한 네트워크에서 ip 입력
    var customSocket = new WebSocket('ws://localhost:8080/flowmate/ws/sailing'); // WebSocket 엔드포인트
    
    customSocket.onopen = function() {
        console.log('WebSocket 연결 성공');
        // 초기 메시지 카운트를 요청
        customSocket.send(JSON.stringify({ type: "REQUEST_UNREAD_COUNT" }));
        // 이후 주기적으로 요청
        //messageCnt();
    };

    // 메시지 수신 시
    customSocket.onmessage = function(event) {
        var data = JSON.parse(event.data); 
      

        if (data.type === "NEW_MESSAGE") { 

            msgAlram(data.unReadCount); // 읽지 않은 메시지 수를 업데이트
        }
    };

    customSocket.onclose = function(event) {
        console.log('WebSocket 연결 종료');
    };
    
    // 주기적으로 읽지 않은 메시지 수 요청 
    // 현재 우리는 소켓 세션으로 연결이 안되어 있어 실시간 양방향 통신으로 알림을 받을 수 없습니다.
/*   function messageCnt() {
        setInterval(function() {
            customSocket.send(JSON.stringify({ type: "REQUEST_UNREAD_COUNT" }));
        }, 3000); // 2초마다 소켓에서 요청 전송
    }*/

    // 알림 표시
    function msgAlram(count) {
        $('.msg-badge').text(count); // 읽지 않은 메시지 수를 UI에 표시
    }
	
    $('.my-project-state-badge').each(function() {
    	const projectState = $(this).text();
    	if (projectState == '예정') {
    		$(this).addClass('bg-dark');
    	} else if (projectState == '진행 중') {
    		$(this).addClass('bg-info');
    	} else if (projectState == '완료') {
    		$(this).addClass('bg-success')
    	} else if (projectState == '보류') {
    		$(this).addClass('bg-warning')
    	}
    });
    
    
    //사이드바0
    const currentPath = window.location.pathname + window.location.search;
    const storedPath = localStorage.getItem('activeSidebarMenu');
    
    console.log("Stored Path:", storedPath);
    console.log("Current Path:", currentPath);

    if (storedPath && storedPath === currentPath) {
        setSidebarActiveState(storedPath);
    }

    window.addEventListener('popstate', function() {
        const newPath = window.location.pathname + window.location.search;
        setSidebarActiveState(newPath);
    });

    $('.sidebar-menu').on('click', function(e) {
        const url = $(this).closest('a').attr('href');

        if (url) {
            e.preventDefault();
            setSidebarActiveState(url);
            localStorage.setItem('activeSidebarMenu', url);
            window.location.href = url;
        }
    });
});

function setSidebarActiveState(url) {
    $('.sidebar-menu').removeClass('active');
    $(`a[href="${url}"] .sidebar-menu`).addClass('active');
}
/*// 읽지 않은 메시지 수 가져오기 
function messageCnt(){
    $.ajax({
        url:"/flowmate/message/msgCnt",
        type: 'get',
        success: function(count){
            msgAlram(count);
        }
    });
}*/