<%@ page import="com.util.BSPageBar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script>
    const noticeDetail= (notice_no) => {
        location.href= "/notice/noticeDetail?notice_no="+notice_no;
    }
</script>
<section class="content">
  <!-- Info boxes -->
  <div class="row">
    <div class="col-md-12">
      <div class="">
        <div class="container">

          <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
          <div class='board-list'>
            <table class="table table-hover text-center ">
              <thead>
              <tr>
                <th style="width: 10%;">#</th>
                <th style="width: 56%;">제목</th>
                <th style="width: 17%;">작성자</th>
                <th style="width: 17%; padding: 7px">작성일</th>
              </tr>
              </thead>
              <tbody>
              <% for (int i = 0; i < noticeList.size(); i++) {
                NoticeBoardVO noticeVO = noticeList.get(i);
                String originalString  = noticeVO.getReg_date();
                String newFormatString = originalString.substring(0, 10);
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
                  </a>
                </td>
                <td><%=noticeVO.getName()%></td>
                <td><%=newFormatString%></td>
                <td></td>
              </tr>
              <%
                }
              %>
              </tbody>
            </table>
            <hr />
          </div>
          <!-- 회원목록   끝  -->
        </div>
      </div>
    </div>
  </div>
</section>