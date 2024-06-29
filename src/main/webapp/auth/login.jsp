<%----------------------------------------------------------
  이름 : 이유리
  날짜 : 2024-02-18
  내용 : login페이지
----------------------------------------------------------%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login</title>
    <%@include file="/common/bootstrap_common.jsp" %>
    <link rel="stylesheet" href="/css/login.css">

    <script type="text/javascript">

        const loginEnter = (event)=> {
            console.log('loginEnter')
            console.log(window.event.keyCode); // 13
            if(window.event.keyCode==13){
                login();
            }
        }

        const login = () => {
            console.log('login 클릭')
            $.ajax({
                type: "POST",
                url: "/loginProcess",
                data: {
                    emp_no: $('#emp_no').val(),
                    password: $('#password').val()
                },
                success: function (data) {
                    console.log("받아온 data 값 : " + data);
                    if (data === "loginError"){
                        Swal.fire({
                            title: '로그인에 실패하였습니다.',
                            icon: 'warning',
                            confirmButtonColor: '#800000',
                            customClass: {
                                popup: 'swal2-small'
                            }
                        })
                    } else {
                        Swal.fire({
                            title: '로그인에 성공하였습니다',
                            icon: 'success',
                            confirmButtonColor: '#800000',
                            customClass:{
                                popup : 'swal2-small'
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // 확인 버튼을 클릭한 경우 다음 화면으로 이동
                                window.location.href = '/';
                            }
                        })
                    }
                }
            })
        }

        // 모달창 클릭 시 입력값 초기화
        const modalClick = () => {
            $('form').each(function (){
                this.reset();
            });
        };

        const findId = () => {
            $.ajax({
                type: "POST",
                url: "findId",
                data: {
                    name: $('#name').val(),
                    email: $('#email').val()
                },
                success: function (data) {
                    console.log("받아온 data 값 : " + data);
                    if (data != "") {
                        Swal.fire({
                            title: "사원번호는 " + data + " 입니다.",
                            icon: false,
                            confirmButtonColor: '#800000',
                            customClass: {
                                popup: 'swal2-small'
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                $('.modal').modal('hide');

                            }
                        })
                    } else {
                        Swal.fire({
                            title: '일치하는 정보가 없습니다.',
                            icon: 'warning',
                            confirmButtonColor: '#800000',
                            customClass: {
                                popup: 'swal2-small'
                            }
                        })
                    }
                }
            })
        }

        const findPw = () => {
            console.log('findPw 클릭')
            const emp_no = $('#floatingPW_id').val();

            $.ajax({
                type: "POST",
                url: "findPw",
                data: {
                    emp_no: emp_no
                },
                success: function (data) {
                    console.log("받아온 data 값 : " + data);
                    if (data != "") {
                        sendEmail(data, emp_no);
                    } else {
                        Swal.fire({
                            title: '일치하는 정보가 없습니다.',
                            icon: 'warning',
                            confirmButtonColor: '#800000',
                            customClass: {
                                popup: 'swal2-small'
                            }
                        })
                    }
                }
            });
        }

        // 2024.05.14 리팩토링_이메일 전송 알림창
        const sendEmail = (email, emp_no) => {
            console.log('sendEmail 실행');
            Swal.fire({
                title: '이메일로 임시비밀번호를 보내드렸습니다.',
                icon: 'success',
                confirmButtonColor: '#800000',
                customClass:{
                    popup : 'swal2-small'
                }
            }).then((result) => {
                    if (result.isConfirmed) {
                        $('.modal').modal('hide');
                    }
            })
            $.ajax({
                type: "POST",
                url: "sendPassword",
                data: {
                    email: email,
                    emp_no : emp_no
                },
                success: function (resource) {
                    console.log("성공여부 : " + resource);
                }
            });
        }

        //
        // $(document).ready(() => {
        //     const key = getCookie("key");
        //     $("#emp_no").val(key);
        //
        //     if ($("#emp_no").val() !== "") {
        //         $("#remember-me").attr("checked", true);
        //     }
        //
        //     $("#remember-me").change(() => {
        //         if ($("#remember-me").is(":checked")) {
        //             setCookie("key", $("#emp_no").val(), 7);
        //         } else {
        //             deleteCookie("key");
        //         }
        //     });
        //
        //     $("#emp_no").keyup(() => {
        //         if ($("#remember-me").is(":checked")) {
        //             setCookie("key", $("#emp_no").val(), 7);
        //         }
        //     });
        // });

        document.addEventListener('DOMContentLoaded', () => {
            const key = getCookie("key");
            const empNoInput = document.getElementById("emp_no");
            const rememberMeCheckbox = document.getElementById("remember-me");

            empNoInput.value = key;

            // 처음 페이지 로딩 시, key 값이 있다면 체크박스를 체크
            if (empNoInput.value !== "") {
                rememberMeCheckbox.checked = true;
            }

            // 체크박스에 변화가 있을 때
            rememberMeCheckbox.addEventListener('change', () => {
                if (rememberMeCheckbox.checked) {
                    setCookie("key", empNoInput.value, 7);
                } else {
                    deleteCookie("key");
                }
            });

            // 입력필드에 입력 할 때마다 체크박스 상태 확인
            empNoInput.addEventListener('keyup', () => {
                if (rememberMeCheckbox.checked) {
                    setCookie("key", empNoInput.value, 7);
                }
            });
        });

        const setCookie = (cookieName, value, exdays) => {
            const exdate = new Date();
            // 현재 날짜에 유효기간을 더해 만료날짜 설정
            exdate.setDate(exdate.getDate() + exdays);
            // expires는 쿠키의 만료 날짜를 지정하는 표준 속성
            const cookieValue = encodeURIComponent(value) + ((exdays === null) ? "" : "; expires=" + exdate.toGMTString());
            console.log("cookieValue : " + cookieValue); //cookieValue : 1004; expires=Sat, 06 Jul 2024 07:12:54 GMT
            document.cookie = `\${cookieName}=\${cookieValue}`;
            // document.cookie = cookieName + "=" + cookieValue;
        };

        const deleteCookie = (cookieName) => {
            const expireDate = new Date();
            // 현재날짜보다 -1을 해서 과거 날짜로 입력하여 즉시 삭제하도록 구현
            expireDate.setDate(expireDate.getDate() - 1);
            document.cookie = `\${cookieName}=; expires=\${expireDate.toGMTString()}`;
            // document.cookie = cookieName + "= " + "; expires="
            //     + expireDate.toGMTString();
        };

        const getCookie = (cookieName) => {
            const name = `\${cookieName}=`; // key=
            // name = cookieName + '=';
            const cookieData = document.cookie; // key=1004
            let start = cookieData.indexOf(name); // 0
            let cookieValue = '';
            if (start !== -1) {
                start += name.length;
                // ; 문자가 있는 곳이 쿠키의 끝
                let end = cookieData.indexOf(';', start);
                // ; 문자가 없다면 문자열 마지막이 쿠키의 끝
                if (end === -1) end = cookieData.length;
                // 쿠키 값만 추출
                cookieValue = cookieData.substring(start, end); // 1004
            }
            return decodeURIComponent(cookieValue);
        };

    </script>
</head>
<body>
<section>
    <div class="login-container">
        <form class="login-form"  id="f_login" action="/loginProcess" method="post">
            <h1 class="mb-4">로그인</h1>
            <p class="mb-4">KIWOOM 구단에 오신 것을 환영합니다.</p>
            <div class="mb-1">
                <label for="emp_no" class="form-label">사원번호</label>
                <input type="text" id="emp_no" name="emp_no" class="form-control" placeholder="사원번호를 입력하세요." onkeyup="loginEnter()">
            </div>
            <div class="m-2 login-options">
                <input type="checkbox" id="remember-me" class="form-check-input">
                <label for="remember-me" class="form-check-label">사원번호 기억하기</label>
            </div>
            <div class="mb-2">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control "  placeholder="비밀번호를 입력하세요." onkeyup="loginEnter()">
            </div>
            <button type="button" class="btn btn-sm btn-outline-dark" onclick="login()">LOGIN</button>
            <div class="d-flex justify-content-between mt-2 gap-2" >
                <button type="button" class="btn btn-sm btn-outline-dark" data-bs-toggle="modal" data-bs-target="#findID" onclick="modalClick()">사원번호찾기</button>
                <button type="button" class="btn btn-sm btn-outline-dark" data-bs-toggle="modal" data-bs-target="#findPW">비밀번호찾기</button>
            </div>
        </form>
    </div>
</section>

<!-- ========================== [[ find ID Modal Start ]] ========================== -->
<div class="modal" id="findID">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content rounded-4 shadow">
            <div class="modal-header p-5 pb-4 border-bottom-0">
                <h1 class="fw-bold mb-0 fs-2">사원번호 찾기</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-5 pt-0">
                <form id="f_findId" method="post" action="/findId">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control rounded-3" id="name" name="name" placeholder="Leave a comment here">
                        <label for="name">이름 입력</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="email" class="form-control rounded-3" id="email" name="email" placeholder="name@example.com">
                        <label for="email">이메일주소 입력</label>
                    </div>
                    <button type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" style="background-color: #652C2C;"  onclick="findId()">찾기</button>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- ========================== [[ find ID Modal End ]] ========================== -->

<!-- ========================== [[ find PW Modal Start ]] ========================== -->
<div class="modal " id="findPW">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content rounded-4 shadow">
            <div class="modal-header p-5 pb-4 border-bottom-0">
                <h1 class="fw-bold mb-0 fs-2">비밀번호 찾기</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <div class="modal-body p-5 pt-0">
                <form id="f_findPw" method="post" action="">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control rounded-3" id="floatingPW_id" name="emp_no" placeholder="ID">
                        <label for="floatingPW_id">사원번호 입력</label>
                    </div>
                    <button type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-primary"  style="background-color: #652C2C;" onclick="findPw()">찾기</button>
                    <small class="text-body-secondary">입력하신 이메일로 임시비밀번호를 보내드립니다.</small>
                </form>
            </div>
        </div>
    </div>
</div>
<!-- ========================== [[ find PW Modal End ]] ========================== -->
</body>
</html>