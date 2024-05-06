<%--
  Created by IntelliJ IDEA.
  User: 13210
  Date: 2024/2/26
  Time: 14:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,com.util.BSPageBar" %>
<%@page import="com.vo.PitchersVO" %>
<%@ page import="org.apache.ibatis.javassist.expr.NewArray" %>


<%    List<PitchersVO> list2= (List) request.getAttribute("list2");
    int size = 0;
    if (list2 != null) {
        size = list2.size();
    }

    int numPerPage = 20;
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
    <title>현역선수현황</title>

    <script type="text/javascript">
        // window.onload = function() {
        //     // 행 태이블 선택
        //     let rows = document.querySelectorAll("table tr");
        //
        //     for(let  i = 1; i < rows.length; i++) {
        //         let firstCell = rows[i].cells[0];
        //         // 첫 번째 셀에 인덱스(행 번호)를 삽입합니다.
        //         firstCell.textContent = i;
        //     }
        // };
        function PlayersSearch() {
            var gubunValue = document.getElementById('gubun').value;
            var gubunPitcherValue = document.getElementById('gubunPitcher').value;

            if (gubunValue === 'pitcherTable') {
                if (gubunPitcherValue === 'pitcherTable') {
                    window.location.href = '/player/PitchersList';
                } else {
                    // 이닝수 랑 타석 처리 부분
                }
            } else if (gubunValue === 'hitterTable') {
                if (gubunPitcherValue === 'pitcherTable') {
                    window.location.href = '/player/HittersList';
                } else {
                    // 이닝수 랑 타석 처리 부분
                }
            }
        }

        let  PitcherDetail= (p_no) => {
            location.href= "/player/PitcherDetail?p_no="+p_no;
        }
    </script>

</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <%@include file="/include/KGW_bar.jsp"%>
    <!-- body start    -->
    <div class="content-wrapper">
        <!-- 페이지 path start    -->
        <div class="box-header p-4" >
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">전력분석</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">현역 선수현황</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-2">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0" ></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">현역 투수 리스트</div>
                    <div class="text-muted ms-3">현역 선수 정보를 검색할 수 있는 페이지입니다.</div>
                </div>
            </div>
        </div>
        <!-- 페이지 path end -->
        <section class="content">
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="container">
                        <div class="box-header">
                            <h4 style="font-weight: bold; margin-left: 1.5rem" >현역 투수 리스트</h4>
                            <hr />
                        </div>

                        <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
                        <div class="row">
                            <div class="col-2">
                                <select id="gubun" class="form-select" aria-label="분류선택">
                                    <option value="pitcherTable">투수</option>
                                    <option value="hitterTable">타자</option>
                                </select>
                            </div>
                            <div class="col-2">
                                <select id="gubunPitcher" class="form-select" aria-label="분류선택">
                                    <option value="pitcherTable">전체이닝</option>
                                    <option value="pitcherTable">이닝수 50이상</option>
                                </select>
                            </div>
                            <div class="col-1 ">
                                <button id="btn_search" class="btn btn-danger" onclick="PlayersSearch()">검색</button>
                            </div>
                            <div class="col-md-7 d-flex justify-content-end">
                                <label class="mt-1" style="color: grey; font-weight: bold">[출처] KBO (업데이트 날짜 24.02.18)</label>
                            </div>

                        </div>
                        <!-- 검색기 끝 -->


                        <div class='board-list'>
                            <table class="table table-hover text-center " id="pitcherTable">
                                <thead>
                                <tr>
                                    <th width="5%" >#</th>
                                    <th width="10%">선수명</th>
                                    <th width="8%">소속</th>
                                    <th width="8%">평균자책</th>
                                    <th width="8%">이닝</th>
                                    <th width="6%">승</th>
                                    <th width="6%">패</th>
                                    <th width="6%">세이브</th>
                                    <th width="6%">홀드</th>
                                    <th width="8%">피안타율</th>
                                    <th width="8%">피장타율</th>
                                    <th width="8%">피출루율</th>
                                    <th width="8%" id="WAR" data-bs-toggle="tooltip" data-bs-placement="bottom" title="WAR(Wins Above Replacement,대체 선수 대비 승리 기여도)
                    특정 선수가 평범한 선수(대체선수) 대비해서 얼마나 팀의 승리에 기여하는지를 나타낸다. ">WAR</th>
                                    <th width="5%" id="WHIP" data-bs-toggle="tooltip" data-bs-placement="bottom" title="WHIP(Walks Plus Hits Divided by Innings Pitched,
                    이닝당 안타 및 볼넷 허용률)는 야구에서 투수의 성적 평가 항목 중 하나로서 피안타 수와 볼넷 수의 합을 투구 이닝으로 나눈 수치이다.">WHIP</th>
                                </tr>
                                </thead>
                                <tbody id="tableBody">
                                <%
                                    for(int i=nowPage*numPerPage;i<(nowPage*numPerPage)+numPerPage;i++){
                                        if(i== size) break;
                                        PitchersVO pitchersVO=list2.get(i);
                                %>
                                    <tr>
                                        <td><%= pitchersVO.getP_no()%></td>
                                        <td>
                                            <a href="javascript:PitcherDetail('<%=pitchersVO.getP_no()%>')">
                                                <%= pitchersVO.getP_name()%>
                                            </a>
                                        </td>
                                        <td><%= pitchersVO.getP_team()%></td>
                                        <td><%= pitchersVO.getP_era()%></td>
                                        <td><%= pitchersVO.getP_ip()%></td>
                                        <td><%= pitchersVO.getP_win()%></td>
                                        <td><%= pitchersVO.getP_lose()%></td>
                                        <td><%= pitchersVO.getP_save()%></td>
                                        <td><%= pitchersVO.getP_hold()%></td>
                                        <td><%= pitchersVO.getP_h()%></td>
                                        <td><%= pitchersVO.getP_ob()%></td>
                                        <td><%= pitchersVO.getP_bh()%></td>
                                        <td><%= pitchersVO.getP_war()%></td>
                                        <td><%= pitchersVO.getP_whip()%></td>
                                    </tr>
                                    <%}%>
                                    </tbody>
                                </table>
                                <hr />

                               <!-- [[ Bootstrap 페이징 처리  구간  ]] -->

                                <ul class="pagination">
                                    <%
                                        String pagePath="PitchersList";
                                        BSPageBar bsbp=new BSPageBar(numPerPage,size,nowPage,pagePath);
                                        out.print(bsbp.getPageBar());
                                    %>
                                </ul>
                                <!-- [[ Bootstrap 페이징 처리  구간  end ]] -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
    <script>  <%-- toolTips function 사용--%>
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltipTriggerList.forEach(function (tooltipTriggerEl) {
        new bootstrap.Tooltip(tooltipTriggerEl);
    });
    </script>
</body>
</html>


