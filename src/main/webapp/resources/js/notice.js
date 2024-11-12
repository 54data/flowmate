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
    console.log("내용:", contentInput);
    
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
    var contentUpdateInput = $('#noticeUpdateContent').summernote('code').trim();
    console.log("내용:", contentUpdateInput);
    
    if (titleUpdateInput.length == 0) {
        Toast.fire({
            icon: 'error',
            title: '제목을 입력해주세요.'
        });
        return false;
    }

    if (contentUpdateInput === '<p><br></p>') {
        Toast.fire({
            icon: 'error',
            title: '내용을 입력해주세요.'
        });
        return false;
    }
    return true;
}

$(document).ready(function() {
    // 공지사항 목록
	// 테이블 헤더의 텍스트를 기반으로 columns 설정 자동 생성
    let columns = $('#noticeTable thead th').map(function() {
        return { data: $(this).text().trim() };
    }).get();
    
    let table = $('#noticeTable').DataTable({
		order: [0, 'desc'],
		orderClasses: true,
		columns: columns,
		columnDefs: [
			{
				targets: [0], 
				render: function(data, type, row) {
				    if (type === 'sort' || type === 'type') {
				    	return parseInt(data, 10);
				    }
				    return data;
				}
			},
			{targets: [1], orderable: false},
			{targets: [2], orderable: false},
			{
				targets: [3], 
				render: function(data, type, row) {
				    if (type === 'sort' || type === 'type') {
				        return parseInt(data, 10);
				    }
				    return data;
				}
			},
			{targets: [4], type: 'num-fmt'}
		],
        createdRow: function(row, data, dataIndex) {
            $(row).on('click', function() {
                const projectId = $(this).data('project-id');
                const noticeId = $(this).data('notice-id');
                window.location.href = '../../flowmate/notice/noticeDetail?projectId=' + projectId + '&noticeId=' + noticeId;
            });
        }
	});
    
    let columnIndex = 1; // 기본 select 옵션 값인 "프로젝트명" 컬럼의 인덱스
    
    // select 옵션 변경 시 검색할 컬럼 인덱스 업데이트
    $('#myNoticeSelect').on('change', function() {
        var selectedOption = $(this).val();
        
        // 컬럼 이름을 기준으로 인덱스 찾기
        columnIndex = table.columns().eq(0).filter(function(index) {
            return table.column(index).dataSrc() === selectedOption;
        })[0];
        
        // 현재 검색 입력창의 값을 사용하여 새로운 컬럼으로 검색 설정
        var searchTerm = $('#myNoticeInput').val();
        table.columns().every(function() {
            if (this.index() === columnIndex) {
                this.search(searchTerm); // 선택된 컬럼에만 검색어 적용
            } else {
                this.search(''); // 다른 컬럼은 검색어 초기화
            }
        });
        
        table.draw();
    });

    $('#myNoticeInput').on('input keyup', function() {
        var searchTerm = this.value;

        if (searchTerm === '') {
            table.search('').columns().search(''); // 전체 검색 초기화
        } else {
            table.column(columnIndex).search(searchTerm); // 선택된 컬럼에만 검색어 적용
        }
        table.draw();
    });
		
    $('#myNoticeInput').on('keydown', function(e) {
        if (e.key === 'Enter') {  
            e.preventDefault();  
        }
    });

    // 공지사항 폼
	$(document).on('click', '.notice-file-input-btn', function() {
		$('.notice-file-input').trigger('click');
	});
	
/*	$('#noticeTable').DataTable({
		searching: true,
	});
*/	
    if ($('#noticeContent').length) {
        $('#noticeContent').summernote({
            height: 600,
            minHeight: null,
            maxHeight: null,
            focus: true,
            lang: "ko-KR"
        });
    }

    if ($('#noticeUpdateContent').length) {
        $('#noticeUpdateContent').summernote({
            height: 600,
            minHeight: null,
            maxHeight: null,
            focus: true,
            lang: "ko-KR"
        });
    }

	
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
	    	    
	    const formData = noticeHandler.getFormData();
	    
	    const projectId = $(this).data("project-id");
	    
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
	    	    
	    const formData = noticeHandler.getFormData();
	    
	    const projectId = $(this).data("project-id");
	    const noticeId = $(this).data("notice-id");

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
let customFiles = [];

const noticeHandler = {
	    maxFileSize: 20 * 1024 * 1024, // 20MB
	    maxFileCount: 3,

	    init() {
	        const fileInput = $('.notice-file-input');
	        const preview = $('.notice-file-preview');
	        
	        $(document).on('change', '.notice-file-input', (event) => {
	            const files = Array.from(event.target.files);
	            
	            // const currentFileCount = preview.find('.notice-file').length;
	            const currentFileCount = customFiles.length;
	            const totalFileCount = currentFileCount + files.length;

	            if (totalFileCount > this.maxFileCount) {
	                Toast.fire({
	                    icon: 'error',
	                    title: '제한 초과',
	                    text: '첨부파일은 최대 3개까지만 업로드할 수 있습니다.'
	                });
	                return;
	            }

	            // 파일 크기 검사
	            for (const file of files) {
	                if (file.size > this.maxFileSize) {
	                    Toast.fire({
	                        icon: 'error',
	                        title: '제한 초과',
	                        text: '첨부파일 크기는 20MB 이하로 제한됩니다.'
	                    });
	                    return;
	                }
	            }
	            
	            // 유효성 검사를 통과한 경우 파일 미리보기 추가
	            files.forEach(file => {
	            	customFiles.push(file);
	                preview.append(
	                    `<div class="notice-file d-inline-flex me-2 mt-2 align-items-center p-2 px-3 border" id="${file.lastModified}">
	                        ${file.name}
	                        <button type="button" class="file-remove btn-close ms-2" data-index="${file.lastModified}"></button>
	                    </div>`
	                );
	            });
	            
	            $('.notice-files-count').text($('.notice-file-preview').find('.notice-file').length);
	        });
	    },
	     
	    removeFile() {
	        $(document).on('click', (e) => {
	            if (!$(e.target).hasClass('file-remove')) return;
	            const removeTargetId = $(e.target).data('index');
	            const removeTarget = $('#' + removeTargetId);
	            
	            customFiles = customFiles.filter(file => file.lastModified != removeTargetId);
	            deletedFileIds.push(removeTargetId);

	            removeTarget.remove();
	            $('.notice-files-count').text($('.notice-file-preview').find('.notice-file').length);
	        });
	    },
	    
	    getFormData() {
	        const formData = new FormData();
	        
	        customFiles.forEach(file => {
	            formData.append('noticeAttaches', file);
	        });
	        
	        deletedFileIds.forEach(id => {
	        	formData.append('existingFileIds', id);
	        });

	        return formData;
	    }
	};
