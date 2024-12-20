$(document).ready(function() {
// 테이블 헤더의 텍스트를 기반으로 columns 설정 자동 생성
    let columns = $('#adminPageDisableTable thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
        
    let table = $('#adminPageDisableTable').DataTable({
		order: [0, 'desc'],
		orderClasses: true,
		columns: columns,
		initComplete: function() {
			this.api()
		    .columns([2])// '상태' 열에만 지정
		    .every(function () {
	            let column = this;
	            let dropdown = $('.dropdown-menu');

		    });

		},
		columnDefs: [
			{
				targets: [0], 
				render: function(data, type, row) {
				    if (type === 'sort' || type === 'type') {
				    	return parseInt(data, 10);
				    }
				    return data;				}
			},
			{targets: [1], orderable: false},
			{targets: [2], orderable: false},
			{targets: [3], orderable: false},
			{targets: [5], orderable: false},
			{targets: [6], orderable: false}
		],
        createdRow: function(row, data, dataIndex) {
        }
	});
    
    let columnIndex = 1; // 기본 select 옵션 값인 "프로젝트명" 컬럼의 인덱스
    
    // select 옵션 변경 시 검색할 컬럼 인덱스 업데이트
    $('#adminPageDisableSelecet').on('change', function() {
        var selectedOption = $(this).val();
        
        // 컬럼 이름을 기준으로 인덱스 찾기
        columnIndex = table.columns().eq(0).filter(function(index) {
            return table.column(index).dataSrc() === selectedOption;
        })[0];
        
        // 현재 검색 입력창의 값을 사용하여 새로운 컬럼으로 검색 설정
        var searchTerm = $('#adminPageDisableInput').val();
        table.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm); // 선택된 컬럼에만 검색어 적용
            } else {
                this.search(''); // 다른 컬럼은 검색어 초기화
            }
        });
        
        table.draw();
    });

    $('#adminPageDisableInput').on('input keyup', function() {
        var searchTerm = this.value;

        if (searchTerm === '') {
            table.search('').columns().search(''); // 전체 검색 초기화
        } else {
            table.column(columnIndex).search(searchTerm); // 선택된 컬럼에만 검색어 적용
        }
        table.draw();
    });
    
    $('#adminPageDisableInput').on('keydown', function(e) {
        if (e.key === 'Enter') {  
            e.preventDefault();  
        }
    });

})