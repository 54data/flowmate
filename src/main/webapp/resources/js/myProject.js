$(document).ready(function() {
	// 테이블 헤더의 텍스트를 기반으로 columns 설정 자동 생성
    let columns = $('#projectList thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let table = $('#projectList').DataTable({
		order: [0, 'desc'],
		orderClasses: true,
		columns: columns,
		initComplete: function() {
	        this.api()
            .columns([8]) // '상태' 열에만 지정
            .every(function () {
                let column = this;
                let dropdown = $('#projectStateMenu');
                dropdown.append(`<li><a class="dropdown-item" id="projectState" href="#" data-value="전체">전체</a></li>`);
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
                                <div class="dropdown-item" id="projectState" data-value="${d}">
                                    <span class="badge rounded-pill ${badgeClass}" style="font-size: 0.75rem;">${d}</span>
                                </div>
                            </li>
                        `);
                    });
                // 드롭다운 옵션을 선택했을 때 필터링된 행만 나오도록 이벤트 추가
                dropdown.on('click', '#projectState', function () {
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
				        return parseInt(data.split('-')[1], 10);
				    }
				    return data;
				}
			},
			{targets: [1, 8], orderable: false},
			{
				targets: [6], 
				render: function(data, type, row) {
				    if (type === 'sort' || type === 'type') {
				        return parseInt(data, 10);
				    }
				    return data;
				}
			},
			{targets: [7], type: 'num-fmt'},
            {
                targets: [8], 
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
            }
		],
	});
    
    let columnIndex = 1; // 기본 select 옵션 값인 "프로젝트명" 컬럼의 인덱스
    
    // select 옵션 변경 시 검색할 컬럼 인덱스 업데이트
    $('#myProjectSelect').on('change', function() {
        var selectedOption = $(this).val();
        
        // 컬럼 이름을 기준으로 인덱스 찾기
        columnIndex = table.columns().eq(0).filter(function(index) {
            return table.column(index).dataSrc() === selectedOption;
        })[0];
        
        // 현재 검색 입력창의 값을 사용하여 새로운 컬럼으로 검색 설정
        var searchTerm = $('#myProjectInput').val();
        table.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm); // 선택된 컬럼에만 검색어 적용
            } else {
                this.search(''); // 다른 컬럼은 검색어 초기화
            }
        });
        
        table.draw();
    });

    $('#myProjectInput').on('input keyup', function() {
        var searchTerm = this.value;

        if (searchTerm === '') {
            table.search('').columns().search(''); // 전체 검색 초기화
        } else {
            table.column(columnIndex).search(searchTerm); // 선택된 컬럼에만 검색어 적용
        }
        table.draw();
    });
    
    $('#myProjectForm').on('keydown', function(e) {
        if (e.key === 'Enter') {  
            e.preventDefault();  
        }
    });
});