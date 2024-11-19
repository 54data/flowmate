const Toast = Swal.mixin({
    toast: true,
    position: 'top',
    showConfirmButton: false,
    timer: 2500,
    timerProgressBar: true,
    didOpen: (toast) => {
    	toast.style.width = '350px';
    	toast.style.fontSize = '14px';
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
});

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
	
    let updatedMembers = [];

    $(document).on('change', 'table tbody tr select', function() {
        const row = $(this).closest('tr'); 
        const memberId = row.find('td:first').text().trim(); 
        const memberDeptId = row.find('#inputDept').val();
        const memberRankId = row.find('#inputRank').val();
        const memberRoleId = row.find('#inputRole').val();

        // updatedMembers 배열에서 이미 존재하는 멤버인지 확인
        const existingMemberIndex = updatedMembers.findIndex(member => member.memberId === memberId);

        if (existingMemberIndex !== -1) {
            // 기존 멤버 정보 업데이트
            updatedMembers[existingMemberIndex] = {
                memberId: memberId,
                memberDeptId: memberDeptId,
                memberRankId: memberRankId,
                memberRoleId: memberRoleId,
            };
        } else {
            // 새로운 멤버 추가
            updatedMembers.push({
                memberId: memberId,
                memberDeptId: memberDeptId,
                memberRankId: memberRankId,
                memberRoleId: memberRoleId,
            });
        }
    });

    $('#update-btn').click(function() {
        console.log(updatedMembers);
        if (updatedMembers.length > 0) {
        	Swal.fire({
                title: '업데이트 하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '확인',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "/flowmate/admin/updateInfo",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify(updatedMembers),
                        success: function(response) {
                            Toast.fire({
                                icon: 'success',
                                title: '변경 완료!',
                                text: '변경사항이 저장되었습니다.',
                            });

                            setTimeout(function() {
                                window.location.href = '/flowmate/admin/adminPage';
                            }, 2500);

                        },
                        error: function(xhr, status, error) {
                            console.error(updatedMembers);
                            Toast.fire({
                                icon: 'error',
                                title: '오류!',
                                text: '변경사항 저장 중 오류가 발생했습니다.',
                            });
                        }
                    });
                } else {
                    Toast.fire({
                        icon: 'info',
                        title: '취소됨',
                        text: '변경사항이 취소되었습니다.',
                    });
                }
            });
        } else {
            Toast.fire({
                icon: 'info',
                title: '변경 사항 없음',
                text: '변경된 정보가 없습니다.',
            });
        }
    });

	/*비활성화*/
	$(document).on("click",".deactivate-btn", function() {
	const memberId = $(this).data("member-id"); 
	console.log("Member ID:", memberId);
	
	Swal.fire({
	    title: '정말 비활성화하시겠습니까?',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: '확인',
	    cancelButtonText: '취소'
	}).then((result) => {
	    if (result.isConfirmed) {
	        $.ajax({
	            url: '/flowmate/admin/updateMemberByAdmin?memberId=' + memberId + '&memberStatus=true&memberEnabled=false',
	            type: 'GET',
	            success: function(response) {
	                Toast.fire(
	                    '비활성화 완료',
	                    '회원이 성공적으로 비활성화되었습니다.',
	                    'success'
	                );
	                
	                setTimeout(function() {
	                    window.location.href = '/flowmate/admin/adminPage';
	                }, 2500);

	            },
	            error: function(error) {
	            	Toast.fire(
	                    '비활성화 실패',
	                    '비활성화 과정에서 오류가 발생했습니다.',
	                    'error'
	                );
	            }
	        });
	    } else {
	        console.log("비활성화가 취소되었습니다.");
	        }
	    });
	});

	
	/*삭제*/
	$(document).on("click", ".decline-btn", function() {
	const memberId = $(this).data("member-id"); 
	console.log("Member ID:", memberId);
	
	Swal.fire({
	    title: '정말 삭제하시겠습니까?',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: '확인',
	    cancelButtonText: '취소'
	}).then((result) => {
	    if (result.isConfirmed) {
	        $.ajax({
	            url: '/flowmate/admin/declineMember?memberId=' + memberId,
	            type: 'GET',
	            success: function(response) {
	                Toast.fire(
	                    '삭제 완료!',
	                    '회원이 성공적으로 삭제되었습니다.',
	                    'success'
	                );
	                
	                setTimeout(function() {
	                    window.location.href = '/flowmate/admin/adminPageStay';
	                }, 2500);

	            },
	            error: function(error) {
	            	Toast.fire(
	                    '삭제 실패!',
	                    '삭제 과정에서 오류가 발생했습니다.',
	                    'error'
	                );
	            }
	        });
	    } else {
	        console.log("삭제가 취소되었습니다.");
	        }
	    });
	});

	/*활성화*/
	
	$(document).on("click", ".activate-btn", function() {
	const memberId = $(this).data("member-id"); 
	console.log("Member ID:", memberId);
	
	Swal.fire({
	    title: '정말 활성화하시겠습니까?',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: '확인',
	    cancelButtonText: '취소'
	}).then((result) => {
	    if (result.isConfirmed) {
	        $.ajax({
	            url: '/flowmate/admin/updateMemberByAdmin?memberId=' + memberId + '&memberStatus=true&memberEnabled=true',
	            type: 'GET',
	            success: function(response) {
	                Toast.fire(
	                    '활성화 완료!',
	                    '회원이 성공적으로 활성화되었습니다.',
	                    'success'
	                );
	                
	                setTimeout(function() {
	                    window.location.href = '/flowmate/admin/adminPageStay';
	                }, 2500);

	            },
	            error: function(error) {
	            	Toast.fire(
	                    '활성화 실패!',
	                    '활성화 과정에서 오류가 발생했습니다.',
	                    'error'
	                );
	            }
	        });
	    } else {
	        console.log("활성화가 취소되었습니다.");
	        }
	    });
	});


});
