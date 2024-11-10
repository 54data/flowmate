$(document).ready(function() {
    $(document).on('click', '.send', function() {
		window.open('/flowmate/message/messageSend','_blank', 'width=600, height=500, scrollbars=yes ');
    });
    
    $(document).on('click','.reply', function() {
        const receiverId = $(this).closest('.message').find('.sender-id').text().trim(); 
        window.open(`/flowmate/message/messageSend?receiverId=${receiverId}`, '_blank', 'width=600, height=500, scrollbars=yes');
    });
    $(document).on('click','.md-reply', function() {
    	const receiverId = $('.senderId').text().trim(); 
    	window.open(`/flowmate/message/messageSend?receiverId=${receiverId}`, '_blank', 'width=600, height=500, scrollbars=yes');
    });
    $(document).on('click','.showList', function() {
    	location.href = "/flowmate/message/messageBox"
    });
    
    
});		