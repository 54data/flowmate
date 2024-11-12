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
	            	window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId + '&taskId=' + taskId;
	            }, 2500);
    		},
    		error: function(error){
    			Toast.fire({
    	            icon: 'error',
    	            title: '결재 요청이 실패하였습니다.'
    	        });
    			
	            setTimeout(function() {
	            	window.location.href = '../../flowmate/project/projectBoard?projectId=' + projectId + '&taskId=' + taskId;
	            }, 2500);
    		}
    	})  	
    });    
    
    const observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.attributeName === "style") {
                const display = $('.task-request-div').css('display');
                if (display === 'none') {
                    $('.task-request-form').val(''); // task-request-form 초기화
                    $('#taskRequestLength').text('0'); // 글자 수 초기화
                }
            }
        });
    });

    observer.observe(document.querySelector('.task-request-div'), { attributes: true });

});		