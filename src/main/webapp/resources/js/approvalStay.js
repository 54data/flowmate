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
	// 테이블 헤더의 텍스트를 기반으로 columns 설정 자동 생성
    let columns = $('#prjApprList thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let table = $('#prjApprList').DataTable({
		order: [0, 'desc'],
		orderClasses: true,
		columns: columns,
		initComplete: function() {
	        this.api()
            .columns([2]) // '상태' 열에만 지정
            .every(function () {
                let column = this;
                let dropdown = $('#col2');
                dropdown.append(`<li><a class="dropdown-item" href="#">전체</a></li>`);
                // 해당 열의 유니크 값들을 드롭다운 옵션으로 지정
                column
                    .data()
                    .unique()
                    .sort()
                    .each(function (d) {
                    	dropdown.append(`<li><div class="dropdown-item" data-value="${d}">${d}</div></li>`);
                    });
                // 드롭다운 옵션을 선택했을 때 필터링된 행만 나오도록 이벤트 추가
                dropdown.on('click', '.dropdown-item', function () {
                	const dropdownVal = $(this).data('value');
                	if (dropdownVal == '전체') {
                		column.search('').draw();
                	} else {
	                    column
	                        .search(dropdownVal ? dropdownVal : '', true, false)
	                        .draw();
                	}
                });
            });

	        this.api()
            .columns([4]) // '상태' 열에만 지정
            .every(function () {
                let column = this;
                let dropdown = $('#col4');
                dropdown.append(`<li><a class="dropdown-item" href="#">전체</a></li>`);
                // 해당 열의 유니크 값들을 드롭다운 옵션으로 지정
                column
                    .data()
                    .unique()
                    .sort()
                    .each(function (d) {
                    	dropdown.append(`<li><div class="dropdown-item" data-value="${d}">${d}</div></li>`);
                    });
                // 드롭다운 옵션을 선택했을 때 필터링된 행만 나오도록 이벤트 추가
                dropdown.on('click', '.dropdown-item', function () {
                	const dropdownVal = $(this).data('value');
                	if (dropdownVal == '전체') {
                		column.search('').draw();
                	} else {
	                    column
	                        .search(dropdownVal ? dropdownVal : '', true, false)
	                        .draw();
                	}
                });
            });

	        this.api()
            .columns([5]) // '상태' 열에만 지정
            .every(function () {
                let column = this;
                let dropdown = $('#col5');
                dropdown.append(`<li><a class="dropdown-item" href="#">전체</a></li>`);
                // 해당 열의 유니크 값들을 드롭다운 옵션으로 지정
                column
                    .data()
                    .unique()
                    .sort()
                    .each(function (d) {
                    	dropdown.append(`<li><div class="dropdown-item" data-value="${d}">${d}</div></li>`);
                    });
                // 드롭다운 옵션을 선택했을 때 필터링된 행만 나오도록 이벤트 추가
                dropdown.on('click', '.dropdown-item', function () {
                	const dropdownVal = $(this).data('value');
                	if (dropdownVal == '전체') {
                		column.search('').draw();
                	} else {
	                    column
	                        .search(dropdownVal ? dropdownVal : '', true, false)
	                        .draw();
                	}
                });
            });

		},
		columnDefs: [
			{
				targets: [0], 
				render: function(data, type, row) {
				    if (type === 'sort' || type === 'type') {
				        return parseInt(data.split('-')[2], 10);
				    }
				    return data.split('-').slice(2).join('-');;
				}
			},
			{targets: [2], orderable: false},
			{targets: [4], orderable: false},
			{targets: [5], orderable: false},
			{
				targets: [6], 
				render: function(data, type, row) {
				    if (type === 'sort' || type === 'type') {
				        return parseInt(data, 10);
				    }
				    return data;
				}
			},
			{targets: [7], orderable: false},
		]/*,
        createdRow: function(row, data, dataIndex) {
            $(row).on('click', function() {
                const projectId = data[0];
                window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId;
            });
        }*/
	});
    
    let columnIndex = 1; // 기본 select 옵션 값인 "프로젝트명" 컬럼의 인덱스
    
    // select 옵션 변경 시 검색할 컬럼 인덱스 업데이트
    $('#prjApprSelect').on('change', function() {
        var selectedOption = $(this).val();
        
        // 컬럼 이름을 기준으로 인덱스 찾기
        columnIndex = table.columns().eq(0).filter(function(index) {
            return table.column(index).dataSrc() === selectedOption;
        })[0];
        
        // 현재 검색 입력창의 값을 사용하여 새로운 컬럼으로 검색 설정
        var searchTerm = $('#prjApprInput').val();
        table.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm); // 선택된 컬럼에만 검색어 적용
            } else {
                this.search(''); // 다른 컬럼은 검색어 초기화
            }
        });
        
        table.draw();
    });

    $('#prjApprInput').on('input keyup', function() {
        var searchTerm = this.value;

        if (searchTerm === '') {
            table.search('').columns().search(''); // 전체 검색 초기화
        } else {
            table.column(columnIndex).search(searchTerm); // 선택된 컬럼에만 검색어 적용
        }
        table.draw();
    });
    
    /*승인*/
    $('.approve-btn').on('click', function(e){
    	e.preventDefault();
    	const projectId = $(this).data('project-id');    	
    	const approvalId = $(this).data('approval-id');
    	const approvalResponseResult = '승인';
        $.ajax({
            url: '/flowmate/approval/updateApprRespResult',
            type: 'POST',
            data: {
                projectId: projectId,            	
                approvalId: approvalId,
                approvalResponseResult: approvalResponseResult
            },
            success: function(response) {
    			Toast.fire({
    	            icon: 'success',
    	            title: '결재 요청이 성공하였습니다.'
    	        });
            },
            error: function(xhr, status, error) {
    			Toast.fire({
    	            icon: 'error',
    	            title: '결재 요청이 실패하였습니다.'
    	        });
            }
        });
    })

    /*거절*/
    $('.reject-btn').on('click', function(e){
    	e.preventDefault();
    	const projectId = $(this).data('project-id');    	
    	const approvalId = $(this).data('approval-id');
    	const approvalResponseResult = '거절';
    	
    	console.log(projectId);
    	console.log(approvalId);
    	console.log(approvalResponseResult);
        $.ajax({
            url: '/flowmate/approval/updateApprRespResult',
            type: 'POST',
            data: {
                projectId: projectId,            	
                approvalId: approvalId,
                approvalResponseResult: approvalResponseResult
            },
            success: function(response) {
            	console.log('성공');
    			Toast.fire({
    	            icon: 'success',
    	            title: '결재 요청이 반려되었습니다.'
    	        });
            },
            error: function(xhr, status, error) {
    			Toast.fire({
    	            icon: 'error',
    	            title: '결재 요청이 실패하였습니다.'
    	        });
            }
        });
    })

});