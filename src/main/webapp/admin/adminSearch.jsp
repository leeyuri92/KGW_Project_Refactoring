<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.util.BSPageBar" %>
<%@ page import="com.vo.EmpVO" %>
<%
    int size = 0;//전체 레코드 수
    List<EmpVO> empList = (List) request.getAttribute("empList");
    if(empList !=null){
        size = empList.size();
    }
    //페이지처리
    int numPerPage = 10;
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
    <title>사원관리</title>
    <link rel="stylesheet" href="/css/admin.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript">

        function searchEnter(event){
            // Enter 키 입력 시 검색 수행
            if(window.event.keyCode === 13){
                empSearch();
            }
        }

        function empSearch(){
            // 검색 기능 수행
            const gubun = document.querySelector("#gubun").value;
            const keyword = document.querySelector("#keyword").value;
            location.href="/admin/empList?gubun="+gubun+"&keyword="+keyword;
        }

        const empDetail= (emp_no)=>{
            // 사원 상세 페이지로 이동
            location.href= "/admin/empDetail?emp_no="+emp_no;
        }

        const empCertificate= (emp_no)=>{
            // 재직증명서 발급 페이지로 이동
            location.href= "/empCertificate?emp_no="+emp_no;
        }

        const retireCertificate= (emp_no)=>{
            // 퇴직증명서 발급 페이지로 이동
            location.href= "/retireCertificate?emp_no="+emp_no;
        }

        var tdNo= "";
        function check(){
            // 체크박스 선택 시 처리
            const checkbox = $("input[name=checkboxName]:checked");
            checkbox.each(function (i) {
                var tr = checkbox.parent().parent().eq(i);
                var td = tr.children();
                tdNo = td.eq(1).text();
            });
        }

        const empSelectDown= ()=>{
            // 선택한 사원 정보 다운로드
            check();
            location.href= "/selectDownLoadExel?emp_no="+tdNo;
        }

        const empAllDown= ()=>{
            // 모든 사원 정보 다운로드
            check();
            location.href= "/allDownLoadExel";
        }

    </script>
    <!-- Google Font: Source Sans Pro -->
</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <!-- header start -->
    <%@include file="/include/KGW_bar.jsp"%>
    <!-- header end    -->

    <!-- body start    -->
    <div class="content-wrapper">
        <!-- 페이지 path start    -->
        <!-- <div class="card"> -->
        <div class="box-header p-4">
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">관리자페이지</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">사원관리</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0"></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">사원관리</div>
                    <div class="text-muted ms-3">사원을 관리할 수 있는 페이지입니다.</div>
                </div>
            </div>
        </div> <!-- Main content -->
        <section class="content">
            <!-- Info boxes -->
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="container">
                            <div class="box-header">
                                <h4 style="font-weight: bold; margin-left: 2rem">사원관리</h4>
                                <hr/>
                            </div>

                            <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
                            <div class="row">
                                <div class="col-2">
                                    <select id="gubun" class="form-select" aria-label="분류선택">
                                        <option value="none">분류선택</option>
                                        <option value="name">이름</option>
                                        <option value="emp_no">사번</option>
                                    </select>
                                </div>
                                <div class="col-3">
                                    <input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요"
                                           aria-label="검색어를 입력하세요." aria-describedby="btn_search" onkeyup="searchEnter()"/>
                                </div>
                                <div class="col-1">
                                    <button type="button" id="btn_search" class="btn btn-danger" onclick="empSearch()">검색</button>
                                </div>
                                <div class="col-md-6 d-flex justify-content-end gap-2">
                                    <button id="btn_selectDown" type="button" class="btn btn-danger" onclick="empSelectDown()">선택사원 다운로드</button>
                                    <button id="btn_allDown" type="button" class="btn btn-danger" onclick="empAllDown()">전체사원 다운로드</button>
                                </div>
                            </div>
                            <!-- 회원목록 시작 -->
                            <div class='board-list'>
                                <table class="table table-hover text-center ">
                                    <thead>
                                    <tr>
                                        <th width="10%" >#</th>
                                        <th width="10%">사번</th>
                                        <th width="10%">이름</th>
                                        <th width="10%">부서</th>
                                        <th width="10%">직급</th>
                                        <th width="10%">상태</th>
                                        <th width="10%">이메일</th>
                                        <th width="15%">잔여연차</th>
                                        <th width="15%">증명서</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for(int i = nowPage*numPerPage; i < (nowPage*numPerPage)+numPerPage; i++) {
                                            if (i == size) break;
                                            EmpVO empVO = empList.get(i);
                                    %>
                                    <tr>

                                        <td> <input type="checkbox" class="form-check-input" id="check" name="checkboxName" onclick="check() "></td>
                                        <td><%=empVO.getEmp_no()%></td>
                                        <td>
                                            <%
                                                String profileImgSrc = "/fileUpload/profile/" + empVO.getEmp_no() + ".png";
                                                if (empVO.getEmp_no() != 0 && new java.io.File(application.getRealPath(profileImgSrc)).exists()) {
                                            %>
                                            <a href="javascript:empDetail('<%=empVO.getEmp_no()%>')">
                                                <img src="<%=profileImgSrc%>" class="img-circle m-1" alt='' style="width: 30px; height: 30px; cursor: pointer;">
                                                    <%
                                            } else {
                                            %>
                                                <a href="javascript:empDetail('<%=empVO.getEmp_no()%>')">
                                                    <img src="/fileUpload/profile/K1.png" class="img-circle m-1" alt='' style="width: 30px; height: 30px; cursor: pointer;">
                                                        <%
                                                }
                                            %>
                                                        <%=empVO.getName()%>
                                        </td>
                                        <td><%=empVO.getTeam_name()%></td>
                                        <td><%=empVO.getEmp_position()%></td>
                                        <% if (empVO.getEmp_state().equals("0")){ %>
                                        <td>퇴직</td>
                                        <% }else{ %>
                                        <td>재직</td>
                                        <%  } %>
                                        <td><%=empVO.getEmail() %></td>
                                        <td><%=empVO.getDayoff_cnt() %></td>
                                        <% if (empVO.getEmp_state().equals("0")){ %>
                                        <td><a href="javascript:retireCertificate('<%=empVO.getEmp_no()%>')">퇴직증명서</a></td>
                                        <% }else{ %>
                                        <td><a href="javascript:empCertificate('<%=empVO.getEmp_no()%>')">재직증명서</a></td>
                                        <%  } %>
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
                                            String pagePath = "empList";
                                            BSPageBar bspb = new BSPageBar(numPerPage,size,nowPage,pagePath);
                                            out.print(bspb.getPageBar());
                                        %>
                                    </ul>
                                </div>
                                <!-- [[ Bootstrap 페이징 처리  구간  ]] -->

                            </div>
                            <!-- 회원목록   끝  -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
</body>
</html>