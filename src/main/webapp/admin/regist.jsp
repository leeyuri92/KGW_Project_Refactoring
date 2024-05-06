<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>사원추가</title>
    <%@include file="/common/bootstrap_common.jsp" %>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script type="text/javascript">

        const memberInsert = () => {
            if (validateForm()) {
                // 유효성 검사 성공 시, 폼을 제출합니다.
                Swal.fire("사원추가 완료!", "", "success")
                    .then((result) => {
                        if (result.isConfirmed || result.isDismissed) {
                            document.querySelector("#f_member").submit();
                        }
                    });
            } else {
                // 유효성 검사 실패 시, 오류 메시지를 표시하거나 적절한 조치를 취합니다.
                Swal.fire("오류!", "사원추가 양식을 올바르게 입력해주세요.", "error");
            }
        };

    /* 자바 스크립트 부분 */
    </script>
</head>
<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <!-- header start -->
    <%@include file="/include/KGW_bar.jsp"%>
    <!-- header end    -->

    <!-- body start    -->
    <div class="content-wrapper">
        <!-- 페이지 path start    -->
        <%-- <div class="card" >--%>
        <div class="box-header p-4">
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">관리자페이지</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">사원추가</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0"></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">사원추가</div>
                    <div class="text-muted ms-3">사원을 추가 할 수 있는 페이지입니다.</div>
                </div>
            </div>
        </div>
        <!-- 페이지 path end -->
        <div class="content">
            <div class="box">
                <div class="container">
                    <div class="box-header">
                        <h4 style="font-weight: bold; margin-left: 2rem" >사원추가</h4>
                        <hr />
                    </div>
                    <form  id="f_member" method="post" action="/admin/regist">
                        <div class="row">
                            <div class="col-6 mb-3 mt-3">
                            <label for="name">이름 <span class="text-danger">*</span>
                             <span id="name_" class="text-danger" style="display:none" > 2~5글자로 입력해주세요. </span>
                            </label>
                                  <input type="text" class="form-control" id="name" name="name" onblur="validateName()"  placeholder="이름를 입력하세요.">
                            </div>
                                <div class="col-6 mb-3 mt-3">
                                    <label for="password">비밀번호 <span class="text-danger">*</span>
                                        <span id="password_" class="text-danger" style="display:none"> 대소문자나 숫자 4~12자리로 입력하세요.</span></label>
                                    <input type="password" class="form-control" id="password" name="password"  onblur="validatePassword()"   placeholder="비밀번호를 입렵하세요.">
                                </div>
                             </div>

                            <div class="row">
                                <div class="col-6 mb-3 mt-3">
            <label for="birthdate">생년월일 <span class="text-danger">*</span>
                <span id="birthdate_" class="text-danger" style="display:none"  >생년월일 형식이 아닙니다.</span> </label>
            <input type="date" class="form-control" id="birthdate"  name="birthdate" onblur="validateBirthdate()">
        </div>

                                <div class="col-6 mb-3 mt-3">
            <label for="phone_num">전화번호 <span class="text-danger">*</span>
                <span id="phone_num_" class="text-danger" style="display:none"  >전화번호 형식이 아닙니다.</span> </label>
            <input type="tel" class="form-control" id="phone_num" name="phone_num" onblur="validatePhone()" placeholder="전화번호를 입력해주세요.">
        </div>
        </div>

                        <div class="row">
                            <div class="col-6 mb-3 mt-3">
            <label for="email">이메일 <span class="text-danger">*</span>
                <span id="email_" class="text-danger" style="display:none"  >이메일형식이 아닙니다.</span> </label>
            <input type="email" class="form-control" id="email" name="email" onblur="validateEmail()" placeholder="이메일을 입력해주세요.">
        </div>

                            <div class="col-6 mb-3 mt-3">
            <label for="address">주소 <span class="text-danger">*</span>
                <span id="address_" class="text-danger" style="display:none">주소형식이 아닙니다.</span> </label>
            </label>
            <div class="input-group">
                <input type="text" class="form-control" id="address" name="address" onblur="validateAddress()" placeholder="우편번호" aria-describedby="search-btn">
                <div class="input-group-append">
                    <button class="btn btn-success" type="button" id="search-btn" onclick="openZipcode()">검색</button>
                </div>
            </div>
            </div>
        </div>

                        <div class="row">
        <div class="col-6 mb-3 mt-3">
            <label for="team_no">부서 <span class="text-danger">*</span>
                <span id="team_no_" class="text-danger" style="display:none">부서를 선택하세요.</span> </label>
            </label>
            <select class="form-control" id="team_no" name="team_no" onblur="validateTeam()">
                <option value="none" selected>부서를 선택해주세요.</option>
                <option value="1">경영지원팀</option>
                <option value="2">운영팀</option>
                <!-- Add more options as needed -->
            </select>
        </div>
                        <div class="col-6 mb-3 mt-3">
                            <label for="emp_position">직급 <span class="text-danger">*</span>
                                <span id="emp_position_" class="text-danger" style="display:none">직급을 선택하세요.</span>
                            </label>
                            <select class="form-control" id="emp_position" name="emp_position" onblur="validatePosition()">
                                <option value="0" selected>직급을 선택해주세요.</option>
                                <option value="사원">사원</option>
                                <option value="팀장">팀장</option>
                                <!-- Add more options as needed -->
                            </select>
                        </div>
                        </div>

                        <div class="row">
                        <div class="col-6 mb-3 mt-3">
                            <label for="emp_state">상태 <span class="text-danger">*</span>
                                <span id="emp_state_" class="text-danger" style="display:none">상태을 선택하세요.</span>
                            </label>
                            <select class="form-control" id="emp_state" name="emp_state" onblur="validateState()" >
                                <option value="none" selected>상태를 선택해주세요.</option>
                                <option value="1">재직</option>
                                <option value="0">퇴직</option>
                                <!-- Add more options as needed -->
                            </select>
                        </div>
                        <div class="col-6 mb-3 mt-3">
                            <label for="hire_date">입사일 <span class="text-danger">*</span>
                                <span id="hire_date_" class="text-danger" style="display:none"  >날자형식이 아닙니다.</span> </label>
                            <input type="date" class="form-control" id="hire_date" name="hire_date" onblur="validateHire()" placeholder="입사일을 입력해주세요.">
                        </div>
                        </div>

                        <div class="row">
                            <div class="col-6 mb-3 mt-3">
                                <label for="emp_access">권한 <span class="text-danger">*</span>
                                    <span id="emp_access_" class="text-danger" style="display:none"  >권한을 선택해주세요.</span>
                                </label>
                                <select class="form-control" id="emp_access" name="emp_access" onblur="validateAccess()">
                                    <option value="0" selected >권한을 선택해주세요.</option>
                                    <option value="ROLE_USER">사원</option>
                                    <option value="ROLE_ADMIN">경영지원팀</option>
                                    <option value="ROLE_MANAGE">운영팀</option>
                                    <!-- Add more options as needed -->
                                </select>
                            </div>
                        </div>
                        <div class="form-group mb-10 mt-10 p-3">
                            <input
                                    type="button"
                                    class="btn btn-primary float-right"
                                    onclick="memberInsert()"
                                    value="사원추가"
                            />
                        </div>
    </form>
    </div>
</div>
</div>
</div>
    <script>
        //회원가입 우편번호찾기
        // 여기배포햇나? -head에 위치 - 호이스팅이슈
        // 단-DOM 읽혀진 이후에만 접근이 가능하다 - undefined - 배포위치 고려해본다 -기준
        const openZipcode = () => {
            new daum.Postcode({//Postcode객체 생성하기  - 생성하자마자 내부에 구현하기가 전기해고있다
                oncomplete: function(data) {//완료되었을때 - 요청에 대한 응답이 완료되었을때 -이벤트처리
                    let addr = '';
                    if (data.userSelectedType === 'R') {
                        addr = data.roadAddress;//도로명
                    } else {
                        addr = data.jibunAddress;//지번
                    }
                    console.log(data);
                    console.log(addr);
                    //console.log(post.postNum);
                    //setPost({...post, zipcode:data.zonecode, addr:addr}) ;
                    // document.querySelector("#mem_zipcode").value = data.zonecode;//우편번호
                    // document.querySelector("#mem_address").value = addr;//주소
                    document.getElementById("address").value = addr;//주소
                    //document.getElementById("postDetail").focus();
                }
            }).open();
        }


        // 정규표현식 패턴 상수 선언
        //아이디 정규식표현
        const expIdText = /^[A-Za-z0-9]{4,12}$/;
        //비밀번호 정규식표현
        const expPwText = /^[A-Za-z0-9]{4,12}$/;
        //이름 정규식표현
        const expNameText = /^[가-힣]{2,5}$/;
        //핸드폰 정규식표현
        const expPhoneText = /^\d{3}-\d{3,4}-\d{4}$/;
        //생년월일 정규식표현
        const expDateText = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
        //이메일 정규실표현
        const expEmailText = /^[a-zA-Z0-9._+=-]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
        //부서 정규식표현
        const expTeamText = /^[1-9]{1,2}$/;
        //권한 정규식표현
        const expRoleText = /ROLE/;
        //주소 정규식표현
        const expAddressText = /^[가-힣a-zA-Z0-9-.,\s]{1,60}$/;





        const validateForm = () => {
            // 각 입력 필드에 대한 개별 유효성 검사 함수를 호출합니다.
            const isPasswordValid = validatePassword();
            const isNameValid = validateName();
            const isBirthdateValid = validateBirthdate();
            const isPhoneValid = validatePhone();
            const isEmailValid = validateEmail();
            const idHireValid = validateHire();
            const isAccessValid = validateAccess();
            const isStateValid = validateState();
            const isTeamValid = validateTeam();
            const isAddressValid = validateAddress();
            const isPositionValid = validatePosition();

            // 모든 검사가 통과되면 true를 반환하고, 그렇지 않으면 false를 반환합니다.
            return isPasswordValid && isNameValid && isBirthdateValid && isPhoneValid && isEmailValid &&idHireValid&& isAccessValid&&isStateValid && isTeamValid && isAddressValid && isPositionValid;
        }



        // 개별 유효성 검사 함수
        const validateName = () => {
            const nmSpan = document.getElementById('name_');
            const mbrNmInput = document.getElementById('name');
            const isValid = expNameText.test(mbrNmInput.value);

            if (isValid) {
                nmSpan.style.display = 'none';
            } else {
                nmSpan.style.display = 'inline';
            }
            return isValid;
        }

        const validatePassword = () => {
            const pwSpan = document.getElementById('password_');
            const mbrPwInput = document.getElementById('password');
            const isValid = expPwText.test(mbrPwInput.value);

            if (isValid) {
                pwSpan.style.display = 'none';
            } else {
                pwSpan.style.display = 'inline';
            }
            return isValid;
        }


        const validateBirthdate = () => {
            const dateSpan = document.getElementById('birthdate_');
            const mbrBirthdateInput = document.getElementById('birthdate');
            const isValid = expDateText.test(mbrBirthdateInput.value);

            if (isValid) {
                dateSpan.style.display = 'none';
            } else {
                dateSpan.style.display = 'inline';
            }
            return isValid;
        }

        const validatePhone = () => {
            const numberSpan = document.getElementById('phone_num_');
            const mbrPhoneInput = document.getElementById('phone_num');
            const isValid = expPhoneText.test(mbrPhoneInput.value);

            if (isValid) {
                numberSpan.style.display = 'none';
            } else {
                numberSpan.style.display = 'inline';
            }
            return isValid;
        }

        const validateEmail = () => {
            const emailSpan = document.getElementById('email_');
            const mbrEmailInput = document.getElementById('email');
            const isValid = expEmailText.test(mbrEmailInput.value);

            if (isValid) {
                emailSpan.style.display = 'none';
            } else {
                emailSpan.style.display = 'inline';
            }
            return isValid;
        }

        const validateTeam = () => {
            const teamSpan = document.getElementById('team_no_');
            const mbrNmInput = document.getElementById('team_no');
            const isValid = expTeamText.test(mbrNmInput.value);

            if (isValid) {
                teamSpan.style.display = 'none';
            } else {
                teamSpan.style.display = 'inline';
            }
            return isValid;
        }

        const validatePosition = () => {
            const positionSpan = document.getElementById('emp_position_');
            const mbrNmInput = document.getElementById('emp_position');
            const isValid = expNameText.test(mbrNmInput.value);

            if (isValid) {
                positionSpan.style.display = 'none';
            } else {
                positionSpan.style.display = 'inline';
            }
            return isValid;
        }
        const validateState  = () => {
            const stateSpan = document.getElementById('emp_state_');
            const mbrNmInput = document.getElementById('emp_state');
            const isValid = expTeamText.test(mbrNmInput.value);

            if (isValid) {
                stateSpan.style.display = 'none';
            } else {
                stateSpan.style.display = 'inline';
            }
            return isValid;
        }

        const validateAccess  = () => {
            const acSpan = document.getElementById('emp_access_');
            const mbrNmInput = document.getElementById('emp_access');
            const isValid = expRoleText.test(mbrNmInput.value);
            if (isValid) {
                acSpan.style.display = 'none';
            } else {
                acSpan.style.display = 'inline';
            }
            return isValid;
        }
        const validateHire  = () => {
            const hireSpan = document.getElementById('hire_date_');
            const mbrNmInput = document.getElementById('hire_date');
            const isValid = expDateText.test(mbrNmInput.value);
            if (isValid) {
                hireSpan.style.display = 'none';
            } else {
                hireSpan.style.display = 'inline';
            }
            return isValid;
        }

        const validateAddress  = () => {
            const addressSpan = document.getElementById('address_');
            const mbrNmInput = document.getElementById('address');
            const isValid = expAddressText.test(mbrNmInput.value);
            if (isValid) {
                addressSpan.style.display = 'none';
            } else {
                addressSpan.style.display = 'inline';
            }
            return isValid;
        }
    </script>
</body>
</html>
