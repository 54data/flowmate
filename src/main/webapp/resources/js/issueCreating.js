function getIssueMembers(projectId, issueMode, loginMemberId) {
	console.log('getIssueMembers');
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
            
            if (issueMode == 'create') {
            	$('.issue-member-select').val([loginMemberId]).trigger('change');
            	$('.select2-selection__arrow').hide();
            }
        }
    });
}

function getIssueRelatedTask(projectId, issueMode, projectName) {
	console.log('getIssueRelatedTask');

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
            
            $('.issue-related-tasks-select').val(null).trigger('change');
        }
    });
}

function diplayElemByMode(issueMode) {
	if (issueMode == 'create') {
		$('.issue-member-select').prop('disabled', true);
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
	
	$.ajax({
		url: '../../flowmate/issue/createIssue',
		type: 'POST',
		contentType: "application/json",
		data: JSON.stringify(issueData),
		success: function(response) {
			$('#issueCreating').modal('hide');
		    window.history.back();
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
		
		$('.issue-add-attachment, .issue-file-input-btn').on('click', function() {
		    $('.issue-file-input').trigger('click');
		});
		
		if (issueMode == 'create') {
			console.log(issueMode);
			const issueRegdate = today.format('YYYYMMDDHHmmss');
			$('.today-regdate').text(today.format('YYYY/MM/DD'));
			getIssueMembers(projectId, issueMode, loginMemberId);
			getIssueRelatedTask(projectId, issueMode);
			
			$('.issue-name').val('');
			$('.issue-content').val('');
			
			const fileInput = modal.find('.issue-file-input')[0];
            fileInput.value = ''; 
			const preview = $('.issue-file-preview');
			preview.empty();
			
			$('.issue-creating-btn').off('click').on('click', function() {
            	issueCreating(projectId, issueRegdate, loginMemberId);
            });
		}
	});
});