function getMembers(receiverId, originalContent) {
    $.ajax({
        url: '/flowmate/project/getMembers',
        dataType: 'json',
        success: function (data) {
            const groupedResults = {};

            data.members.forEach(function (member) {
                const groupName = '▶ ' + member.memberDept;
                if (!groupedResults[groupName]) {
                    groupedResults[groupName] = [];
                }
                groupedResults[groupName].push({
                	 id: member.memberId,
                     text: member.memberName,
                     deptRank: member.memberDept + ' ' + member.memberRank
                });
            });

            const results = Object.keys(groupedResults).map(function (groupName) {
                return {
                    text: groupName,
                    children: groupedResults[groupName]
                };
            });

            $('.reciver-select').select2({
                data: results,
                width: '100%',
                placeholder: '할당되지 않음',
                allowClear: true,
                dropdownParent: $('#sendMessage'),
                closeOnSelect: false,
                templateResult: function (member) {
    
                    if (!member.deptRank) {
                        return member.text; 
                    }
                    const $result = $('<span></span>');
                    const $name = $('<span></span>').text(member.text);
                    const $deptRank = $('<span></span>').css({
                        fontSize: '12px',
                        color: '#6c757d',
                        marginLeft: '10px',
                        fontStyle: 'italic'
                    }).text(member.deptRank);
                    $result.append($name).append($deptRank);
                    return $result;
                },
                templateSelection: function (member) {

                    if (!member.deptRank) {
                        return member.text;
                    }
                    const $selection = $('<span></span>');
                    const $name = $('<span></span>').text(member.text);
                    const $deptRank = $('<span></span>').css({
                        fontSize: '12px',
                        color: '#6c757d',
                        marginLeft: '10px',
                        fontStyle: 'italic'
                    }).text(member.deptRank);
                    $selection.append($name).append($deptRank);
                    return $selection;
                }
            });

            // receiverId 및 originalContent 값 반영
            if (receiverId) {
                $('.reciver-select').val([receiverId]).trigger('change').attr('disabled', true);
            }

            if (originalContent) {
                const messageContent = $('.message-content');
                const replyContent = `RE: \n------------------\n${decodeURIComponent(originalContent)}`;
                messageContent.val(replyContent);

                // "RE: " 접두사 유지
                messageContent.on("input", function () {
                    if (!messageContent.val().startsWith("RE: ")) {
                        messageContent.val(`RE: ${messageContent.val().replace(/^RE:\s*/, "")}`);
                    }
                });
            }
        }
    });
}

$(document).ready(function () {
    const urlParams = new URLSearchParams(window.location.search);
    const receiverId = urlParams.get('receiverId') ? urlParams.get('receiverId').replace(/[()]/g, '').trim() : null;
    const originalContent = urlParams.get('originalContent');

    // AJAX 요청 후 데이터 반영
    getMembers(receiverId, originalContent);

    let approvalReject = urlParams.get('approvalReject');
    let approvalId = urlParams.get('approvalId');
    let taskReqContent = urlParams.get('taskReqContent');
    let taskId = urlParams.get('taskId');
    let requestAppr = urlParams.get('requestAppr');

    if (approvalReject === 'true') {
        $('.message-content').val(taskId + '건 반려메세지 : ' + "\n");
    }

    if (requestAppr === 'true') {
        $('.message-content').val(`요청메세지 : ${taskId}건에 대한 결재 요청드립니다.\n사유 : ${taskReqContent}`);
    }

    handler.init();
    handler.removeFile();

    $('.sendMsg').on('click', function (e) {
        e.preventDefault();
        if (!validateMsg()) return;

        const memberIds = $('.reciver-select').val();
        const formData = new FormData($('#sendMessage')[0]);
        const addedIds = [];

        memberIds.forEach(id => {
            if (!addedIds.includes(id)) {
                formData.append('memberIds', id);
                addedIds.push(id);
            }
        });

        $.ajax({
            url: '/flowmate/message/sendMessage',
            type: 'post',
            data: formData,
            processData: false,
            contentType: false,
            dataType: 'text',
            success: function (msgId) {
                if (approvalReject === 'true') {
                    $.ajax({
                        url: '/flowmate/approval/updateApprDeniedMsg',
                        method: 'post',
                        data: { approvalId: approvalId, msgId: msgId },
                        success: function (response) {
                            console.log(response);
                        }
                    });
                }

                Swal.fire({
                    title: '성공',
                    text: '쪽지가 성공적으로 전송되었습니다.',
                    icon: 'success',
                    confirmButtonText: '확인'
                }).then(() => {
                    window.close();
                });
            }
        });
    });

    $(document).on('click', '.send', function () {
        window.open('/flowmate/message/messageSend', '_blank', 'width=600, height=500, scrollbars=yes');
    });

    $(document).on('click', '.add-attachment', function () {
        $('.message-file-input').trigger('click');
    });

    $(document).on('click', '.file-input-btn', function () {
        $('.message-file-input').trigger('click');
    });

    handler.init();
    handler.removeFile();

    $('.reciver-select').select2({
        width: '100%',
        placeholder: '할당되지 않음',
        allowClear: true,
        dropdownParent: $('#sendMessage'),
        closeOnSelect: false
    });
});
