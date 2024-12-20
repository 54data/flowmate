$(document).ready(function() {
	const getQueryString = (param) => new URLSearchParams(window.location.search).get(param);
    const projectId = getQueryString('projectId');
    
    let columns = $('#myIssueList thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let table = $('#myIssueList').DataTable({
		order: [4, 'desc'],
		orderClasses: true,
		columns: columns,
		initComplete: function() {
            if (projectId) {
            	this.api().column(1).search(projectId).draw();
            }
	        this.api()
            .columns([5])
            .every(function () {
                let column = this;
                let dropdown = $('#myIssueStateMenu');
                dropdown.append(`<li><a class="dropdown-item" id="myIssueState" href="#" data-value="전체">전체</a></li>`);
                const stateBadges = {
                    '미해결': 'bg-danger',
                    '해결': 'bg-info'
            	};
                column
                    .data()
                    .unique()
                    .sort()
                    .each(function (d) {
                    	let badgeClass = stateBadges[d] || '';
                    	dropdown.append(`
	                    	<li>
	                    		<div class="dropdown-item" id="myIssueState" data-value="${d}">
	                    			<span class="badge rounded-pill ${badgeClass}" style="font-size: 0.75rem;">${d}</span>
	                    		</div>
	                    	</li>`
                    	);
                    });
                dropdown.on('click', '#myIssueState', function () {
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
			{targets: [2, 5], orderable: false},
			{
                targets: [5], 
                render: function(data, type, row) {
                    if (type === 'display') {
                        const stateBadges = {
                            '미해결': 'bg-danger',
                            '해결': 'bg-info'
                        };
                        const badgeClass = stateBadges[data] || 'bg-secondary';
                        return `<span class="badge rounded-pill ${badgeClass}" style="font-size: 0.85rem;">${data}</span>`;
                    }
                    return data;
                }
            },
	        {
				targets: 0, 
				width: '30%'
	        },
	        {
				targets: 1, 
				render: function(data, type, row) {
				    if (type === 'sort' || type === 'type') {
				        return parseInt(data.split('-')[1], 10);
				    }
				    return data;
				},
				width: '10%'
	        },
	        {
				targets: 2, 
				width: '10%'
	        },
	        {
				targets: 3, 
				width: '30%'
	        },
	        {
				targets: 4, 
				width: '10%'
	        },
	        {
				targets: 5, 
				width: '10%'
	        },
		],
	});
    
    let columnIndex = 0;
    
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
        	table.columns().search('').column(columnIndex).search(searchTerm);
        }
        table.draw();
    });
    
    $('#myIssueInput').on('keydown', function(e) {
        if (e.key === 'Enter') {  
            e.preventDefault();  
        }
    });
    
    $(document).on('click', '.my-issue-title', function() {
        const projectId = $(this).data('projectId');
        const issueId = $(this).data('issueId');
        window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId + '&issueId=' + issueId;
    });
});