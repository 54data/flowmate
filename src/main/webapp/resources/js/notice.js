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


function validateForm(){
	var titleInput = document.getElementById("noticeTitle").value;
	var contentInput = document.getElementById("noticeContent").value;
	
	if(titleInput.length == 0){
		Toast.fire({
		    icon: 'error',
		    title: '제목을 입력해주세요.'
		});
		return false;
	}
	
	if(contentInput.length == 0){
		Toast.fire({
		    icon: 'error',
		    title: '내용을 입력해주세요.'
		});
		return false;
	}	
}

$('#noticeTitle').keyup(function (e){
	var content = $(this).val();
	$('#titleLength').html("("+content.length+"/50)");
	
	if(content.length > 50){
		Toast.fire({
		    icon: 'error',
		    title: '제목 글자수가 50자를 초과하였습니다.'
		});
		return false;
	}
})

$('#noticeContent').keyup(function (e){
	var content = $(this).val();
	$('#contentsLength').html("("+content.length+"/2000)");
	
	if(content.length > 2000){
		Toast.fire({
		    icon: 'error',
		    title: '내용 글자수가 2000자를 초과하였습니다.'
		});
		return false;
	}
})

$(document).ready(function() {
	$(document).on('click', '.notice-file-input-btn', function() {
		$('.notice-file-input').trigger('click');
	});
	
	noticeHandler.init();
	noticeHandler.removeFile();
})

const noticeHandler = {
	init() {
		const fileInput = $('.notice-file-input');
		const preview = $('.file-preview');
		
		$(document).on('change', '.notice-file-input', function() {
			console.dir(fileInput);
			const files = Array.from(this.files);
			files.forEach(file => {
				preview.append(
					`<div class="notice-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.lastModified}">
						${file.name}
						<button type="button" class="file-remove btn-close ms-2" data-index="${file.lastModified}"></button>
					</div>`);
			});
		});
	},
	 
	removeFile() {
		$(document).on('click', (e) => {
			if (!$(e.target).hasClass('file-remove')) return;
			const removeTargetId = $(e.target).data('index');
			const removeTarget = $('#' + removeTargetId);
			const files = $('.notice-file-input')[0].files;
			const dataTransfer = new DataTransfer();
			
	        Array.from(files)
	            .filter(file => file.lastModified != removeTargetId)
	            .forEach(file => {
	                dataTransfer.items.add(file);
	            });
	        $('.notice-file-input')[0].files = dataTransfer.files;
	        removeTarget.remove();
		});
	}
};

$('#insertBtn').on('click', function(event) {
    event.preventDefault(); 
    var formData = new FormData();

    var noticeAttaches = $('#noticeAttach')[0].files;
    for (var i = 0; i < noticeAttaches.length; i++) {
        formData.append('noticeAttach', noticeAttaches[i]);
    }

    formData.append('noticeTitle', $('#noticeTitle').val());
    formData.append('noticeContent', $('#noticeContent').val());
    
    $.ajax({
        url: '/flowmate/notice/insertNotice', 
        type: 'POST', 
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            console.log('공지사항 등록 성공');
            console.log("선택된 파일 수: " + noticeAttaches.length);
            window.location.href = '/flowmate/notice/noticeList?pageNo=1';
        },
        error: function(error) {
            console.error('공지사항 등록 실패');
            console.error(error);
        }
    });
});
