<%----------------------------------------------------------
  이름 : 박병현
  날짜 : 2024-02-19
  내용 : 메인페이지jsp
----------------------------------------------------------%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vo.EmpVO, com.vo.AttendanceVO, com.vo.NoticeBoardVO, com.vo.MediaNoticeVO" %>
<%
  AttendanceVO attendance = (AttendanceVO) request.getAttribute("attendance");
  List<AttendanceVO> attendanceCalendar = (List) request.getAttribute("attendanceCalendar");
  List<NoticeBoardVO> noticeList = (List)request.getAttribute("noticeList");
  List<MediaNoticeVO> mediaNoticeList = (List)request.getAttribute("mediaNoticeList");
  List<Map<String,Object>> stateCnt = (List)request.getAttribute("stateCnt");
//  Map<String,Object> stateMap = stateCnt.get(0);
  //out.print(faList);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script>
      // FullCalendar 라이브러리 로드 함수
      const loadFullCalendar = () => {
          // FullCalendar 스타일이 이미 로드되었는지 확인
          if (!document.querySelector('link[href="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css"]')) {
              // FullCalendar 스타일을 동적으로 생성하여 로드
              const fullcalendarStyle = document.createElement('link');
              fullcalendarStyle.rel = 'stylesheet';
              fullcalendarStyle.href = 'https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css';
              document.head.appendChild(fullcalendarStyle);
          }

          // FullCalendar 스크립트가 이미 로드되었는지 확인
          if (typeof FullCalendar === 'undefined') {
              // FullCalendar 스크립트를 동적으로 생성하여 로드
              const fullcalendarScript = document.createElement('script');
              fullcalendarScript.src = 'https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js';
              document.head.appendChild(fullcalendarScript);
          }

          // FullCalendar 언어 스크립트가 이미 로드되었는지 확인
          if (!document.querySelector('script[src="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js"]')) {
              // FullCalendar 언어 스크립트를 동적으로 생성하여 로드
              const fullcalendarLocaleScript = document.createElement('script');
              fullcalendarLocaleScript.src = 'https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js';
              document.head.appendChild(fullcalendarLocaleScript);
          }
      };
      // FullCalendar 라이브러리 로드
      loadFullCalendar();
  </script>

  <!-- 부트스트랩 라이브러리 -->
  <%@include file="/common/bootstrap_common.jsp" %>
  <link rel="stylesheet" href="/css/mainCalendar.css">


  <title>메인페이지</title>
</head>
<body class="hold-transition sidebar-mini sidebar-collapse ">
    <div class="wrapper">
      <!-- header start -->
      <%@include file="/include/KGW_bar.jsp"%>
      <link rel="stylesheet" href="/css/dashboard.css">

      <!-- body start    -->
      <div class="content-wrapper">
        <!-- 페이지 path start    -->
        <%--		<div class="card" >--%>
        <div class="mainbox-header p-4" >
          <div class="d-flex align-items-center">
            <div class="d-flex align-items-center me-2">
              <a class="text-muted fs-6" href="#">메인페이지</a>
            </div>
          </div>
          <div class="d-flex align-items-center mt-2">
            <div class="position-relative">
              <div class="position-absolute top-0 start-0" ></div>
            </div>
            <div class="d-flex align-items-center ms-2">
              <div class="fw-bold fs-5">메인페이지</div>
              <div class="text-muted ms-3">메인페이지입니다.</div>
            </div>
          </div>
        </div>
    <!-- 페이지 path end -->
    <section class="content">

      <div class="row">
        <div class="col-2 text-center" >
          <div class="col" style="position:sticky; top:30px;">
            <div class="row mainbox" style="background-color: #e1cdcc;">
              <div class="row" style="margin: auto;">
                <div class="user-panel">
                  <a href="/mypage?emp_no=<%=sessionVO.getEmp_no()%>">
                    <img src="<%=filePath%>" class="img-circle m-4 img-responsive" alt="User Image" style=" margin: auto; width: 70%; height: auto;">
                  </a>
                </div>
              </div>
              <div class="row" style="margin: auto;">
                <div class="row" style="margin: auto;">
                  <div class="text text-bold text-lg">
                    [<%=sessionVO.getTeam_name()%>]
                  </div>
                </div>
                <div class="row mb-5" style="margin: auto;">
                  <div class="text text-bold text-lg">
                    <%=sessionVO.getName()%> <%=sessionVO.getEmp_position()%>
                  </div>
                </div>
              </div>
            </div>

            <div class="row mainbox mt-3 pt-5" style="background-color: #e1cdcc; ">
                <div class="row text-bold text-lg" style="margin: auto;">
                  <div class="text col-6 ">
                    <label>현재 시간  </label>
                  </div>
                  <div class="text2 col-6">
                    <div id="clock"></div>
                  </div>
                </div>
                <div class="row text-bold text-lg mt-2 mb-5" style="margin: auto;">
                  <div class="text col-6 " style="line-height: 70px">
                    <label>현재 날씨 </label>
                  </div>
                  <div class="text2 col-6">
                    <div>
                      <img class="icon " style="width: 70px; height: 70px; "/>
                    </div>
                  </div>
                </div>
                <div class="row text-bold text-lg" style="margin: auto;">
                  <div class="text col-6 ">
                    <label>출근시간 : </label>
                  </div>
                  <div class="text2 col-6">
                    <%
                      if(attendance != null){
                        if(attendance.getStart_time() != null){
                    %>
                        <label id="workStart"><%=attendance.getStart_time()%></label>
                    <%
                        }else{
                    %>
                        <label id="workStart"></label>
                    <%
                        }
                      }else{
                    %>
                    <label id="workStart"></label>
                    <%
                      }
                    %>
                  </div>
                </div>
                <div class="row text-bold text-lg" style="margin: auto;">
                  <div class="text col-6 ">
                    <label>퇴근시간 : </label>
                  </div>
                  <div class="text2 col-6">
                    <%
                      if(attendance != null){
                        if(attendance.getEnd_time() != null){
                    %>
                      <label id="workStart"><%=attendance.getEnd_time()%></label>
                    <%
                        }else{
                    %>
                      <label id="workEnd"></label>
                    <%
                        }
                      }else{
                    %>
                    <label id="workEnd"></label>
                    <%
                      }
                    %>
                  </div>
                </div>

              <div class="mt-5 mb-5">
                <hr class="m-3" style=" height: 1px; background-color: #0e0e0e; border: 0">
              </div>
              <div class="mb-5" >
                <%
                  if(attendance == null){
                %>
                  <button id="btn_start" class="btn btn-danger" onclick="workStart()">출근</button>
                <%
                  }else {
                    if(attendance.getStart_time() == null){
                %>
                  <button id="btn_start" class="btn btn-danger" onclick="workStart()">출근</button>
                <%
                    }else if(attendance.getEnd_time() == null){
                %>
                  <button id="btn_end" class="btn btn-danger" onclick="workEnd()">퇴근</button>
                <%
                    }else{
                %>
                  <p class="text-bold text-lg">오늘 하루도</p>
                  <p class="text-bold text-lg">수고하셨습니다</p>
                  <p class="text-bold text-lg">♡⸜(ˆᗜˆ˵ )⸝♡</p>
                <%
                    }
                  }
                %>
              </div>
            </div>
            <div class="row mainbox mt-3 p-4 d-grid gap-5  mx-auto" style="background-color: #e1cdcc; ">
              <a href="/mypage?emp_no=<%=sessionVO.getEmp_no()%>" class="btn btn-danger">프로필정보수정</a>
            </div>
          </div>
        </div>

        <div class="col-10">
          <div class="row">
            <div class="col mainbox">
              <div class="mainbox-header d-flex align-items-center pb-0">
                <div class="d-flex align-items-center">
                  <span style="font-weight: bold; margin-left: 1.5rem" >전자결재 진행 현황</span>
                </div>
              </div>
              <hr/>

                <div class="row mb-3">
                  <div class="custom-col" >
                    <button type="button" id="btn_approval_wait" class="approval btn btn-danger" onclick="waitApproval()">결재대기 [<%=stateCnt.get(0).get("COUNT")%>]</button>
                  </div>

                  <div class="custom-col" >
                    <button type="button" id="btn_approval_progress" class="approval btn btn-danger" onclick="processApproval()">결재진행 [<%=stateCnt.get(3).get("COUNT")%>]</button>
                  </div>

                  <div class="custom-col" >
                    <button type="button" id="btn_approval_complete" class="approval btn btn-danger" onclick="completeApproval()">결재완료 [<%=stateCnt.get(2).get("COUNT")%>]</button>
                  </div>

                  <div class="custom-col" >
                    <button type="button" id="btn_approval_companion" class="approval btn btn-danger" onclick="companionApproval()">결재반려 [<%=stateCnt.get(1).get("COUNT")%>]</button>
                  </div>

                  <div class="custom-col">
                    <button type="button" id="btn_approval" class="approval btn btn-danger" onclick="draft()">기안작성</button>
                  </div>

                </div>

            </div>
          </div>

          <div class="row" >
            <div class="col mr-3">
              <div class="row">
                <div class="col mainbox">
                  <div class="mainbox-header d-flex align-items-center pb-0">
                    <div class="d-flex align-items-center">
                      <span style="font-weight: bold; margin-left: 1.5rem" >공지게시판</span>
                    </div>
                    <div style="margin-left: auto; margin-right: 1.5rem">
                      <a href="/notice/noticeList" class="btn btn-danger" style="border-radius:30px">more</a>
                    </div>
                  </div>
                  <hr/>
                  <%@include file="/include/icNotice.jsp"%>
                </div>
              </div>
              <div class="row">
                <div class="col mainbox" style="height: 300px">
                  <div class="mainbox-header d-flex align-items-center pb-0">
                    <div class="d-flex align-items-center">
                      <span style="font-weight: bold; margin-left: 1.5rem" >미디어게시판</span>
                    </div>
                    <div style="margin-left: auto; margin-right: 1.5rem">
                      <a href="/media/mediaNotice" class="btn btn-danger" style="border-radius:30px">more</a>
                    </div>
                  </div>
                  <hr/>
                  <%@include file="/include/icMedia.jsp"%>
                </div>
              </div>
            </div>

            <div class="col mainbox">
              <div class="mainbox-header d-flex align-items-center pb-0">
                <div class="d-flex align-items-center">
                  <span style="font-weight: bold; margin-left: 1.5rem" >근태관리</span>
                </div>
                <div style="margin-left: auto; margin-right: 1.5rem">
                  <a href="/attendance/attendanceCalendar?emp_no=<%=sessionVO.getEmp_no()%>" class="btn btn-danger" style="border-radius:30px">more</a>
                </div>
              </div>
              <hr/>
              <div id='calendar-container'>
                <%@include file="/include/icAttendance.jsp"%>
              </div>
            </div>
          </div>

          <div class="row" >
            <div class="col mainbox">
              <div class="mainbox-header d-flex align-items-center pb-0">
                <div class="d-flex align-items-center">
                  <span style="font-weight: bold; margin-left: 1.5rem" >전략분석 차트</span>
                </div>
                <div style="margin-left: auto; margin-right: 1.5rem">
                  <a href="/manage/FAChart" class="btn btn-danger" style="border-radius:30px">more</a>
                </div>
              </div>
                <hr/>
            <%@include file="/include/icFAchart.jsp"%>
            </div>
          </div>
          <div class="col" style="text-align: center;">
            <div id="btn_top" title="위로">
                <img src='/images/btn_png/btn_top.png' alt='top' style="cursor: pointer"/>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</div>
    <script>
            const draft = () =>{
            location.href = "/approval/docu?emp_no=<%=sessionVO.getEmp_no()%>";
        }

            const waitApproval = () =>{
            location.href = "/approval/documentList?emp_no=<%=sessionVO.getEmp_no()%>&gubun=state&keyword=대기";
        }

            const processApproval = () =>{
            location.href = "/approval/documentList?emp_no=<%=sessionVO.getEmp_no()%>&gubun=state&keyword=진행";
        }

            const completeApproval = () =>{
            location.href = "/approval/documentList?emp_no=<%=sessionVO.getEmp_no()%>&gubun=state&keyword=완료";
        }

            const companionApproval = () =>{
            location.href = "/approval/documentList?emp_no=<%=sessionVO.getEmp_no()%>&gubun=state&keyword=반려";
        }


    $("#btn_top").click(function() { // 버튼 클릭 시
    $('html,body').scrollTop(0); // 스크롤탑이 '0'이 된다는 - 스크롤이 제일 위로 올라간다는 의미
    });

    const updateTime = () => {
    let timeString = moment().format('HH:mm:ss');
    document.querySelector("#clock").textContent = timeString;
    }

    // 매 초마다 시간을 업데이트
    setInterval(updateTime, 1000);

    const workStart = () =>{
    let timeString = moment().format('HH:mm:ss');
    const data = {
    "start_time" : timeString,
    "emp_no" : <%=sessionVO.getEmp_no()%>
            }
            Swal.fire({
                title: "출근하시겠습니까?",
                showCancelButton: true,
                confirmButtonColor: "#7c1512",
                cancelButtonColor: "#7c1512",
                confirmButtonText: "네",
                cancelButtonText: "아니요"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type:"POST",
                        url: '/attendance/attendanceTime',
                        data: data,
                        success: function(response) {
                            console.log('성공');
                            Swal.fire({
                                title: "출근이 완료되었습니다.",
                                text: "좋은 하루 되세요.",
                                icon: "success",
                            });
                            document.querySelector("#workStart").textContent = timeString;
                            location.reload();
                        },
                        error: function(error) {
                            console.error('실패:', error);
                            // 실패한 경우 처리할 내용 추가
                        }
                    })
                }
            });
        }
        const workEnd = () =>{
            let timeString = moment().format('HH:mm:ss');
            let attendace_no = 0;
            <%
              if(attendance != null){
            %>
            attendace_no = <%=attendance.getAttendance_no()%>;

            const data = {
                "start_time" : '<%=attendance.getStart_time()%>',
                "end_time" : timeString,
                "emp_no" : <%=sessionVO.getEmp_no()%>,
                "attendance_no" : attendace_no
            }

            Swal.fire({
                title: "퇴근하시겠습니까?",
                showCancelButton: true,
                confirmButtonColor: "#7c1512",
                cancelButtonColor: "#7c1512",
                confirmButtonText: "네",
                cancelButtonText: "아니요"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type:"POST",
                        url: '/attendance/attendanceEndTime',
                        data: data,
                        success: function(response) {
                            console.log('성공');
                            Swal.fire({
                                title: "퇴근이 완료되었습니다.",
                                text: "오늘 하루 고생하셨습니다.",
                                icon: "success",
                            });
                            document.querySelector("#workStart").textContent = timeString;
                            location.reload();
                        },
                        error: function(error) {
                            console.error('실패:', error);
                            // 실패한 경우 처리할 내용 추가
                        }
                    })
                }
            });
            <%
            }
            %>
        }

        function success (position){
            const latitude = position.coords.latitude;
            const longitude = position.coords.longitude;

            getWeather(latitude, longitude);
        }
        function getWeather (lat, lon) {
            const API_KEY = '151ebeae4d0dc3a80ce3b6ba4912e175';
            fetch(
                `https://api.openweathermap.org/data/2.5/weather?lat=\${lat}&lon=\${lon}&appid=\${API_KEY}&units=metric&lang=kr`
            )
                .then((response) => {
                    if (!response.ok) {
                        throw new Error('날씨 정보를 가져오는 데 실패했습니다.');
                    }
                    return response.json();
                })
                .then((data) => {
                    const iconSection = document.querySelector('.icon');
                    const icon = data.weather[0].icon;
                    console.log(icon)
                    const iconURL = `http://openweathermap.org/img/wn/\${icon}.png`;
                    console.log(iconURL)
                    iconSection.setAttribute('src', iconURL);
                    iconSection.setAttribute('alt', data.weather[0].description);
                })
                .catch((error) => {
                    console.error('Error:', error);
                });
        }

        navigator.geolocation.getCurrentPosition(success);

        const mypage = () =>{
            location.href = "/mypage?emp_no=<%=sessionVO.getEmp_no()%>";
        }
    </script>
</body>
</html>
