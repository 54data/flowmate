const Toast = Swal.mixin({
    toast: true,
    position: 'top',
    showConfirmButton: false,
    timer: 2000,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.style.width = '350px';
        toast.style.fontSize = '14px';
    }
});

function projectMemberManageEnabled(status, memberId, memberName, projectId) {
	Swal.fire({
		title: `${memberName} 님을 ${status} 하시겠습니까?`,
		icon: 'warning',
		showCancelButton: true, 
		confirmButtonText: '확인', 
		cancelButtonText: '취소', 
		reverseButtons: true, 
	}).then(result => {
		if (result.isConfirmed) {
			$.ajax({
				url: '../../flowmate/project/projectMemberManageEnabled',
                type: 'POST',
                data: {
                	projectId: projectId,
                    memberId: memberId,
                    memberStatus: (status === '활성화' ? true : false)
                },
		        success: function(response) {
		        	window.location.href = '../../flowmate/project/projectMemberManage?projectId=' + projectId + '&status=' + status;
				},
		    });
		}
	});
}

$(document).ready(function() {
    let columns = $('#projectMemberManageList thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let projectMemberManageTable = $('#projectMemberManageList').DataTable({
		order: [1, 'asc'],
		orderClasses: true,
		columns: columns,
		initComplete: function() {
		    const columnsToApplyFilter = [2, 3, 4, 5]; 

		    columnsToApplyFilter.forEach((columnIndex) => {
		        this.api()
		        .columns([columnIndex])
		        .every(function () {
		            let column = this;
		            let dropdownId = '';
		            switch (columnIndex) {
		                case 2:
		                    dropdownId = 'projectMemberManageDept';
		                    break;
		                case 3:
		                    dropdownId = 'projectMemberManageRank';
		                    break;
		                case 4:
		                    dropdownId = 'projectMemberManageRole';
		                    break;
		                case 5:
		                    dropdownId = 'projectMemberManageEnabled';
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
			{targets: [0, 2, 3, 4, 5, 6], orderable: false},
		],
	});
    
    let columnIndex = 0;
    
    $('#projectMemberManageSelect').on('change', function() {
        let selectedOption = $(this).val();
        columnIndex = projectMemberManageTable.columns().eq(0).filter(function(index) {
            return projectMemberManageTable.column(index).dataSrc() === selectedOption;
        })[0];
        
        let searchTerm = $('#projectMemberManageInput').val();
        projectMemberManageTable.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm);
            } else {
                this.search('');
            }
        });
        
        projectMemberManageTable.draw();
    });

    $('#projectMemberManageInput').on('input keyup', function() {
    	let searchTerm = this.value;
        if (searchTerm === '') {
        	projectMemberManageTable.search('').columns().search('');
        } else {
        	projectMemberManageTable.column(columnIndex).search(searchTerm);
        }
        projectMemberManageTable.draw();
    });
    
    $('#projectMemberManageForm').on('keydown', function(e) {
        if (e.key === 'Enter') {  
            e.preventDefault();  
        }
    });
    
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');

    if (status) {
        Toast.fire({
            icon: 'success',
            title: status + ' 처리 완료',
        });
        const newUrl = `${window.location.origin}${window.location.pathname}?projectId=${urlParams.get('projectId')}`;
        window.history.replaceState(null, null, newUrl);
    }
});