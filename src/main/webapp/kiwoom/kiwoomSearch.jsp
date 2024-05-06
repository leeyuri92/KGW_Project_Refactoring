<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.util.BSPageBar" %>
<%@ page import="com.vo.KChartVO" %>

<%
  int size = 0;//전체 레코드 수
  List<KChartVO> kList = (List) request.getAttribute("kList");
  if(kList !=null){
    size = kList.size();
  }
  //페이지처리
  int numPerPage = 9;
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
  <title>우리구단 선수조회</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script type="text/javascript">

  const kiwoomDetail= (k_no)=>{
  location.href= "/kiwoom/kiwoomDetail?k_no="+k_no;
  }
  function kiwoomSearch(){
    console.log('empSearch');
    const gubun = document.querySelector("#gubun").value;
    const keyword = document.querySelector("#keyword").value;
    console.log(`${gubun} , ${keyword}`);
    location.href="/kiwoom/kiwoomList?gubun="+gubun+"&keyword="+keyword;
  }
  function searchEnter(event){
    if(window.event.keyCode === 13){
      kiwoomSearch();
    }
  }
  </script>
</head>
<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
  <!-- header start -->
  <%@include file="/include/KGW_bar.jsp"%>
  <link rel="stylesheet" href="/css/kiwoom.css">
  <!-- header end    -->

  <!-- body start    -->
  <div class="content-wrapper">
    <!-- 페이지 path start    -->
    <%-- <div class="card" >--%>
    <div class="box-header p-4">
      <div class="d-flex align-items-center">
        <div class="d-flex align-items-center me-2">
          <a class="text-muted fs-6" href="#">우리구단</a>
          <div class="ms-2">></div>
        </div>
        <div class="d-flex align-items-center">
          <div class="text-dark fs-6">우리구단 선수조회</div>
        </div>
      </div>
      <div class="d-flex align-items-center mt-3">
        <div class="position-relative">
          <div class="position-absolute top-0 start-0"></div>
        </div>
        <div class="d-flex align-items-center ms-2">
          <div class="fw-bold fs-5">우리구단 선수조회</div>
          <div class="text-muted ms-3">우리구단 선수를 조회 할 수 있는 페이지입니다.</div>
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
            <div class="container">
              <div class="box-header">
                <h4 style="font-weight: bold; margin-left: 2rem" >우리구단 선수조회</h4>
                <hr />
              </div>
              <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
              <div class="row p-3 mb-5" >
                <div class="col-2">
                  <select id="gubun" class="form-select" aria-label="분류선택">
                    <option value="none">분류선택</option>
                    <option value="k_name">이름</option>
                    <option value="k_num">등번호</option>
                    <option value="k_pos">포지션</option>
                  </select>
                </div>

                <div class="col-2">
                  <input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요"
                         aria-label="검색어를 입력하세요." aria-describedby="btn_search" onkeyup="searchEnter()"/>
                </div>

                <div class="col-1 ">
                  <button id="btn_search" class="btn btn-danger" onclick="kiwoomSearch()">검색</button>
                </div>
                <div class="col-md-7 d-flex justify-content-end">
                  <label class="mt-1" style="color: grey; font-weight: bold">[출처] KBO (업데이트 날짜 24.02.18)</label>
                </div>
              </div>
              <%
                for (int i = nowPage * numPerPage; i < (nowPage * numPerPage) + numPerPage; i++) {
                  if (i == size) break;
                  KChartVO kmap = kList.get(i);
              %>
              <% if (i % 3 == 0) { %>
              <div class="row mb-3">
                <% } %>
                <div class="col-md-4">
                  <div class="card mb-3" style="display:flex; justify-content:center;">
                  <a href="javascript:kiwoomDetail('<%=kmap.getK_no()%>')">
                    <div class="row g-0" >

                      <div class="col-md-6 " style="display:flex; justify-content:center;">
                        <img src="/fileUpload/kiwoom/<%=kmap.getK_name()%>.jpeg" class="img-fluid rounded-start" alt="profile" >
                      </div>
                      <div class="col-md-6">
                        <div class="card-body">
                          <p class="card-text">  <%= kmap.getK_pos() %></p>
                          <p class="card-text fw-bold" > <%= kmap.getK_name() %></p>
                          <hr style="width: 50px">
                          <p class="card-text"> NO  : <%= kmap.getK_num()%></p>
                        </div>
                      </div>
                    </div>
                  </a>
                  </div>
                </div>
                <% if ((i + 1) % 3== 0 || i == size - 1) { %>
              </div>
              <% } %>
              <%
                }
              %>

                  <!-- [[ Bootstrap 페이징 처리  구간  ]] -->
              <div style="display:flex; justify-content:center;">
                <ul class="pagination">
                  <%
                    String pagePath = "kiwoomList";
                    BSPageBar bspb = new BSPageBar(numPerPage,size,nowPage,pagePath);
                    out.print(bspb.getPageBar());
                  %>
                </ul>
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