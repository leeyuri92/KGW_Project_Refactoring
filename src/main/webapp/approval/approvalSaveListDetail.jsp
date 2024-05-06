<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vo.ApprovalVO" %>
<%
    List<ApprovalVO> saveDetail = (List<ApprovalVO>) request.getAttribute("saveDetail");
//    out.print(saveDetail);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>{임시보관함 상세} -휴가</title>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script>
        const saveUpdate=()=>{
            // not null 공통값
            let document_no=document.getElementById('document_no').value;
            let document_category=document.getElementById('document_category').value;
            let document_title=document.getElementById('document_title').value;
            let state=document.getElementById('state').value;
            let approval_name = document.getElementById('vacation_name').value;
            let name = document.getElementById('name').value;

            // 휴가 제외 임지분서 제출 불가  추가 로직처리
            if (document_category === '휴가') {
                start_date = document.getElementById('start_date').value;
                end_date = document.getElementById('end_date').value;
                dayoff_content=document.getElementById('dayoff_content').value;
            } else if (document_category === '계약') {
                extension_name = document.getElementById('extension_name').value;
                salary = document.getElementById('salary').value;
               contract_term = document.getElementById('contract_term').value;
            }
            else if (document_category === '영입') {
                scout_name = document.getElementById('scout_name').value;
            }
            else if (document_category === '방출') {
                release_name = document.getElementById('release_name').value;
            }
            $('#saveDocumentPost').submit();

        }
    </script>

    <link  rel="stylesheet " href="../css/approvalDocu.css">
    <style>
        input[type="text"],
        input[type="date"] {
            margin: 0;
            padding: 8px;
            border: 1px solid #ced4da;
            height: 32px;
            /*input type data,text 규격 통일  */
        }

    </style>

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
                    <a class="text-muted fs-6" href="../approval/documentList">전자결재</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">임시보관함</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-2">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0" ></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">임시보관함</div>
                    <div class="text-muted ms-3">임시보관문서   상세정보 조회할수 있는 페이지입니다.</div>
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
                                <h4 style="font-weight: bold; margin-left: 1.5rem" >임시보관문서 상세 </h4>
                                <hr />
                            </div>

                            <!-- 검색기 시작 !! div 안에 있는 태그 건들지마시오!! -->
                             </div>
                        <div class="row">

                            <%--추가 수정 부분   --%>

                            <form id="saveDocumentPost" name="saveDocumentPost" action="saveDetailUpdate" method="post">
                                <div class="frame " id="do_vocation">
                                    <div class="document-section">
                                        <%
                                            if (saveDetail != null && !saveDetail.isEmpty()) {
                                                ApprovalVO approvalVO = saveDetail.get(0);
                                        %>
                                        <div class="row">
                                            <div class="row">
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">사원번호 </span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="text" class="value-input" id="emp_no"  name="emp_no" value="<%=sessionVO.getEmp_no()%>">
                                                </div>
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">신청자</span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="text" class="value-input" id="name"  name="name" value="<%=sessionVO.getName()%> " >
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">담당자</span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="text" class="value-input" id="vacation_name" name="approval_name" value="<%=approvalVO.getApproval_name()%>">
                                                </div>
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">제목</span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="text" class="value-input" id="document_title" name="document_title" value="<%=approvalVO.getDocument_title()%>">
                                                </div>
                                            </div>
                                            <%--  공통부분 끝  --%>
                                                <%
                                                    if ("휴가".equals(approvalVO.getDocument_category())) {
                                                %>
                                            <div class="row">
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">휴가 사유 </span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="text" class="value-input" id="dayoff_content" name="dayoff_content" value="<%=approvalVO.getDayoff_content()%>" >
                                                </div>
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">휴가시작일 </span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="date" id="start_date" name="start_date"   value="<%=approvalVO.getStart_date()%>">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">휴가만료일 </span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="date" id="end_date" name="end_date"  value="<%=approvalVO.getEnd_date()%>">
                                                </div>
                                                <div class="col-2 mb-3 mt-3">
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                </div>
                                            </div>

                                            <%
                                            }else if("계약".equals(approvalVO.getDocument_category())){
                                            %>
                                            <div class="row">
                                                    <div class="col-2 mb-3 mt-3">
                                                        <span class="title">계약 선수 </span>
                                                    </div>
                                                    <div class="col-4 mb-3 mt-3">
                                                        <input type="text" class="value-input"  id="extension_name"  name="fa_name"  value="<%=approvalVO.getFa_name()%>">
                                                    </div>
                                                    <div class="col-2 mb-3 mt-3">
                                                        <span class="title">계약금액 </span>
                                                    </div>
                                                    <div class="col-4 mb-3 mt-3" >
                                                        <input type="text"class="value-input"  id="salary"  name="salary"  value="<%=approvalVO.getSalary()%>">
                                                    </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">계약년수 </span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="text" class="value-input" id="contract_term"  name="contract_term"  value="<%=approvalVO.getContract_term()%>">
                                                </div>
                                                <div class="col-2 mb-3 mt-3">
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                </div>
                                            </div>
                                            <%}else if ("영입".equals(approvalVO.getDocument_category())){  %>
                                            <div class="row">
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">영입 선수 </span>
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="text"  class="value-input" id="scout_name"  name="fa_name"  value="<%=approvalVO.getFa_name()%>">

                                                </div>
                                                <div class="col-2 mb-3 mt-3">
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                </div>
                                            </div>
                                            <%}else if ("방출".equals(approvalVO.getDocument_category())){  %>
                                                <div class="row">
                                                <div class="col-2 mb-3 mt-3">
                                                    <span class="title">방출  선수 </span>
                                                </div>
                                                <div  class="col-4 mb-3 mt-3">
                                                    <input type="text" class="value-input"  id="release_name"  name="fa_name"  value="<%=approvalVO.getFa_name()%>">
                                                </div>
                                                    <div class="col-2 mb-3 mt-3">
                                                    </div>
                                                    <div  class="col-4 mb-3 mt-3">
                                                    </div>
                                            </div>
                                            <%}%>
                                                <div class="col-2 mb-3 mt-3">
                                                    <input type="hidden"  id="document_no" name="document_no" value="<%=approvalVO.getDocument_no()%>">
                                                </div>
                                                <div class="col-4 mb-3 mt-3">
                                                    <input type="hidden"  id="state" name="state" value="중간결재대기">
                                                </div>
                                                <div class="col-2 mb-3 mt-3">
                                                    <input type="text"  hidden="hidden" class="value-input" id="document_category"  name="document_category" value="<%=approvalVO.getDocument_category()%>" >
                                                </div>
                                            <%
                                            }
                                            %>
                                        </div>

                                        <div id ="documentButton " class="col-md-6 d-flex justify-content-end gap-2">
                                            <button type="button"  id="btn_docSubmit" class="btn btn-danger" data-bs-toggle="modal"  onclick="saveUpdate()" >제출</button>
                                            <button type="button" class="btn btn-danger" data-bs-toggle="modal"   href="./approval/saveList">임시보관함</button>

<%--                                            <button type="button"  id="btn_docSubmit" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#boardForm"  onclick="saveUpdate()" >제출</button>--%>
<%--                                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#boardForm" href="./approval/saveList">임시보관함</button>--%>
                                        </div>
                                    </div>
                            </div>
                            </form>
                                </div>
                    </div>
                </div>
            </div>
        </section>
            </div>
            </div>



    </body>
    </html>