$(document).ready(function() {
    let columns = $('#myIssueList thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let table = $('#myIssueList').DataTable({
		order: [0, 'desc'],
		orderClasses: true,
		columns: columns,
		initComplete: function() {
	        this.api()
            .columns([5])
            .every(function () {
                let column = this;
                let dropdown = $('#myIssueStateMenu');
                dropdown.append(`<li><a class="dropdown-item" id="myIssueState" href="#" data-value="전체">전체</a></li>`);
                column
                    .data()
                    .unique()
                    .sort()
                    .each(function (d) {
                    	dropdown.append(`<li><div class="dropdown-item" id="myIssueState" data-value="${d}">${d}</div></li>`);
                    });
                dropdown.on('click', '#myIssueState', function () {
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
			{targets: [1, 2, 3, 5], orderable: false},
		],
//        createdRow: function(row, data, dataIndex) {
//            $(row).on('click', function() {
//                const projectId = data[columns[0].data];
//                console.log(projectId);
//                window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId;
//            });
//        }
	});
    
    let columnIndex = 2;
    
    $('#myIssueSelect').on('change', function() {
        var selectedOption = $(this).val();
        
        columnIndex = table.columns().eq(0).filter(function(index) {
            return table.column(index).dataSrc() === selectedOption;
        })[0];
        
        var searchTerm = $('#myIssueInput').val();
        table.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm);
            } else {
                this.search('');
            }
        });
        
        table.draw();
    });

    $('#myIssueInput').on('input keyup', function() {
        var searchTerm = this.value;

        if (searchTerm === '') {
            table.search('').columns().search('');
        } else {
            table.column(columnIndex).search(searchTerm);
        }
        table.draw();
    });
    
    $('#myIssueInput').on('keydown', function(e) {
        if (e.key === 'Enter') {  
            e.preventDefault();  
        }
    });
});