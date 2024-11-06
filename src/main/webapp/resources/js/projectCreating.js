const addTaskStepBtn = $('.add-task-step-btn').detach();

function removeTaskStepBtn(mode) {
	const stepCnt = $('.project-steps').find('.project-step-select').length;
	if (stepCnt < 5) {
		if (!$('.add-task-step-btn').length) {
            $('.project-steps').append(addTaskStepBtn);
        }
	} else {
		$('.add-task-step-btn').remove();
	}
	if (mode == 'read') {
		$('.add-task-step-btn').remove();
	}
};

function getMembers(mode, editProjectMemberIdList) {
	$.ajax({
        url: '../../flowmate/project/getMembers',
        dataType: 'json',
        success: function(data) {
            // 각 부서별로 그룹화된 데이터를 생성
            var groupedResults = {};
            data.members.forEach(function(member) {
                var groupName = member.memberDept;  // 부서명을 기준으로 그룹화
                if (!groupedResults[groupName]) {
                    groupedResults[groupName] = [];
                }
                groupedResults[groupName].push({
                    id: member.memberId,
                    text: member.memberName + ' ' + member.memberRank
                });
            });
            
            var results = Object.keys(groupedResults).map(function(groupName) {
                return {
                    text: groupName,  // optgroup 라벨
                    children: groupedResults[groupName]  // 해당 그룹에 속한 멤버 리스트
                };
            });
            
            $('.project-team-select').select2().empty().select2({
                data: results,
                width: '100%',
                placeholder: '할당되지 않음',
                allowClear: true,
                dropdownParent: $('#projectCreating'),
                closeOnSelect: false,
            });
            
            if (mode != 'create') {
            	$('.project-team-select').val(editProjectMemberIdList).trigger('change');
            }
            
            if (mode == 'read') {
            	$('span[aria-hidden="true"]').hide();
            	$('.select2-selection__choice').each(function() {
            		$(this).css('padding-left', '5px');
            	});
            } else {
            	$('span[aria-hidden="true"]').show();
            	$('.select2-selection__choice').each(function() {
            		$(this).css('padding-left', '');
            	});
            }
        }
    });
}

function setSelectAndDate() {	
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
        "drops": "auto"
    });
};

function setProjectSteps() {
    const projectStepsContainer = $('.project-steps'); 
    projectStepsContainer.empty();
    const stepNames = ["분석", "설계", "개발", "테스트", "이행"];

    stepNames.forEach((step, index) => {
        const options = stepNames.map(name => `
	        <option ${name === step ? 'selected' : ''}>${name}</option>
	    `).join('');
        
        const stepDiv = `
            <div class="project-step-select d-flex align-items-center ${index > 0 ? 'mt-1' : ''} w-100">
                <select class="project-step">
                	${options} 
                </select>
                <input type="text" class="task-range" name="daterangepicker" id="daterangepicker" placeholder="날짜를 선택하세요"/>
                <button class="btn btn-sm delete-step ms-1 btn-close project-step-close"></button>
            </div>
        `;
        projectStepsContainer.append(stepDiv); 
    });

    const addTaskStepBtn = `
        <div class="add-task-step-btn d-flex align-items-center mt-1 w-100">
            <button type="button" class="add-task-step btn flex-fill">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                </svg>
                단계 추가
            </button>
            <button class="btn btn-sm delete-step ms-1 btn-close project-step-close" style="visibility: hidden;"></button>
        </div>
    `;

    projectStepsContainer.append(addTaskStepBtn);

    $('.project-steps .project-step-select:first-child .project-step-close').css('visibility', 'hidden');

    setSelectAndDate();
    removeTaskStepBtn();
}

function renderProjectSteps(stepsData, mode) {
	const stepNames = stepsData.map(step => step.stepName);
    const projectStepsContainer = $('.project-steps'); 
    projectStepsContainer.empty();

    stepsData.forEach(stepData => {
        const options = stepNames.map(step => `
	        <option ${stepData.stepName === step ? 'selected' : ''}>${step}</option>
	    `).join('');
        const stepDiv = `
            <div class="project-step-select d-flex align-items-center mt-1 w-100">
                <select class="project-step" data-step-id="${stepData.stepId}">
                	${options} 
                </select>
                <input type="text" class="task-range" name="daterangepicker" id="daterangepicker" placeholder="날짜를 선택하세요"/>
                <button class="btn btn-sm delete-step ms-1 btn-close project-step-close"></button>
            </div>
        `;
        projectStepsContainer.append(stepDiv); 
    });

    const addTaskStepBtn = `
        <div class="add-task-step-btn d-flex align-items-center mt-1 w-100">
            <button type="button" class="add-task-step btn flex-fill">
                <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                    <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                </svg>
                단계 추가
            </button>
            <button class="btn btn-sm delete-step ms-1 btn-close project-step-close" style="visibility: hidden;"></button>
        </div>
    `;
    
    projectStepsContainer.append(addTaskStepBtn); 
    
    setSelectAndDate();
    $('.project-steps .project-step-select:first-child .project-step-close').css('visibility', 'hidden');
    removeTaskStepBtn(mode);
    
    $('.task-range').each(function(index) {
        const startDate = moment(stepsData[index].stepStartDate, 'YYYYMMDDHHmmss');
        const dueDate = moment(stepsData[index].stepDueDate, 'YYYYMMDDHHmmss');
        $(this).data('daterangepicker').setStartDate(startDate);
        $(this).data('daterangepicker').setEndDate(dueDate);
    });
    
    if (mode == 'read') {
    	$('.project-step').each(function() {
    		$(this).prop('disabled', true);
    	});
		$('.task-range').each(function() {
            $(this).attr('readonly', true).css('pointer-events', 'none');
        });
		$('.project-step-close').each(function() {
			$(this).hide();
		});
    } else {
    	$('.project-step').each(function() {
    		$(this).prop('disabled', false);
    	});
	    $('.task-range').each(function() {
            $(this).removeAttr('readonly').css('pointer-events', 'auto');
        });
		$('.project-step-close').each(function() {
			$(this).show();
		});
    }
}

const fileHandler = {		
		fileArray : [],
		
		deleteFileArray : [],
		
		isEditing: false,
		
		init(projectId, mode) {
			this.updateFileInput();
			const fileInput = $('.project-file-input');
			const preview = $('.file-preview');
			
			if (this.isEditing) {
				this.loadFiles(projectId, mode); 
			}
			
			fileInput.on('change', (e) => {
				let maxSize = 20 * 1024 * 1024;
				const files = Array.from(e.target.files);
				files.some(file => {
					let fileSize = file.size;
					if (fileSize > maxSize) {
						Toast.fire({
		    				  icon: 'error',                   
		    				  title: file.name + '의 용량이 20MB를 초과했습니다.',
		    			});
		    			return false;
					}
					if (!this.fileArray.some(f => f.lastModified === file.lastModified)) {
						if (this.fileArray.length >= 3) {
							Toast.fire({
								  icon: 'error',                   
								  title: '첨부파일은 3개까지 첨부 가능합니다.',
							});
							return false;
						}
	                    this.fileArray.push(file);
						preview.append(
							`<div class="project-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="project-${file.lastModified}">
								${file.name}
								<button type="button" class="file-remove btn-close ms-2" data-index="project-${file.lastModified}"></button>
							</div>`);
					}
				});
				this.updateFileInput();
				$('.project-files-length').text($('.file-preview').find('.project-file').length);
			});
		},
		
		loadFiles(projectId, mode) {
			$.ajax({
				url: '../../flowmate/project/getProjectFiles',
				data: {projectId: projectId},
				success: (files) => {			
					const preview = $('.file-preview');
					this.fileArray = []; 
					files.forEach(file => {
						const lastModified = Date.now();
						projectFile = new File([new Blob([file.fileData], {type: file.fileType})], file.fileName, {
			                type: file.fileType,
			                lastModified: lastModified
			            });
						this.fileArray.push(projectFile);
	                    if (mode == 'read') {
							preview.append(
									`<div class="project-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
										${file.fileName}
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="project-file-down-btn bi bi-download ms-2" viewBox="0 0 16 16" data-file-id="${file.fileId}">
											<path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"/>
											<path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
										</svg>
									</div>`);	                    
						} else {
							preview.append(
									`<div class="project-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
										${file.fileName}
										<button type="button" class="file-remove btn-close ms-2" data-index="project-${lastModified}" data-file-id="${file.fileId}"></button>
									</div>`)
						}
					});
					this.updateFileInput();
					$('.project-files-length').text($('.file-preview').find('.project-file').length);
				},
			});
		},
		 
		removeFile() {
			$(document).on('click', (e) => {
				if (!$(e.target).hasClass('file-remove')) return;
				const removeTargetId = $(e.target).data('index');
				const files = $('.project-file-input')[0].files;
				let removeTarget;
				const fileId = $(e.target).data('fileId');
				if (fileId) {
					removeTarget = $('#' + fileId);
		            if (!this.deleteFileArray.includes(fileId)) {
		                this.deleteFileArray.push(fileId);
		            }
				} else {
					removeTarget = $('#' + removeTargetId);
				}
				this.fileArray = this.fileArray.filter(file => `project-${file.lastModified}` !== removeTargetId);
				this.updateFileInput();
		        removeTarget.remove();
		        $('.project-files-length').text($('.file-preview').find('.project-file').length);
			});
		},
		
	    updateFileInput() {
	        const dataTransfer = new DataTransfer();
	        this.fileArray.forEach(file => {
	            dataTransfer.items.add(file);
	        });
	        $('.project-file-input')[0].files = dataTransfer.files; 
	    }
};

function getProjectStatusDropdown(mode, status) {
    const dropdown = $('.project-status-dropdown');
    
    if (mode === 'edit') {
        dropdown.show();
        $('#projectBtn').show();
        $('#projectBtn').addClass('ms-auto');
        $('#projectStatus[data-status="' + status + '"]').trigger('click', [true]); 
        $('#projectBtn').text('수정');
        $('#projectBtn').removeClass('project-creating-btn').addClass('project-editing-btn');
        $('#projectDeactivateBtn').css('visibility', 'visible');
        $('.add-attachment').show();
        $('.file-input-btn').show();
    } else if (mode === 'create') {
        dropdown.hide();
        $('#projectBtn').show();
        $('#projectBtn').removeClass('ms-auto');
        $('#projectBtn').text('프로젝트 생성');
        $('#projectBtn').removeClass('project-editing-btn').addClass('project-creating-btn');
        $('#projectDeactivateBtn').css('visibility', 'hidden');
        $('.add-attachment').show();
        $('.file-input-btn').show();
    } else if (mode === 'read') {
    	dropdown.show();
    	$('#projectBtn').hide();
    	$('#projectStatus[data-status="' + status + '"]').trigger('click', [true]); 
    	$('#projectDeactivateBtn').css('visibility', 'hidden');
    	$('.add-attachment').hide();
    	$('.file-input-btn').hide();
    }
}

function projectCreating() {	
	let projectName = $('.project-name').val().trim();
	if (projectName == '') {
		Toast.fire({
			  icon: 'error',                   
			  title: '프로젝트 제목 입력은 필수입니다.',
		});
		return;
	}
	let projectStartDate = $('.project-range').data('daterangepicker').startDate.format('YYYYMMDDHHmmss');
	let projectDueDate = $('.project-range').data('daterangepicker').endDate.format('YYYYMMDDHHmmss');
	let projectContent = $('.project-content').val().trim();
	let projectMemberList = $('.project-team-select').val() || [];
	let projectFiles = $('.project-file-input')[0].files;
	let stepList = [];
	
	let projectStepStatus = false;
	let stepBeforeDueDate = projectStartDate;
	$('.project-step').each(function() {
		let stepName = $(this).find(':selected').text();
		let stepStartDate = $(this).siblings('.task-range').data('daterangepicker').startDate.format('YYYYMMDDHHmmss');
		let stepDueDate = $(this).siblings('.task-range').data('daterangepicker').endDate.format('YYYYMMDDHHmmss');
		if (stepStartDate < projectStartDate || stepDueDate > projectDueDate) {
			Toast.fire({
				  icon: 'error',                   
				  title: stepName + ' 단계의 기간이 프로젝트 기간 범위를 벗어납니다.',
			});
			projectStepStatus = true;
			return false;
		}
		if (stepBeforeDueDate > stepStartDate) {
			Toast.fire({
				  icon: 'error',                   
				  title: stepName + ' 단계의 시작 시점은 이전 단계 종료 시점 이후여야 합니다. ',
			});
			projectStepStatus = true;
			return false;
		} else {
			stepBeforeDueDate = stepDueDate;
		}
		stepList.push({'stepName' : stepName, 'stepStartDate' : stepStartDate, 'stepDueDate' : stepDueDate});
	});
	
	if (projectStepStatus) {
		return;
	}

	let projectData = {};
	projectData['projectName'] = projectName;
	projectData['projectStartDate'] = projectStartDate;
	projectData['projectDueDate'] = projectDueDate;
	projectData['projectContent'] = projectContent;
	
	let formData = new FormData();
	formData.append('projectData', new Blob([JSON.stringify(projectData)], { type: 'application/json' })); 
	formData.append('projectMemberList', new Blob([JSON.stringify(projectMemberList)], { type: 'application/json' }));
	formData.append('projectStepList', new Blob([JSON.stringify(stepList)], { type: 'application/json' })); 
	
    Array.from(projectFiles).forEach(file => {
    	formData.append('projectFiles', file);
    });
    	
	$.ajax({
		url: '../../flowmate/project/createProject',
		type: 'POST',
		processData: false,
		contentType: false,
		data: formData,
		success: function(response) {
			$('#projectCreating').modal('hide');
			window.location.href = "../../flowmate/project/projectBoard?projectId=" + response;
		},
		error: function(response) {
			console.log('프로젝트 생성 실패');
		}
	});
}

function updateFiles(projectId, projectFiles, deleteFileList) {
    let formData = new FormData();
    let projectNewFiles = Array.from(projectFiles);
    
    $('.project-file').each(function() {
        let fileId = $(this).find('.file-remove').data('fileId'); 
        let removeTargetId = $(this).find('.file-remove').data('index');
        if (fileId) { 
        	projectNewFiles = projectNewFiles.filter(file => `project-${file.lastModified}` !== removeTargetId);
        }
    });

    if (deleteFileList.length > 0) {
    	formData.append('deleteFileList', new Blob([JSON.stringify(deleteFileList)], { type: 'application/json' })); 
    }
    
    formData.append('projectId', projectId);
    
	projectNewFiles.forEach(file => {
    	formData.append('projectNewFiles', file);
    });
	
    $.ajax({
        url: '../../flowmate/project/updateProjectNewFiles',
        type: 'POST',
        processData: false, 
        contentType: false,
        data: formData,
        success: function(response) {
        	console.log('수정 파일 DB 작업 완료');
        }
    });
    
    return true;
}

function updateMembers(projectId) {
	let projectMemberList = $('.project-team-select').val() || [];
	let formData = new FormData();
	formData.append('projectMemberList', new Blob([JSON.stringify(projectMemberList)], { type: 'application/json' }));
	formData.append('projectId', projectId);
    $.ajax({
        url: '../../flowmate/project/updateProjectNewMembers',
        type: 'POST',
        processData: false, 
        contentType: false,
        data: formData,
        success: function(response) {
        	console.log('비활성 멤버 & 신규 멤버 DB 작업 완료');
        }
    });
    
    return true;
}

function updateProjectSteps(projectId) {
	let projectStartDate = $('.project-range').data('daterangepicker').startDate.format('YYYYMMDDHHmmss');
	let projectDueDate = $('.project-range').data('daterangepicker').endDate.format('YYYYMMDDHHmmss');
	let stepList = [];
	let projectStepStatus = false;
	let stepBeforeDueDate = projectStartDate;
	$('.project-step').each(function() {
		let stepId = $(this).data('stepId');
		let stepName = $(this).find(':selected').text();
		let stepStartDate = $(this).siblings('.task-range').data('daterangepicker').startDate.format('YYYYMMDDHHmmss');
		let stepDueDate = $(this).siblings('.task-range').data('daterangepicker').endDate.format('YYYYMMDDHHmmss');
		if (stepStartDate < projectStartDate || stepDueDate > projectDueDate) {
			Toast.fire({
				  icon: 'error',                   
				  title: stepName + ' 단계의 기간이 프로젝트 기간 범위를 벗어납니다.',
			});
			projectStepStatus = true;
			return false;
		}
		if (stepBeforeDueDate > stepStartDate) {
			Toast.fire({
				  icon: 'error',                   
				  title: stepName + ' 단계의 시작 시점은 이전 단계 종료 시점 이후여야 합니다.',
			});
			projectStepStatus = true;
			return false;
		} else {
			stepBeforeDueDate = stepDueDate;
		}
		stepList.push({'stepId': stepId, 'stepName' : stepName, 'stepStartDate' : stepStartDate, 'stepDueDate' : stepDueDate});
	});
	if (projectStepStatus) {
		return false;
	}
	let formData = new FormData();
	formData.append('projectStepList', new Blob([JSON.stringify(stepList)], { type: 'application/json' }));
	formData.append('projectId', projectId);
    $.ajax({
        url: '../../flowmate/project/updateProjectNewSteps',
        type: 'POST',
        processData: false, 
        contentType: false,
        data: formData,
        success: function(response) {
        	console.log('프로젝트 단계 정보 DB 작업 완료');
        }
    });
    
    return true;
}

function updateProjectData(projectId) {
	let projectName = $('.project-name').val().trim();
	if (projectName == '') {
		Toast.fire({
			  icon: 'error',                   
			  title: '프로젝트 제목 입력은 필수입니다.',
		});
		return false;
	}
	let projectStartDate = $('.project-range').data('daterangepicker').startDate.format('YYYYMMDDHHmmss');
	let projectDueDate = $('.project-range').data('daterangepicker').endDate.format('YYYYMMDDHHmmss');
	let projectContent = $('.project-content').val().trim();
	let projectState = $('#projectStatusButton').text().trim();
	let projectData = {};
	projectData['projectName'] = projectName;
	projectData['projectStartDate'] = projectStartDate;
	projectData['projectDueDate'] = projectDueDate;
	projectData['projectContent'] = projectContent;
	projectData['projectState'] = projectState;
	
	let formData = new FormData();
	formData.append('projectData', new Blob([JSON.stringify(projectData)], { type: 'application/json' })); 
	formData.append('projectId', projectId);
	
    $.ajax({
        url: '../../flowmate/project/updateProjectNewData',
        type: 'POST',
        processData: false, 
        contentType: false,
        data: formData,
        success: function(response) {
        	$('#projectCreating').modal('hide');
			window.location.href = '../../flowmate/project/projectBoard?projectId=' + response;
        }
    });
    
    return true;
}

function projectEditing(editProjectId, deleteFileArray) {
	// 첨부파일 업데이트
	let projectFiles = $('.project-file-input')[0].files;
	if (!updateFiles(editProjectId, projectFiles, deleteFileArray)) {
		return false;
	};
	
	// 프로젝트 멤버 업데이트
	if (!updateMembers(editProjectId)) {
		return false;
	};
	
	// 프로젝트 단계 업데이트
	if (!updateProjectSteps(editProjectId)) {
		return false;
	};
	
	// 프로젝트 데이터 업데이트
	if (!updateProjectData(editProjectId)) {
		return false;
	}
}

$(document).ready(function() {
	setSelectAndDate();
	
	$('.add-attachment, .file-input-btn').on('click', function() {
	    $('.project-file-input').trigger('click');
	});
	
    $('[id$=issueState]').on('click', function() {
        const status = $(this).text();
        $('.issue-state-btn').text(status);

        const color = $(this).data('color');
        $('.issue-state-btn').css('color', color);
    });
    
    $('[id$=projectStatus]').on('click', function(e, isTrigger) {
        var status = $(this).data('status');
        if (!isTrigger) {
	        if (status == '보류' || status == '완료') {
	        	Swal.fire({
	        		title: status + ' 상태로 변경하시겠습니까?',
	        		icon: 'warning',
	        		showCancelButton: true, 
	        		confirmButtonText: '확인', 
	        		cancelButtonText: '취소', 
	        		reverseButtons: true, 
	        	}).then(result => {
	        		if (result.isConfirmed) {
	        	        var color = $(this).data('color');
	        	        $('#projectStatusButton').text(status); 
	        	        $('#projectStatusButton').removeClass('btn-info btn-warning btn-success btn-dark').addClass('btn-' + color);
	        		}
	        	});
	        }
        } else {
	        var color = $(this).data('color');
	        $('#projectStatusButton').text(status); 
	        $('#projectStatusButton').removeClass('btn-info btn-warning btn-success btn-dark').addClass('btn-' + color);
        }
    });
    
    $(document).on('click', '.project-step-close', function() {
        $(this).closest('.d-flex').remove();
        removeTaskStepBtn();
    });
    
    $(document).on('click', '.add-task-step', function() {
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
		$('.add-task-step-btn').remove();
		$('.project-steps').append(projectStepSelect);
		setSelectAndDate();
		removeTaskStepBtn();
    });
     
	$('#projectCreating').on('show.bs.modal', function(e) {
		const button = $(e.relatedTarget); 
		const mode = button.data('mode'); 
        const modal = $(this);
        
        if (mode == 'create') {
        	getMembers(mode);
        	
        	modal.find('.project-name').val('');
        	modal.find('.project-content').val('');
        	
        	const today = moment();
        	modal.find('.project-range').data('daterangepicker').setStartDate(today);
        	modal.find('.project-range').data('daterangepicker').setEndDate(today);
        	
        	setProjectSteps();
        	
        	const fileInput = modal.find('.project-file-input')[0];
            fileInput.value = ''; 
			const preview = $('.file-preview');
			preview.empty();
			$('.project-files-length').text($('.file-preview').find('.project-file').length);
			fileHandler.isEditing = false;
			fileHandler.fileArray = [];
        	fileHandler.init();
        	fileHandler.removeFile();
        	
        	getProjectStatusDropdown(mode);
        	
            $('.project-creating-btn').off('click').on('click', function() {
            	projectCreating();
            });
        } else {   
        	const editProjectId = button.data('projectId');
        	const editProjectName = button.data('projectName');
        	const editProjectContent = button.data('projectContent');
        	const editProjectState = button.data('projectState');
        	let editStartDate = button.data('projectStartDate');
        	let editDueDate = button.data('projectDueDate');
        	editStartDate = moment(editStartDate, 'YYYYMMDDHHmmss');
        	editDueDate = moment(editDueDate, 'YYYYMMDDHHmmss');
        	
        	$.ajax({
                url: '../../flowmate/project/getProjectMembers',
                data: {projectId: editProjectId},
                success: function(response) {
                	getMembers(mode, response);
                }
        	});     
        	
        	$.ajax({
    		    url: '../../flowmate/project/getProjectSteps',
                data: {projectId: editProjectId},
                success: function(response) {
                	renderProjectSteps(response, mode);
                }
        	})
        	        	
        	modal.find('.project-name').val(editProjectName);
        	modal.find('.project-content').val(editProjectContent);
        	modal.find('.project-range').data('daterangepicker').setStartDate(editStartDate);
        	modal.find('.project-range').data('daterangepicker').setEndDate(editDueDate);
        	
        	const fileInput = modal.find('.project-file-input')[0];
            fileInput.value = ''; 
			const preview = $('.file-preview');
			preview.empty();
			fileHandler.deleteFileArray = [];
        	fileHandler.isEditing = true;
        	fileHandler.init(editProjectId, mode);
        	fileHandler.removeFile();
        	
        	getProjectStatusDropdown(mode, editProjectState);
        	
            $('.project-editing-btn').off('click').on('click', function() {
            	projectEditing(editProjectId, fileHandler.deleteFileArray);
            });
        }
        
    	if (mode == 'read') {
    		modal.find('.project-name').attr('disabled', true);
    		modal.find('.project-content').attr('disabled', true).css('background-color', '#ffffff');
    		$('.project-status-dropdown').css('pointer-events', 'none');
    		$('.project-range').each(function() {
    			$(this).attr('readonly', true).css('pointer-events', 'none');
    		});
    		$('.project-team-select').prop('disabled', true);
    	} else {
    	    modal.find('.project-name').removeAttr('disabled');
    	    modal.find('.project-content').removeAttr('disabled').css('background-color', '');
    	    $('.project-status-dropdown').css('pointer-events', 'auto');
    		$('.project-range').each(function() {
    			$(this).removeAttr('readonly').css('pointer-events', 'auto');
    		});
    		$('.project-team-select').prop('disabled', false);
    	}
    });
	
	$('#projectDeactivateBtn').on('click', function() {
		const projectId = $('#projectId').val();
		const projectName = $('.project-name').val().trim();
		Swal.fire({
    		title: '[' + projectId + '] ' + projectName + ' 을(를) 비활성화 하시겠습니까?',
    		text: '비활성화된 프로젝트는 작업 생성 및 수정이 불가능합니다.',
    		icon: 'warning',
    		showCancelButton: true, 
    		confirmButtonText: '확인', 
    		cancelButtonText: '취소', 
    		reverseButtons: true, 
    	}).then(result => {
    		if (result.isConfirmed) {
    	        $.ajax({
    	        	url: '../../flowmate/project/updateProjectDeactivated',
    	        	type: 'POST',
    	        	data: {projectId: projectId},
                    success: function(response) {
						Toast.fire({
							icon: 'success',
							title: projectName + ' (' + projectId + ') 비활성화 처리 완료',
							timer: 2000,
		    			});
						setTimeout(function() {
							$('#projectCreating').modal('hide');
							window.location.href = '../../flowmate/'
						}, 2000);
                    }
    	        });
    		}
    	});
	});
	
	$(document).on('click', '.project-file-down-btn', function() {
	    let fileId = $(this).data('fileId');
	    window.location.href = '../../flowmate/project/downloadFile?fileId=' + fileId;
	});
});