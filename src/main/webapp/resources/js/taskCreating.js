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
    taskId = urlParams.get('taskId');
    
    if (projectId && taskId) {
    	$('#taskCreating').modal('show');
        openTaskUpdateModal(taskId, projectId);
        const newUrl = `${window.location.origin}${window.location.pathname}?projectId=${projectId}`;
        window.history.replaceState(null, null, newUrl);
    }
    
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
    
/*    //버튼글자체인지
    $('[id$=taskStatus]').on('click', function() {
        var status = $(this).data('status');
        var color = $(this).data('color');
        
        $('#taskStatusButton').text(status); 
        $('#taskStatusButton').removeClass('btn-info btn-warning btn-success').addClass('btn-' + color);
    });
*/    
    // 작업 기간 설정
    $('.task-date-range').daterangepicker(
    	    {
    	        locale: {
    	            format: 'YYYY/MM/DD',
    	            separator: " - ",
    	            applyLabel: "확인",
    	            cancelLabel: "취소",
    	            fromLabel: "From",
    	            toLabel: "To",
    	            customRangeLabel: "Custom",
    	            weekLabel: "W",
    	            daysOfWeek: ["일", "월", "화", "수", "목", "금", "토"],
    	            monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
    	            firstDay: 1
    	        },
    	        drops: "auto",
    	        startDate: moment(),
    	        endDate: moment()
    	    },
    	    function(start, end) {
    	    	 $('#taskStartDate').val(start.set({ second: 0 }).format('YYYYMMDDHHmmss'));
    	      $('#taskDueDate').val(end.set({ hour: 23, minute: 59, second: 59 }).format('YYYYMMDDHHmmss'));
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
            $('#taskStepDueDate').val(end.set({ hour: 23, minute: 59, second: 59 }).format('YYYYMMDDHHmmss'));
        }); 
    
    //버튼글자체인지2
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
		enableEditing(undefined); 
	    $(".task-file-preview").empty(); 
	    $(".task-name").val(""); 
	    $(".task-content").val(""); 
	    $(".task-log").val(""); 
	    const today = moment().format('YYYY/MM/DD');
	    $('.task-date-range').val(today + ' - ' + today);
	    $("#taskPriority").val("").trigger("change"); 
	    $(".task-issue-state-btn").text("미해결").css("color", "#FF5959"); 
	    $(".task-issue-id").text(""); // 이슈 ID 초기화
	    $('#task-issue').css('display', 'none'); 
	    $('.task-request-div').css('display', 'none');
	    $('#taskStatusButton').css('display', 'none');
	    $(".taskSubmit").css('display', 'block');      
	    $(".taskDisabled").css('display', 'none');      
	    $('.taskIds').css('display', 'none');
	    
	    
	    $('.dev_selected').attr('style', 'display: none !important;');
	    $('.task-update-btn').attr('style', 'display: none !important;');
	   
	    taskHandler.updateFileCount(0); 
	    taskHandler.fileArray = []; 
		modalInfo().done(function() {
			$(".task-file-preview").empty(); // 미리보기 초기화
			$('#taskCreating').modal('show');
			taskManagerSelect(projectId);
			
			 let currentStepId = null;
		        
		        // 첫 번째 단계가 있는지 확인 후 현재 단계 ID 설정
		        if (stepData.length > 0) {
		            currentStepId = stepData[0].stepId;
		        }

		$('.task-step').on('change', function() {
            const selectedStepId = $(this).val();
            const selectedStep = stepData.find(step => step.stepId === selectedStepId);

            if (selectedStep) {
                // 상태 설정: 현재 단계인 경우 "진행 중", 이후 단계인 경우 "예정"
                if (selectedStepId !== currentStepId) {  // 현재 단계가 아닌 경우
                    taskStatus = '예정';
                } else {  // 현재 단계인 경우
                    taskStatus = '진행 중';
                }

                // 선택된 단계의 날짜 범위 업데이트
                $('.task-step-date-range').val(`${selectedStep.stepStartDate} - ${selectedStep.stepDueDate}`);
                $('#taskStepStartDate').val(selectedStep.stepStartDate);
                $('#taskStepDueDate').val(selectedStep.stepDueDate);
            }
        });

        // 기본값으로 첫 번째 단계의 상태와 날짜 범위 설정
        if (currentStepId) {
            $('.task-step').val(currentStepId).trigger('change');
            taskStatus = '진행 중'; // 기본 상태를 "진행 중"으로 설정
        }
        
        console.log(taskStatus);
    	});  
    });

    //수정모달
    $(".task-updateModal").on('click', function() {
        const urlParams = new URLSearchParams(location.search);
        projectId = urlParams.get('projectId');
        let taskId = $(this).data('task-id');
        console.log(taskId);
        getIssue(projectId, taskId);
        
        const taskIdForUpdate = $(this).data('task-id');
        openTaskUpdateModal(taskIdForUpdate, projectId)
    });

    function openTaskUpdateModal(taskId, projectId){
    		
        taskHandler.taskInit(true); // 모달 초기화
        $('.task-date-range').val('');
        $(".task-name").val("");
        $(".task-content").val("");
        $(".task-log").val("");
        $(".task-file-preview").empty();
        $("#taskPriority").val("").trigger("change");
        $(".task-request-div").css('display', 'none');
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
                let taskIssue = response.taskIssueList;
                currentStatus = taskInfo.taskState;
                console.log(response);
                const fileList = response.taskAttachList;            
                
                $(".task-name").val(taskInfo.taskName);                
                $("#taskId").val(taskInfo.taskId);                
                $(".task-step").val(taskInfo.taskStepId).trigger('change');
                $("#taskPriority").val(taskInfo.taskPriority);
                $(".task-pj-id").text(taskInfo.projectName);           
                $(".task-issue-id").text(taskIssue.issueId);                
                $(".task-issue-title").text(taskIssue.issueTitle);  
                $(".task-log").val(taskInfo.taskContent);
                $(".taskStartDate").val(taskInfo.taskStartDate);
                $(".taskDueDate").val(taskInfo.taskDueDate);
                $(".task-content").val(taskInfo.taskContent);
                $("#taskStatusButton").text(taskInfo.taskState);  
                $(".task-priority-option").val(taskInfo.taskPriority).trigger('change');  
                $("#taskId").val(taskInfo.taskId);
                $('#taskStatusButton').addClass('bg-info');
                $(".taskSubmit").css('display', 'none');             
                $(".taskDisabled").css('display', 'block');  
                
                $(".fmt-task-id").text(taskInfo.fmtTaskId);               
                
                
                taskIssue.forEach(issue => {
                    console.log(issue.issueId); 


                    if (issue.issueId != null) {
                        $('#task-issue').css('display', 'block');
                    }

                    if (issue.issueState === "해결") {
                        $(".task-issue-state-btn").text("해결");
                        $(".task-issue-state-btn").css("color", "#0C66E4");
                    } else {
                        $(".task-issue-state-btn").text("미해결");
                        $(".task-issue-state-btn").css("color", "#FF5959");
                    }
                });

                if (taskInfo.taskState === "완료") {
                    $('#taskStatusButton').removeClass("bg-warning bg-info bg-dark").addClass("bg-success").prop('disabled', false);
                } else if (taskInfo.taskState === "보류") {
                    $('#taskStatusButton').removeClass("bg-info bg-success bg-dark").addClass("bg-warning").prop('disabled', false);
                }else if (taskInfo.taskState === "예정") {
                    $('#taskStatusButton').removeClass("bg-info bg-success bg-warning").addClass("bg-dark").prop('disabled', false);
                }  else {
                    $('#taskStatusButton').removeClass("bg-success bg-warning bg-dark").addClass("bg-info").prop('disabled', false);
                }

                console.log(taskInfo.memberId != $('#selectedMemberId').val());
                console.log(taskInfo.projectEnabled)
                console.log(taskInfo.memberId )
                console.log( $('#selectedMemberId').val() );


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
                        		   <button class="border-0 bg-light" type="button" onclick="location.href='/flowmate/task/downloadFile?fileId=${file.fileId}'">${file.fileName}</button>
                                <button type="button" class="task-file-remove btn-close ms-2" data-index="task-${file.lastModified}" style="display:none;"></button>
        				            <button type="button" class="btn-download ms-2" onclick="location.href='downloadFile?fileId=${file.fileId}'" style="background-color:white; border:none; display: none;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-in-down" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M3.5 6a.5.5 0 0 0-.5.5v8a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-8a.5.5 0 0 0-.5-.5h-2a.5.5 0 0 1 0-1h2A1.5 1.5 0 0 1 14 6.5v8a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-8A1.5 1.5 0 0 1 3.5 5h2a.5.5 0 0 1 0 1z"/>
								  <path fill-rule="evenodd" d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
								</svg>				     	
							</button>	                          
                            </div>`
                        );
                    });
                }
                
                modalInfo().done(function() {
                    const existingStep = stepData.find(step => step.stepId === taskInfo.taskStepId);
                    if (taskInfo.projectEnabled != 1) {
                        disableEditing();
                    } else {
                        if (response.loginMemberRole.includes("ROLE_PM") || taskInfo.memberId === $('#selectedMemberId').val()) {
                            enableEditing(response); // 편집 모드 활성화
                        } else {
                            disableEditing(); // 읽기 전용 모드
                        }
                    }
                    // 현재 단계가 stepData에 없으면 추가 (과거 단계일 경우)
                    if (!existingStep) {
                        $('.task-step').append(
                            `<option value="${taskInfo.taskStepId}" selected>${taskInfo.stepName}</option>`
                        );
                        
                        stepData.push({
                            stepId: taskInfo.taskStepId,
                            stepName: taskInfo.taskStepName,
                            stepStartDate: moment(taskInfo.stepStartDate, 'YYYYMMDDHHmmss').format('YYYY/MM/DD'),
                            stepDueDate: moment(taskInfo.stepDueDate, 'YYYYMMDDHHmmss').format('YYYY/MM/DD')
                        });
                    }               	
                    	
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
                    
                    if (stepData.length > 0) {
                        // 첫 번째 단계가 있는지 확인 후 현재 단계 ID 설정
                        currentStepId = stepData[0].stepId;
                    }
                    taskStatus = taskInfo.taskState ;
                    console.log(taskInfo.taskState)
                    $("#taskStatusButton").text(taskStatus);
                    $(".task-step").val(taskInfo.taskStepId).trigger('change');
                   
                    // 단계 선택 시 현재 또는 이후 단계에 따라 상태 설정
                    $('.task-step').on('change', function() {
                        const selectedStepId = $(this).val();
                        const selectedStep = stepData.find(step => step.stepId === selectedStepId);
                        console.log("Current Step ID:", currentStepId);
                        console.log("Selected Step ID:", selectedStepId);
                        if (selectedStep) {
                            if (taskStatus !== '완료' && taskStatus !== '보류') {
                                taskStatus = (selectedStepId === currentStepId) ? '진행 중' : '예정';
                            }

                            // 선택된 단계의 날짜 범위 업데이트
                            $('.task-step-date-range').val(`${selectedStep.stepStartDate} - ${selectedStep.stepDueDate}`);
                            $('#taskStepStartDate').val(selectedStep.stepStartDate);
                            $('#taskStepDueDate').val(selectedStep.stepDueDate);                        
                        }
                    });
                });
	            	$('.task-request').on('keyup', function() {	            		
	            	    $('#taskRequestLength').text($(this).val().length);
	            	});
                
	             // 드롭다운 상태 버튼에 기본값 표시
	             $('#taskStatusButton').text(taskStatus);

	             // 상태를 사용자가 선택하도록 설정
	             $('#taskStatusButton').on('click', function() {
	                 taskStatus = $(this).text(); // 현재 선택한 상태로 taskStatus 설정

	                 console.log(taskStatus);
	             });
                console.log(taskStatus);
                taskHandler.updateFileCount(fileList.length);
                // 기존 daterangepicker 인스턴스 제거
                console.log(taskInfo.stepName);
                console.log(taskInfo.taskStepId);
                $('.task-step-date').empty();
                $(".task-step").val(taskInfo.taskStepId).trigger('change'); 
                
                let taskStartDate = moment(taskInfo.taskStartDate, 'YYYYMMDDHHmmss');
                let taskDueDate = moment(taskInfo.taskDueDate, 'YYYYMMDDHHmmss');

                console.log(taskStartDate.format('YYYY/MM/DD'));
                // 초기값으로 보이는 날짜 범위 설정
                $('.task-date-range').val(taskStartDate.format('YYYY/MM/DD') + ' - ' + taskDueDate.format('YYYY/MM/DD'));
            }
        });
        
        // 상태 버튼 클릭 시 색상 및 표시 변경
        $('[id$=taskStatus]').on('click', function() {
            const selectedStatus = $(this).data('status');
            const color = $(this).data('color');
            const taskId = $('#taskId').val();
            const urlParams = new URLSearchParams(location.search);
            const projectId = urlParams.get('projectId');
            console.log(selectedStatus);
            taskStatus = selectedStatus;
            console.log(currentStatus);
            
            $('#selectedStatusInput').val(selectedStatus);
            
            $.ajax({
                url: '/flowmate/approval/isApprRequested',
                method: 'GET',
                data: { taskId: taskId },
                success: function(response) {
                	console.log('ajax실행');
                	console.log(response);
                    if (response === false) {
                        $('.task-request-div').css('display', 'none');
                        Toast.fire({
                            icon: 'error',
                            title: '이미 결재 요청을 보내셨습니다.'
                        });                        
                    } else {                    	
                        $('#taskStatusButton')
                        .text(selectedStatus)
                        .removeClass('bg-info bg-warning bg-success bg-dark')
                        .addClass(`bg-${color}`);

                        $('.task-request-div').css('display', 'block');
                    }
                },
                error: function(error) {
                    console.error(error);
                    Toast.fire({
                        icon: 'error',
                        title: '결재 요청 상태를 확인하는 데 실패했습니다.'
                    });
                }
            });            	
            
            if (selectedStatus !== currentStatus) {
               $('.task-request-div').css('display', 'block');
            } else {
                $('.task-request-div').css('display', 'none ');
            }
        });
        
        $('.task-step').on('change', updateDateRangeStep);
        $('.taskUpdateModal').css('display', 'block');
        $('.dev_selected').css('display', 'block');
        $('#taskStatusButton').css('display', 'block');
        $('.task-update-btn').css('display', 'block');
        $('.taskIds').css('display', 'block');
        $('.task-file-remove').css('display', 'block');
        console.log( $('.task-file-remove'));
        }
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

    // 기본 값 설정
    // 시작 및 종료 날짜 값이 없다면 기본값 설정
    
    const dateRange = $('.task-date-range').val();

    const dates = dateRange.split(" - ");
    let taskStartDate = $('#taskStartDate').val(moment(dates[0], 'YYYY/MM/DD').format('YYYYMMDDHHmmss'));
    let taskDueDate = $('#taskDueDate').val(moment(dates[1], 'YYYY/MM/DD').format('YYYYMMDDHHmmss'));

    let stepStartDate = moment($("#taskStepStartDate").val(), 'YYYYMMDDHHmmss').format('YYYYMMDDHHmmss');
    let stepDueDate = moment($('#taskStepDueDate').val(), 'YYYYMMDDHHmmss').format('YYYYMMDDHHmmss');
       
    console.log(taskStartDate);
    console.log(taskDueDate);
    console.log($('#taskStartDate').val());
    console.log($('#taskDueDate').val());
    console.log(stepStartDate);
    console.log(stepDueDate);
    
    if ($('#taskStartDate').val() >= stepStartDate && $('#taskDueDate').val() <= stepDueDate) {
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
		        		let maxSize = 20 * 1024 * 1024;
		            const files = Array.from(this.files);
		            files.forEach(file => {
		                // 파일 크기 확인
		                if (file.size > maxSize) {
		                    Toast.fire({
		                        icon: 'error',
		                        title: file.name + '의 용량이 20MB를 초과했습니다.',
		                    });
		                    return;
		                }

		                // 파일 개수 확인
		                if ((isUpdate ? taskHandler.newFileArray.length + taskHandler.fileArray.length : taskHandler.fileArray.length) >= 3) {
		                    Toast.fire({
		                        icon: 'error',
		                        title: '첨부파일은 3개까지 첨부 가능합니다.',
		                    });
		                    return false; // 파일이 초과되었을 경우 추가하지 않음
		                }
		            	
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
		                       <span class="taskFileDown"> ${file.name}</span>
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
        formData.append("taskState", taskStatus);
        formData.append("taskStepId", $(".task-step").val());
        formData.append("projectId", projectId);
        formData.append("taskStartDate", $("#taskStartDate").val());
        formData.append("taskDueDate", $("#taskDueDate").val());
        console.log(taskDueDate);
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
    Swal.fire({
        title: '작업을 수정하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '확인',
        cancelButtonText: '취소',
        reverseButtons: true,
    }).then((result) => {
        if (result.isConfirmed) {
        	taskHandler.sendTaskData(true);
        }
    });
});

$(document).on('click', '.taskDisabled', function () {
    Swal.fire({
        title: '작업을 비활성화 하시겠습니까?',
        text: '비활성화된 작업은  생성 및 수정이 불가능합니다.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonText: '확인',
        cancelButtonText: '취소',
        reverseButtons: true,
    }).then((result) => {
        if (result.isConfirmed) {
            // 사용자가 확인을 눌렀을 때만 AJAX 요청을 실행
            $.ajax({
                url: '/flowmate/task/taskDisabled',
                type: 'post',
                data: { taskId: $('#taskId').val(), projectId },
                success: function() {
                    Toast.fire({
                        icon: 'success',
                        title: '작업이 비활성화되었습니다.',
                        timer: 2000,
                    });
                    setTimeout(function() {
                        location.href = "/flowmate/project/projectBoard?projectId=" + encodeURIComponent(projectId);
                    }, 2000);
                },
                error: function() {
                    // 에러 발생 시
                    Toast.fire({
                        icon: 'error',
                        title: '비활성화 처리 중 오류가 발생했습니다.',
                    });
                }
            });
        }
    });
});

function enableEditing(response = {}) {
    $('.task-name').prop('disabled', false);
    $('.task-content').prop('disabled', false);
    $('.task-log').prop('disabled', false);
    $('.task-file-input').prop('disabled', false);
    $('.task-step').prop('disabled', false);
    $('.task-priority-option').prop('disabled', false);
    $('#taskStatusButton').prop('disabled', false);
    $('.taskSubmit').prop('disabled', false);
   
    $('.task-update-btn').prop('disabled', false);
    $('.task-add-attachment').prop('disabled', false);
    $('.task-add-issue').prop('disabled', false);
    $('.task-file-input-btn').prop('disabled', false);
    $('.task-manager-select').prop('disabled', false);
    $('.task-date-range').prop('disabled', false);
    $('.task-file-remove').css('display', 'block');
    $('.btn-download').css('display', 'none');
    $('.task-file-input-btn').prop('disabled', false).css('display', 'block');
    $('.task-add-attachment').prop('disabled', false).css('display', 'block');
    $('.task-update-btn').prop('disabled', false).css('display', 'block');
    
    if ($('.dev_selected').data('role') === 'DEV') {
    		$('.dev_selected').attr('style', 'display: block ;');
    		$('.task-manager-select').prop('disabled', true);
    		
    } else {
    		$('.dev_selected').attr('style', 'display: none !important;');
    }
    
    if (response.loginMemberRole && response.loginMemberRole.includes("ROLE_PM")) {
        console.log("User has ROLE_PM");
        $('.taskDisabled').prop('disabled', false);
    } 
   
}

function disableEditing() {
    $('.task-name').prop('disabled', true);
    $('.task-content').prop('disabled', true);
    $('.task-log').prop('disabled', true);
    $('.task-file-input').prop('disabled', true);
    $('.task-step').prop('disabled', true);
    $('.task-priority-option').prop('disabled', true);
    $('#taskStatusButton').prop('disabled', true).css('opacity','1');
    $('.taskSubmit').prop('disabled', true);
    $('.task-update-btn').prop('disabled', true);
    $('.task-add-attachment').prop('disabled', true);
    $('.task-add-issue').prop('disabled', true);
    $('.task-file-input-btn').prop('disabled', true);
    $('.taskDisabled').prop('disabled', true);
    $('.task-manager-select').prop('disabled', true);
    $('.task-date-range').prop('disabled', true);
    $('.task-manager-select').prop('disabled', true);
    $('.task-file-remove').prop('disabled', true).css('display', 'none');
    $('.btn-download').css('display', 'block');
    $('.task-file-input-btn').prop('disabled', true).css('display', 'none');
    $('.task-add-attachment').prop('disabled', true).css('display', 'none');
    $('.task-update-btn').prop('disabled', true).css('display', 'none');

}

$(document).ready(function() {
	$('.table').DataTable({
		searching: false,
		"lengthChange": false, 
		 "pageLength": 10  
	});

});

//datatables
$(document).ready(function() {
    // DataTable 초기화 여부 확인 및 초기화
    if ($.fn.DataTable.isDataTable('#proTaskList')) {
        $('#proTaskList').DataTable().destroy();
    }

    // 테이블 헤더의 텍스트를 기반으로 columns 설정 자동 생성
    let columns = $('#proTaskList thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let table = $('#proTaskList').DataTable({
        order: [5, 'asc'],
        orderClasses: true,
        columns: columns,
        initComplete: function() {
            let tableApi = this.api();

            // '상태' 열 (index 6)
            tableApi.columns([2]).every(function() {
                let column = this;
                let dropdown = $('#dropdown-step');
                dropdown.append(`<li><a class="dropdown-item" href="#">전체</a></li>`);
                
                column.data().unique().sort().each(function(d) {
                    dropdown.append(`<li><a class="dropdown-item" href="#" data-value="${d}">${d}</a></li>`);
                });
                
                dropdown.on('click', '.dropdown-item', function(e) {
                    e.preventDefault();
                    const dropdownVal = $(this).data('value');
                    if (dropdownVal === '전체') {
                        column.search('').draw();
                    } else {
                        column.search(dropdownVal ? dropdownVal : '', true, false).draw();
                    }
                });
            });

            // '우선순위' 열 (index 6)
            tableApi.columns([6]).every(function() {
                let column = this;
                let dropdown = $('#dropdown-priority');
                dropdown.append(`<li><a class="dropdown-item" href="#" data-value="전체">전체</a></li>`);

                column.data().unique().sort().each(function(d) {
                    let priority = $("<div>").html(d).text().trim();
                    if (priority === '높음') {
                        dropdown.append(`<li><a class="dropdown-item" href="#" data-value='${priority}'>
                            <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" fill="currentColor" stroke="#FF7D04" class="bi bi-arrow-up" viewBox="0 0 16 16">
                                <path fill-rule="evenodd" d="M8 15a.5.5 0 0 0 .5-.5V2.707l3.146 3.147a.5.5 0 0 0-.708-.708l-4-4a.5.5 0 0 0-.708 0l-4 4a.5.5 0 1 0 .708.708L7.5 2.707V14.5a.5.5 0 0 0 .5.5"/>
                            </svg> <span class="text-warning">${priority}</span>
                        </a></li>`);
                    } else if (priority === '긴급') {
                        dropdown.append(`<li><a class="dropdown-item" href="#" data-value='${priority}'>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="#EC1E1E" class="bi bi-brightness-alt-high-fill" viewBox="0 0 16 16">
                                <path d="M8 3a.5.5 0 0 1 .5.5v2a.5.5 0 0 1-1 0v-2A.5.5 0 0 1 8 3m8 8a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1 0-1h2a.5.5 0 0 1 .5.5m-13.5.5a.5.5 0 0 0 0-1h-2a.5.5 0 0 0 0 1zm11.157-6.157a.5.5 0 0 1 0 .707l-1.414 1.414a.5.5 0 1 1-.707-.707l1.414-1.414a.5.5 0 0 1 .707 0m-9.9 2.121a.5.5 0 0 0 .707-.707L3.05 5.343a.5.5 0 1 0-.707.707zM8 7a4 4 0 0 0-4 4 .5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5 4 4 0 0 0-4-4"/>
                            </svg> <span class="text-danger">${priority}</span>
                        </a></li>`);
                    } else {
                        dropdown.append(`<li><a class="dropdown-item" href="#" data-value='${priority}'>${priority}</a></li>`);
                    }
                });

                dropdown.on('click', '.dropdown-item', function(e) {
                    e.preventDefault();
                    const dropdownVal = $(this).data('value');
                    if (dropdownVal === '전체') {
                        column.search('').draw();
                    } else {
                        column.search(dropdownVal ? dropdownVal : '', true, false).draw();
                    }
                });
            });
        },
        columnDefs: [
            { targets: [0], render: function(data, type, row) { return type === 'sort' || type === 'type' ? parseInt(data.split('-')[1], 10) : data; }},
            { targets: [1, 2, 3, 6], orderable: false }
        ],
        createdRow: function(row, data, dataIndex) {
            let taskId = $(row).find('.taskId').val();
            let projectId = $(row).find('.taskProjectId').val();
            console.log(taskId)
            console.log(projectId)
	      	  $(row).find('td').eq(0).on('click', function() {
	              window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId + '&taskId=' + taskId;
	          });
	          
	          $(row).find('td').eq(1).on('click', function() {
	              window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId + '&taskId=' + taskId;
	          });
        }
    });
    
    let columnIndex = 1; // 기본 select 옵션 값인 "프로젝트명" 컬럼의 인덱스

    $('#taskSelect').on('change', function() {
        var selectedOption = $(this).val();
        columnIndex = table.columns().eq(0).filter(function(index) {
            return table.column(index).dataSrc() === selectedOption;
        })[0];
        
        var searchTerm = $('#proTaskInput').val();
        table.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm);
            } else {
                this.search('');
            }
        });
        table.draw();
    });

    $('#proTaskInput').on('input keyup', function() {
        var searchTerm = this.value;
        table.column(columnIndex).search(searchTerm).draw();
    });
});