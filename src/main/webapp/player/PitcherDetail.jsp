<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vo.PitchersVO" %>

<%
    String pNoParamStr = request.getParameter("p_no");
    int pNoParam = Integer.parseInt(pNoParamStr);

    List<PitchersVO> list = (List<PitchersVO>)request.getAttribute("pitcherDetail");
    PitchersVO selectedPitcher = null;

    if (list != null) {
        for (PitchersVO pitcher : list) {
            if (pitcher.getP_no() == pNoParam) {
                selectedPitcher = pitcher;
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>선수 상세</title>
    <script>
        function noticeList(){
            location.href='/player/PitchersList';
        }



    </script>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <!-- header start -->
    <%@include file="/include/KGW_bar.jsp"%>
    <link rel="stylesheet" href="/css/mediaNotice.css">
    <!-- header end -->
    <!-- body start -->
    <div class="content-wrapper">
        <!-- 페이지 path start -->
        <div class="box-header p-4">
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">전략분석</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">전체선수 조회</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0"></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">선수 상세 정보</div>
                    <div class="text-muted ms-3">선수 상세 정보 조회할 수 있는 페이지입니다.</div>
                </div>
            </div>
        </div>
        <!-- 페이지 path end -->
        <section class="content">
            <!-- Info boxes -->
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="container">
                            <div class="box-header">
                                <h4 style="font-weight: bold; margin-left: 2rem" >선수명</h4>
                                <hr />
                                <%--------------------게시글 상세내용---------------------%>
                                <% if (selectedPitcher != null) { %>
                                <div class="board_view">
                                    <div class="title">
                                        <dd><%=selectedPitcher.getP_name()%></dd>
                                    </div>
                                    <div class="info">
                                        <dl>
                                            <dt>팀명</dt>
                                            <dd><%=selectedPitcher.getP_team()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>평균자책점 era</dt>
                                            <dd><%=selectedPitcher.getP_era()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>이닝 IP</dt>
                                            <dd><%=selectedPitcher.getP_ip()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>승 WIN</dt>
                                            <dd><%=selectedPitcher.getP_win()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>패</dt>
                                            <dd><%=selectedPitcher.getP_lose()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>세이브</dt>
                                            <dd><%=selectedPitcher.getP_save()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>피안타율 </dt>
                                            <dd><%=selectedPitcher.getP_h()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>피출루율 OB</dt>
                                            <dd><%=selectedPitcher.getP_ob()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>승리기여도 WAR</dt>
                                            <dd><%=selectedPitcher.getP_war()%></dd>
                                        </dl>
                                    </div>
                                </div>
                                <% } %>
                                <div class="d-flex gap-2 justify-content-end mt-2">
                                    <button type="submit" class="btn btn-primary" onclick="noticeList()">목록</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

</body>
</html>