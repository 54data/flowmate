let projectId;
let stepData = [];

$(document).ready(function() {
	$('.task-add-attachment, .task-file-input-btn').on('click', function() {
		$('.task-file-input').trigger('click');
	});
	
	taskHandler.taskInit();
	taskHandler.taskRemoveFile();
	
	$('.task-step').select2({
		width: '100%',
        dropdownParent: $('#taskCreating'),
        minimumResultsForSearch: Infinity
	});
	
	$('.task-priority-option').select2({
		width: '100%',
        dropdownParent: $('#taskCreating'),
        minimumResultsForSearch: Infinity,
        templateResult: formatOption,
        templateSelection: formatOption
	});
	
    $('[id$=taskIssueState]').click(function() {
        const status = $(this).text();
        $('.task-issue-state-btn').text(status);

        const color = $(this).data('color');
        $('.task-issue-state-btn').css('color', color);
    });
    
    $('[id$=taskStatus]').on('click', function() {
        var status = $(this).data('status');
        var color = $(this).data('color');
        
        $('#taskStatusButton').text(status); 
        $('#taskStatusButton').removeClass('btn-info btn-warning btn-success').addClass('btn-' + color);
    });
    
    // 날짜 설정
    $('.task-date-range').daterangepicker(
    	{}, //projectCreateing.js에 있어 생략	
    	function(start, end) {
        // 날짜 db에 맞게 설정
        $('#taskStepStartDate').val(start.format('YYYYMMDDHHMMSS'));
        $('#taskStepDueDate').val(end.format('YYYYMMDDHHMMSS'));
        console.log(start.format('YYYYMMDDHHMMSS'));
        console.log(end.format('YYYYMMDDHHMMSS'));
    });    

    
    
    $('.dropdown-item').on('click', function() {
        const status = $('#taskStatusButton').text();
        $('#taskStatusInput').val(status);  
        console.log(status);
    });
    
    $('.add-task').on('click', function() {
    		
        let step = $(this).data('step');
        $('.task-step').empty().append(`<option value="${step}" selected>${step}</option>`);
        //$('.task-step').prop('disabled', true);
        
        let dateText = $(this).closest('.board').find('.board-date').text();
        console.log('날짜: ' + dateText);
        $('.task-date-range').val(step.stepStartDate + ' - ' + step.stepDueDate);
    });
    
	const urlParams = new URLSearchParams(location.search);
	projectId = urlParams.get('projectId');

    //모달창 나타날 때 정보 조회
    $('#topTaskCreat').on('click', function() {
        $.ajax({
            url: '/flowmate/task/taskModalInfo',
            method: 'get',
            data: { projectId: projectId },
            success: function(response) {
                stepData = response;
                $('.task-step').empty();

                response.forEach(function(step) {
                    $('.task-step').append('<option value="' + step.stepId + '">' + step.stepName + '</option>');
                });

                // 기본 날짜 설정
                if (stepData.length > 0) {
                    const firstStep = stepData[0];
                    $('.task-date-range').val(firstStep.stepStartDate + ' - ' + firstStep.stepDueDate);
                    $('#taskStepStartDate').val(firstStep.stepStartDate);
                    $('#taskStepDueDate').val(firstStep.stepDueDate);
                }

                $('#taskCreating').modal('show');
            }
        });
    });

    // 단계 선택 시마다 기간 변경
    $('.task-step').on('change', function() {
        const selectedStepId = $(this).val();
        const selectedStep = stepData.find(step => step.stepId === selectedStepId);

        if (selectedStep) {
            $('.task-date-range').val(selectedStep.stepStartDate + ' - ' + selectedStep.stepDueDate);
            $('#taskStepStartDate').val(selectedStep.stepStartDate);
            $('#taskStepDueDate').val(selectedStep.stepDueDate);
        }
    });
    
});

const taskHandler = {
	fileArray:[],
	
	taskInit() {
		const fileInput = $('.task-file-input');
		const preview = $('.task-file-preview');
		
		fileInput.on('change', function() {
			const files = Array.from(this.files);
			files.forEach(file => {
				taskHandler.fileArray.push(file);
				preview.append(
					`<div class="task-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="task-${file.lastModified}">
						${file.name}
						<button type="button" class="task-file-remove btn-close ms-2" data-index="task-${file.lastModified}"></button>
					</div>`);
			});
            taskHandler.updateFileCount(taskHandler.fileArray.length);
            console.log("fileArray:", taskHandler.fileArray);
            console.log("+length: " + taskHandler.fileArray.length);
		});
	},
	 
	taskRemoveFile() {
		$(document).on('click', (e) => {
			if (!$(e.target).hasClass('task-file-remove')) return;
			const removeTargetId = $(e.target).data('index');
			const removeTarget = $('#' + removeTargetId);
			const files = $('.task-file-input')[0].files;
			const dataTransfer = new DataTransfer();

	        const fileIndex = taskHandler.fileArray.findIndex(file => `task-${file.lastModified}` == removeTargetId);
	        
	        if (fileIndex !== -1) {
	            taskHandler.fileArray.splice(fileIndex, 1); 
	        }
	        $('.task-file-input')[0].files = dataTransfer.files;
	        removeTarget.remove();
	        
	        taskHandler.updateFileCount(taskHandler.fileArray.length);
	        console.log("fileArray:", taskHandler.fileArray);
	        console.log("파일 개수: " + taskHandler.fileArray.length);
		});
	},
    sendTaskData() {
        const formData = new FormData();
        formData.append("taskName", document.querySelector(".task-name").value);
        formData.append("taskContent", document.querySelector(".task-content").value);
        formData.append("taskLog", document.querySelector(".task-log").value);
        formData.append("taskPriority", document.querySelector(".task-priority-option").value);
        formData.append("taskState", $('#taskStatusInput').val()); 
        formData.append("taskStep", document.querySelector(".task-step").value); 
        formData.append("projectId", projectId); 
        
        const startDate = moment($('#taskStepStartDate').val()).format('YYYYMMDDHHmmss');
        const dueDate = moment($('#taskStepDueDate').val()).format('YYYYMMDDHHmmss');
        formData.append("stepStartDate", startDate); 
        formData.append("stepDueDate", dueDate);
        
        taskHandler.fileArray.forEach((file, index) => {
            formData.append("taskAttach", file); 
        });
        
        $.ajax({
            url: '/flowmate/task/taskCreate',
            type: 'post',
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
            success: function() {
               location.href = "/flowmate/project/projectBoard?projectId=" + encodeURIComponent(projectId);
            		console.log("전송")
            },
        }).done((data) => {
        	console.log(data);
        	if(data.result === "success"){
        		console.log("전송 성공");
        	}
        })
    },

    updateFileCount(count) {
        $('.badge').text(count);
    }
};
$(document).on('click', '.taskSubmit', function () {
    taskHandler.sendTaskData();
});

function formatOption(option) {
    if (!option.id) {
        return option.text; 
    }
    
    let icon;
    switch (option.id) {
        case '긴급':
            icon = '<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#EC1E1E" class="bi bi-brightness-alt-high-fill me-1" viewBox="0 0 16 16"><path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4"/></svg>';
            break;
        case '높음':
            icon = '<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#ff7d04" class="bi bi-arrow-up" viewBox="0 0 16 16 me-1"><path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0 .708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/></svg>'; 
            break;
        case '보통':
        	icon = '<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#6DB822" class="bi bi-dash-lg" viewBox="0 0 16 16 me-1"><path fill-rule="evenodd" d="M2 8a.5.5 0 0 1 .5-.5h11a.5.5 0 0 1 0 1h-11A.5.5 0 0 1 2 8"/></svg>'
        	break;
        case '낮음':
        	icon = '<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="#706F74" class="bi bi-arrow-down" viewBox="0 0 16 16 me-1"><path fill-rule="evenodd" d="M8 1a.5.5 0 0 1 .5.5v11.793l3.146-3.147a.5.5 0 0 1 .708.708l-4 4a.5.5 0 0 1-.708 0l-4-4a.5.5 0 0 1 .708-.708L7.5 13.293V1.5A.5.5 0 0 1 8 1"/></svg>';
        	break;
        default:
            icon = ''; 
    }
    
    return $('<span>' + icon + ' ' + option.text + '</span>');
}

