<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.util.BSPageBar" %>
<%
  Map<String, Object> attendanceModMap = (Map) request.getAttribute("attendanceModMap");
//  out.print(attendanceModMap);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>인사정보</title>
  <script type="text/javascript">
    const adminattendanceList = () =>{
      location.href = "/attendance/adminAttendance";
    }

    const signOn = () =>{
      document.getElementById('state').value = "승인";
      document.querySelector('#attendanceModUpdate').submit();
    }

    const signOff = () =>{
      document.getElementById('state').value = "반려";
      document.querySelector('#attendanceModUpdate').submit();
    }
  </script>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
  <!-- header start -->
  <%@include file="/include/KGW_bar.jsp"%>
  <div class="content-wrapper">
    <!-- 페이지 path start    -->
    <!-- <div class="card"> -->
    <div class="box-header p-4">
      <div class="d-flex align-items-center">
        <div class="d-flex align-items-center me-2">
          <a class="text-muted fs-6" href="/">관리자메뉴</a>
          <div class="ms-2">></div>
          <a class="text-muted fs-6" href="#">근태관리</a>
          <div class="ms-2">></div>
          <a class="text-muted fs-6" href="#">근태수정요청안</a>
        </div>
      </div>
      <div class="d-flex align-items-center mt-3">
        <div class="position-relative">
          <div class="position-absolute top-0 start-0"></div>
        </div>
        <div class="d-flex align-items-center ms-2">
          <div class="fw-bold fs-5">근태수정요청안</div>
          <div class="text-muted ms-3">근태수정요청안을 확인 할 수 있는 페이지입니다.</div>
        </div>
      </div>
    </div> <!-- Main content -->

    <section class="content">
      <div class="box mt-3">
        <div class="box-header d-flex align-items-center pb-0">
          <div class="d-flex align-items-center">
            <h4 style="font-weight: bold; margin-left: 1.5rem">근태수정요청안</h4>
          </div>
        </div>
        <hr />

        <div class="row mt-5">
          <div class="col-5 mr-3 ml-5">
            <div class="row mb-3">
              <div class="col-2" style="line-height: 37px"><label>작성자</label></div>
              <div class="col-10"><input type="text" class="form-control" value="<%=attendanceModMap.get("NAME")%>" disabled></div>
            </div>
            <div class="row mb-3">
              <div class="col-2" style="line-height: 37px"><label>작성일</label></div>
              <% if(attendanceModMap.get("REG_DATE")!=null){
              %>
              <div class="col-10"><input type="text" class="form-control" value="<%=attendanceModMap.get("REG_DATE")%>" disabled></div>
              <%
              }else {
              %>
              <div class="col-10"><input type="text" class="form-control" value="-" disabled></div>
              <%
                }
              %>
            </div>
            <div class="row mb-3">
              <div class="col-2" style="line-height: 37px"><label>수정요청일</label></div>
              <div class="col-10"><input type="text" class="form-control" value="<%=attendanceModMap.get("MOD_DATE")%>" disabled></div>
            </div>
            <div class="row mb-3" style="line-height: 37px"><label>요청사유</label></div>
            <div class="row mb-3"><textarea type="text" class="form-control" id="request_content" name="request_content" disabled><%=attendanceModMap.get("REQUEST_CONTENT")%></textarea></div>
          </div>

          <div class="col-5 ml-5" style="border: 1px solid grey">
            <div class="row m-4">
              <div class="col-6"><label>출근일</label></div>
              <div class="col-6"><%=attendanceModMap.get("WORK_DATE")%></div>
            </div>
            <hr/>
            <div class="row m-4" >
              <div class="col-6"><label>출근시간</label></div>
              <%if (attendanceModMap.get("START_TIME")!=null){%>
              <div class="col-6"><%=attendanceModMap.get("START_TIME")%></div>
              <%
              }else{
              %>
              <div class="col-6">-</div>
              <%
                }
              %>
            </div>
            <hr/>
            <div class="row m-4" >
              <div class="col-6"><label>퇴근시간</label></div>
              <%
                if (attendanceModMap.get("END_TIME") != null) {
              %>
              <div class="col-6"><%=attendanceModMap.get("END_TIME")%></div>
              <%
              }else{
              %>
              <div class="col-6">-</div>
              <%
                }
              %>
            </div>
            <hr/>
            <div class="row m-4" >
              <div class="col-6"><label>근태상태</label></div>
              <div class="col-6"><%=attendanceModMap.get("STATE")%></div>
            </div>
          </div>
        </div>

        <hr style="margin-top: 50px; margin-bottom: 50px;"/>
        <form id="attendanceModUpdate" method="post" action="/attendance/attendanceModUpdate">
          <div class="form-floating m-3">
            <div class="row mb-3" >
              <div class="col-1" style=" line-height: 37px"><label>상태수정</label></div>
              <div class="col-2" >
                <select id="mod_state" name="mod_state" class="form-select" aria-label="분류선택">
                  <option value="none" selected>분류선택</option>
                  <option value="정상출근">정상출근</option>
                  <option value="비정상출근">비정상출근</option>
                  <option value="지각">지각</option>
                  <option value="결근">결근</option>
                  <option value="휴가">휴가</option>
                  <option value="조퇴">조퇴</option>
                </select>
              </div>
            </div>
            <input type="hidden" id="attendance_no" name="attendance_no" value="<%=attendanceModMap.get("ATTENDANCE_NO")%>">
            <input type="hidden" id="attendancemod_no" name="attendancemod_no" value="<%=attendanceModMap.get("ATTENDANCEMOD_NO")%>">
            <input type="hidden" id="state" name="state" value="">
            <div class="row mb-3">
              <div class="col" style="line-height: 37px"><label>수정사유</label></div>
            </div>
            <div class="row mb-3">
              <textarea type="text" class="form-control" id="mod_content" name="mod_content"></textarea>
            </div>

            <div style=" text-align: right;">
              <input type="button" class="btn btn-danger" onclick="adminattendanceList()" value="목록"/>
              <input type="button" class="btn btn-danger"  onclick="signOn()" value="승인"/>
              <input type="button" class="btn btn-danger"  onclick="signOff()" value="반려"/>
            </div>

          </div>
        </form>
      </div>
    </section>
  </div>
</body>
</html>
