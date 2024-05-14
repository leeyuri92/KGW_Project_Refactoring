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
            $.ajax({
                type: "POST",
                url: "findPw",
                data: {
                    emp_no: $('#floatingPW_id').val()
                },
                success: function (data) {
                    console.log("받아온 data 값 : " + data);
                    if (data != "") {
                        sendEmail(data);
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
        const sendEmail = (email) => {
            console.log('sendEmail 실행');
            Swal.fire({
                title: '이메일로 임시비밀번호를 보내드렸습니다.',
                icon: 'success',
                confirmButtonColor: '#800000',
                customClass:{
                    popup : 'swal2-small'
                }
            })
            $.ajax({
                type: "POST",
                url: "sendPassword",
                data: {email: email},
                success: function (resource) {
                    console.log("성공여부 : " + resource);
                }
            });
        }
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
<%--            <div class="m-2 login-options">--%>
<%--                <input type="checkbox" id="remember-me" class="form-check-input">--%>
<%--                <label for="remember-me" class="form-check-label">사원번호 기억하기</label>--%>
<%--            </div>--%>
            <div class="mb-2">
                <label for="password" class="form-label">비밀번호</label>
                <input type="password" id="password" name="password" class="form-control "  placeholder="비밀번호를 입력하세요." onkeyup="loginEnter()">
            </div>
            <button type="button" class="btn btn-sm btn-outline-dark" onclick="login()">LOGIN</button>
            <div class="d-flex justify-content-between mt-2 gap-2" >
                <button type="button" class="btn btn-sm btn-outline-dark" data-bs-toggle="modal" data-bs-target="#findID">사원번호찾기</button>
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
                        <input type="text" class="form-control rounded-3" id="floatingPW_id" name="emp" placeholder="ID">
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