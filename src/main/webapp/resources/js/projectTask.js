
$(document).ready(function() {
    let Tasktable = $('.table').DataTable({
        paging: false,
        ordering: true,
        info: false,             
        searching: false,        
        lengthChange: false,
        columnDefs: [
            {
                targets: [0, 1, 2, 3, 6],
                orderable: false 
            }
        ]
    });
    
    
    let currentStatus;
    // 시작일과 마감일 아이콘 클릭 시 정렬
    $('.dateSort').on('click', function() {
        var column = $(this).data('column');
        var currentOrder = Tasktable.order();

        if (currentOrder.length && currentOrder[0][0] === column && currentOrder[0][1] === 'asc') {
            Tasktable.order([column, 'desc']).draw();
        } else {
            Tasktable.order([column, 'asc']).draw();
        }
    });
    
    $(".task-updateModal").on('click', function() {
        const urlParams = new URLSearchParams(location.search);
        projectId = urlParams.get('projectId');
        let taskId = $(this).data('task-id');
        console.log(taskId);
        $(".task-name").val("");
        $(".task-content").val("");
        $(".task-log").val("");
        $("#taskPriority").val("").trigger("change");
        $(".task-issue-state-btn").text("미해결").css("color", "#FF5959");
        $(".task-issue-id").text("");
        $('#task-issue').css('display', 'none'); 
       
        
        
        $.ajax({
            url: '/flowmate/task/getTaskUpdateModalInfo',
            method: 'get',
            data: { taskId, projectId },
            success: function(response) {
            	console.log(response);
            	console.log(response[0].issueId);
                // 응답 데이터를 기반으로 모달 내 필드 업데이트
                $(".task-name").val(response[0].taskName);                
                $("#taskId").val(response[0].taskId);                
                $("#taskDueDate").val(response[0].taskDueDate);
                $("#taskPriority").val(response[0].taskPriority);
                $(".task-step").val(response[0].stepName).trigger('change');                
                $(".task-issue-id").text(response[0].issueId);                
                $(".task-issue-title").text(response[0].issueTitle);  
                $(".task-log").val(response[0].taskContent);
                $(".task-content").val(response[0].taskContent);
                $("#taskStatusButton").text(response[0].taskState);  
                $(".task-priority-option").val(response[0].taskPriority).trigger('change');  
                $("#taskId").val(response[0].taskId);
                $('#taskStatusButton').addClass('bg-info');
                $(".taskSubmit").text("비활성화").removeClass("taskSubmit").addClass("taskDisabled");
                
                $(".task-step").val(response[0].stepName);
                
                if(response[0].issueId != null){
                		$('#task-issue').css('display', 'block');
                }
                
                if (response[0].issueState === "해결") {
                    $(".task-issue-state-btn").text("해결");
                    $(".task-issue-state-btn").css("color", "#0C66E4");
                } else {
                    $(".task-issue-state-btn").text("미해결");
                    $(".task-issue-state-btn").css("color", "#FF5959");
                }
                
                if (response[0].taskState === "완료") {
                    $('#taskStatusButton')
                        .removeClass("bg-warning bg-info")
                        .addClass("bg-success");
                } else if (response[0].taskState === "보류") {
                    $('#taskStatusButton')
                        .removeClass("bg-info bg-success")
                        .addClass("bg-warning");
                } else {
                    $('#taskStatusButton')
                        .removeClass("bg-success bg-warning")
                        .addClass("bg-info");
                }

                currentStatus = response[0].taskState;

                $.ajax({
                    url: '/flowmate/task/taskModalInfo',
                    method: 'get',
                    data: { projectId: projectId },
                    success: function(response) {
                        stepData = response;
                        $('.task-step').empty();

                        response.forEach(function(step) {
                            $('.task-step').append('<option value="' + step.stepId + '" >' + step.stepName + '</option>');
                        });
                        
                        console.log(stepData)
                        
                        // 기본 날짜 설정
                        if (stepData.length > 0) {
                            const firstStep = stepData[0];
                            $('.task-step-date-range').val(firstStep.stepStartDate + ' - ' + firstStep.stepDueDate);
                            $('#taskStepStartDate').val(firstStep.stepStartDate);
                            $('#taskStepDueDate').val(firstStep.stepDueDate);
                        }

                        $('#taskCreating').modal('show');
                    }
                    
                    
                    
                });

                
                
            }
        });

          
            // 단계 선택 시마다 기간 변경
            $('.task-step').on('change', function() {
                const selectedStepId = $(this).val();
                const selectedStep = stepData.find(step => step.stepId === selectedStepId);

                if (selectedStep) {
                    $('.task-step-date-range').val(selectedStep.stepStartDate + ' - ' + selectedStep.stepDueDate);
                    $('#taskStepStartDate').val(selectedStep.stepStartDate);
                    $('#taskStepDueDate').val(selectedStep.stepDueDate);
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
            
            
        
        $('.taskUpdateModal').css('display', 'block');
        $('#taskStatusButton').css('display', 'block');
        $('.task-update-btn').css('display', 'block');
        
    });
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
        		console.log("비활성화")
 
        }
    });


});
