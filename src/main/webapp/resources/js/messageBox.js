$(document).ready(function() {
    $(document).on('click', '.send', function() {
		window.open('/flowmate/message/messageSend','_blank', 'width=600, height=500, scrollbars=yes ');
    });
    
    $(document).on('click','.reply', function() {
        const receiverId = $(this).closest('.message').find('.sender-id').text().trim(); 
        
        const originalContent = $(this).closest('.message').find('.messageContext').text().trim();

        const popup = window.open(`/flowmate/message/messageSend?receiverId=${receiverId}&originalContent=${encodeURIComponent(originalContent)}`, '_blank', 'width=600, height=500, scrollbars=yes');
    });
    $(document).on('click','.md-reply', function() {
    	const receiverId = $('.senderId').text().trim(); 
    	window.open(`/flowmate/message/messageSend?receiverId=${receiverId}`, '_blank', 'width=600, height=500, scrollbars=yes');
    });
    $(document).on('click','.showList', function() {
    	location.href = "/flowmate/message/messageBox"
    });
    
    $('#selectChoice').on('change', function() {
        $('.messageCheckbox').prop('checked', this.checked);
    });
    
    
    $(document).on('click', '#msgDelete-receiver', function(){
    		
    		let selectMessageId = [];

        $('.messageCheckbox:checked').each(function() {
            selectMessageId.push($(this).closest('.message').find('input[name="messageId"]').val());
        });

        if (selectMessageId.length === 0) {
            return;
        }
        console.log(selectMessageId);
        Swal.fire({
            title: '선택한 쪽지를 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#3085d6',
            confirmButtonText: '삭제',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed){
	        
	    	$.ajax({
	    		url: '/flowmate/message/msgDeleteReceiver',
	    		method: 'post',
	    		data: {selectMessageId},
	    		traditional: true,
	    		success:function(response){
	    			console.log(response);
	    			console.log("AJAX 요청 성공:", response);
	    			location.reload();
	    		}
	    	});
	            }
	        });
    	
    });
    
    
    $(document).on('click', '#msgDelete-sender', function(){
		
		let selectMessageId = [];

	    $('.messageCheckbox:checked').each(function() {
	        selectMessageId.push($(this).closest('.message').find('input[name="messageId"]').val());
	    });
	
	    if (selectMessageId.length === 0) {
	        return;
	    }
	    console.log(selectMessageId);
	    Swal.fire({
	        title: '선택한 쪽지를 삭제하시겠습니까?',
	        icon: 'warning',
	        showCancelButton: true,
	        confirmButtonColor: '#d33',
	        cancelButtonColor: '#3085d6',
	        confirmButtonText: '삭제',
	        cancelButtonText: '취소'
	    }).then((result) => {
	        if (result.isConfirmed){
	        
	    	$.ajax({
	    		url: '/flowmate/message/msgDeleteSender',
	    		method: 'post',
	    		data: {selectMessageId},
	    		traditional: true,
	    		success:function(response){
	    			console.log(response);
	    			console.log("AJAX 요청 성공:", response);
	    			location.reload();
	    		}
	    	});
	            }
	        });
		
	    });
	    
	    $(document).on('click', '.md-delete.sender', function() {
	    		const messageId = $(this).data('message-id');
	
	        Swal.fire({
	            title: '쪽지를 삭제하시겠습니까?',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#d33',
	            cancelButtonColor: '#3085d6',
	            confirmButtonText: '삭제',
	            cancelButtonText: '취소'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                $.ajax({
	                    url: '/flowmate/message/msgDeleteSender',
	                    method: 'post',
	                    data: { selectMessageId: [messageId] },
	                    traditional: true,
	                    success: function(response) {
	                        location.href = '/flowmate/message/messageSentBox';
	                    }
	                });
	            }
	        });
	    });
	
	    $(document).on('click', '.md-delete.receiver', function() {
	    		const messageId = $(this).data('message-id');
	
	        Swal.fire({
	            title: '쪽지를 삭제하시겠습니까?',
	            icon: 'warning',
	            showCancelButton: true,
	            confirmButtonColor: '#d33',
	            cancelButtonColor: '#3085d6',
	            confirmButtonText: '삭제',
	            cancelButtonText: '취소'
	        }).then((result) => {
	            if (result.isConfirmed) {
	                $.ajax({
	                    url: '/flowmate/message/msgDeleteReceiver',
	                    method: 'post',
	                    data: { selectMessageId: [messageId] },
	                    traditional: true,
	                    success: function(response) {
	                        location.href = '/flowmate/message/messageBox';
	                    }
	                });
	            }
	        });
	    });
	    
	});		