$(document).ready(function() {
    let columns = $('#projectIssueList thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let projectIssueTable = $('#projectIssueList').DataTable({
		order: [0, 'desc'],
		orderClasses: true,
		columns: columns,
		initComplete: function() {
	        this.api()
            .columns([5]) 
            .every(function () {
                let column = this;
                let dropdown = $('#projectIssueStateMenu');
                dropdown.append(`<li><a class="dropdown-item" id="projectIssueState" href="#" data-value="전체">전체</a></li>`);
                column
                    .data()
                    .unique()
                    .sort()
                    .each(function (d) {
                    	dropdown.append(`<li><div class="dropdown-item" id="projectIssueState" data-value="${d}">${d}</div></li>`);
                    });
                dropdown.on('click', '#projectIssueState', function () {
                    const dropdownVal = $(this).data('value');
                    if (dropdownVal == '전체') {
                    	column.search('').draw();
                    } else {
                    	column.search('^' + dropdownVal + '$', true, false).draw();
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
    
    let columnIndex = 0;
    
    $('#projectIssueSelect').on('change', function() {
        let selectedOption = $(this).val();
        columnIndex = projectIssueTable.columns().eq(0).filter(function(index) {
            return projectIssueTable.column(index).dataSrc() === selectedOption;
        })[0];
        
        let searchTerm = $('#projectIssueInput').val();
        projectIssueTable.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm);
            } else {
                this.search('');
            }
        });
        
        projectIssueTable.draw();
    });

    $('#projectIssueInput').on('input keyup', function() {
    	let searchTerm = this.value;
        if (searchTerm === '') {
            projectIssueTable.search('').columns().search('');
        } else {
            projectIssueTable.column(columnIndex).search(searchTerm);
        }
        projectIssueTable.draw();
    });
    
    $('#projectIssueForm').on('keydown', function(e) {
        if (e.key === 'Enter') {  
            e.preventDefault();  
        }
    });
});