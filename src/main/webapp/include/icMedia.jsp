<%@ page import="com.util.BSPageBar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  int mediaSize = 0;
  if(mediaNoticeList!=null){
    mediaSize = mediaNoticeList.size();
  }
  //페이징처리
  int mediaNumPerPage = 1;
  int medianowPage = 0;
  if(request.getParameter("nowPage")!=null) {
    medianowPage = Integer.parseInt(request.getParameter("nowPage"));
  }
%>
<script>
    const mediaDetail=(board_no) => {
        location.href = '/media/mediaDetail?board_no='+board_no;
    }
</script>
<section class="content">
  <!-- Info boxes -->
  <div class="row">
    <div class="col">
      <div>
        <div class="container" >
          <!------------------------- [[ 미디어게시판목록 시작 ]] ------------------------->
          <div class='board-list' >
            <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" >
              <div class="carousel-inner" >
                <% for(int i = 0; i < mediaNoticeList.size(); i++) {
                  if (i == mediaSize) break;
                  MediaNoticeVO mediaNoticeVO = mediaNoticeList.get(i);
                  String originalString  = mediaNoticeVO.getReg_date();
                  String newFormatString = originalString.substring(0, 10);
                %>
                <div class="carousel-item <% if(i == 0) { %>active<% } %>" > <!-- 첫 번째 슬라이드에 "active" 클래스 추가 -->
                  <div class="card custom-card p-2" style="height: 150px;">
                    <div class="row">
                      <div class="col-md-4">
                        <%------------------------- [[ 이미지의 경로를 가져오는 코드 ]]-------------------------%>
                        <img src="/fileUpload/media/<%=mediaNoticeVO.getFilename()%>/" class="img-fluid rounded-start" alt="...이미지 없음" style="width: 100%; height: 140px">
                      </div>
                      <div class="col-md-8">
                        <div class="card-body pt-1">
                          <p class="card-text m-0 p-0" >
                            <a href="javascript:mediaDetail('<%=mediaNoticeVO.getBoard_no()%>')" class="link-styled">
                                <%=mediaNoticeVO.getBoard_title()%> [<%=mediaNoticeVO.getCommend_cnt()%>]
                            </a>
                          </p>
                          <p class="card-text m-0 p-0">작성자 : <%=mediaNoticeVO.getName()%></p>
                          <p class="card-text m-0 p-0">작성일 : <%=newFormatString%></p>
                          <p class="card-text m-0 p-0">
                            <small class="text-body-secondary">조회수 : <%=mediaNoticeVO.getBoard_hit()%></small>
                          </p>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <% } %>
              </div>
              <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
              </button>
              <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
              </button>
            </div>


            <hr/>
          </div>

<%--          <!-- [[ Bootstrap 페이징 처리  구간  ]] -->--%>
<%--          <div style="display:flex; justify-content:center;">--%>
<%--            <ul class="pagination">--%>
<%--              <%--%>
<%--                String mediaPagePath = "mediaNotice";--%>
<%--                BSPageBar bs = new BSPageBar(mediaNumPerPage,mediaSize,medianowPage,mediaPagePath);--%>
<%--                out.print(bs.getPageBar());--%>
<%--              %>--%>
<%--            </ul>--%>
<%--          </div>--%>
<%--          <!-- [[ Bootstrap 페이징 처리  구간  ]] -->--%>

        </div>
        <!-- 미디어게시판목록   끝  -->
      </div>
    </div>
  </div>
</section>
