
<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>


<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">

    // 첫번째 차트
    google.charts.load('current', {'packages': ['bar']});
    google.charts.setOnLoadCallback(drawStuff);

    function drawStuff() {
        const data = new google.visualization.arrayToDataTable(
            ${warChart}
        );

        const options = {
            width: 900,
            legend: {position: 'none'},
            axes: {
                x: {
                    0: {side: 'top', label: '선수명'} // Top x-axis.
                }
            },
            bar: {groupWidth: "60%"},
            colors: ['#7c1512']
        };

        const chart = new google.charts.Bar(document.getElementById('top_x_div'));
        chart.draw(data, google.charts.Bar.convertOptions(options));

        google.visualization.events.addListener(chart, 'select', selectHandler);

        function selectHandler() {
            const selection = chart.getSelection();
            alert('That\'s column no. ' + selection[0].row);
        }
    }

    <%--// 파이차트--%>
    google.charts.load('current', {'packages': ['corechart']});
    google.charts.setOnLoadCallback(drawChart2);

    function drawChart2() {
        var data2 = google.visualization.arrayToDataTable(
            ${positionChart}
        );
        var options2 = {
            chartArea: {
                width: '90%', // 차트 영역의 너비
                height: '90%',// 차트 영역의 높이
                left: '22%'
            },
            "is3D": true,
            colors: ['#7c1512', '#d77e7b', '#e7c0bd', '#f1e2e1'],
            backgroundColor: 'transparent'
        };
        var chart2 = new google.visualization.PieChart(document.getElementById('piechart'));
        chart2.draw(data2, options2);
    }

</script>

<style>
    .chart {
        width: 100%;
        padding-bottom: 15px;
        border-radius: 6px;
        overflow: hidden;
        align-self: stretch;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    /* 컬럼의 첫 번째 행에 배경색을 적용하기 위한 CSS */
    .header-row th {
        background-color: #d0455e;
    }

</style>
</head>

<section class="content">
  <!-- Info boxes -->
  <div class="row">
    <div class="col-md-8">
      <div class="m-2">
        <div class="container">
          <div class="box-header">
            <h4 style="font-weight: bold; margin-left: 1.5rem" >2024년도 FA 선수 현황</h4>
          </div>
          <div class="chart">
            <div id="top_x_div" style="width: 100%; height: 400px;"></div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="m-2">
        <div class="container">
          <div class="box-header">
            <h4 style="font-weight: bold; margin-left: 1.5rem">2024년도 FA선수 포지션별 현황</h4>
          </div>
          <div class="chart-pie">
            <div id="piechart" style="width: 100%; height: 415px;"></div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- /.row -->

  <!-- /.row -->
  <!-- /.col -->
</section>
</div>
<!-- content-wrapper end-->
