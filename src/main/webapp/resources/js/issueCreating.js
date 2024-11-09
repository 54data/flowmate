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
            
            const projectName = $('#projectName').val();
            var placeholderText;
            if (issueMode === 'create') {
            	placeholderText = '미선택시 프로젝트 이슈로 등록'
            } else if (issueMode === 'read' && issueRelatedTaskId === null) {
            	placeholderText = `[${projectId}] ${projectName}`;
            }
                        
            $('.issue-related-tasks-select').select2().empty().select2({
                data: results,
                width: '100%',
                allowClear: true,
                placeholder: placeholderText,
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

            console.log(issueRelatedTaskId);
            if (issueMode == 'create') {
            	$('.issue-related-tasks-select').val(null).trigger('change');
            	if (issueRelatedTaskId != null) {
            		$('.issue-related-tasks-select').val([issueRelatedTaskId]).trigger('change');
            	}
            } else if (issueMode == 'read') {
            	$('.select2-selection__arrow').hide();
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
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="issue-file-down-btn bi bi-download ms-2" viewBox="0 0 16 16" data-file-id="${file.fileId}">
											<path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5"/>
											<path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708z"/>
										</svg>
									</div>`);	                    
						} else {
							preview.append(
									`<div class="issue-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.fileId}">
										${file.fileName}
										<button type="button" class="file-remove btn-close ms-2" data-index="issue-${lastModified}" data-file-id="${file.fileId}"></button>
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
		$('.issue-related-tasks-select').prop('disabled', false);
		$('.issue-btn-area').show();
		$('.issue-name').attr('disabled', false);
		$('.issue-content').attr('disabled', false);
		$('#issueBtn').show();
        $('#issueBtn').removeClass('ms-auto');
        $('#issueBtn').text('이슈 생성');
        $('#issueBtn').removeClass('issue-editing-btn').addClass('issue-creating-btn');
        $('#issueDeactivateBtn').hide();
        $('.issue-status-dropdown').hide();
        $('.issue-content').removeAttr('disabled').css('background-color', '');
        $('.issueInfo').hide();
	} else if (issueMode == 'read') {
    	$('.issue-member-select').prop('disabled', true);
    	$('.issue-btn-area').hide();
    	$('.issueInfo').show();
    	$('.issue-name').attr('disabled', true);
    	$('.issue-content').attr('disabled', true);
    	$('.issue-creating-btn').hide();
    	$('#issueDeactivateBtn').hide();
    	$('.issue-status-dropdown').show();
    	$('.issue-status-dropdown').css('pointer-events', 'none');
    	$('.issue-content').attr('disabled', true).css('background-color', '#ffffff');
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

function issueReading(projectId, issueMode, issueId, loginMemberId) {
	$.ajax({
		url: '../../flowmate/issue/getIssue',
        data: {issueId: issueId},
        success: function(issue) {
        	// 이슈 조회
        	let issueMemberId = issue['memberId'];
        	getIssueMembers(projectId, issueMode, issueMemberId);
        	getIssueRelatedTask(projectId, issueMode, issue['taskId']);
        	$('.issue-regdate').text(moment(issue['issueRegdate'], "YYYYMMDDHHmmss").format('YYYY/MM/DD'));
        	$('.issue-name').val(issue['issueTitle']);
        	$('.issue-content').val(issue['issueContent']);
        	$('.fmt-issue-id').text(issue['fmtIssueId']);
        	$('#issueBtn').hide();
        	$('#issueStatus[data-status="' + issue['issueState'] + '"]').trigger('click', [true]); 
        	// 이슈 수정
        	let projectPmId = issue['projectPmId'];      	
        	if (loginMemberId == issueMemberId || loginMemberId == projectPmId) {
        		let isPm = (loginMemberId == projectPmId);
        		issueEditing(issueId, isPm);
        	} else {
            	const fileInput = $('.issue-file-input')[0];
                fileInput.value = ''; 
    			const preview = $('.issue-file-preview');
    			preview.empty();
    			issueFileHandler.deleteFileArray = [];
    			issueFileHandler.isEditing = true;
    			issueFileHandler.init(issueId, issueMode);
    			issueFileHandler.removeFile();
        	}
        }
	});
}

function issueEditing(issueId, isPm) {
	$('.issue-status-dropdown').show();
	$('.issue-status-dropdown').css('pointer-events', 'auto');
	$('#issueBtn').show();
	$('#issueBtn').addClass('ms-auto');
	$('#issueBtn').text('수정');
	$('#issueBtn').removeClass('issue-creating-btn').addClass('issue-editing-btn');
	$('#issueDeactivateBtn').show();
	$('.issue-name').attr('disabled', false);
	$('.issue-content').attr('disabled', false);
	$('.issue-btn-area').show();
	if (isPm) {		
		$('.issue-member-select').prop('disabled', false);
	} else {
		$('.issue-name').attr('disabled', false);
		$('.issue-content').attr('disabled', false);
	}
	
	const fileInput = $('.issue-file-input')[0];
    fileInput.value = ''; 
	const preview = $('.issue-file-preview');
	preview.empty();
	issueFileHandler.deleteFileArray = [];
	issueFileHandler.isEditing = true;
	issueFileHandler.init(issueId, 'edit');
	issueFileHandler.removeFile();
	
	$('.issue-editing-btn').off('click').on('click', function() {
    	issueEditInsert(issueId, issueFileHandler.deleteFileArray);
    });
}

function updateIssueFiles(issueId, issueFiles, deleteFileList) {
    let formData = new FormData();
    let issueNewFiles = Array.from(issueFiles);
    
    $('.issue-file').each(function() {
        let fileId = $(this).find('.file-remove').data('fileId'); 
        let removeTargetId = $(this).find('.file-remove').data('index');
        if (fileId) { 
        	issueNewFiles = issueNewFiles.filter(file => `issue-${file.lastModified}` !== removeTargetId);
        }
    });
    if (deleteFileList.length > 0) {
    	formData.append('deleteFileList', new Blob([JSON.stringify(deleteFileList)], { type: 'application/json' })); 
    }
    
    formData.append('issueId', issueId);
    
    issueNewFiles.forEach(file => {
    	formData.append('issueNewFiles', file);
    });
	
    $.ajax({
        url: '../../flowmate/issue/updateIssueNewFiles',
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

function updateIssueData(issueId) {
	let issueName = $('.issue-name').val().trim();
	if (issueName == '') {
		Toast.fire({
			  icon: 'error',                   
			  title: '이슈 제목 입력은 필수입니다.',
		});
		return;
	}
	let issueContent = $('.issue-content').val().trim();
	let memberId = $('.issue-member-select').val();
	let issueState = $('#issueStatusButton').text().trim();
	
	let issueData = {};
	issueData['issueId'] = issueId;
	issueData['memberId'] = memberId;
	issueData['issueTitle'] = issueName;
	issueData['issueContent'] = issueContent; 
	issueData['issueState'] = issueState;
	
	$.ajax({
		url: '../../flowmate/issue/updateIssue',
		type: 'POST',
		contentType: "application/json",
		data: JSON.stringify(issueData),
		success: function(response) {
			Toast.fire({
				  icon: 'success',                   
				  title: '수정이 완료되었습니다.',
			});
			$('#issueCreating').modal('hide');
		}
	});
}

function issueEditInsert(issueId, deleteFileArray) {
	let issueFiles = $('.issue-file-input')[0].files;
	if (!updateIssueFiles(issueId, issueFiles, deleteFileArray)) {
		return false;
	}
	
	if(!updateIssueData(issueId)) {
		return false;
	}
}

$(document).ready(function() {
	$('#issueCreating').on('shown.bs.modal', function(e) {
		const issueMode = $(e.relatedTarget).data('triggeredBy');
		diplayElemByMode(issueMode);
		const projectId = $('#projectId').val();
		const loginMemberId = $('#loginMemberId').text();
		const today = moment();
		const modal = $(this);
		const issueId = $(e.relatedTarget).data('issueId');
		const taskId = $(e.relatedTarget).data('taskId');
		
		if (issueMode == 'create') {
			const issueRegdate = today.format('YYYYMMDDHHmmss');
			$('.issue-regdate').text(today.format('YYYY/MM/DD'));
			getIssueMembers(projectId, issueMode, loginMemberId);
			getIssueRelatedTask(projectId, issueMode, taskId);
			
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
			issueReading(projectId, issueMode, issueId, loginMemberId);
		}
		
	    $('[id$=issueStatus]').on('click', function(e, isTrigger) {
	        var status = $(this).data('status');
	        if (!isTrigger) {
		        if (status == '미해결' || status == '해결') {
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
		        	        $('#issueStatusButton').text(status); 
		        	        $('#issueStatusButton').removeClass('btn-info btn-danger').addClass('btn-' + color);
		        		}
		        	});
		        }
	        } else {
		        var color = $(this).data('color');
		        $('#issueStatusButton').text(status); 
		        $('#issueStatusButton').removeClass('btn-info btn-danger').addClass('btn-' + color);
	        }
	    });
		
		$('.issue-add-attachment, .issue-file-input-btn').off('click').on('click', function() {
		    $('.issue-file-input').trigger('click');
		});
		
		$(document).on('click', '.issue-file-down-btn', function() {
		    let fileId = $(this).data('fileId');
		    window.location.href = '../../flowmate/issue/downloadFile?fileId=' + fileId;
		});
		
		$('#issueDeactivateBtn').on('click', function() {
			let issueName = $('.issue-name').val().trim();
			Swal.fire({
	    		title: '[' + issueId + '] ' + issueName + ' 을(를) 비활성화 하시겠습니까?',
	    		text: '비활성화된 이슈는 조회 및 수정이 불가능합니다.',
	    		icon: 'warning',
	    		showCancelButton: true, 
	    		confirmButtonText: '확인', 
	    		cancelButtonText: '취소', 
	    		reverseButtons: true, 
	    	}).then(result => {
	    		if (result.isConfirmed) {
	    	        $.ajax({
	    	        	url: '../../flowmate/issue/updateIssueDeactivated',
	    	        	type: 'POST',
	    	        	data: {issueId: issueId},
	                    success: function(response) {
							Toast.fire({
								icon: 'success',
								title: '[' + issueId + '] ' + issueName + ' 비활성화 처리 완료',
								timer: 2000,
			    			});
							setTimeout(function() {
								$('#issueCreating').modal('hide');
								window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId;
							}, 2000);
	                    }
	    	        });
	    		}
	    	});
		});
	});
});