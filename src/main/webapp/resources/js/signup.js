const Toast = Swal.mixin({
    toast: true,
    position: 'top',
    showConfirmButton: false,
    timer: 2500,
    timerProgressBar: true,
    didOpen: (toast) => {
        toast.addEventListener('mouseenter', Swal.stopTimer);
        toast.addEventListener('mouseleave', Swal.resumeTimer);
    }
});

// 이름 유효성 검사
let inputName = document.querySelector('#inputName');
inputName.addEventListener('input', inputNameCheck);

function inputNameCheck() {
    let inputNameMessage = document.querySelector('#inputNameMessage');
    let regExp = RegExp(/^[가-힣a-zA-Z]{1,20}$/);

    if (inputName.value.trim() === '') {
        inputNameMessage.innerHTML = '';
        return;
    }

    if (regExp.test(inputName.value)) {
        inputNameMessage.innerHTML = '';
    } else {
        inputNameMessage.innerHTML = "<span>영문 또는 한글로 입력해주세요.</span>";
    }
}

// 아이디 유효성 검사 및 중복 체크
let memberId = document.querySelector('#inputId');
memberId.addEventListener('input', chkVaildId);

function chkVaildId() {
    let inputIdMessage = document.querySelector('#inputIdMessage');
    let regExp = RegExp(/^[a-zA-Z0-9_]{6,16}$/);

    if (memberId.value.trim() === '') {
        inputIdMessage.innerHTML = '';
        return false;  // 빈 입력일 경우 false 반환
    }

    if (regExp.test(memberId.value)) {
        inputIdMessage.innerHTML = ''; 
        return true;  // 유효한 경우 true 반환
    } else {
        inputIdMessage.innerHTML = "<span>아이디는 6자 이상 16자 이하만 가능합니다. (숫자, 알파벳, _ 만 가능)</span>";
        return false;  // 유효하지 않은 경우 false 반환
    }
}

let hasIdChecked = false;

function idDuplicateChk() {
    if (!chkVaildId()) {
        Toast.fire({
            icon: 'error',
            title: '아이디를 올바르게 입력해 주세요.'
        });
        return;
    }

    let memberIdValue = $('#inputId').val().trim();

    $.ajax({
        url: "idDuplicateChk",
        type: "post",
        contentType: "application/x-www-form-urlencoded",
        dataType: "json",
        data: { memberId: memberIdValue },
        success: function(checkResult) {
            console.log(checkResult);
            if (checkResult) {
                hasIdChecked = true;
                Toast.fire({
                    icon: 'success',
                    title: '사용 가능한 아이디입니다.'
                });
            } else {
                hasIdChecked = false;
                Toast.fire({
                    icon: 'error',
                    title: '이미 존재하는 아이디입니다.'
                });
            }
        }
    });
}

function checkIdStatus() {
    if (!hasIdChecked) {
        Toast.fire({
            icon: 'error',
            title: '아이디 중복체크는 필수입니다.'
        });
        return false;
    }
    return true;
}

// 비밀번호 유효성 검사
let memberPwd = document.querySelector('#inputPwd');
let memberPwdChk = document.querySelector('#inputPwdChk');
memberPwd.addEventListener('input', inputPasswordCheck);
memberPwdChk.addEventListener('input', inputPasswordCheck);

function inputPasswordCheck() {
    let inputPwdMessage = document.querySelector('#inputPwdMessage');
    let inputPwdChkMessage = document.querySelector('#inputPwdChkMessage');
    let regExp = RegExp(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_])[A-Za-z\d@$!%*?&_]{8,20}$/);

    if (memberPwd.value.trim() === '') {
        inputPwdMessage.innerHTML = '';
    } else if (regExp.test(memberPwd.value)) {
        inputPwdMessage.innerHTML = '';
    } else {
        inputPwdMessage.innerHTML = "<span>8자 이상 20자 이하의 알파벳 대소문자, 숫자, 특수문자를 조합해주세요.</span>";
    }

    if (memberPwd.value === memberPwdChk.value) {
        inputPwdChkMessage.innerHTML = '';
    } else {
        inputPwdChkMessage.innerHTML = "<span>비밀번호를 확인해주세요.</span>";
    }
}

function isValid() {
    let errorMessageStatus = false;
    $('.errorMessage').each(function () {
        if ($(this).children('span').length != 0) {
            errorMessageStatus = true;
            return false;
        }
    });
    return errorMessageStatus;
}

function signup() {
    const signupData = $('.signup-form').serialize();

    if (isValid()) {
        Toast.fire({
            icon: 'error',
            title: '입력값을 확인해주세요.'
        });
        return;
    }

    let hasEmptyField = false;
    $('input').each(function() {
        if ($(this).val().trim() === '') {
            hasEmptyField = true;
            return false;
        }
    });

    if (hasEmptyField) {
        Toast.fire({
            icon: 'error',
            title: '모든 입력값은 필수입니다.'
        });
        return;
    }

    if (checkIdStatus()) {
        $.ajax({
            url: 'signup',
            type: 'post',
            data: signupData,
            success: function(signupResult) {
                if (signupResult) {
                    Toast.fire({
                        title: '회원가입이 완료되었습니다.',
                        icon: 'success',
                    }).then(function(result) {
                        if (result.isConfirmed) {
                            window.location.href = '../';
                        } else {
                            window.location.href = '../account/loginForm';
                        }
                    });
                }
            }
        });
    }
}

function resetSignupForm() {
    document.forms['signup'].reset();
    $('#inputName').val('');
    $('#inputId').val('');
    $('#inputPwd').val('');
    $('#inputPwdChk').val('');
    $('#inputNameMessage').text('');
    $('#inputIdMessage').text('');
    $('#inputPwdMessage').text('');
    $('#inputPwdChkMessage').text('');
}

$(document).ready(function () {
    resetSignupForm();

    document.querySelector('.idDuplicateChk-btn').addEventListener('click', function() {
        if (chkVaildId()) {
            idDuplicateChk(); // 유효성 검사를 통과한 경우에만 중복 확인 호출
        } else {
            Toast.fire({
                icon: 'error',
                title: '아이디를 올바르게 입력해 주세요.'
            });
        }
    });

    $('#inputId').on('input', function() {
        hasIdChecked = false;
    });

    $('#signup-btn').on('click', function() {
        signup();
    });
});
