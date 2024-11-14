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


$(document).ready(function() {
    $("#login-btn").click(function(event) {
        event.preventDefault(); 
        
        var memberId = $("#inputId").val();
        var rawPassword = $("#inputPwd").val();
        $.ajax({
            url: "/flowmate/account/checkUserFailure",
            type: "GET",
            data: { memberId: memberId,
            	rawPassword: rawPassword},
            contentType: "application/x-www-form-urlencoded; charset=UTF-8",  // 문자셋 지정
            success: function(response) {
                if (response === "good") {
                    $(".login-form").submit();
                } else {
                    Toast.fire({
                        icon: 'error',
                        title: '로그인 실패',
                        text: response  
                    });
                }
            },
            error: function() {
                Toast.fire({
                    icon: 'error',
                    title: '서버 오류',
                    text: '아이디 검증 중 오류가 발생했습니다.'
                });
            }
        });
    });
});