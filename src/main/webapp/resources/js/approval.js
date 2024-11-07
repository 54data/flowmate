$(document).ready(function() {
	/*작업에서 요청 보내기*/
    $('.task-request-btn').on('click', function(e) {
    	e.preventDefault();
    	console.log('요청 이벤트발생')
    	const taskReqContent = $('.task-request-form').val();
        const urlParams = new URLSearchParams(location.search);
        const projectId = urlParams.get('projectId');
        const taskId = document.getElementById('taskId').value;
        const selectedStatus = document.getElementById('selectedStatusInput').value;
        
        console.log(taskReqContent);
        console.log(projectId);
        console.log(taskId);
        console.log(selectedStatus);
    	    	    	
    	$.ajax({
    		url: '/flowmate/approval/insertAppr',
    		method: 'POST',
    		data: {
    			selectedStatus: selectedStatus,
    			taskReqContent: taskReqContent,
                projectId: projectId,
                taskId: taskId
            },
    		success: function(response){
    			Toast.fire({
    	            icon: 'success',
    	            title: '결재 요청이 성공하였습니다.'
    	        });
    			
	            setTimeout(function() {
	                window.location.href = '/flowmate/project/projectBoard?projectId=' + projectId;
	            }, 2500);

    		},
    		error: function(error){
    			Toast.fire({
    	            icon: 'error',
    	            title: '결재 요청이 실패하였습니다.'
    	        });    			
    		}
    	})
    	
    });    
    
    /*작업에서 요청 보내기*/

});		