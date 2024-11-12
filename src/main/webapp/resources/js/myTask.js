$(document).ready(function() {
    // 테이블 헤더의 텍스트를 기반으로 columns 설정 자동 생성
    let columns = $('#myTaskTable thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let table = $('#myTaskTable').DataTable({
        order: [4, 'asc'],
        orderClasses: true,
        columns: columns,
        initComplete: function() {
            let tableApi = this.api();

            // '상태' 열 (index 6)
            tableApi.columns([5])
            .every(function () {
                let column = this;
                let dropdown = $('#dropdown-status');
                dropdown.append(`<li><a class="dropdown-item" id="taskState" href="#" data-value="전체">전체</a></li>`);
                const stateBadges = {
                    '진행 중': 'bg-info',
                    '보류': 'bg-warning',
                    '완료': 'bg-success',
                    '예정': 'bg-dark'
                };
                column
                    .data()
                    .unique()
                    .sort()
                    .each(function (d) {
                        let badgeClass = stateBadges[d] || '';
                        dropdown.append(`
                            <li>
                                <div class="dropdown-item" id="taskState" data-value="${d}">
                                    <span class="badge rounded-pill ${badgeClass}" style="font-size: 0.75rem;">${d}</span>
                                </div>
                            </li>
                        `);
                    });
                // 드롭다운 옵션을 선택했을 때 필터링된 행만 나오도록 이벤트 추가
                dropdown.on('click', '#taskState', function () {
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

            
            // '단계' 열 (index 7)
            tableApi.columns([6]).every(function() {
                let column = this;
                let dropdown = $('#dropdown-step'); // '단계' 드롭다운 메뉴를 위한 ID
                dropdown.append(`<li><a class="dropdown-item" href="#">전체</a></li>`);
                
                // 해당 열의 유니크 값들을 드롭다운 옵션으로 지정
                column.data().unique().sort().each(function(d) {
                    dropdown.append(`<li><a class="dropdown-item" href="#" data-value="${d}">${d}</a></li>`);
                });
                
                // 드롭다운 옵션 클릭 시 필터링 적용
                dropdown.on('click', '.dropdown-item', function(e) {
                    e.preventDefault();
                    const dropdownVal = $(this).data('value');
                    if (dropdownVal === '전체') {
                        column.search('').draw();
                    } else {
                        column.search(dropdownVal ? dropdownVal : '', true, false).draw();
                    }
                });
            });

            // '우선순위' 열 (index 8)
            tableApi.columns([7]).every(function() {
                let column = this;
                let dropdown = $('#dropdown-priority'); // '우선순위' 드롭다운 메뉴를 위한 ID
                dropdown.append(`<li><a class="dropdown-item" href="#" data-value="전체">전체</a></li>`);

                // 해당 열의 유니크 값들을 드롭다운 옵션으로 지정
                column.data().unique().sort().each(function(d) {
                		let priority = $("<div>").html(d).text().trim();
                    if (priority === '높음') {
                        // '높음'일 때 아이콘과 텍스트 추가
                        dropdown.append(`<li><a class="dropdown-item" href="#" data-value='${priority}'>
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" stroke="#FF7D04" class="bi bi-arrow-up" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0-.708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
                            </svg> <span class="text-warning">${priority}</span>
                        </a></li>`);
                    } else if (priority === '긴급') {
                        // '긴급'일 때 아이콘과 텍스트 추가
                        dropdown.append(`<li><a class="dropdown-item" href="#" data-value='${priority}'>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#EC1E1E" class="bi bi-brightness-alt-high-fill" viewBox="0 0 16 16">
                                <path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4"/>
                            </svg> <span class="text-danger">${priority}</span>
                        </a></li>`);
                    } else {
                        // 기본 텍스트 추가 (예: 없음)
                        dropdown.append(`<li><a class="dropdown-item" href="#" data-value='${priority}'>${priority}</a></li>`);
                    }
                });

                // 드롭다운 옵션 클릭 시 필터링 적용
                dropdown.on('click', '.dropdown-item', function(e) {
                    e.preventDefault();
                    const dropdownVal = $(this).data('value');
                    if (dropdownVal === '전체') {
                        column.search('').draw();
                    } else {
                        column.search(dropdownVal ? dropdownVal : '', true, false).draw();
                    }
                });
            });
        },
        columnDefs: [
            {
                targets: [0], 
                render: function(data, type, row) {
                    if (type === 'sort' || type === 'type') {
                        return parseInt(data.split('-')[1], 10);
                    }
                    return data;
                }
            },
            {targets: [1, 5], orderable: false},
            {
                targets: [5], 
                render: function(data, type, row) {
                    if (type === 'display') {
                        const stateBadges = {
                            '진행 중': 'bg-info',
                            '보류': 'bg-warning',
                            '완료': 'bg-success',
                            '예정': 'bg-dark'
                        };
                        const badgeClass = stateBadges[data] || 'bg-secondary';
                        return `<span class="badge rounded-pill ${badgeClass}" style="font-size: 0.85rem;">${data}</span>`;
                    }
                    return data;
                }
            },
            {targets: [6], orderable: false},
            {targets: [7], orderable: false},
        ],
        createdRow: function(row, data, dataIndex) {
        	 	let rowTaskId  = $(row).find('.myTaskId').val();
        		let taskId =  rowTaskId
        		let projectId = $(row).find('td').eq(0).text().trim();
        		$(row).find('td').eq(2).on('click', function() {
                  window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId + '&taskId=' + taskId;
              });
              // 세 번째와 네 번째 td (projectId와 projectName)에 대한 클릭 이벤트 설정
              $(row).find('td').eq(0).on('click', function() {
                  window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId;
              });
              
              $(row).find('td').eq(1).on('click', function() {
                  window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId;
              });
        }
    });
    
    let columnIndex = 1; // 기본 select 옵션 값인 "프로젝트명" 컬럼의 인덱스
    
    // select 옵션 변경 시 검색할 컬럼 인덱스 업데이트
    $('#taskSelect').on('change', function() {
        var selectedOption = $(this).val();
        
        // 컬럼 이름을 기준으로 인덱스 찾기
        columnIndex = table.columns().eq(0).filter(function(index) {
            return table.column(index).dataSrc() === selectedOption;
        })[0];
        
        // 현재 검색 입력창의 값을 사용하여 새로운 컬럼으로 검색 설정
        var searchTerm = $('#myTaskInput').val();
        table.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm); // 선택된 컬럼에만 검색어 적용
            } else {
                this.search(''); // 다른 컬럼은 검색어 초기화
            }
        });
        
        table.draw();
    });

    $('#myTaskInput').on('input keyup', function() {
        var searchTerm = this.value;

        if (searchTerm === '') {
            table.search('').columns().search(''); // 전체 검색 초기화
        } else {
            table.column(columnIndex).search(searchTerm); // 선택된 컬럼에만 검색어 적용
        }
        table.draw();
    });
});
