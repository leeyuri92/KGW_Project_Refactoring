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
    <title>사원정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/certificate.css" />
    <script type="text/javascript">
        function searchEnter(event){
            if(window.event.keyCode === 13){
                empSearch();
            }
        }
        function empSearch(){
            console.log('empSearch');
            const gubun = document.querySelector("#gubun").value;
            const keyword = document.querySelector("#keyword").value;
            console.log(`${gubun} , ${keyword}`);
            location.href="/empInfo?gubun="+gubun+"&keyword="+keyword;
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
                    <a class="text-muted fs-6" href="#">주소록</a>
                </div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0"></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">주소록</div>
                    <div class="text-muted ms-3">주소록을 확인 할 수 있는 페이지입니다.</div>
                </div>
            </div>
        </div> <!-- Main content -->
        <section class="content">
            <!-- Info boxes -->
            <div class="row">
                <div class="col-md-12">
                    <div class="box ">
                        <div class="container">
                            <div class="box-header">
                                <h4 style="font-weight: bold; margin-left: 2rem">주소록</h4>
                                <hr/>
                            </div>

                            <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
                            <div class="row">
                                <div class="col-2">
                                    <select id="gubun" class="form-select" aria-label="분류선택">
                                        <option value="none">분류선택</option>
                                        <option value="name">이름</option>
                                        <option value="team_name">팀</option>
                                    </select>
                                </div>
                                <div class="col-3">
                                    <input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요"
                                           aria-label="검색어를 입력하세요." aria-describedby="btn_search" onkeyup="searchEnter()"/>
                                </div>
                                <div class="col-1">
                                    <button id="btn_search" class="btn btn-danger" onclick="empSearch()">검색</button>
                                </div>
                            </div>
                            <!-- 회원목록 시작 -->
                            <div class='board-list'>
                                <table class="table table-hover text-center ">
                                    <thead>
                                    <tr>
                                        <th width="15%">부서</th>
                                        <th width="15%">이름</th>
                                        <th width="15%">직급</th>
                                        <th width="20%">핸드폰번호</th>
                                        <th width="20%">이메일</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for(int i = nowPage*numPerPage; i < (nowPage*numPerPage)+numPerPage; i++) {
                                            if (i == size) break;
                                            EmpVO empVO = empList.get(i);
                                    %>
                                    <tr>
                                        <td><%=empVO.getTeam_name()%></td>
                                        <td>
                                            <%
                                                String profileImgSrc = "/fileUpload/profile/" + empVO.getEmp_no() + ".png";
                                                if (empVO.getEmp_no() != 0 && new java.io.File(application.getRealPath(profileImgSrc)).exists()) {
                                            %>
                                            <img src="<%=profileImgSrc%>" class="img-circle m-1" alt='' style="width: 30px; height: 30px; ">
                                            <%
                                            } else {
                                            %>
                                            <img src="/fileUpload/profile/K1.png" class="img-circle m-1" alt='' style="width: 30px; height: 30px;">
                                            <%
                                                }
                                            %>
                                            <%=empVO.getName()%>
                                        </td>
                                        <td><%=empVO.getEmp_position() %></td>
                                        <td><%=empVO.getPhone_num()%></td>
                                        <td><%=empVO.getEmail()%></td>
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
                                            String pagePath = "empInfo";
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
