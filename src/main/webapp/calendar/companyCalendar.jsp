<%@ page import="java.util.List" %>
<%@ page import="com.vo.CalendarVO" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.vo.EmpVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Calendar</title>
    <!-- fullcalendar CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@5.10.1/main.min.js"></script>
    <!-- moment.js 라이브러리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <!-- moment-timezone.js 라이브러리 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.34/moment-timezone-with-data.min.js"></script>
    <!-- 부트스트랩 라이브러리 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/calendar.css" />
    <!-- fullcalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@5.10.1/main.min.css" rel="stylesheet">
</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <%@include file="/include/KGW_bar.jsp"%>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        let calendarEl = document.getElementById('calendar');
        let calendar;
        if (calendarEl) {
            calendar = new FullCalendar.Calendar(calendarEl, {
                expandRows: true,
                initialView: 'dayGridMonth',
                slotMinTime: '08:00',
                slotMaxTime: '20:00',
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                },
                navLinks: true,
                editable: true,
                selectable: true,
                nowIndicator: true,
                dayMaxEvents: true,
                height: '570px',
                locale: 'ko',

                select: function(arg) {
                    if (detailStart === !null) {
                        let modal = document.getElementById('detailModal');
                        modal.style.display = 'block';
                        let endInput = document.getElementById('detailEnd');
                        let startInput = document.getElementById('detailStart');
                        let startTime = moment(arg.start, 'Asia/Seoul').format('YYYY-MM-DDTHH:mm');
                        let endTime = moment(arg.end, 'Asia/Seoul').format('YYYY-MM-DDTHH:mm');
                        startInput.value = startTime;
                        endInput.value = endTime;
                    } else {
                        let modal = document.getElementById('insertModal');
                        modal.style.display = 'block';
                        let startInput = document.getElementById('insertStart');
                        let endInput = document.getElementById('insertEnd');
                        let startTime = moment(arg.start, 'Asia/Seoul').format('YYYY-MM-DDTHH:mm');
                        let endTime = moment(arg.end, 'Asia/Seoul').format('YYYY-MM-DDTHH:mm');
                        startInput.value = startTime;
                        endInput.value = endTime;
                    }
                },
                eventClick: function(info) {
                    if(detailTitle != null && detailCalendarNo != null) {
                        let modal = document.getElementById('detailModal');
                        modal.style.display = 'block';
                        let detailCalendarNoInput = document.getElementById('detailCalendarNo');
                        let detailCalendarIdInput = document.getElementById('detailCalendarId');
                        let detailTitleInput = document.getElementById('detailTitle');
                        let detailStartInput = document.getElementById('detailStart');
                        let detailEndInput = document.getElementById('detailEnd');
                        let event = info.event;
                        detailTitleInput.value = event.title;
                        detailCalendarIdInput.value = event.id;
                        detailCalendarNoInput.value = event.extendedProps.CalendarNo;
                        detailStartInput.value = moment(event.start).format('YYYY-MM-DDTHH:mm');
                        detailEndInput.value = moment(event.end).format('YYYY-MM-DDTHH:mm');
                    } else {
                        let modal = document.getElementById('insertModal');
                        modal.style.display = 'block';
                        let insertTitleInput = document.getElementById('insertTitle');
                        let insertStartInput = document.getElementById('insertStart');
                        let insertEndInput = document.getElementById('insertEnd');
                        let event = info.event;
                        insertTitleInput.value = event.title;
                        insertStartInput.value = moment(event.start).format('YYYY-MM-DDTHH:mm');
                        insertEndInput.value = moment(event.end).format('YYYY-MM-DDTHH:mm');
                    }
                },

                eventMouseEnter: function(info) {
                    // 이벤트가 호버될 때 툴팁 생성
                    var tooltip = document.createElement('div');
                    tooltip.className = 'data-bs-container="body" data-bs-toggle="popover" data-bs-placement="top" data-bs-content="Top popover"';
                    tooltip.style.backgroundColor = '#f7eced';
                    tooltip.style.border = '1px solid #ccc';
                    tooltip.style.padding = '10px';
                    tooltip.style.zIndex = '1000';

                    // 시작 시간과 종료 시간에서 시간 정보를 추출하여 툴팁으로 표시
                    tooltip.innerHTML = info.event.title + info.event.start + info.event.end;

                    // 마우스 위치에 툴팁을 표시
                    tooltip.style.position = 'absolute';
                    tooltip.style.top = (info.jsEvent.pageY - 60) + 'px'; // 마우스 위치에서 약간 위로 이동
                    tooltip.style.left = (info.jsEvent.pageX - 50) + 'px';

                    // 툴팁을 body에 추가
                    document.body.appendChild(tooltip);

                    // 마우스가 이벤트 바깥으로 나갈 때 툴팁 제거
                    info.el.addEventListener('mouseleave', function() {
                        tooltip.remove();
                    });
                },

                events: [
                    <%  List<CalendarVO> companyCalendarList = (List<CalendarVO>) request.getAttribute("companyCalendarList");
                        if (companyCalendarList != null) {
                            for (CalendarVO vo : companyCalendarList) {
                            %>
                    {
                        extendedProps: { CalendarNo: '<%= vo.getCalendar_no() %>' },
                        id: '<%= vo.getCalendar_id() %>',
                        title: '<%= vo.getCalendar_title() %>',
                        start: '<%= vo.getCalendar_start() %>',
                        end: '<%= vo.getCalendar_end() %>',
                        color: '#93DAFF'
        },
                    <% }} %>
                ]
            });
            calendar.render();
        } else {
            console.error('calendarEl = NULL');
        }

        // 예약 취소 모달 관련 스크립트
        const modal = document.getElementById('detailModal');
        const span = document.getElementsByClassName("close")[0];

        span.onclick = function () {
            modal.style.display = "none";
        }

        window.onclick = function (event) {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        }

        // 이벤트 핸들러 등록
        let submitBtn = document.getElementById('submitEvent');
        let searchBtn = document.getElementById('searchEvent');
        let exitBtn = document.getElementById('exitEvent');
        let deleteBtn = document.getElementById('deleteEvent');
        let updateBtn = document.getElementById('updateEvent');
        let addEventBtn = document.getElementById('addEvent');
        let closeBtnList = document.querySelectorAll('.modal-content .close');

        submitBtn.addEventListener('click', handleEventSubmit);
        submitBtn.addEventListener('click', handleEventUpdate);
        searchBtn.addEventListener('click', calendarSearch);
        exitBtn.addEventListener('click', handleEventSubmit);
        exitBtn.addEventListener('click', handleEventUpdate);
        deleteBtn.addEventListener('click', handleEventDelete);
        updateBtn.addEventListener('click', handleEventUpdate);
        addEventBtn.addEventListener('click', function() {
            let insertModal = document.getElementById('insertModal');
            insertModal.style.display = 'block';
        });
        closeBtnList.forEach(function(closeBtn) {
            closeBtn.addEventListener('click', handleModalClose);
            closeBtn.addEventListener('click', handleEventUpdate);
        });

        function handleEventSubmit() {
            let idInput = document.getElementById('insertCalendarId');
            let titleInput = document.getElementById('insertTitle');
            let startInput = document.getElementById('insertStart');
            let endInput = document.getElementById('insertEnd');

            let calendar_id = idInput.value;
            let calendar_title = titleInput.value;
            let calendar_start = startInput.value;
            let calendar_end = endInput.value;
            let emp_no = <%= sessionVO.getEmp_no() %>;
            let url = '/calendar/insertCalendar';

            if (calendar_title && calendar_start && calendar_end && emp_no && calendar_id) {
                Swal.fire({
                    title: "일정을 등록하시겠습니까?",
                    icon: "question",
                    showCancelButton: true,
                    confirmButtonColor: '#7c1512',
                    cancelButtonColor: '#7c1512',
                    confirmButtonText: '등록',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: url,
                            data: {
                                calendar_title: calendar_title,
                                calendar_start: calendar_start,
                                calendar_end: calendar_end,
                                emp_no: emp_no,
                                calendar_id: calendar_id
                            },
                            success: function(response) {
                                console.log(response);
                                if (response > 0) {
                                    if (window.opener) window.opener.location.reload(true);
                                    window.location.href = '${pageContext.request.contextPath}' + '/calendar/companyCalendarList';

                                    Swal.fire({
                                        title: "일정이 등록되었습니다.",
                                        icon: "success",
                                    });
                                }
                            },
                            error: function(request, status, error) {
                                console.error("오류 발생 >> " + error);
                            }
                        });
                    }
                });
            } else {
                // 필수 값이 입력되지 않은 경우 알림 표시
                Swal.fire({
                    title: "필수 항목을 모두 입력해주세요.",
                    icon: "warning",
                });
            }
            // 모달 숨기기
            let modal = document.getElementById('insertModal');
            modal.style.display = 'none';
            closeModalAndClearInputs();
        }

        function handleEventDelete() {
            let calendarNoInput = document.getElementById('detailCalendarNo');
            let calendar_no = calendarNoInput.value;
            let url = "<%=request.getContextPath()%>/calendar/deleteCalendar";

            if (calendar_no) {
                Swal.fire({
                    title: "일정을 삭제하시겠습니까?",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: '#7c1512',
                    cancelButtonColor: '#7c1512',
                    confirmButtonText: '삭제',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: url,
                            data: { calendar_no: calendar_no },
                            success: function(response) {
                                console.log(response);
                                if (response > 0) {
                                    if (window.opener) window.opener.location.reload(true);
                                    window.location.href = '${pageContext.request.contextPath}' + '/calendar/companyCalendarList';

                                    Swal.fire({
                                        title: "일정이 삭제되었습니다.",
                                        icon: "success",
                                    });
                                }
                            },
                            error: function(request, status, error) {
                                console.error("오류 발생 >> " + error);
                            }
                        });
                    }
                });
            }
            closeModalAndClearInputs();
            // 모달 숨기기
            let modal = document.getElementById('detailModal');
            modal.style.display = 'none';
        }

        function handleEventUpdate() {
            let titleInput = document.getElementById('detailTitle');
            let startInput = document.getElementById('detailStart');
            let endInput = document.getElementById('detailEnd');
            let calendarNoInput = document.getElementById('detailCalendarNo');
            let idInput = document.getElementById('detailCalendarId');

            let calendar_title = titleInput.value;
            let calendar_start = startInput.value;
            let calendar_end = endInput.value;
            let emp_no = <%= sessionVO.getEmp_no() %>;
            let calendar_no = calendarNoInput.value;
            let calendar_id = idInput.value;

            let url = "/calendar/updateCalendar";

            if (calendar_title && calendar_start && calendar_end && emp_no && calendar_no && calendar_id) {
                Swal.fire({
                    title: "일정을 수정하시겠습니까?",
                    icon: "question",
                    showCancelButton: true,
                    confirmButtonColor: '#7c1512',
                    cancelButtonColor: '#7c1512',
                    confirmButtonText: '수정',
                    cancelButtonText: '취소'
                }).then((result) => {
                    if (result.isConfirmed) {
                        $.ajax({
                            type: "POST",
                            url: url,
                            data: {
                                calendar_title: calendar_title,
                                calendar_start: calendar_start,
                                calendar_end: calendar_end,
                                emp_no: emp_no,
                                calendar_no : calendar_no,
                                calendar_id: calendar_id
                            },
                            success: function(response) {
                                console.log(response);
                                if (response > 0) {
                                    if (window.opener) window.opener.location.reload(true);
                                    window.location.href = '${pageContext.request.contextPath}' + '/calendar/companyCalendarList';

                                    Swal.fire({
                                        title: "일정이 수정되었습니다.",
                                        icon: "success",
                                    });
                                }
                            },
                            error: function(request, status, error) {
                                console.error("오류 발생 >> " + error);
                            }
                        });
                    }
                });
            }
            closeModalAndClearInputs();
            // 모달 숨기기
            let modal = document.getElementById('detailModal');
            modal.style.display = 'none';
        }


        let cancelTodayButton = document.querySelectorAll('.cancel-button');

        cancelTodayButton.forEach(function(cancelButton) {
            cancelButton.addEventListener('click', function() {
                let calendarNoInput = document.getElementById('calNo');
                if (calendarNoInput !== null) {
                    let calendar_no = calendarNoInput.textContent;

                    if (calendar_no) {
                        // SweetAlert로 삭제 여부 확인
                        Swal.fire({
                            title: "일정을 삭제하시겠습니까?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: '#7c1512',
                            cancelButtonColor: '#7c1512',
                            confirmButtonText: '삭제',
                            cancelButtonText: '취소'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                // 사용자가 삭제를 선택한 경우, AJAX를 통해 삭제 요청
                                let url = "<%=request.getContextPath()%>/calendar/deleteTodayCalendar";

                                $.ajax({
                                    type: "POST",
                                    url: url,
                                    data: { calendar_no: calendar_no },
                                    success: function(response) {
                                        console.log(response);
                                        if (response > 0) {
                                            if (window.opener) window.opener.location.reload(true);
                                            window.location.href = '${pageContext.request.contextPath}' + '/calendar/companyCalendarList';
                                            Swal.fire({
                                                title: "일정이 삭제되었습니다.",
                                                icon: "success",
                                            });
                                        }
                                    },
                                    error: function(request, status, error) {
                                        console.error("오류 발생 >> " + error);
                                    }
                                });
                            }
                        });
                    }
                }
            });
        });


        // 내 일정 체크박스 클릭 시 링크로 이동
        document.getElementById('myCal').addEventListener('change', function() {
            if (this.checked) {
                window.location.href = '../calendar/myCalendarList';
            }
        });

        // 팀 일정 체크박스 클릭 시 링크로 이동
        document.getElementById('teamCal').addEventListener('change', function() {
            if (this.checked) {
                window.location.href = '../calendar/teamCalendarList';
            }
        });

        // 모달 닫기 및 입력 값 초기화 함수
        function closeModalAndClearInputs() {
            let modal = document.getElementById('insertModal');
            modal.style.display = 'none';
            clearModalInputs();
        }

        // 모달 닫기 처리 함수
        function handleModalClose() {
            let modal1 = document.getElementById('insertModal');
            let modal2 = document.getElementById('detailModal');
            modal1.style.display = 'none';
            modal2.style.display = 'none';
            clearModalInputs();
        }

        // 모달 입력값 초기화 함수
        function clearModalInputs() {
            document.getElementById('insertTitle').value = '';
            document.getElementById('detailTitle').value = '';
            document.getElementById('insertStart').value = '';
            document.getElementById('detailStart').value = '';
            document.getElementById('insertEnd').value = '';
            document.getElementById('detailEnd').value = '';
            document.getElementById('detailCalendarNo').value = '';
        }
    });

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function(event) {
        let modal1 = document.getElementById('insertModal');
        let modal2 = document.getElementById('detailModal');
        if (event.target === modal1) {
            modal1.style.display = 'none';
        } else if (event.target === modal2) {
            modal2.style.display = 'none';
        }
    }

    function searchEnter(event){
        if(window.event.keyCode == 13){
            calendarSearch()
        }
    }

    function calendarSearch() {
        console.log('calendarSearch');
        const gubun = document.querySelector("#gubun").value;
        const keyword = document.querySelector("#keyword").value;

        console.log(`${gubun} , ${keyword}`);

        let searchURL = "/calendar/companyCalendarList?gubun=" + gubun;

        if (keyword.trim() === '') {
            Swal.fire({
                icon: 'warning',
                title: '검색어를 입력하세요',
                text: '검색어를 입력하지 않으면 검색할 수 없습니다.',
                confirmButtonText: '확인'
            });
        } else {
            searchURL += "&keyword=" + keyword;
            location.href = searchURL;
        }
    }
</script>
    <div class="content-wrapper">

        <div class="box-header p-4">
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="/">일정</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">전사 일정</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0"></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">전사 일정 현황</div>
                    <div class="text-muted ms-3">전사 일정 현황을 조회할 수 있는 페이지입니다.</div>
                </div>
            </div>
        </div>

        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="container-fluid1">
                            <h4 class="cal_title">전사 일정 현황</h4>
                            <input type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-primary col-md-1" id="addEvent" name="addEvent" value="일정 등록"/>
                        </div>
                        <hr />

                        <%-- 캘린더 태그 --%>
                        <div id="calendar"></div>
                        <div class="checkbox-container">
                            <div>
                                <input type="checkbox" class="form-check-input" id="myCal" name="myCal" value="myCal">
                                <label for="myCal">내 일정</label>
                            </div>

                            <div>
                                <input type="checkbox" class="form-check-input" id="teamCal" name="teamCal" value="teamCal">
                                <label for="teamCal">팀 일정</label>
                            </div>

                        </div>

                    </div>
                </div>
            </div>
        </section>

        <%
            // 현재 날짜 가져오기
            Date today = new Date();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String todayDate = dateFormat.format(today);
        %>

        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <%-- 내 일정 현황 태그 --%>
                        <div class="container-fluid1">
                            <h4 class="cal_title">오늘 전사 일정</h4>
                            <!-- 검색기 시작 -->
                            <div class="row search">
                                <div class="col-3">
                                    <select id="gubun" class="form-select" aria-label="분류선택">
                                        <option value="name">작성자</option>
                                        <option value="calendar_title">일정명</option>
                                        <option value="calendar_start">시작일</option>
                                        <option value="calendar_end">종료일</option>
                                    </select>
                                </div>
                                <div class="col-7">
                                    <input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요"
                                           aria-label="검색어를 입력하세요" aria-describedby="btn_search" onkeyup="searchEnter()"/>
                                </div>
                                <div class="col-2">
                                    <input type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" id="searchEvent" name="searchEvent" value="검색" style="border-radius: 3px;" onclick="calendarSearch()"/>
                                </div>
                            </div>
                        </div>

                            <div class="container-fluid">
                                <table class="table">
                                    <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">일정 구분</th>
                                        <th scope="col">일정명</th>
                                        <th scope="col">시작시간</th>
                                        <th scope="col">종료시간</th>
                                        <th scope="col">취소</th>
                                    </tr>
                                    </thead>
                                    <tbody id="calendarTableBody">
                                        <% List<CalendarVO> companyCalendarList1 = (List<CalendarVO>) request.getAttribute("companyCalendarList");
                                    if (companyCalendarList1 != null) {
                                        int count = 0; // 일정 카운터 변수 추가
                                        for (CalendarVO vo : companyCalendarList1) {
                                            if (vo.getCalendar_id() == 3) {
                                            String startDateCheck = vo.getCalendar_start().split("T")[0]; // 일정 시작일자만 추출
                                            String endDateCheck = vo.getCalendar_end().split("T")[0]; // 일정 종료일자만 추출
                                                String startDate = vo.getCalendar_start().replace("T", "&nbsp;"); // T를 공백으로 대체
                                                String endDate = vo.getCalendar_end().replace("T", "&nbsp;"); // T를 공백으로 대체
                                            // 오늘 날짜와 시작일 또는 종료일이 일치하거나 오늘 날짜가 시작일과 종료일 사이에 있는 경우에만 출력
                                            if (startDateCheck.equals(todayDate) || endDateCheck.equals(todayDate) || (startDateCheck.compareTo(todayDate) < 0 && endDateCheck.compareTo(todayDate) > 0)) {
                                %>
                                <tr>
                                    <th scope="row"><%= ++count %></th>
                                    <%-- 화면엔 필요없지만 서버에 전송할 데이터 --%>
                                    <td class="calNo" id="calNo" style="display: none;"><%= vo.getCalendar_no() %></td>
                                    <td>전사 일정</td>
                                    <td><%= vo.getCalendar_title() %></td>
                                    <td><%= startDate%></td>
                                    <td><%= endDate %></td>
                                    <td><input type="button" class="btn btn-danger cancel-button" id="cancel-button" value="취소"/></td>
                                </tr>
                                <%
                                }}}}
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- 일정등록 모달 -->
        <div class="modal " id="insertModal">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content rounded-4 shadow">
                    <div class="modal-header p-5 pb-2 border-bottom-0">
                        <h1 class="fw-bold mb-0 fs-2">일정 등록</h1>
                    </div>
                    <div class="modal-body p-5 pt-0">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="insertTitle" name="insertTitle" placeholder="일정명">
                            <label for="insertTitle">일정명</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="insertName" name="insertName" placeholder="참석자" value="<%=sessionVO.getName()%>">
                            <label for="insertName">참석자</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="datetime-local" class="form-control rounded-3" id="insertStart" name="insertStart">
                            <label for="insertStart">일정 시작</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="datetime-local" class="form-control rounded-3" id="insertEnd" name="insertEnd">
                            <label for="insertEnd">일정 종료</label>
                        </div>
                        <select class="form-control" id="insertCalendarId" name="insertCalendarId">
                            <option value="0" selected>일정을 선택하세요.</option>
                            <option value="1">내일정</option>
                            <option value="2">팀일정</option>
                            <option value="3" selected>전사일정</option>
                        </select>
                        <br>
                        <input type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" id="submitEvent" name="submitEvent" value="등록"/>
                        <input type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-secondary close" id="exitEvent" name="exitEvent" value="취소"/>
                    </div>
                </div>
            </div>
        </div>

        <!-- 일정 수정/삭제 모달 -->
        <div class="modal " id="detailModal">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content rounded-4 shadow">
                    <div class="modal-header p-5 pb-4 border-bottom-0">
                        <h1 class="fw-bold mb-0 fs-2">일정 상세</h1>
                    </div>
                    <div class="modal-body p-5 pt-0">
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="detailTitle" name="detailTitle" placeholder="일정명">
                            <label for="detailTitle">일정명</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="detailName" name="detailName" placeholder="참석자" value="<%=sessionVO.getName()%>">
                            <label for="detailName">참석자</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="detailCalendarNo" name="detailCalendarNo" placeholder="일정 번호">
                            <label for="detailCalendarNo">일정 번호</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="datetime-local" class="form-control rounded-3" id="detailStart" name="detailStart">
                            <label for="detailStart">일정 시작</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="datetime-local" class="form-control rounded-3" id="detailEnd" name="detailEnd">
                            <label for="detailEnd">일정 종료</label>
                        </div>
                        <div class="form-floating mb-3">
                            <input type="text" class="form-control rounded-3" id="detailCalendarId" name="detailCalendarId" placeholder="일정 ID">
                            <label for="detailCalendarId">일정 ID</label>
                        </div>
                        <input type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" id="updateEvent" name="updateEvent" value="수정"/>
                        <input type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-primary" id="deleteEvent" name="deleteEvent" value="삭제"/>
                        <input type="button" class="w-100 mb-2 btn btn-lg rounded-3 btn-secondary close" id="exitEvent2" name="exitEvent" value="취소"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
