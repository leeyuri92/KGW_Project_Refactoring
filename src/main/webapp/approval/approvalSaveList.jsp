<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*,com.util.BSPageBar" %>
<%@  page import="com.vo.ApprovalVO" %>
<%
    List<ApprovalVO>list3=(List)request.getAttribute("list3");
//    out.print(list3);
    int size=0;
    if(list3!=null){
        size=list3.size();
    }
    int numPerPage=10;
    int nowPage=0;
    if(request.getParameter("nowPage")!=null){
        nowPage=Integer.parseInt(request.getParameter("nowPage"));
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/common/bootstrap_common.jsp" %>
    <title>문서함{임시보관함}</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <script type="text/javascript">

          const saveDetail= (document_no) => {
              location.href= "/approval/saveDetail?document_no="+document_no ;
          }


          function saveDelete(document_no) {
              if (!confirm('삭제확인하시겠습니까？')) {
                  return;
              }

              $.ajax({
                  url: '/approval/saveList/' + document_no,
                  type: 'DELETE',
                  success: function(result) {
                      alert('삭제성공');
                      window.location.href = '/approval/documentList';
                  },
                  error: function(xhr, status, error) {
                      console.error(error);
                      location.reload();
                  }
              });
          }


          function searchEnter(event){
              if(event.keyCode === 13){
                  boardSearch();
              }
          }

          function boardSearch(){
              const gubun = document.getElementById('gubun').value;
              const keyword = document.getElementById('keyword').value;
              console.log(gubun+keyword);
              if(gubun !== 'none' && keyword.trim() !== ''){
                  location.href="/approval/saveList?gubun="+gubun+"&keyword="+keyword;
              } else {
                  alert('원한시는 검색어를 입력하세요');
              }
          }

      </script>
</head>

<body   class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <!-- header start -->
    <%@include file="/include/KGW_bar.jsp"%>
    <!-- header end    -->

    <!-- body start    -->
    <div class="content-wrapper">
        <!-- 페이지 path start    -->
        <%--		<div class="card" >--%>
        <div class="box-header p-4" >
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">전자결재</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">임시문서함</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-2">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0" ></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">임시문서함</div>
                    <div class="text-muted ms-3">임시보관문서  정보 조회할수 있는 페이지입니다.</div>
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
                                <h4 style="font-weight: bold; margin-left: 1.5rem" >임시문서함</h4>
                                <hr />
                            </div>

                            <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
                            <div class="row">
                                <div class="col-2">
                                    <select id="gubun" class="form-select" aria-label="분류선택">
                                        <option value="none">분류선택</option>
                                        <option value="document_category">종류</option>
                                        <option value="document_title">제목</option>
                                    </select>
                                </div>
                                <div class="col-3">
                                    <input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요"
                                           aria-label="검색어를 입력하세요." aria-describedby="btn_search" onkeyup="searchEnter(event)"/>
                                </div>
                                <div class="col-1 ">
                                    <button id="btn_search" class="btn btn-danger" onclick="boardSearch()">검색</button>

                                </div>


                            <!-- 검색기 끝 -->

                            <!-- 회원목록 시작 -->
                            <div class='board-list'>
                                <table class="table table-hover text-center ">
                                    <thead>
                                    <tr>
                                        <th width="10%" >문서번호</th>
                                        <th width="10%">문서종류</th>
                                        <th width="30%">문서제목</th>
                                        <th width="15%">임시보관날짜</th>
                                        <th width="10%"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for(int i =nowPage*numPerPage;i<(nowPage*numPerPage)+numPerPage;i++){
                                            if(i==size)break;
                                            ApprovalVO approvalVO=list3.get(i);
                                    %>
                                    <tr>
                                        <td><%= approvalVO.getDocument_no()%></td>
                                        <td><%= approvalVO.getDocument_category()%></td>
                                        <td> <a href="javascript:saveDetail('<%=approvalVO.getDocument_no()%>')">
                                            <%= approvalVO.getDocument_title()%></a>
                                        </td>
                                        <td><%= approvalVO.getDraftday()%></td>
                                        <td><a href="javascript:saveDelete('<%= approvalVO.getDocument_no() %>')">삭제</a></td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                    </tbody>
                                </table>
                                <hr />

                                <!-- [[ Bootstrap 페이징 처리  구간  ]] -->
                                <ul class="pagination">
                                    <%
                                        String pagePath="saveList";
                                        BSPageBar bsbp=new BSPageBar(numPerPage,size,nowPage,pagePath);
                                        out.print(bsbp.getPageBar());
                                    %>
                                </ul>
                                <!-- [[ Bootstrap 페이징 처리  구간  ]] -->
                            </div>
                            <!-- 회원목록   끝  -->
                        </div>
                    </div>
                </div>
            </div>
            <!-- /.row -->

            <!-- /.row -->

            <!-- /.col -->

    </div>
    <!-- content-wrapper end-->
<!-- body end   -->



<!-- ========================== [[ 게시판 Modal ]] ========================== -->
<%--	<div class="modal" id="boardForm">--%>
<%--  		<div class="modal-dialog modal-dialog-centered">--%>
<%--	<div class="modal-content">--%>

<%--	  <!-- Modal Header -->--%>
<%--	  <div class="modal-header">--%>
<%--		<h4 class="modal-title">게시판</h4>--%>
<%--		<button type="button" class="btn-close" data-bs-dismiss="modal"></button>--%>
<%--	  </div>--%>
<%--	  <!-- Modal body -->--%>
<%--	  <div class="modal-body">--%>
<%--		<!-- <form id="f_board" method="get" action="./boardInsert"> -->--%>
<%--		<form id="f_board" method="post" enctype="multipart/form-data" action="./boardInsert">--%>
<%--		  <input type="hidden" name="method" value="boardInsert">--%>
<%--		  <div class="form-floating mb-3 mt-3">--%>
<%--			<input type="text"  class="form-control" id="b_title" name="b_title" placeholder="Enter 제목" />--%>
<%--			<label for="b_title">제목</label>--%>
<%--		  </div>--%>
<%--		  <div class="form-floating mb-3 mt-3">--%>
<%--			<input type="text"  class="form-control" id="b_writer" name="b_writer" placeholder="Enter 작성자" />--%>
<%--			<label for="b_writer">작성자</label>--%>
<%--		  </div>--%>
<%--		  <div class="form-floating mb-3 mt-3">--%>
<%--			<textarea rows="5" class="form-control h-25" aria-label="With textarea" id="b_content" name="b_content"></textarea>--%>
<%--		  </div>--%>
<%--		  <div class="input-group mb-3">--%>
<%--			  <input type="file" class="form-control" id="b_file" name="b_file">--%>
<%--			  <label class="input-group-text" for="b_file">Upload</label>--%>
<%--		  </div>--%>
<%--		</form>--%>
<%--	  </div>--%>
<%--	  <div class="modal-footer">--%>
<%--		<input type="button" class="btn btn-warning" data-bs-dismiss="modal" onclick="boardInsert()"  value="저장">--%>
<%--		<input type="button" class="btn btn-danger" data-bs-dismiss="modal" value="닫기">--%>
<%--	  </div>--%>
<!-- ========================== [[ 게시판 Modal ]] ========================== -->
</body>
</html>