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


/* 개인정보수정 */
document.getElementById('edit-pwd-btn').addEventListener('click', function() {
    Swal.fire({
        title: '비밀번호 변경',
        html: `
            <input type="password" id="currentPwd" class="swal2-input" placeholder="현재 비밀번호">
            <input type="password" id="newPwd" class="swal2-input" placeholder="새 비밀번호">
            <input type="password" id="newPwdConfirm" class="swal2-input" placeholder="새 비밀번호 확인">
        `,
        confirmButtonText: '확인',
        focusConfirm: false,
        didOpen: function() {
            const popup = Swal.getPopup();
            const currentPwdInput = popup.querySelector('#currentPwd');
            const newPwdInput = popup.querySelector('#newPwd');
            const newPwdConfirmInput = popup.querySelector('#newPwdConfirm');

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
                url: "updatePwd",
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
                            window.location.href = "../logout";
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
});
