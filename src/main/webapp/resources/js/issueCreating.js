function getIssueMembers(projectId, issueMode, loginMemberId) {
	$.ajax({
        url: '../../flowmate/issue/getIssuesMembers',
        data: {projectId: projectId},
        success: function(data) {
            var groupedResults = {};
            data.members.forEach(function(member) {
                var groupName = '▶ ' + member.memberDept;
                if (!groupedResults[groupName]) {
                    groupedResults[groupName] = [];
                }
                groupedResults[groupName].push({
                    id: member.memberId,
                    text: member.memberName,
                    deptRank: member.memberDept + ' ' + member.memberRank
                });
            });
            
            var results = Object.keys(groupedResults).map(function(groupName) {
                return {
                    text: groupName,
                    children: groupedResults[groupName]
                };
            });
            
            $('.issue-member-select').select2().empty().select2({
                data: results,
                width: '100%',
                placeholder: '할당되지 않음',
                allowClear: true,
                dropdownParent: $('#issueCreating'),
                closeOnSelect: false,
                templateResult: function(member) {
                    if (!member.deptRank) { return member.text; }  
                    var $result = $('<span></span>');
                    var $name = $('<span></span>').text(member.text);
                    var $deptRank = $('<span></span>').css({
                        fontSize: '12px',
                        color: '#6c757d',
                        marginLeft: '10px',
                        fontStyle: 'italic'
                    }).text(member.deptRank);
                    $result.append($name).append($deptRank);
                    return $result;
                },
                templateSelection: function(member) {
                    if (!member.deptRank) { return member.text; } 
                    var $selection = $('<span></span>');
                    var $name = $('<span></span>').text(member.text);
                    var $deptRank = $('<span></span>').css({
                        fontSize: '12px',
                        color: '#6c757d',
                        marginLeft: '10px',
                        fontStyle: 'italic'
                    }).text(member.deptRank);
                    $selection.append($name).append($deptRank);
                    return $selection;
                }
            });
            
        	$('.issue-member-select').val([loginMemberId]).trigger('change');
        	$('.select2-selection__arrow').hide();
        }
    });
}

function getIssueRelatedTask(projectId, issueMode, issueRelatedTaskId) {
	$.ajax({
        url: '../../flowmate/issue/getProjectTasks',
        data: {projectId: projectId},
        success: function(data) {
            var groupedResults = {};
            data.projectTasks.forEach(function(task) {
                var groupName = '▶ ' + task.stepName;
                if (!groupedResults[groupName]) {
                    groupedResults[groupName] = [];
                }
                groupedResults[groupName].push({
                    id: task.taskId,
                    text: '[' + task.fmtTaskId + '] ' + task.taskName,
                    deptRank: task.memberName
                });
            });
            
            var results = Object.keys(groupedResults).map(function(groupName) {
                return {
                    text: groupName,
                    children: groupedResults[groupName]
                };
            });
            
            $('.issue-related-tasks-select').select2().empty().select2({
                data: results,
                width: '100%',
                allowClear: true,
                placeholder: '미선택시 프로젝트 이슈로 등록',
                dropdownParent: $('#issueCreating'),
                closeOnSelect: false,
                templateResult: function(task) {
                    if (!task.deptRank) { return task.text; }  
                    var $result = $('<span></span>');
                    var $name = $('<span></span>').text(task.text);
                    var $deptRank = $('<span></span>').css({
                        fontSize: '12px',
                        color: '#6c757d',
                        marginLeft: '10px',
                        fontStyle: 'italic'
                    }).text(task.deptRank);
                    $result.append($name).append($deptRank);
                    return $result;
                },
                templateSelection: function(task) {
                    if (!task.deptRank) { return task.text; } 
                    var $selection = $('<span></span>');
                    var $name = $('<span></span>').text(task.text);
                    var $deptRank = $('<span></span>').css({
                        fontSize: '12px',
                        color: '#6c757d',
                        marginLeft: '10px',
                        fontStyle: 'italic'
                    }).text(task.deptRank);
                    $selection.append($name).append($deptRank);
                    return $selection;
                }
            });
            
            if (issueMode == 'create' || issueRelatedTaskId == null) {
            	$('.issue-related-tasks-select').val(null).trigger('change');
            } else if (issueMode == 'read') {
            	$('.issue-related-tasks-select').val([issueRelatedTaskId]).trigger('change');
            	$('.issue-related-tasks-select').prop('disabled', true);
            }
        }
    });
}

const issueFileHandler = {		
		fileArray : [],
		
		deleteFileArray : [],
		
		isEditing: false,
		
		init(issueId, mode) {
			this.updateFileInput();
			const fileInput = $('.issue-file-input');
			const preview = $('.issue-file-preview');
			
			if (this.isEditing) {
				this.loadFiles(issueId, mode); 
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
							`<div class="issue-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="issue-${file.lastModified}">
								${file.name}
								<button type="button" class="file-remove btn-close ms-2" data-index="issue-${file.lastModified}"></button>
							</div>`);
					}
				});
				this.updateFileInput();
				$('.issue-files-length').text($('.issue-file-preview').find('.issue-file').length);
			});
		},
		
		loadFiles(issueId, mode) {
			$.ajax({
				url: '../../flowmate/issue/getIssueFiles',
				data: {issueId: issueId},
				success: (files) => {			
					const preview = $('.issue-file-preview');
					this.fileArray = []; 
					files.forEach(file => {
						const lastModified = Date.now();
						issueFile = new File([new Blob([file.fileData], {type: file.fileType})], file.fileName, {
			                type: file.fileType,
			                lastModified: lastModified
			            });
						this.fileArray.push(issueFile);
	                    if (mode == 'read') {
							preview.append(
									`<div class="issue-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
										${file.fileName}
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="project-file-down-btn bi bi-download ms-2" viewBox="0 0 16 16" data-file-id="${file.fileId}">
											<path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"/>
											<path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
										</svg>
									</div>`);	                    
						} else {
							preview.append(
									`<div class="issue-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
										${file.fileName}
										<button type="button" class="file-remove btn-close ms-2" data-index="project-${lastModified}" data-file-id="${file.fileId}"></button>
									</div>`)
						}
					});
					this.updateFileInput();
					$('.issue-files-length').text($('.issue-file-preview').find('.issue-file').length);
				},
			});
		},
		 
		removeFile() {
			$(document).on('click', (e) => {
				if (!$(e.target).hasClass('file-remove')) return;
				const removeTargetId = $(e.target).data('index');
				const files = $('.issue-file-input')[0].files;
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
				this.fileArray = this.fileArray.filter(file => `issue-${file.lastModified}` !== removeTargetId);
				this.updateFileInput();
		        removeTarget.remove();
		        $('.issue-files-length').text($('.issue-file-preview').find('.issue-file').length);
			});
		},
		
	    updateFileInput() {
	        const dataTransfer = new DataTransfer();
	        this.fileArray.forEach(file => {
	            dataTransfer.items.add(file);
	        });
	        $('.issue-file-input')[0].files = dataTransfer.files; 
	    }
};

function diplayElemByMode(issueMode) {
	if (issueMode == 'create') {
		$('.issue-member-select').prop('disabled', true);
		$('.project-name').attr('disabled', false);
		$('.issue-btn-area').show();
	} else if (issueMode == 'read') {
    	$('.issue-member-select').prop('disabled', true);
    	$('.issue-related-tasks-select').prop('disabled', true);
    	$('.project-name').attr('disabled', true);
    	$('.issue-btn-area').hide();
    	$('.issueInfo').show();
	} else {
    	$('.issue-member-select').prop('disabled', false);
    	$('.issue-related-tasks-select').prop('disabled', false);
    	$('.project-name').attr('disabled', false);
    	$('.issue-btn-area').show();
	}
}

function issueCreating(projectId, issueRegdate, loginMemberId) {
	let issueName = $('.issue-name').val().trim();
	if (issueName == '') {
		Toast.fire({
			  icon: 'error',                   
			  title: '이슈 제목 입력은 필수입니다.',
		});
		return;
	}
	let issueContent = $('.issue-content').val().trim();
	let issueRelatedTask = $('.issue-related-tasks-select').val() || '';
	
	let issueData = {};
	issueData['projectId'] = projectId;
	issueData['memberId'] = loginMemberId;
	issueData['taskId'] = issueRelatedTask;
	issueData['issueTitle'] = issueName;
	issueData['issueRegdate'] = issueRegdate;
	issueData['issueContent'] = issueContent;
	
	let formData = new FormData();
	let issueFiles = $('.issue-file-input')[0].files;
    Array.from(issueFiles).forEach(file => {
    	formData.append('issueFiles', file);
    });
	formData.append('issueData', new Blob([JSON.stringify(issueData)], { type: 'application/json' })); 
	
	$.ajax({
		url: '../../flowmate/issue/createIssue',
		type: 'POST',
		processData: false,
		contentType: false,
		data: formData,
		success: function(response) {
			$('#issueCreating').modal('hide');
			window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId;
		}
	});
}

function issueReading(projectId, issueMode, issueId) {
	$.ajax({
		url: '../../flowmate/issue/getIssue',
        data: {issueId: issueId},
        success: function(issue) {
        	let issueMemeberId = issue['memberId'];
        	getIssueMembers(projectId, issueMode, issueMemeberId);
        	getIssueRelatedTask(projectId, issueMode, issue['taskId']);
        	$('.issue-regdate').text(moment(issue['issueRegdate'], "YYYYMMDDHHmmss").format('YYYY/MM/DD'));
        	$('.issue-name').val(issue['issueTitle']);
        	$('.issue-content').val(issue['issueContent']);
        	$('.fmt-issue-id').text(issue['fmtIssueId']);
        }
	});
}

$(document).ready(function() {
	$('#issueCreating').on('shown.bs.modal', function(e) {
		const issueMode = $(e.relatedTarget).data('triggeredBy');
		diplayElemByMode(issueMode);
		const projectId = $('#projectId').val();
		const loginMemberId = $('#loginMemberId').text();
		const today = moment();
		const modal = $(this);
		
		if (issueMode == 'create') {
			const issueRegdate = today.format('YYYYMMDDHHmmss');
			$('.issue-regdate').text(today.format('YYYY/MM/DD'));
			getIssueMembers(projectId, issueMode, loginMemberId);
			getIssueRelatedTask(projectId, issueMode);
			
			$('.issue-name').val('');
			$('.issue-content').val('');
			
			const fileInput = modal.find('.issue-file-input')[0];
            fileInput.value = ''; 
			const preview = $('.issue-file-preview');
			preview.empty();
			$('.issue-files-length').text($('.issue-preview').find('.issue-file').length);
			issueFileHandler.isEditing = false;
			issueFileHandler.fileArray = [];
        	issueFileHandler.init();
        	issueFileHandler.removeFile();
			
			$('.issue-creating-btn').off('click').on('click', function() {
            	issueCreating(projectId, issueRegdate, loginMemberId);
            });
		} else {
			const issueId = $(e.relatedTarget).data('issueId');
			issueReading(projectId, issueMode, issueId);
		}
		
		$('.issue-add-attachment, .issue-file-input-btn').off('click').on('click', function() {
		    $('.issue-file-input').trigger('click');
		});
	});
});