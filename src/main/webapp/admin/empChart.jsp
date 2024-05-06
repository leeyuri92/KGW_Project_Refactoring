<%--
  이름 : 이유리
  날짜 : 2024-02-18
  내용 : empChart
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<%
    List<Map<String, Object>> hireList = (List)request.getAttribute("hireList");
    int hsize = hireList.size();
    Map<String, Object> hmap = hireList.get(hsize-1);

    List<Map<String, Object>> retireList = (List)request.getAttribute("retireList");
    int rsize = retireList.size();
    Map<String, Object> rmap = retireList.get(rsize-1);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>입/퇴사자 차트</title>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        google.charts.load('current', {'packages': ['corechart']}); //구글 지원하는 라인차트 로딩

        const hireChart =() => {//DataTable()
            const data = google.visualization.arrayToDataTable(
                ${hireChart}
            );

            const options = {
                lineWidth: 4 ,
                colors: ['#a11a16'],
                legend : {position: 'bottom'}
            };

            const chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
            chart.draw(data, options);
        };
        google.charts.setOnLoadCallback(hireChart); // 그래프 그리려면 데이터가 필요함 - 함수호출

        const retireChart = () => {
            const data = google.visualization.arrayToDataTable(
                ${retireChart}
            );

            const options = {
                lineWidth: 4 ,
                colors: ['#d97d7a'],
                legend : {position: 'bottom'}
            };
            const chart2 = new google.visualization.LineChart(document.getElementById('curve_chart2'));
            chart2.draw(data, options);
        };
        google.charts.setOnLoadCallback(retireChart); // 그래프 그리려면 데이터가 필요함 - 함수호출

    </script>

    <style>
        .content-box {
            width: 90%;
            margin: 2rem 2.5rem 2rem 2.5rem;
            padding: 16px;
            border-radius: 6px;
            overflow: hidden;
            border: 2px solid #c8c8c8;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            gap: 4px;
        }
        .chart-box {
            width: 90%;
            margin: 2rem 2.5rem 2rem 2.5rem;
            border-radius: 6px;
            overflow: hidden;
            border: 2px solid #c8c8c8;
            align-self: stretch;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .chart {
            width: 100%;
            margin-left: -8rem;
            border-radius: 6px;
            overflow: hidden;
            align-self: stretch;
        }
        .subtitle {
            color: rgba(0, 0, 0, 0.50);
            font-size: 14px;
            font-family: Roboto;
            font-weight: 600;
            line-height: 24px;
            word-wrap: break-word;
        }
        .count {
            width: 100px;
            height: 40px;
            color: black;
            font-size: 20px;
            font-family: Roboto;
            font-weight: 600;
            line-height: 36px;
            word-wrap: break-word;
        }
    </style>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper" >
    <!-- header start -->
    <%@include file="/include/KGW_bar.jsp"%>
    <!-- header end    -->

    <!-- body start    -->
    <div class="content-wrapper">
        <!-- 페이지 path start    -->
        <div class="box-header p-4" >
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">관리자</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">입/퇴사자 현황</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-2">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0" ></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">입/퇴사자 현황</div>
                    <div class="text-muted ms-3">차트</div>
                </div>
            </div>
        </div>
        <!-- 페이지 path end -->

        <!-- Main content -->
        <section class="content">
            <!-- Info boxes -->
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="container">
                                    <div class="box-header">
                                        <h4 style="font-weight: bold; margin-left: 2rem">입사자</h4>
                                        <hr />
                                        <div class="content-box">
                                            <div class="subtitle">2024년 입사자</div>
                                            <div class="count"><%=hmap.get("COUNT")%> 명</div>
                                        </div>
                                        <div class="chart-box">
                                            <div class="chart">
                                                <div id="curve_chart"  style="width: 120%; height: 440px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="container">
                                    <div class="box-header">
                                        <h4 style="font-weight: bold; margin-left: 2rem">퇴사자</h4>
                                        <hr />
                                        <div class="content-box">
                                            <div class="subtitle">2024년 퇴사자</div>
                                            <div class="count"><%=rmap.get("COUNT")%> 명</div>
                                        </div>
                                        <div class="chart-box">
                                            <div class="chart ">
                                                <div id="curve_chart2" style="width: 120%; height: 440px;"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- ./box-body -->
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </section>
    </div>
    <!-- content-wrapper end-->
</div>
<!-- body end   -->
</body>
</html>

