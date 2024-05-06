<%@ page import="com.best.kgw.auth.PrincipalDetails" %>
<%@ page import="org.springframework.security.core.context.SecurityContextHolder" %>
<%@ page import="org.springframework.security.core.Authentication" %>
<%@ page import="com.vo.EmpVO" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/common/bootstrap_common.jsp" %>
<%
    // 세션에서 로그인된 유저 정보 가져오기
    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
    EmpVO sessionVO = principalDetails.getEmpVO();

    // 세션 시간 설정
    session.setMaxInactiveInterval(3000);

%>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="../../dist/css/adminlte.css">
<link rel="stylesheet" href="/css/common.css">
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script type="text/javascript">
    // 카운트 다운 함수
    function startCountdown(duration, display) {
        let timer = duration;

        // 타이머 호출 함수
        function countdown() {
            let minutes = parseInt(timer / 60, 10);
            let seconds = parseInt(timer % 60, 10);

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            display.textContent = minutes + ":" + seconds;

            // 1분 남았을 때 연장 여부 확인
            if (timer === 60) {
                const extend = confirm("1분 남았습니다. 연장하시겠습니까?");
                if (extend) {
                    // 세션 시간 연장 요청
                    extendSessionTime(function(newSessionTimeout) {
                        // 새로운 세션 시간으로 카운트 다운을 업데이트
                        timer = newSessionTimeout;
                    });
                }
            }

            // 카운트 다운 종료
            if (--timer < 0) {
                clearInterval(countdownInterval);
                display.textContent = "00:00";
                Swal.fire({
                    title: '세션시간이 만료되어 <br> 로그아웃 되었습니다.',
                    icon: 'success',
                    confirmButtonColor: '#800000',
                    customClass:{
                        popup : 'swal2-small'
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        // 확인 버튼을 클릭한 경우 다음 화면으로 이동
                        window.location.href = '/logout';
                    }
                })
            }
        }
        const countdownInterval = setInterval(countdown, 1000); // 타이머 시작
    }

    // 세션 시간 연장 요청 함수
    function extendSessionTime(callback) {
        $.ajax({
            url: '/extendSessionTime',
            method: 'GET',
            success: function (response) {
                // 세션 시간을 성공적으로 연장한 경우
                const newSessionTimeout = parseInt(response);
                // 새로운 세션 시간을 콜백 함수에 전달
                if (typeof callback === 'function') { // 콜백 함수가 유효한지 확인
                    callback(newSessionTimeout);
                }
            },
            error: function (xhr, status, error) {
                // 오류 처리
                console.error('세션 시간을 연장하는 동안 오류가 발생했습니다:', error);
            }
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        const sessionTimeout = <%= session.getMaxInactiveInterval() %>;
        const display = document.querySelector('#time');
        startCountdown(sessionTimeout, display);
    });

    extendLoginTime = () => {
        Swal.fire({
            title: '로그인 연장',
            text: '로그인을 연장하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: '연장',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                // 확인을 눌렀을 때의 동작
                location.reload();
            } else {
                // 취소를 눌렀을 때의 동작
                console.log("연장 취소");
            }
        });
    };
</script>
    <!-- Navbar -->
    <nav class="main-header navbar navbar-expand navbar-white navbar-light">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
            </li>
            <li class="nav-item d-none d-sm-inline-block">
                <a href="/" class="nav-link">Home</a>
            </li>
            <li>
                <a href="/logout" class="nav-link">로그아웃</a>
            </li>
        </ul>
        <!-- Right navbar links -->
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <div class="user-panel d-flex" >
                    <div class="nav-link mt-1" style="font-weight: bold">자동 로그아웃 시간  <i class="bi bi-clock"></i> &nbsp; <span id="time" style="font-size: 18px">05:00</span></div>
                    <button type="button" class="btn btn-secondary btn-sm mt-2" id="sessionBtn"  style="font-weight:bold; height: 35px;" onclick="extendLoginTime()">로그인 연장</button>
                    <div class="info">
                        <%
                            String realFolder = "";
                            String filePath = "/fileUpload/profile/"+sessionVO.getEmp_no()+".png"; // 파일 경로 설정
                            ServletContext context = request.getServletContext();
                            realFolder = context.getRealPath(filePath);
                            File file = new File(realFolder);
                            if (!(file.exists())) { // 파일이 존재하는지 확인
                                filePath = "/fileUpload/profile/K1.png";
                                }
                        %>
                        <a href="/mypage?emp_no=<%=sessionVO.getEmp_no()%>" class="nav-link"><img src="<%=filePath%>" class="img-circle" alt="User Image">&nbsp;<%=sessionVO.getName()%></a>
                    </div>
                </div>
            </li>
        </ul>
    </nav>
    <!-- /.navbar -->

    <!-- Main Sidebar Container -->
    <aside class="main-sidebar sidebar-dark-primary elevation-4">
        <!-- Brand Logo -->
        <a href="/" class="brand-link">
            <img src="/images/K1.png" alt=" Logo" class="brand-image mt-2 ml-2" style="opacity: .8">
            <span class="brand-text font-weight-light font-weight-bold" style="font-size: 30px">KIWOOM</span>
        </a>

        <!-- Sidebar -->
        <div class="sidebar">
            <!-- Sidebar Menu -->
            <nav class="mt-2">
                <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                    <li class="nav-item">
                        <a href="../notice/noticeList" class="nav-link">
                            <i class="nav-icon bi bi-bell-fill"></i>
                            <p>
                                공지사항
                            </p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="/empInfo" class="nav-link">
                            <i class="nav-icon bi bi-person-heart"></i>
                            <p>
                                주소록
                            </p>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="nav-icon bi bi-emoji-smile-fill"></i>
                            <p>
                                우리구단
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="/media/mediaNotice" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>우리구단소식</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/kiwoom/kiwoomList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>우리구단선수조회</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="nav-icon bi bi-calendar-heart"></i>
                            <p>
                                일정
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="/calendar/myCalendarList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>내 일정</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/calendar/teamCalendarList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>팀 일정</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/calendar/companyCalendarList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>전사 일정</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="nav-icon bi bi-list-stars"></i>
                            <p>
                                예약
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="/assetReservation/assetReservationList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>자산 예약</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/vehicleReservation/vehicleReservationList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>차량 예약</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                        <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="nav-icon bi bi-pencil-square"></i>
                            <p>
                                전자결재
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="/approval/docu?emp_no=<%=sessionVO.getEmp_no()%>" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>기안문서작성</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="../approval/documentList?emp_no=<%=sessionVO.getEmp_no()%>" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>기안문서함</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="../approval/saveList?emp_no=<%=sessionVO.getEmp_no()%>" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>임시문서함 </p>
                                </a>
                            </li>
                            <%
                                if (!(sessionVO.getEmp_position().equals("사원"))){
                            %>
                            <li class="nav-item">
                                <a href="../approval/approvalList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>결재문서함</p>
                                </a>
                            </li>
                            <%
                                }
                            %>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="nav-icon bi bi-clipboard-data"></i>
                            <p>
                                전력분석
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="../player/PitchersList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>전체선수조회</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/manage/FAChart" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>FA선수현황</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <%
                        if(sessionVO.getEmp_access().equals("ROLE_ADMIN") || sessionVO.getEmp_access().equals("ROLE_MASTER" )){
                    %>
                    <li class="nav-header">관리자</li>
                    <li class="nav-item">
                        <a href="../calendar.html" class="nav-link">
                            <i class="nav-icon bi bi-heart-fill"></i>
                            <p>
                                관리자메뉴
                                <i class="fas fa-angle-left right"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <li class="nav-item">
                                <a href="/admin/empList" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>사원관리</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/admin/registPage" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>사원추가</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/admin/empChart" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>입/퇴사자 현황</p>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="/attendance/adminAttendance" class="nav-link">
                                    <i class="bi bi-record nav-icon"></i>
                                    <p>근태관리</p>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </nav>
            <!-- /.sidebar-menu -->
        </div>
        <!-- /.sidebar -->
    </aside>
