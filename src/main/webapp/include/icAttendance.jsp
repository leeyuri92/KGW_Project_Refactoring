<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String jspFileName = new java.io.File(request.getServletPath()).getName();
//    out.print(jspFileName);
%>

    <!-- calendar 태그 -->
    <div id='calendar-container'>
        <div id='calendar'></div>
    </div>

<script>
    (function(){
        $(function(){
            // calendar element 취득
            let calendarEl = $('#calendar')[0];
            // full-calendar 생성하기
            let calendar = new FullCalendar.Calendar(calendarEl, {
                expandRows: true, // 화면에 맞게 높이 재설정
                initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
                slotMinTime: '08:00', // Day 캘린더에서 시작 시간
                slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
                // 해더에 표시할 툴바
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                },
                // initialDate: '', // 초기 날짜 설정 (미설정시 오늘 날짜로 설정)
                navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
                editable: true, // 수정 가능
                selectable: true, // 달력 일자 드래그 설정가능
                nowIndicator: true, // 현재 시간 마크
                dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
                height: '550px', // calendar 높이 설정
                locale: 'ko', // 한국어 설정

                datesSet: function(info) {
                    // 뷰가 렌더링될 때마다 실행됩니다.
                    let toolbarTitle = document.querySelector('.fc-toolbar-title').textContent; ;
                    let formattedTitle = toolbarTitle.replace(/년 |월/g, '-');
                    let date = new Date(formattedTitle);

                    // 월을 가져오고, 한 자리 숫자인 경우 앞에 0을 붙여줌
                     var month = (date.getMonth() + 1 < 10 ? '0' : '') + (date.getMonth() + 1);
                    //
                    // // 변환된 문자열을 출력
                     var result = date.getFullYear() + '-' + month;
                    console.log(result);

                    var requestData = {
                        work_date: result, // 예: '2024-03'
                        emp_no: <%=attendanceCalendar.get(0).getEmp_no()%> // 이 부분은 서버 사이드 템플릿 코드로 처리되므로 클라이언트에서는 그대로 두세요.
                    };

                    <%
                    if (jspFileName.equals("attendanceCalendar.jsp")){
                    %>
                    $.ajax({
                        url: 'jsonAttendanceSelect',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(requestData),
                        success: function(data) {
                            // 받은 데이터를 사용하여 테이블에 추가하는 작업 수행
                            let table = $('#attendanceTable'); // 기존의 테이블 선택

                            // 기존의 테이블의 모든 행을 제거
                            table.find('tbody').empty();

                            // 데이터를 사용하여 테이블에 행 추가
                            $.each(data, function(index, item) {
                                let row = $('<tr>');
                                let columns = [ 'work_date', 'start_time', 'end_time', 'state'];
                                $.each(columns, function(index, column) {
                                    row.append($('<td>').text(item[column]));
                                });

                                if (item['state'] !== '정상출근') {
                                    var buttonCell = $('<td>');
                                    var button = $('<button>').attr('id', 'bb').attr('class', 'btn btn-danger').attr('style', 'width: 70%;').attr('data-bs-toggle', 'modal').attr('data-bs-target', '#modAttendance').text('근태수정요청');
                                    buttonCell.append(button);
                                    row.append(buttonCell);
                                }

                                table.append(row);
                            });
                        },
                        error: function(xhr, status, error) {
                            // 에러 처리
                        }
                    });
                    <%
                    }
                    %>
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
                    tooltip.innerHTML = info.event.extendedProps.start_time + info.event.extendedProps.end_time;

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
                    <%
                      for(int i = 0; i < attendanceCalendar.size(); i++) {
                        if (attendanceCalendar.get(i).getState() != null){
                    %>
                    {
                        title: '<%=attendanceCalendar.get(i).getState()%>',
                        start: '<%=attendanceCalendar.get(i).getWork_date()%>',
                        extendedProps: {
                            <%
                                if (attendanceCalendar.get(i).getStart_time() == null){
                            %>
                            start_time: '출근시간 : -',
                            end_time: '<br> 퇴근시간 : -'
                            <%
                            }else{
                            %>
                            start_time: '출근시간 : <%=attendanceCalendar.get(i).getStart_time()%>',
                            end_time: '<br> 퇴근시간 : <%=attendanceCalendar.get(i).getEnd_time()%>'
                            <%
                            }
                            %>
                        },
                        color:
                                `
                                            <% if (attendanceCalendar.get(i).getState().equals("지각")){ %>
                                              #BA6F33
                                            <%
                                              }else if(attendanceCalendar.get(i).getState().equals("조퇴")){
                                            %>
                                              #efc30f
                                            <%
                                              }else if(attendanceCalendar.get(i).getState().equals("정상출근")){
                                            %>
                                               #5eb900
                                            <%
                                            }else if(attendanceCalendar.get(i).getState().equals("결근")){
                                            %>
                                               #FF0800FF
                                            <%
                                            }
                                            %>
                                            `

                    },
                    <%
                        }
                      }
                    %>

                ],
            });

            // 캘린더 랜더링
            calendar.render();
        });
    })();
</script>
