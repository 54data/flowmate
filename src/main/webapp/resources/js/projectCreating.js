const projectStepListCnt = $('.project-steps').find('.project-step-select').length;
const addTestStepBtn = $('.add-task-step-btn').detach();

let projectName = '';
let projectStartDate = '';
let projectDueDate = '';
let projectContent = '';

let projectMemberList = [];
let stepList = [];

function removeTaskStepBtn() {
	if ($('.project-steps').find('.project-step-select').length < projectStepListCnt) {
		$('.project-steps').append(addTestStepBtn);
	} else {
		$('.add-task-step-btn').remove();
	}
};

function setSelectAndDate() {
	$('.project-team-select').select2({
		width: '100%',
        placeholder: '할당되지 않음',
        allowClear: true,
        dropdownParent: $('#projectCreating'),
        closeOnSelect: false,
		ajax: {
		    url: '../project/getMembers',
		    dataType: 'json',
		    cache: true,
		    processResults: function (data) {
		    	return {
	                results: data.members.map(function(member) {
	                    return {
	                        id: member.memberId,
	                        text: member.memberName + ' ' + member.memberDept + ' ' + member.memberRank
	                    };
	                })
		    	};
		    }
		}
	});
	
	$('.project-step').select2({
		width: '100%',
        dropdownParent: $('#projectCreating'),
        tags: true
	});
	
	$('[id$=daterangepicker]').daterangepicker({
        "locale": {
            "format": "YYYY-MM-DD",
            "separator": " ~ ",
            "applyLabel": "확인",
            "cancelLabel": "취소",
            "fromLabel": "From",
            "toLabel": "To",
            "customRangeLabel": "Custom",
            "weekLabel": "W",
            "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
            "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            "firstDay": 1
        },
        "startDate": "2024-10-07",
        "endDate": "2024-11-25",
        "drops": "auto"
    });
	
	$('.project-range').on('apply.daterangepicker', function(ev, picker) {
		projectStartDate = picker.startDate.format('YYYYMMDDHHmmss');
		projectDueDate = picker.endDate.format('YYYYMMDDHHmmss');
	});
	
	$('.project-team-select').on('change', function (e) {
		projectMemberList = $(this).val();      
	});
};

const handler = {
		init() {
			const fileInput = $('.project-file-input');
			const preview = $('.file-preview');
			
			fileInput.on('change', function() {
				const files = Array.from(this.files);
				files.forEach(file => {
					preview.append(
						`<div class="project-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="project-${file.lastModified}">
							${file.name}
							<button type="button" class="file-remove btn-close ms-2" data-index="project-${file.lastModified}"></button>
						</div>`);
				});
				$('.project-files-length').text($('.file-preview').find('.project-file').length);
			});
		},
		 
		removeFile() {
			$(document).on('click', (e) => {
				if (!$(e.target).hasClass('file-remove')) return;
				const removeTargetId = $(e.target).data('index');
				const removeTarget = $('#' + removeTargetId);
				const files = $('.project-file-input')[0].files;
				const dataTransfer = new DataTransfer();
				
		        Array.from(files)
		            .filter(file => `project-${file.lastModified}` != removeTargetId)
		            .forEach(file => {
		                dataTransfer.items.add(file);
		            });
		        $('.project-file-input')[0].files = dataTransfer.files;
		        removeTarget.remove();
		        $('.project-files-length').text($('.file-preview').find('.project-file').length);
			});
		}
};

$(document).ready(function() {
	$('.add-attachment, .file-input-btn').on('click', function() {
	    $('.project-file-input').trigger('click');
	});
	
	handler.init();
	handler.removeFile();
	
	setSelectAndDate();
	
    $('[id$=issueState]').on('click', function() {
        const status = $(this).text();
        $('.issue-state-btn').text(status);

        const color = $(this).data('color');
        $('.issue-state-btn').css('color', color);
    });
    
    $('[id$=projectStatus]').on('click', function() {
        var status = $(this).data('status');
        var color = $(this).data('color');
        
        $('#projectStatusButton').text(status); 
        $('#projectStatusButton').removeClass('btn-info btn-warning btn-success').addClass('btn-' + color);
    });
    
    $('.project-step-close').on('click', function() {
        $(this).closest('.d-flex').remove();
        removeTaskStepBtn();
    });
    
    $('.add-task-step').on('click', function() {
		const projectStepSelect = `<div class="project-step-select d-flex align-items-center mt-1 w-100">
			<select class="project-step">
				<option value="" disabled selected>입력</option>
			  	<option>분석</option>
			  	<option>설계</option>
			  	<option>개발</option>
			  	<option>테스트</option>
			  	<option>이행</option>
			</select>
			<input type="text" class="task-range" id="daterangepicker" name="daterangepicker" value="" />
			<button class="btn btn-sm delete-step ms-1 btn-close project-step-close"></button>
		</div>`;
		$('.project-steps').append(projectStepSelect);
		setSelectAndDate();
		removeTaskStepBtn();
    });
    
    $('.project-name').on('change', function() {
    	projectName = $(this).val().trim();
    });    
    
    $('.project-content').on('change', function() {
    	projectContent = $(this).val().trim();
    }); 
    
    $('.project-creating-btn').on('click', function() {
    	projectCreating();
    })
});

function projectCreating() {
	stepList = [];
	$('.project-step').each(function() {
		let stepName = $(this).find(':selected').text();
		let stepStartDate = $(this).siblings('.task-range').data('daterangepicker').startDate.format('YYYYMMDDHHmmss');
		let stepDueDate = $(this).siblings('.task-range').data('daterangepicker').endDate.format('YYYYMMDDHHmmss');
		stepList.push({'stepName' : stepName, 'stepStartDate' : stepStartDate, 'stepDueDate' : stepDueDate});
	});
	
	let projectData = {};
	projectData['projectName'] = projectName;
	projectData['projectStartDate'] = projectStartDate;
	projectData['projectDueDate'] = projectDueDate;
	projectData['projectContent'] = projectContent;
	projectData['projectMemberList'] = projectMemberList;
	projectData['projectStepList'] = stepList;
	
	$.ajax({
		url: 'createProject',
		type: 'POST',
		contentType: 'application/json',
		data: JSON.stringify(projectData),
		success: function(response) {
			console.log(response);
		},
		error: function(response) {
			console.log('프로젝트 생성 실패');
		}
	});
}
