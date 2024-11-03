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

$(document).ready(function() {
    let updatedMembers = [];

    $('table tbody tr').each(function() {
        const row = $(this);
        row.find('select').on('change', function() {
            const memberId = row.find('td:first').text().trim(); 
            const memberDeptId = row.find('#inputDept').val();
            const memberRankId = row.find('#inputRank').val();
            const memberRoleId = row.find('#inputRole').val();
            
            updatedMembers.push({
                memberId: memberId,
                memberDeptId: memberDeptId,
                memberRankId: memberRankId,
                memberRoleId: memberRoleId,
            });
        });
    });

    
    $('#update-btn').click(function() {
    	console.log(updatedMembers);
        if (updatedMembers.length > 0) {
            Swal.fire({
                title: '업데이트 하시겠습니까?',
                text: "이 작업은 되돌릴 수 없습니다.",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: '예, 변경합니다!',
                cancelButtonText: '아니요, 취소합니다!'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "/flowmate/admin/updateInfo",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify(updatedMembers),
                        success: function(response) {
                        	Toast.fire(
                                '변경 완료!',
                                '변경사항이 저장되었습니다.',
                                'success'
                            );
                        },
                        error: function(xhr, status, error) {
                        	console.error(updatedMembers);
                        	Toast.fire(
                                '오류!',
                                '변경사항 저장 중 오류가 발생했습니다.',
                                'error'
                            );
                        }
                    });
                } else {
                	Toast.fire(
                        '취소됨',
                        '변경사항이 취소되었습니다.',
                        'info'
                    );
                }
            });
        } else {
        	Toast.fire(
                '변경 사항 없음',
                '변경된 정보가 없습니다.',
                'info'
            );
        }
    });
});
