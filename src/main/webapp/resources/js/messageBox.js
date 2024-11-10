$(document).ready(function() {
    $(document).on('click', '.send', function() {
		window.open('/flowmate/message/messageSend','_blank', 'width=600, height=500, scrollbars=yes ');
    });
    
    $(document).on('click', '.reply', function() {
        // 수신자 ID를 가져옵니다. 예를 들어, 메시지의 수신자가 .sender-id로 표시된다면:
        const receiverId = $(this).closest('.message').find('.sender-id').text().trim(); 

        // 수신자 ID를 URL 파라미터로 전달하여 팝업을 엽니다.
        window.open(`/flowmate/message/messageSend?receiverId=${receiverId}`, '_blank', 'width=600, height=500, scrollbars=yes');
    });
    
});		