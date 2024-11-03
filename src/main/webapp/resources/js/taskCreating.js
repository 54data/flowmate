let projectId;
let stepData = [];
const Toast = Swal.mixin({
    toast: true,
    position: 'top',
    showConfirmButton: false,
    timer: 2500,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.style.width = '350px';
        toast.style.fontSize = '14px';
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
});

//단계 선택 시 날짜 업데이트 함수
function updateDateRangeStep(stepId) {
    const selectedStepId =  $('.task-step').val();
    const selectedStep = stepData.find(step => step.stepId === selectedStepId);

    if (selectedStep) {
        $('.task-step-date-range').val(`${selectedStep.stepStartDate} - ${selectedStep.stepDueDate}`);
        $('#taskStepStartDate').val(selectedStep.stepStartDate);
        $('#taskStepDueDate').val(selectedStep.stepDueDate);
    }
}

function modalInfo(){
    return $.ajax({
        url: '/flowmate/task/taskModalInfo',
        method: 'get',
        data: { projectId: projectId },
        success: function(response) {
            stepData = response;
            $('.task-step').empty();

            response.forEach(function(step) {
                $('.task-step').append('<option value="' + step.stepId + '">' + step.stepName + '</option>');
            });

            if (stepData.length > 0) {
                const firstStep = stepData[0];
                $('.task-step-date-range').val(firstStep.stepStartDate + ' - ' + firstStep.stepDueDate);
                $('#taskStepStartDate').val(firstStep.stepStartDate);
                $('#taskStepDueDate').val(firstStep.stepDueDate);
            }
        }
    });
}

function taskManagerSelect(projectId) {
    $('.task-manager-select').select2({
        width: '100%',
        placeholder: '할당되지 않음',
        allowClear: true,
        dropdownParent: $('#taskCreating'),
        closeOnSelect: false,
        minimumResultsForSearch: Infinity,
        ajax: {
            url: '../../flowmate/task/getTaskMembers',
            dataType: 'json',
            data: function() {
                return {
                    projectId: projectId
                };
            },
            processResults: function(data) {
                return {
                    results: data.map(function(member) {
                        return {
                            id: member.memberId,
                            text: member.memberName + ' ' + member.memberDept + ' ' + member.memberRank
                        };
                    })
                };
            }
        }
    }).on('select2:select', function(e) {
        let selectedMemberId = e.params.data.id;
        $('#selectedMemberId').val(selectedMemberId);
    });
}

$(document).ready(function() {
    $('.task-add-attachment, .task-file-input-btn').on('click', function() {
        $('.task-file-input').trigger('click');
    });
    
    const urlParams = new URLSearchParams(location.search);
    projectId = urlParams.get('projectId');
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
    
    taskManagerSelect(projectId);
    
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
    
    // 작업 기간 설정
    $('.task-date-range').daterangepicker(
        {
            locale: {
                format: 'YYYY/MM/DD'
            },
            startDate: moment(),
            endDate: moment(),
        }, 
        function(start, end) {
            $('#taskStartDate').val(start.format('YYYYMMDDHHmmss'));
            $('#taskDueDate').val(end.set({ hour: 0, minute: 0, second: 0 }).format('YYYYMMDDHHmmss'));
        }
    );
    
    $('.task-step-date-range').daterangepicker(
            {
          locale: {
             format: 'YYYY/MM/DD'  
          }                
            },
            function(start, end) {
            $('#taskStepStartDate').val(start.set({ second: 0 }).format('YYYYMMDDHHmmss'));
            $('#taskStartDueDate').val(end.set({ hour: 0, minute: 0, second: 0 }).format('YYYYMMDDHHmmss'));
        }); 
    
    $('.dropdown-item').on('click', function() {
        const status = $('#taskStatusButton').text();
        $('#taskStatusInput').val(status);  
    });
    
    $('.add-task').on('click', function() {
        let step = $(this).data('step');
        $('.task-step').empty().append(`<option value="${step}" selected>${step}</option>`);
        
        let dateText = $(this).closest('.board').find('.board-date').text();
        $('.task-date-range').val(step.stepStartDate + ' - ' + step.stepDueDate);
    });
    

    	//생성모달
    $('#topTaskCreat').on('click', function() {
    			taskHandler.taskInit(false); // 생성 모달 초기화
    		    $(".task-file-preview").empty(); 
    		    $(".task-name").val(""); 
    		    $(".task-content").val(""); 
    		    $(".task-log").val(""); 
    		    $("#taskPriority").val("").trigger("change"); 
    		    $(".task-issue-state-btn").text("미해결").css("color", "#FF5959"); 
    		    $(".task-issue-id").text(""); // 이슈 ID 초기화
    		    $('#task-issue').css('display', 'none'); 
    		    $('.task-request-div').css('display', 'none');
    		    $('#taskStatusButton').css('display', 'none')
    		    $('.dev_selected').attr('style', 'display: none !important;');
    		    $(".taskSubmit").text("작업 생성").addClass("taskSubmit").removeClass("taskDisabled");
    		    taskHandler.updateFileCount(0); 
    		    taskHandler.fileArray = []; 
    			modalInfo().done(function() {
    	            $(".task-file-preview").empty(); // 미리보기 초기화
            $('#taskCreating').modal('show');
            taskManagerSelect(projectId);
        });
        
        $('.task-step').on('change', updateDateRangeStep);
    });

    //수정모달
    $(".task-updateModal").on('click', function() {
    		
    	
        const urlParams = new URLSearchParams(location.search);
        projectId = urlParams.get('projectId');
        let taskId = $(this).data('task-id');
        console.log(taskId);
        taskHandler.taskInit(true); // 모달 초기화
        
        $(".task-name").val("");
        $(".task-content").val("");
        $(".task-log").val("");
        $(".task-file-preview").empty();
        $("#taskPriority").val("").trigger("change");
        $(".task-issue-state-btn").text("미해결").css("color", "#FF5959");
        $(".task-issue-id").text("");
        $('#task-issue').css('display', 'none'); 
        taskHandler.fileArray = [];
       
        $.ajax({
            url: '/flowmate/task/getTaskUpdateModalInfo',
            method: 'get',
            data: { taskId, projectId },
            success: function(response) {
            		
            		$('#taskUpdateModal').modal('show');
                let taskInfo = response.taskInfo;
                currentStatus = taskInfo.taskState;
                console.log(response);
                const fileList = response.taskAttachList;
                $(".task-name").val(taskInfo.taskName);                
                $("#taskId").val(taskInfo.taskId);                
                $(".task-step").val(taskInfo.taskStepId).trigger('change');
                $("#taskPriority").val(taskInfo.taskPriority);
                           
                $(".task-issue-id").text(taskInfo.issueId);                
                $(".task-issue-title").text(taskInfo.issueTitle);  
                $(".task-log").val(taskInfo.taskContent);
                $(".taskStartDate").val(taskInfo.taskStartDate);
                $(".taskDueDate").val(taskInfo.taskDueDate);
                $(".task-content").val(taskInfo.taskContent);
                $("#taskStatusButton").text(taskInfo.taskState);  
                $(".task-priority-option").val(taskInfo.taskPriority).trigger('change');  
                $("#taskId").val(taskInfo.taskId);
                $('#taskStatusButton').addClass('bg-info');
                $(".taskSubmit").text("비활성화").removeClass("taskSubmit").addClass("taskDisabled");
               

                if (taskInfo.issueId != null) {
                    $('#task-issue').css('display', 'block');
                }

                if (taskInfo.issueState === "해결") {
                    $(".task-issue-state-btn").text("해결");
                    $(".task-issue-state-btn").css("color", "#0C66E4");
                } else {
                    $(".task-issue-state-btn").text("미해결");
                    $(".task-issue-state-btn").css("color", "#FF5959");
                }

                if (taskInfo.taskState === "완료") {
                    $('#taskStatusButton').removeClass("bg-warning bg-info bg-dark").addClass("bg-success".prop('disabled', false));
                } else if (taskInfo.taskState === "보류") {
                    $('#taskStatusButton').removeClass("bg-info bg-success bg-dark").addClass("bg-warning").prop('disabled', false);
                }else if (taskInfo.taskState === "예정") {
                    $('#taskStatusButton').removeClass("bg-info bg-success bg-warning").addClass("bg-dark").prop('disabled', true);
                }  else {
                    $('#taskStatusButton').removeClass("bg-success bg-warning bg-dark").addClass("bg-info").prop('disabled', false);
                }

                // 기존 첨부파일을 fileArray에 추가
                if (fileList && fileList.length > 0) {
                    fileList.forEach(file => {
                        // 파일 정보를 fileArray에 추가
                        taskHandler.fileArray.push({
                            name: file.fileName,
                            lastModified: file.lastModified,
                            isExisting: true,  // 기존 파일임을 표시하기 위해 추가
                            fileId : file.fileId
                        });

                     
                        $('.task-file-preview').append(
                            `<div class="task-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="task-${file.lastModified}">
                                ${file.fileName}
                                <button type="button" class="task-file-remove btn-close ms-2" data-index="task-${file.lastModified}"></button>
                            </div>`
                        );
                    });
                }

                modalInfo().done(function() {
                    $(".task-step").val(taskInfo.taskStepId).trigger('change');
                    taskManagerSelect(projectId)
                    //담당자 selected 되게
                    	if (response.taskMembers) {
                        response.taskMembers.forEach(function(member) {
                            if (member.memberId === taskInfo.memberId) {
                                $(".task-manager-select").append(new Option(member.memberName + ' ' + member.memberDept + ' ' + member.memberRank, member.memberId, true, true));
                            } else {
                                $(".task-manager-select").append(new Option(member.memberName + ' ' + member.memberDept + ' ' + member.memberRank, member.memberId));
                            }
                        });
                        $(".task-manager-select").trigger('change'); // Select2 적용
                    }
                    updateDateRangeStep(taskInfo.taskStepId);
                });
                
                taskHandler.updateFileCount(fileList.length);
                // 기존 daterangepicker 인스턴스 제거
                console.log(taskInfo.stepName);
                console.log(taskInfo.taskStepId);
                $('.task-step-date').empty();
                $(".task-step").val(taskInfo.taskStepId).trigger('change'); 
                
                const taskStartDate = moment(taskInfo.taskStartDate, 'YYYYMMDDHHmmss');
                const taskDueDate = moment(taskInfo.taskDueDate, 'YYYYMMDDHHmmss');

                console.log(taskStartDate.format('YYYY/MM/DD'));
                // 초기값으로 보이는 날짜 범위 설정
                $('.task-date-range').val(taskStartDate.format('YYYY/MM/DD') + ' - ' + taskDueDate.format('YYYY/MM/DD'));
                
              
                
                
            }
        });
        
        // 상태 버튼 클릭 시 색상 및 표시 변경
        $('[id$=taskStatus]').on('click', function() {
            const selectedStatus = $(this).data('status');
            const color = $(this).data('color');
            
            console.log(selectedStatus);
            console.log(currentStatus);
            

            if (selectedStatus !== currentStatus) {
                $('.task-request-div').css('display', 'block');

            } else {
                $('.task-request-div').css('display', 'none ');
            }

            $('#taskStatusButton')
                .text(selectedStatus)
                .removeClass('bg-info bg-warning bg-success')
                .addClass(`bg-${color}`);
        });
        
        $('.task-step').on('change', updateDateRangeStep);
        $('.taskUpdateModal').css('display', 'block');
        $('.dev_selected').css('display', 'block');
        $('#taskStatusButton').css('display', 'block');
        $('.task-update-btn').css('display', 'block');
    });
    
    // 모달이 닫힐 때의 이벤트
    $('.taskUpdateModal').on('hidden.bs.modal', function () {
        $('.taskUpdateModal').css('display', 'none');
    });
});

function taskValidate() {
    if ($(".task-name").val().trim().length === 0 || $(".task-name").val() == null) {
        Toast.fire({
            icon: 'error',
            title: '작업명을 입력해주세요.'
        });
        return false;
    }

    if ($('#selectedMemberId').val().trim().length === 0 || $('#selectedMemberId').val() == null) {
        Toast.fire({
            icon: 'error',
            title: '담당자를 선택하세요.'
        });
        return false;
    }

    if ($(".task-step").val().trim().length === 0 || $(".task-step").val() == null) {
        Toast.fire({
            icon: 'error',
            title: '작업 단계를 선택하세요'
        });
        return false;
    }





    let todayStartDate = $('.task-date-range').data('daterangepicker').startDate;
    let todayEndDate = $('.task-date-range').data('daterangepicker').endDate;

    $('#taskStartDate').val(todayStartDate.format('YYYYMMDDHHmmss'));
    $('#taskDueDate').val(todayEndDate.format('YYYYMMDDHHmmss'));

    let taskStartDate = moment($('#taskStartDate').val(), 'YYYYMMDD').startOf('day');
    let taskDueDate = moment($('#taskDueDate').val(), 'YYYYMMDD').endOf('day');
    let stepStartDate = moment($("#taskStepStartDate").val(), 'YYYYMMDD').startOf('day');
    let stepDueDate = moment($('#taskStepDueDate').val(), 'YYYYMMDD').endOf('day');

    if (taskStartDate >= stepStartDate && taskDueDate <= stepDueDate) {
        return true;
    } else {
        Toast.fire({
            icon: 'error',
            title: '작업 기간은 해당 단계 기간 내에 있어야 합니다.'
        });
        return false;
    }
}

let taskHandler = {
		 	fileArray: [],       // 생성 모달 전용
		    newFileArray: [],    // 수정 모달 전용으로 새로 추가된 파일들만
		    removeFileArray: [], // 수정 모달 전용으로 삭제할 파일 저장
		    
		    taskInit(isUpdate = false) { // isUpdate 플래그로 생성 모달과 수정 모달 구분
		        const fileInput = $('.task-file-input');
		        const preview = $('.task-file-preview');
		        
		        // 기존 파일 배열을 초기화
		        if (isUpdate) {
		            this.newFileArray = []; // 수정 모달 초기화
		            this.removeFileArray = []; 
		        } else {
		            this.fileArray = []; // 생성 모달 초기화
		            this.removeFileArray = []; 
		        }
		        preview.empty(); // 미리보기 초기화
		        fileInput.off('change').on('change', function() {
		            const files = Array.from(this.files);
		            files.forEach(file => {
		                if (isUpdate) {
		                    // 수정 모달인 경우 newFileArray에 추가
		                    taskHandler.newFileArray.push(file);
		                    console.log(taskHandler.newFileArray);
		                } else {
		                    // 생성 모달인 경우 fileArray에 추가
		                    taskHandler.fileArray.push(file);
		                    console.log(taskHandler.fileArray);
		                }
		                preview.append(
		                    `<div class="task-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="task-${file.lastModified}">
		                        ${file.name}
		                        <button type="button" class="task-file-remove btn-close ms-2" data-index="task-${file.lastModified}"></button>
		                    </div>`
		                );
		            });
		            taskHandler.updateFileCount(isUpdate ? taskHandler.newFileArray.length + taskHandler.fileArray.length : taskHandler.fileArray.length);
		        });

		    },
		     
		    taskRemoveFile() {
		        $(document).on('click', (e) => {
		            if (!$(e.target).hasClass('task-file-remove')) return;
		            const removeTargetId = $(e.target).data('index');
		            const removeTarget = $('#' + removeTargetId);
		            
		            const existingFileIndex = taskHandler.fileArray.findIndex(file => `task-${file.lastModified}` === removeTargetId);
		            if (existingFileIndex !== -1) {
		                if (taskHandler.fileArray[existingFileIndex].isExisting) { // 수정 모달에서만 추가
		                    taskHandler.removeFileArray.push(taskHandler.fileArray[existingFileIndex].fileId); // fileId를 저장		                    
		                    console.log(taskHandler.fileArray);
		                    console.log(taskHandler.removeFileArray);
		                }
		                taskHandler.fileArray.splice(existingFileIndex, 1); // 파일 제거
		            } else {
		                const newFileIndex = taskHandler.newFileArray.findIndex(file => `task-${file.lastModified}` === removeTargetId);
		                if (newFileIndex !== -1) {
		                    taskHandler.newFileArray.splice(newFileIndex, 1); // 새 파일 제거
		                }
		            }
		            removeTarget.remove(); // UI에서 제거
		            taskHandler.updateFileCount(taskHandler.fileArray.length + taskHandler.newFileArray.length);
		        });
		    },
        
    sendTaskData: function(isUpdate) {
        const formData = new FormData();
        formData.append("taskName", $(".task-name").val());
        formData.append("taskContent", $(".task-content").val());
        formData.append("taskLog", $(".task-log").val());
        formData.append("taskPriority", $(".task-priority-option").val());
        formData.append("taskState", $("#taskStatusInput").val());
        formData.append("taskStepId", $(".task-step").val());
        formData.append("projectId", projectId);
        formData.append("taskStartDate", $("#taskStartDate").val());
        formData.append("taskDueDate", $("#taskDueDate").val());
        formData.append("stepStartDate", moment($("#taskStepStartDate").val(), 'YYYY-MM-DD').format('YYYYMMDDHHmmss'));
        formData.append("stepDueDate", moment($("#taskStepDueDate").val(), 'YYYY-MM-DD').format('YYYYMMDDHHmmss'));
        formData.append("memberId", $('#selectedMemberId').val());


        
        if (isUpdate) {
            formData.append("taskId", $('#taskId').val());

            // 수정 모달에서는 새로운 파일(newFileArray)만 전송
            taskHandler.newFileArray.forEach(file => {
                console.log(file); // 여기서 file을 올바르게 참조할 수 있는지 확인
                formData.append("taskAttach", file); 
            });

           
            taskHandler.removeFileArray.forEach(file => {
                console.log(file); 
                formData.append("removeFiles", file); 
            });
        } else {
            taskHandler.fileArray.forEach(file => {
                formData.append("taskAttach", file); 
            });
        }
        
        let url = isUpdate ? '/flowmate/task/taskUpdate' : '/flowmate/task/taskCreate'; 
        
        $.ajax({
            url: url,
            type: 'post',
            data: formData,
            cache: false,
            processData: false,
            contentType: false,
            success: function() {
                location.href = "/flowmate/project/projectBoard?projectId=" + encodeURIComponent(projectId);
            },
        });
    },

    updateFileCount(count) {
        $('.file-count').text(count);
    }
    

    
};

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
        default:
            icon = ''; 
    }
    
    return $('<span>' + icon + ' ' + option.text + '</span>');
}

$(document).on('click', '.taskSubmit', function () {
    if (!taskValidate()) {
        event.preventDefault();
        return false;
    }

    taskHandler.sendTaskData(false);
});

$(document).on('click', '.task-update-btn', function () {
    if (!taskValidate()) {
        event.preventDefault();
        return false;
    }
    
    taskHandler.sendTaskData(true);
});

$(document).on('click', '.taskDisabled', function () {
    $.ajax({
        url: '/flowmate/task/taskDisabled',
        type: 'post',
        data: {taskId:$('#taskId').val(), projectId},
        success: function() {
            location.href = "/flowmate/project/projectBoard?projectId=" + encodeURIComponent(projectId);
            console.log("비활성화");
        }
    });
});


