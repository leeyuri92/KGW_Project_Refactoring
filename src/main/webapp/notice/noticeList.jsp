<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.util.BSPageBar" %>
<%@ page import="com.vo.NoticeBoardVO" %>
<%@ page import="com.best.kgw.common.TimeUtil" %>
<%
    int size=0;
    List<NoticeBoardVO> noticeList = (List)request.getAttribute("noticeList");
    if(noticeList!=null){
        size=noticeList.size();
    }

    //페이지처리
    int numPerPage = 15;
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
    <title>공지사항</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/certificate.css" />
    <script type="text/javascript">
        function searchEnter(event){
            if(window.event.keyCode == 13){
                noticeSearch()
            }
        }
        function noticeSearch(){
            console.log('noticeSearch');
            const gubun = document.querySelector("#gubun").value;
            const keyword = document.querySelector("#keyword").value;
            console.log(`${gubun} , ${keyword}`);
            location.href="/notice/noticeList?gubun="+gubun+"&keyword="+keyword;
        }
        const noticeDetail= (notice_no) => {
            location.href= "/notice/noticeDetail?notice_no="+notice_no;
        }
        function NoticeForm () {
            location.href = '../admin/noticeForm.jsp';
        }
    </script>
    <!-- Google Font: Source Sans Pro -->
</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <!-- header start -->
    <%@include file="/include/KGW_bar.jsp"%>
    <link rel="stylesheet" href="/css/mediaNoticeCard.css">
    <!-- header end    -->

    <!-- body start    -->
    <div class="content-wrapper">
        <!-- 페이지 path start    -->
        <!-- <div class="card"> -->
        <div class="box-header p-4">
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">공지사항</a>
                </div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0"></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">공지사항</div>
                    <div class="text-muted ms-3">공지사항 목록을 조회할 수 있는 페이지입니다.</div>
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
                                <h4 style="font-weight: bold; margin-left: 2rem">공지사항</h4>
                                <hr/>
                            </div>

                            <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
                            <div class="row">
                                <div class="col-2">
                                    <select id="gubun" class="form-select" aria-label="분류선택">
                                        <option value="none">분류선택</option>
                                        <option value="notice_title">제목</option>
                                        <option value="emp_no">작성자</option>
                                    </select>
                                </div>
                                <div class="col-3">
                                    <input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요"
                                           aria-label="검색어를 입력하세요." aria-describedby="btn_search" onkeyup="searchEnter()"/>
                                </div>
                                <div class="col-1">
                                    <button id="btn_search" class="btn btn-danger" onclick="noticeSearch()">검색</button>
                                </div>
                                <div class="col-md-6 d-flex justify-content-end gap-2">
                                    <%
                                        if (sessionVO.getEmp_access().equals("ROLE_ADMIN") ) {
                                    %>
                                    <button type="button" class="btn btn-danger" onclick="NoticeForm()">작성</button>
                                    <%
                                        }
                                    %>
                                </div>
                            </div>
                            <div class='board-list'>
                                <table class="table table-hover text-center ">
                                    <thead>
                                    <tr>
                                        <th style="width: 10%;">#</th>
                                        <th style="width: 45%;">제목</th>
                                        <th style="width: 17%;">작성자</th>
                                        <th style="width: 17%;">작성일</th>
                                        <th style="width: 17%;">조회수</th>
                                    </tr>
                                    </thead>
                                    <hr />
                                    <tbody>
                                    <%
                                        for (int i = nowPage * numPerPage; i < (nowPage * numPerPage) + numPerPage; i++) {
                                        if (i == size) break;
                                        NoticeBoardVO noticeVO = noticeList.get(i);
                                        String originalString  = noticeVO.getReg_date();
                                        String newFormatString = originalString.substring(0, 10);

                                        // New 배지 표시를 위한 작성일로부터의 일 수 계산
                                        long days = TimeUtil.newBadge(noticeVO.getReg_date());
                                    %>
                                    <tr>
                                        <td>
                                            <%--메서드를 통해 해당 공지사항이 상단에 고정된 것인지 여부를 확인하는 JSP 스크립틀릿
                                             만약 상단에 고정된 공지사항이라면 (true), <i class="bi bi-pin-angle"></i> 아이콘이 표시되고,
                                             그렇지 않다면 (false), 해당 공지사항의 번호인 <%= noticeVO.getNotice_no() %> 가 표시--%>
                                            <% if (noticeVO.isNotice_pin()) {%>
                                            <i class="bi bi-pin-angle-fill" style="color: #7c1512;"></i>
                                            &nbsp;
                                            <% } else
                                            {
                                            %>
                                            <%=noticeVO.getNotice_no()%>
                                        </td>
                                        <%
                                            }
                                        %>
                                        <td>
                                            <a href="javascript:noticeDetail('<%=noticeVO.getNotice_no()%>')">
                                                <%=noticeVO.getNotice_title()%>
                                                <% if (days < 2) { %>
                                                <span class="badge badge-small text-bg-danger">New</span>
                                                <% } %>
                                            </a>

                                        </td>
                                        <td><%=noticeVO.getName()%></td>
                                        <td><%=newFormatString%></td>
                                        <td><%=noticeVO.getNotice_hit()%></td>
                                        <td></td>
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
                                            String pagePath = "noticeList";
                                            BSPageBar bspb = new BSPageBar(numPerPage,size,nowPage,pagePath);
                                            out.print(bspb.getPageBar());
                                        %>
                                    </ul>
                                </div>
                                <!-- [[ Bootstrap 페이징 처리  구간  ]] -->
                            </div>
                            <!-- 공지사항   끝  -->
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>
</html>
