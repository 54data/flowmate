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
	var titleInput = document.getElementById("notice-title-input").value;
	var contentInput = document.getElementById("exampleTextarea").value;
	
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

$('#notice-title-input').keyup(function (e){
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

$('#exampleTextarea').keyup(function (e){
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
    $(document).on('click', '.btn-download', function() {
        const fileId = $(this).data('file-id');
        window.location.href = '/flowmate/notice/downloadFile?fileId=' + fileId;
    });
});
