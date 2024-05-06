<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*  ,com.util.BSPageBar" %>
<%@  page import="com.vo.ApprovalVO" %>
<%
    List<ApprovalVO>list2=(List)request.getAttribute("list2");
//    out.print(list2);
    int size=0;
    if(list2!=null){
        size=list2.size();
    }
    int numPerPage=15;
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

    <title>전자결재 결재자 문서함</title>
    <%@include file="/common/bootstrap_common.jsp" %>

      <script type="text/javascript">

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
                  location.href="/approval/approvalList?gubun="+gubun+"&keyword="+keyword;
                  // console.log({keyword}+{gubun});
              } else {
                  alert('원한시는 검색어를 입력하세요');
              }
          }

    const ApprovalDetail = (document_no, document_category) => {
        let url = "";
        if (document_category === '영입') {
            url = "/approval/approvalDetail?document_no=" + document_no;
        } else if (document_category === '방출') {
            url = "/approval/approvalDetail2?document_no=" + document_no;
        } else if (document_category === '계약') {
            url = "/approval/approvalDetail3?document_no=" + document_no;
        }else if (document_category === '휴가') {
            url = "/approval/approvalDetail4?document_no=" + document_no;
        }
        location.href = url;
    };
      </script>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
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
                    <div class="text-dark fs-6">결재문서함</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-2">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0" ></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">결재문서함</div>
                    <div class="text-muted ms-3">결재문서 정보 조회할수 있는 페이지입니다.</div>
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
                                <h4 style="font-weight: bold; margin-left: 1.5rem" >결재문서함</h4>
                                <hr />
                            </div>

                            <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
                            <div class="row">
                                <div class="col-2">
                                    <select id="gubun" class="form-select" aria-label="분류선택">
                                        <option value="none">분류선택</option>
                                        <option value="document_category">종류</option>
                                        <option value="document_title">제목</option>
                                        <option value="name">신청자</option>
                                        <option value="approval_category">상태</option>
                                    </select>
                                </div>
                                <div class="col-3">
                                    <input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요"
                                           aria-label="검색어를 입력하세요." aria-describedby="btn_search" onkeyup="searchEnter(event)"/>
                                </div>
                                <div class="col-1 ">
                                    <button id="btn_search" class="btn btn-danger" onclick="boardSearch()">검색</button>
                                </div>
                            </div>
                            <!-- 검색기 끝 -->
                            <!-- 회원목록 시작 -->
                            <div class='board-list'>
                                <table class="table table-hover text-center ">
                                    <thead>
                                    <tr>
                                        <th width="10%">문서번호</th>
                                        <th width="10%">문서종류</th>
                                        <th width="30%">문서제목</th>
                                        <th width="15%">신청자</th>
                                        <th width="15%">신청날짜</th>
                                        <th width="15%">결재상태</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for(int i =nowPage*numPerPage;i<(nowPage*numPerPage)+numPerPage;i++){
                                            if(i==size)break;
                                            ApprovalVO approvalVO=(ApprovalVO) list2.get(i);
                                    %>
                                    <tr>
                                        <td><%= approvalVO.getDocument_no()%></td>
                                        <td><%= approvalVO.getDocument_category()%></td>
                                        <td>
                                            <a href="javascript:ApprovalDetail('<%= approvalVO.getDocument_no() %>', '<%= approvalVO.getDocument_category() %>')">
                                            <%= approvalVO.getDocument_title()%>
                                            </a>
                                        </td>
                                        <td><%= approvalVO.getName()%></td>
                                        <td><%= approvalVO.getSubmission_date()%></td>
                                        <td><%= approvalVO.getApproval_category()%></td>
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
                                        String pagePath="approvalList";
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
        </section>
    </div>
</div>
</body>
</html>