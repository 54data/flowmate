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

    if (titleInput.length == 0) {
        Toast.fire({
            icon: 'error',
            title: '제목을 입력해주세요.'
        });
        return false;
    }

    if (contentInput.length == 0) {
        Toast.fire({
            icon: 'error',
            title: '내용을 입력해주세요.'
        });
        return false;
    }
    return true;
}

function validateUpdateForm(){
    var titleUpdateInput = document.getElementById("noticeUpdateTitle").value;
    var contentUpdateInput = document.getElementById("noticeUpdateContent").value;

    if (titleUpdateInput.length == 0) {
        Toast.fire({
            icon: 'error',
            title: '제목을 입력해주세요.'
        });
        return false;
    }

    if (contentUpdateInput.length == 0) {
        Toast.fire({
            icon: 'error',
            title: '내용을 입력해주세요.'
        });
        return false;
    }
    return true;
}

$(document).ready(function() {
	$(document).on('click', '.notice-file-input-btn', function() {
		$('.notice-file-input').trigger('click');
	});
	
	$('#noticeTable').DataTable({
		searching: false,
	});
	
	$('#noticeContent').summernote({
		  height: 600,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR"					// 한글 설정
	});

	$('#noticeUpdateContent').summernote({
		  height: 600,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR"					// 한글 설정
	});

	noticeHandler.init();
	noticeHandler.removeFile();
	
	$('#noticeTitle').keyup(function () {
	    var content = $(this).val();
	    $('#titleLength').html("(" + content.length + "/50)");

	    if (content.length > 50) {
	        Toast.fire({
	            icon: 'error',
	            title: '제목 글자수가 50자를 초과하였습니다.'
	        });
	        
	        $(this).val(content.substring(0, 50)); // 글자 수 제한
	        $('#titleLength').html("(50/50)");
	    }
	});


	$('#noticeUpdateTitle').keyup(function () {
	    var content = $(this).val();
	    $('#updateTitleLength').html("(" + content.length + "/50)");

	    if (content.length > 50) {
	        Toast.fire({
	            icon: 'error',
	            title: '제목 글자수가 50자를 초과하였습니다.'
	        });
	        
	        $(this).val(content.substring(0, 50)); // 글자 수 제한
	        $('#updateTitleLength0').html("(50/50)");
	    }
	});

	
	
	/*공지사항 등록*/
	$('#noticeInsert-btn').on('click', function(event) {
	    event.preventDefault(); 
	    
	    if (!validateForm()) {
	        return;
	    }
	    
	    var formData = new FormData();
	    
	    const projectId = $(this).data("project-id");
	    
	    var noticeAttaches = $('#noticeAttach')[0].files;
        const maxFileSize = 20 * 1024 * 1024; // 20MB
        const maxFileCount = 3;
	    
        if (noticeAttaches.length > maxFileCount) {
            Toast.fire({
                icon: 'error',
                title: '제한 초과',
                text: '첨부파일은 최대 3개까지만 업로드할 수 있습니다.'
            });
            return;
        }

        for (var i = 0; i < noticeAttaches.length; i++) {
            if (noticeAttaches[i].size > maxFileSize) {
            	Toast.fire({
                    icon: 'error',
                    title: '제한 초과',
                    text: '첨부파일 크기는 20MB 이하로 제한됩니다.'
                });
                return;
            }
        }
	    	    
	    for (var i = 0; i < noticeAttaches.length; i++) {
	        formData.append('noticeAttaches', noticeAttaches[i]);
	    }
	    
	    
	    formData.append('noticeTitle', $('#noticeTitle').val());
	    formData.append('noticeContent', $('#noticeContent').val());
	    formData.append('projectId', projectId);
	    
	    $.ajax({
	        url: '/flowmate/notice/insertNotice', 
	        type: 'POST', 
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(response) {
	            console.log('공지사항 등록 성공');
	            console.log("선택된 파일 수: " + noticeAttaches.length);
	            console.log('파일 업로드 성공:', response);
	            Toast.fire({
	    		    icon: 'success',
	    		    title: '등록을 성공하였습니다.'
	    		});

	            setTimeout(function() {
	                window.location.href = '/flowmate/notice/noticeList?projectId='+projectId+'&pageNo=1';
	            }, 2500);
	        },
	        error: function(error) {
	            console.error('공지사항 등록 실패');
	            console.error(error);
	        }
	    });
	});

	/*공지사항 수정*/
	$('#noticeUpdate-btn').on('click', function(event) {
	    event.preventDefault(); 
	    
	    if (!validateUpdateForm()) {
	        return;
	    }
	    
	    var formData = new FormData();
	    const projectId = $(this).data("project-id");
	    const noticeId = $(this).data("notice-id");
	    
	    var noticeAttaches = $('#noticeUpdateAttach')[0].files;
        const maxFileSize = 20 * 1024 * 1024; // 20MB
        const maxFileCount = 3;

        if (noticeAttaches.length > maxFileCount) {
            Toast.fire({
                icon: 'error',
                title: '제한 초과',
                text: '첨부파일은 최대 3개까지만 업로드할 수 있습니다.'
            });
            return;
        }

        for (var i = 0; i < noticeAttaches.length; i++) {
            if (noticeAttaches[i].size > maxFileSize) {
            	Toast.fire({
                    icon: 'error',
                    title: '제한 초과',
                    text: '첨부파일 크기는 20MB 이하로 제한됩니다.'
                });
                return;
            }
        }
	    
	    for (var i = 0; i < noticeAttaches.length; i++) {
	        formData.append('noticeAttaches', noticeAttaches[i]);
	    }

	    deletedFileIds.forEach(id => formData.append('existingFileIds', id));

	    formData.append('noticeTitle', $('#noticeUpdateTitle').val());
	    formData.append('noticeContent', $('#noticeUpdateContent').val());
	    formData.append('projectId', projectId);
	    formData.append('noticeId', noticeId);
	    
	    $.ajax({
	        url: '/flowmate/notice/updateNotice', 
	        type: 'POST', 
	        data: formData,
	        processData: false,
	        contentType: false,
	        success: function(response) {
	            console.log('공지사항 수정 성공');
	            console.log("선택된 파일 수: " + noticeAttaches.length);

	            Toast.fire({
	    		    icon: 'success',
	    		    title: '수정을 성공하였습니다.'
	    		});

	            setTimeout(function() {
	                window.location.href = '/flowmate/notice/noticeList?projectId='+projectId+'&pageNo=1';
	            }, 2500);
	        },
	        error: function(error) {
	            console.error('공지사항 등록 실패');
	            console.error(error);
	        }
	    });
	});

	/*공지사항 비활성화*/
	$('#noticeDisable-btn').on('click', function(event) {
	    event.preventDefault(); 
	    
	    const projectId = $(this).data("project-id");
	    const noticeId = $(this).data("notice-id");
	    
		Swal.fire({
		    title: '정말 비활성하시겠습니까?',
		    text: "이 작업은 되돌릴 수 없습니다.",
		    icon: 'warning',
		    showCancelButton: true,
		    confirmButtonColor: '#3085d6',
		    cancelButtonColor: '#d33',
		    confirmButtonText: '네, 비활성화할게요!',
		    cancelButtonText: '아니요, 취소할게요!'
		}).then((result) => {
		    if (result.isConfirmed) {
			    $.ajax({
			        url: '/flowmate/notice/enabledNotice', 
			        type: 'POST', 
			        data: { noticeId: noticeId,
			        	projectId: projectId},
			        success: function(response) {
			            console.log('공지사항 비활성화 성공');

			            Toast.fire({
			    		    icon: 'success',
			    		    title: '공지사항이 비활성화되었습니다.'
			    		});
			            setTimeout(function() {
			                window.location.href = '/flowmate/notice/noticeList?projectId='+projectId+'&pageNo=1';
			            }, 2500);
			        },
			        error: function(error) {
			            console.error('공지사항 비활성화 실패');
			            console.error(error);
			        }
			    });
		    } else {
		        console.log("삭제가 취소되었습니다.");
		        }
		    });
	});

})

let deletedFileIds = [];

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
			deletedFileIds.push(removeTargetId);
			
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

