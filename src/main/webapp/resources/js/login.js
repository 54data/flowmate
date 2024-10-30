function showLoginError(message) {
    Swal.fire({
        icon: 'error',
        title: '로그인 실패',
        text: '${loginError}',
        confirmButtonText: '확인'
    });
}
