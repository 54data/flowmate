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


/* 개인정보수정 */

document.addEventListener('DOMContentLoaded', function() {
    const editMyInfoButtons = document.querySelectorAll('.edit-myInfo');

    if (editMyInfoButtons.length > 0) {
        editMyInfoButtons.forEach(editMyInfo => {
            editMyInfo.addEventListener('click', function() {
                $.ajax({
                    url: "/flowmate/mypage/getInfo",
                    method: "get",
                    dataType: "json",
                    success: function(member) {
                        Swal.fire({
                            title: '개인정보 수정',
                            html: `
                                <input type="text" class="swal2-input" placeholder="이름" value="${member.memberName}" disabled>
                                <input type="text" class="swal2-input" placeholder="아이디" value="${member.memberId}" disabled>
                                <input type="text" class="swal2-input" value="${member.memberDept}" placeholder="부서" disabled>
                                <input type="text" class="swal2-input" value="${member.memberRank}" placeholder="직급" disabled>
                                <input type="text" class="swal2-input" value="${member.memberRole}" placeholder="권한" disabled>
                                <input type="password" id="currentPwd" class="swal2-input" placeholder="현재 비밀번호">
                                <div class="errorMessage" id="curPwdChkMsg"></div>
                                <input type="password" id="newPwd" class="swal2-input" placeholder="새 비밀번호">
                                <input type="password" id="newPwdConfirm" class="swal2-input" placeholder="새 비밀번호 확인">
                            `,
                            showCloseButton: true,
                            confirmButtonText: '확인',
                            focusConfirm: false,
                            didOpen: function() {
                                const popup = Swal.getPopup();
                                const currentPwdInput = popup.querySelector('#currentPwd');
                                const newPwdInput = popup.querySelector('#newPwd');
                                const newPwdConfirmInput = popup.querySelector('#newPwdConfirm');

                                let regExp = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_])[A-Za-z\d@$!%*?&_]{8,20}$/);

                                function inputPasswordCheck() {
                                    let inputcurPwdChkMsg = document.querySelector('#curPwdChkMsg');

                                    if (regExp.test(currentPwdInput.value)) {
                                        inputcurPwdChkMsg.innerHTML = '';
                                    } else {
                                        inputcurPwdChkMsg.innerHTML =
                                            "<span>8자 이상 20자 이하의 알파벳 대소문자, 숫자, 특수문자를 조합해주세요.</span>";
                                    }
                                }

                                currentPwdInput.addEventListener('input', inputPasswordCheck);

                                // Enter 키로 확인
                                currentPwdInput.onkeyup = function(event) {
                                    if (event.key === 'Enter') {
                                        Swal.clickConfirm();
                                    }
                                };
                                newPwdInput.onkeyup = function(event) {
                                    if (event.key === 'Enter') {
                                        Swal.clickConfirm();
                                    }
                                };
                                newPwdConfirmInput.onkeyup = function(event) {
                                    if (event.key === 'Enter') {
                                        Swal.clickConfirm();
                                    }
                                };
                            },
                            preConfirm: function() {
                                const currentPwd = document.getElementById('currentPwd').value;
                                const newPwd = document.getElementById('newPwd').value;
                                const newPwdConfirm = document.getElementById('newPwdConfirm').value;

                                if (!currentPwd) {
                                    Swal.showValidationMessage(`현재 비밀번호를 입력해주세요`);
                                } else if (!newPwd) {
                                    Swal.showValidationMessage(`변경할 비밀번호를 입력해주세요`);
                                } else if (!newPwdConfirm) {
                                    Swal.showValidationMessage(`변경한 비밀번호를 한번 더 입력해주세요`);
                                } else if (currentPwd === newPwd) {
                                    Swal.showValidationMessage(`현재 비밀번호와 변경할 비밀번호가 같습니다`);
                                } else if (newPwd !== newPwdConfirm) {
                                    Swal.showValidationMessage(`변경 비밀번호가 일치하지 않습니다`);
                                } 
                                return { currentPwd, newPwd };
                            },
                        }).then(function(result) {
                            if (result.isConfirmed) {
                                const pwdData = {
                                    currentPwd: result.value.currentPwd,
                                    newPwd: result.value.newPwd
                                };

                                $.ajax({
                                    url: "/flowmate/mypage/updatePwd",
                                    method: "POST",
                                    contentType: "application/json",
                                    data: JSON.stringify(pwdData),
                                    success: function(response) {
                                        console.log(response);
                                        let alertMessage = "";
                                        if (response === "NOT EQUAL") {
                                            alertMessage = "현재 비밀번호가 일치하지 않습니다";
                                        } else if (response === "SUCCESS") {
                                            alertMessage = "비밀번호가 성공적으로 변경되었습니다";
                                        } else if (response === "FAIL") {
                                            alertMessage = "비밀번호 변경에 실패했습니다";
                                        }

                                        Toast.fire({
                                            icon: response === "SUCCESS" ? 'success' : 'error',
                                            title: alertMessage
                                        });

                                        if (response === "SUCCESS") {
                                            setTimeout(function() {
                                                window.location.href = "/flowmate/logout";
                                            }, 2500);
                                        }
                                    },
                                    error: function() {
                                        Toast.fire({
                                            icon: 'error',
                                            title: '변경 중 오류가 발생했습니다'
                                        });
                                    }
                                });
                            }
                        });
                    }, 
                    error: function() {
                        Toast.fire({
                            icon: 'error',
                            title: '변경 중 오류가 발생했습니다'
                        });
                    }
                }); 
            });
        });
    } else {
        console.error('edit-myInfo 버튼이 존재하지 않습니다.');
    }
});


//작업 데이터 테이블
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
$(document).ready(function() {
	$('#myTaskTable').DataTable({
		searching: false,
	});
});
