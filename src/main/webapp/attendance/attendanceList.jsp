<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.util.BSPageBar" %>
<%@ page import="com.vo.AttendanceVO" %>
<%@ page import="com.vo.AttendanceModifyVO" %>
<%
  List<AttendanceModifyVO> attendanceModList = (List) request.getAttribute("attendanceModList");
  List<AttendanceVO> attendanceList = (List) request.getAttribute("attendanceList");
  int size = 0;
  if(attendanceModList !=null){
    size = attendanceModList.size();
  }
//  out.print(attendanceModList);
  //페이지처리
  int numPerPage = 5;
  int nowPage = 0;
  if(request.getParameter("nowPage")!=null){
    nowPage = Integer.parseInt(request.getParameter("nowPage"));
  }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>인사정보</title>
  <script type="text/javascript">
      const modAttendance = () =>{
          console.log("제출버튼 클릭");
          const modDate_vale = document.getElementById('attendance_no').value
          const request_content = document.getElementById('request_content').value

          if(modDate_vale == 0){
              alert('수정요청일 선택해 주세요.');
          }else if (request_content == ""){
              alert('요청사유를 입력해 주세요.');
          }else{
              document.querySelector('#attendaceMod').submit();
          }
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
          <a class="text-muted fs-6" href="/">메인페이지</a>
          <div class="ms-2">></div>
          <a class="text-muted fs-6" href="#">근태관리</a>
          <div class="ms-2">></div>
          <a class="text-muted fs-6" href="#">근태수정요청</a>
        </div>
      </div>
      <div class="d-flex align-items-center mt-3">
        <div class="position-relative">
          <div class="position-absolute top-0 start-0"></div>
        </div>
        <div class="d-flex align-items-center ms-2">
          <div class="fw-bold fs-5">근태수정요청목록</div>
          <div class="text-muted ms-3">근태수정요청목록 확인 할 수 있는 페이지입니다.</div>
        </div>
      </div>
    </div> <!-- Main content -->

    <section class="content">
      <div class="box mt-3">
        <div class="box-header d-flex align-items-center pb-0">
          <div class="d-flex align-items-center">
            <h4 style="font-weight: bold; margin-left: 1.5rem">근태수정요청목록</h4>
          </div>
            <div style="margin-left: auto;">
              <button id="bb" class="btn btn-danger" style="width: 100%;" data-bs-toggle="modal" data-bs-target="#modAttendance">근태수정요청</button>
            </div>
        </div>
        <hr />

        <div class='board-list'>
          <table class="table table-hover text-center ">
            <thead>
            <tr>
              <th width="13%">수정요청일시</th>
              <th width="13%">요청자</th>
              <th width="10%">출근시간</th>
              <th width="10%">퇴근시간</th>
              <th width="13%">수정 전 근태상태</th>
              <th width="13%">수정 후 근태상태</th>
              <th width="13%">상태</th>
            </tr>
            </thead>
            <tbody>
            <%
                   for(int i = nowPage*numPerPage; i < (nowPage*numPerPage)+numPerPage; i++) {
                     if (i == size) break;
                     AttendanceModifyVO attendancemodifyvo = attendanceModList.get(i);
            %>
            <tr>
                   <td><%=attendancemodifyvo.getMod_date()%></td>
                   <td><%=attendancemodifyvo.getName()%></td>
                   <td><%=attendancemodifyvo.getOriginal_start_time()%></td>
                   <td><%=attendancemodifyvo.getOriginal_end_time()%></td>
                   <td><%=attendancemodifyvo.getOriginal_state()%></td>
                   <td><%=attendancemodifyvo.getMod_state() %></td>
                   <td><%=attendancemodifyvo.getState()%></td>
            </tr>
                  <%
                    }
                  %>
            </tbody>
          </table>
          <hr />

                <!-- [[ Bootstrap 페이징 처리  구간  ]] -->
          <div style="display:flex; justify-content:center;">
            <ul class="pagination">
                    <%
                      String pagePath = "attendanceList?emp_no="+sessionVO.getEmp_no();
                      BSPageBar bspb = new BSPageBar(numPerPage,size,nowPage,pagePath);
                      out.print(bspb.getPageBar());
                    %>
            </ul>
          </div>
                <!-- [[ Bootstrap 페이징 처리  구간  ]] -->

        </div>
      </div>
    </section>
  </div>
</div>

<div class="modal content" id="modAttendance">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content rounded-4 shadow">
      <div class="modal-header p-5 pb-4 border-bottom-0">
        <h1 class="fw-bold mb-0 fs-2">근태 수정 요청서</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="attendaceMod" method="post" action="/attendance/attendaceMod">
          <div class="form-floating m-3">
            <div class="row mb-3">
              <div class="col-2" style="line-height: 37px"><label for="name">작성자</label></div>
              <div class="col-10" ><input type="text" class="form-control" id="name" name="name" value="<%=sessionVO.getName()%>" disabled></div>
            </div>
            <div class="row mb-3">
              <div class="col-2" style="line-height: 37px"><label for="name">수정요청일</label></div>
              <div class="col-10" >
                <select class="form-control" id="attendance_no" name="attendance_no" >
                  <option value="0" selected>원하시는 날짜를 선택하세요.</option>
                  <hr class="dropdown-divider">
                  <%
                    for(int i = 0; i < attendanceList.size(); i++) {
                      AttendanceVO attendancevo = attendanceList.get(i);
                      if (attendancevo.getState() != null){
                        if (attendancevo.getState().equals("정상출근")){
                          continue;
                        }else{
                  %>
                  <option value="<%=attendancevo.getAttendance_no()%>">|<%=attendancevo.getEmp_no()%>| <%=attendancevo.getWork_date()%> | <%=attendancevo.getState()%></option>
                  <%
                        }
                      }
                    }
                  %>
                </select>
              </div>
            </div>
            <input type="hidden" class="form-control" id="emp_no" name="emp_no" value="" >
            <div class="row mb-5">
              <div class="col-2" style="line-height: 37px"><label for="name">근태상태</label></div>
              <div class="col-10" ><input type="text" class="form-control" id="state" name="state" value="" disabled></div>
            </div>
            <div class="row mb-5">
              <div class="col-2" style="line-height: 37px"><label for="name">요청사유</label></div>
              <div class="col-10" ><textarea type="text" class="form-control" id="request_content" name="request_content"></textarea>
            </div>
          </div>
          <div style=" text-align: right;">
            <input type="button" class="btn btn-danger" onclick="modAttendance()" value="제출"/>
            <input type="button" class="btn btn-danger" data-bs-dismiss="modal" aria-label="Close" value="취소"/>
          </div>

          </div>
        </form>
        <script>
            // select 요소에 대한 이벤트 리스너 추가
            document.getElementById('attendance_no').addEventListener('change', function() {
                // 선택된 option 요소 가져오기
                var selectedOption = this.options[this.selectedIndex];
                // 해당 option 요소의 텍스트 값에서 근태 상태 추출
                var attendanceState = selectedOption.innerText.split('|')[3].trim();
                var emp_no = selectedOption.innerText.split('|')[1].trim();
                // 근태 상태를 state input 요소의 value로 설정
                document.getElementById('state').value = attendanceState;
                document.getElementById('emp_no').value = emp_no;
            });
        </script>
      </div>
    </div>
  </div>
</div>
</body>
</html>
