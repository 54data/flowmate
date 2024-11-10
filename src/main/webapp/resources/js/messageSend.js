const Toast = Swal.mixin({
    toast: true,
    position: 'top',
    showConfirmButton: false,
    timer: 2500,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.style.width = '350px';
        toast.style.fontSize = '14px';
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
});

function getMembers() {
    $.ajax({
        url: '/flowmate/project/getMembers',
        dataType: 'json',
        success: function(data) {
            const groupedResults = {};

            data.members.forEach(function(member) {
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

            const results = Object.keys(groupedResults).map(function(groupName) {
                return {
                    text: groupName,
                    children: groupedResults[groupName]
                };
            });

            $('.reciver-select').select2().empty().select2({
                data: results,
                width: '100%',
                placeholder: '할당되지 않음',
                allowClear: true,
                dropdownParent: $('#sendMessage'),
                closeOnSelect: false,
                templateResult: function(member) {
                    if (!member.deptRank) { return member.text; }
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
                templateSelection: function(member) {
                    if (!member.deptRank) { return member.text; }
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
        }
    });
}



$(document).ready(function() {
    const urlParams = new URLSearchParams(window.location.search);
    let receiverId = urlParams.get('receiverId');

    getMembers();

    if (receiverId) {
        receiverId = receiverId.replace(/[()]/g, '').trim();

        setTimeout(function() {
            $('.reciver-select').val([receiverId]).trigger('change').attr('disabled', true);
            const selectedValue = $('.reciver-select').val();
        }, 100);
        
    }

    handler.init();
    handler.removeFile();

    $('.sendMsg').on('click', function(e) {
        e.preventDefault();
        validateMsg();

        const memberIds = $('.reciver-select').val();
        console.log("Selected member IDs:", memberIds);

        const formData = new FormData($('#sendMessage')[0]);
        const addedIds = [];
        
        memberIds.forEach(id => {
            if (!addedIds.includes(id)) {
                formData.append('memberIds', id);
                addedIds.push(id);
            }
        });
        console.log(addedIds);

        $.ajax({
            url: '/flowmate/message/sendMessage', 
            type: 'post',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
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

    $(document).on('click', '.send', function() {
        window.open('/flowmate/message/messageSend','_blank', 'width=600, height=500, scrollbars=yes');
    });

    $(document).on('click', '.add-attachment', function () {
        $('.message-file-input').trigger('click');
    });

    $(document).on('click', '.file-input-btn', function() {
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


const handler = {
		   fileArray: [], // 파일을 관리하는 배열

		    init() {
		        const fileInput = $('.message-file-input');
		        const preview = $('.message-file-preview');

		        // 파일 선택 시 이벤트
		        $(document).on('change', '.message-file-input', function() {
		            const files = Array.from(this.files);

		            // 선택한 파일을 fileArray에 추가
		            files.forEach(file => {
		                // fileArray에 파일이 중복되지 않게 체크
		                if (!handler.fileArray.some(f => f.name === file.name && f.lastModified === file.lastModified)) {
		                    handler.fileArray.push(file);
		                    
		                    // 파일 미리보기 추가
		                    preview.append(
		                        `<div class="message-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.lastModified}">
		                            ${file.name}
		                            <button type="button" class="file-remove btn-close ms-2" data-index="${file.lastModified}"></button>
		                        </div>`
		                    );
		                }
		            });

		            // 파일 개수 업데이트
		            $('.file-count').text(handler.fileArray.length);
		            handler.updateFileInput();
		        });
		    },
		     
		    removeFile() {
		        $(document).on('click', (e) => {
		            if (!$(e.target).hasClass('file-remove')) return;
		            
		            const removeTargetId = $(e.target).data('index');
		            const removeTarget = $('#' + removeTargetId);

		            // fileArray에서 파일 제거
		            handler.fileArray = handler.fileArray.filter(file => file.lastModified != removeTargetId);

		            // 인풋 파일 목록에서도 제거
		            const dataTransfer = new DataTransfer();
		            handler.fileArray.forEach(file => dataTransfer.items.add(file));
		            $('.message-file-input')[0].files = dataTransfer.files;

		            // 미리보기에서 파일 제거
		            removeTarget.remove();
		            
		            // 파일 개수 업데이트
		            $('.file-count').text(handler.fileArray.length);
		            handler.updateFileInput();
		        });
		    },updateFileInput() {
		        const dataTransfer = new DataTransfer();
		        handler.fileArray.forEach(file => dataTransfer.items.add(file));
		        $('.message-file-input')[0].files = dataTransfer.files;
		    }

    
};


function validateMsg(){
    const receiverIds = $('.reciver-select').val(); 
    const messageContent = $(".message-content").val(); 

    if (!receiverIds || receiverIds.length === 0) {
        Toast.fire({
            icon: 'error',
            title: '수신자를 선택하세요.'
        });
        return false; 
    }

    if (!messageContent || messageContent.trim().length === 0) {
        Toast.fire({
            icon: 'error',
            title: '메세지를 입력하세요'
        });
        return false; 
    }

    return true; 
}
