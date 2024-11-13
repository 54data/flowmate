$(document).ready(function() {
    let columns = $('#projectMemberList thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let projectMemberTable = $('#projectMemberList').DataTable({
		order: [1, 'asc'],
		orderClasses: true,
		columns: columns,
		initComplete: function() {
		    const columnsToApplyFilter = [2, 3]; 

		    columnsToApplyFilter.forEach((columnIndex) => {
		        this.api()
		        .columns([columnIndex])
		        .every(function () {
		            let column = this;
		            let dropdownId = '';
		            switch (columnIndex) {
		                case 2:
		                    dropdownId = 'projectMemberDeptMenu';
		                    break;
		                case 3:
		                    dropdownId = 'projectMemberRankMenu';
		                    break;
		            }

		            let dropdown = $('#' + dropdownId);
		            dropdown.append(`<li><a class="dropdown-item" id="${dropdownId}Item" href="#" data-value="전체">전체</a></li>`);
		            column
		                .data()
		                .unique()
		                .sort()
		                .each(function (d) {
		                    dropdown.append(`<li><div class="dropdown-item" id="${dropdownId}Item" data-value="${d}">${d}</div></li>`);
		                });

		            dropdown.on('click', `#${dropdownId}Item`, function () {
		                const dropdownVal = $(this).data('value');
		                if (dropdownVal == '전체') {
		                    column.search('').draw();
		                } else {
		                    column.search('^' + dropdownVal + '$', true, false).draw();
		                }
		            });
		        });
		    });
		},
		columnDefs: [
			{targets: [0, 2, 3, 4], orderable: false},
		],
	});
    
    let columnIndex = 0;
    
    $('#projectMemberSelect').on('change', function() {
        let selectedOption = $(this).val();
        columnIndex = projectMemberTable.columns().eq(0).filter(function(index) {
            return projectMemberTable.column(index).dataSrc() === selectedOption;
        })[0];
        
        let searchTerm = $('#projectMemberInput').val();
        projectMemberTable.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm);
            } else {
                this.search('');
            }
        });
        
        projectMemberTable.draw();
    });

    $('#projectMemberInput').on('input keyup', function() {
    	let searchTerm = this.value;
        if (searchTerm === '') {
        	projectMemberTable.search('').columns().search('');
        } else {
        	projectMemberTable.column(columnIndex).search(searchTerm);
        }
        projectMemberTable.draw();
    });
    
    $('#projectMemberForm').on('keydown', function(e) {
        if (e.key === 'Enter') {  
            e.preventDefault();  
        }
    });
    
    $(document).on('click','.send-msg', function() {
        let receiverId = $(this).closest('tr').find('.reciverId').text();
        console.log(receiverId);

        window.open(`/flowmate/message/messageSend?receiverId=${receiverId}`, '_blank', 'width=600, height=500, scrollbars=yes');
    });
});