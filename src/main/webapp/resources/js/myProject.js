$(document).ready(function() {
    const table = $('#projectList').DataTable({
		order: [0, 'desc'],
		orderClasses: true,
		initComplete: function() {
	        this.api()
            .columns([8]) // '상태' 열에만 지정
            .every(function () {
                let column = this;
                let dropdown = $('.dropdown-menu');
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
				        return parseInt(data.split('-')[1], 10);
				    }
				    return data;
				}
			},
			{targets: [1], orderable: false},
			{targets: [2], orderable: false},
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
			{targets: [8], orderable: false},
		],
        createdRow: function(row, data, dataIndex) {
            $(row).on('click', function() {
                const projectId = data[0];
                window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId;
            });
        }
	});
});