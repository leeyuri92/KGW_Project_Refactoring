<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vo.DocumentVO,com.vo.ApprovalVO" %>
<%@ page import="com.google.gson.Gson" %>
<%
//    List<Map<String,Object>> kiwoomList = (List) request.getAttribute("kiwoomList")
    List<ApprovalVO> faList = (List) request.getAttribute("faList");
    List<EmpVO> empList = (List) request.getAttribute("empList");
    EmpVO empVO = empList.get(0);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>기안 문서</title>
    <%@include file="/common/bootstrap_common.jsp" %>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const navLinks = document.querySelectorAll('.navbar-nav .nav-link'); //nav 링크전채 확보
            const frames = document.querySelectorAll('.frame'); // frame 링크 전채 확보

            // 디폴트로 첫 휴가문서 보여주기
            frames.forEach((frame, index) => frame.style.display = index === 0 ? 'block' : 'none');
            navLinks[0].classList.add('active');

            navLinks.forEach(link => link.addEventListener('click', e => {
                e.preventDefault();

                const targetId = link.getAttribute('data-target'); //클릭 이밴트 발동시 id 식별
                if (!targetId) return; // data-target 없는경우  리턴

                frames.forEach(frame => frame.style.display = frame.id === targetId ? 'block' : 'none'); // id값 맞는 frame 만 보여주기
                navLinks.forEach(nav => nav.classList.toggle('active', nav === link)); // 업데이트 처리
            }));
        });


        function docSubmitScout() {
            let fa_name = document.getElementById('playersList1').value;
            $('#r_documentScout').submit();
        }
        function docSaveSubmitScout() {//영입 문서 임시저장
            let fa_name = document.getElementById('playersList1').value;
            let state = document.getElementById('stateScout');
            state.value = '임시저장';
            let now = new Date();
            let draftday = now.toISOString();
            document.getElementById('draftdayScout').value =draftday;
            $('#r_documentScout').submit();
            console.log("임시저장성공");
        }


        function docSubmitRelease() {
            let fa_name = document.getElementById('playersList2').value;
            $('#r_documentRelease').submit();
        }
        function docSaveSubmitRelease() {//방출 문서 임시저장
            let fa_name = document.getElementById('playersList2').value;
            let state = document.getElementById('stateRelease');
            state.value = '임시저장';
            let now = new Date();
            let draftday = now.toISOString();
            document.getElementById('draftdayRelease').value =draftday;
            $('#r_documentRelease').submit();
            console.log("임시저장성공");
        }


        function docSubmitOffer() {
            let fa_name = document.getElementById('playersList3').value;
            let salaryValue = document.getElementById('salary').value;
            let contract_term = document.getElementById('contract_term').value;
            $('#salary').val(salaryValue);
            $('#contract_term').val(contract_term);
            $('#r_documentOffer').submit();
        }
        function docSaveSubmitOffer() {
            let fa_name = document.getElementById('playersList3').value;
            $('#stateOffer').val('임시저장');

            let salaryValue = document.getElementById('salary').value;
            let contract_term = document.getElementById('contract_term').value;
            $('#salary').val(salaryValue);
            $('#contract_term').val(contract_term);

            let now = new Date();
            let draftday = now.toISOString();
            $('#draftdayOffer').val(draftday);

            $('#r_documentOffer').submit(); //재출

        }

        function docSubmitVacation() {
            $('#r_documentVacation').submit();
        }

        function docSaveSubmitVacation() {//휴가 문서 임시저장 jquery date tyep input String 형전환 필요
            let state = document.getElementById('stateVacation');
            state.value = '임시저장';

            let now = new Date();
            let draftday = now.toISOString();
            document.getElementById('draftdayVacation').value =draftday;
            $('#r_documentVacation').submit();
            console.log("임시저장성공");
        }
    </script>
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
    <link  rel="stylesheet " href="../css/approvalDocu.css">
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
                    <div class="text-dark fs-6">기안문서</div>
                </div>

            </div>
            <div class="d-flex align-items-center mt-2">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0" ></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">기안문서 </div>
                    <div class="text-muted ms-3">문서기안 하는 페이지입니다.</div>
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
                                <h4 style="font-weight: bold; margin-left: 1.5rem" > 기안문서 </h4>
                                <hr />
                            </div>
                            <nav class="navbar navbar-expand-lg navbar-light bg-light">
                                <div class="container-fluid">
                                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                                        <span class="navbar-toggler-icon"></span>
                                    </button>
                                    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                                        <div class="navbar-nav">
                                            <a class="nav-link " href="#" data-target="do_vocation">휴가문서</a>
                                            <%
                                                if (sessionVO.getTeam_no() == 2){
                                            %>
                                            <a class="nav-link" href="#" data-target="do_pla_a">계약문서</a>
                                            <a class="nav-link" href="#" data-target="do_pla_b">방출문서</a>
                                            <a class="nav-link" href="#" data-target="do_pla_c">영입문서</a>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>
                            </nav>

                            <%--휴가문서--%>
                            <form id="r_documentVacation" name="r_documentVacation" action="documentInsert" method="post">
                                <div class="frame " id="do_vocation">
                                    <div class="row">
                                        <div class="col-2 mb-3 mt-3 ">
                                            <span class="title">사원번호 </span>
                                        </div>
                                        <div class="col-4 mb-3 mt-3 ">
                                            <input type="text" class="value-input" id="emp_no"  name="emp_no" value="<%=sessionVO.getEmp_no()%>">
                                        </div>
                                        <div class="col-2 mb-3 mt-3 ">
                                            <span class="title">문서제목 </span>
                                        </div>
                                        <div class="col-4 mb-3 mt-3 ">
                                            <input type="text" class="value-input" id="document_title" name="document_title" value=""  >
                                        </div>
                                    </div>
                                    <div class="document-section">
                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">결재자  </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="approval_name" name="approval_name" value="경영지원팀장">
                                            </div>
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">신청자 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="name"  name="name" value="<%=sessionVO.getName()%>" >
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">휴가 사유 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="dayoff_content" name="dayoff_content" value="연차" >
                                            </div>
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">잔여휴가</span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="dayoff_cnt" id="dayoff_cnt" name="dayoff_cnt" value="<%=empVO.getDayoff_cnt()%>" disabled/>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">휴가시작일 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="date" id="start_date" name="start_date"   value="2024-03-03">
                                            </div>
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">휴가만료일 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="date" id="end_date" name="end_date"  value="2024-03-04">
                                            </div>
                                        </div>
                                        <div class="row justify-content-center">
                                            <div class="col-auto mb-3 mt-3">
                                                <div class="text-wrapper-2">상기와 같이 휴가 희망함</div>
                                            </div>
                                        </div>
                                        <input type="hidden" class="value-input" id="document_category"  name="document_category" value="휴가" >
                                        <input type="hidden" id="stateVacation" name="state" value="대기" >
                                        <input type="hidden" id="draftdayVacation" name="draftday" value="" >

                                        <div class="row">
                                            <div class="col-7 mb-3 mt-3 ">
                                            </div>
                                            <div class="col-5 mb-3 mt-3 ">
                                                <div id ="documentButton " class="col-md-6 d-flex justify-content-end gap-2">
                                                    <button type="button"  id="btn_docSubmit" class="btn btn-danger" onclick="docSubmitVacation()" >제출</button>
                                                    <button type="button" id="btn_search" class="btn btn-danger" onclick="docSaveSubmitVacation()">임시보관 </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <form id="r_documentOffer" name="r_documentOffer" action="documentInsert" method="post">
                            <div class="frame" id="do_pla_a"> <%--계약연장 문서--%>
                                <div class="row">
                                    <div class="col-2 mb-3 mt-3 ">
                                        <span class="title">사원번호 </span>
                                    </div>
                                    <div class="col-4 mb-3 mt-3 ">
                                        <input type="text" class="value-input" id="emp_no3"  name="emp_no" value="<%=sessionVO.getEmp_no()%>">
                                    </div>
                                    <div class="col-2 mb-3 mt-3 ">
                                        <span class="title">문서제목 </span>
                                    </div>
                                    <div class="col-4 mb-3 mt-3 ">
                                        <input type="text" class="value-input" id="document_title3" name="document_title" value=""   >
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-2 mb-3 mt-3 ">
                                        <span class="title">결재자  </span>
                                    </div>
                                    <div class="col-4 mb-3 mt-3 ">
                                        <input type="text" class="value-input" id="approval_name3" name="approval_name" value="운영팀장">

                                    </div>
                                    <div class="col-2 mb-3 mt-3 ">
                                        <span class="title">신청자 </span>
                                    </div>
                                    <div class="col-4 mb-3 mt-3 ">
                                        <input type="text" class="value-input" id="name3" name="name" value="<%=sessionVO.getName()%>" >
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-2 mb-3 mt-3 ">
                                        <span class="title">계약연장  선수 </span>

                                    </div>
                                    <div class="col-4 mb-3 mt-3 ">
                                        <select id="playersList3" name="fa_name">
                                            <% for (int i = 0; i < faList.size(); i++) {
                                                ApprovalVO faVO = faList.get(i);
                                                if (faVO != null && "키움".equals(faVO.getFa_team()) && "FA자유계약".equals(faVO.getFa_agent())){
                                            %>
                                            <option value="<%= faVO.getFa_name() %>"><%= faVO.getFa_name() %></option>
                                            <%
                                                    }
                                                }
                                            %>
                                        </select>
                                    </div>
                                    <div class="col-2 mb-3 mt-3 ">
                                        <span class="title">연봉 </span>
                                    </div>
                                    <div class="col-4 mb-3 mt-3 ">
                                        <input type="text" class="value-input short-input" id="salary" name="salary" placeholder="연봉 입력" value=""　>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-2 mb-3 mt-3 ">
                                        <span class="title">계약년수 </span>
                                    </div>
                                    <div class="col-4 mb-3 mt-3 ">
                                        <input type="text" class="value-input short-input" id="contract_term"  name="contract_term" placeholder="계약년수 입력" value="">
                                    </div>

                                    <div class="col-2 mb-3 mt-3 ">
                                    </div>
                                    <div class="col-4 mb-3 mt-3 ">
                                    </div>
                                </div>
                                <div class="row justify-content-center">
                                    <div class="col-auto mb-3 mt-3">
                                        <div class="text-wrapper-2">상기와 같이 계약연장 희망함</div>
                                    </div>
                                </div>
                                <input type="hidden" id="stateOffer" name="state"    value="대기" >
                                <input type="hidden" id="draftdayOffer" name="draftday"    value="" >
                                <input type="hidden" class="value-input" id="document_category2"  name="document_category" value="계약" >

                                <div class="row">
                                    <div class="col-7 mb-3 mt-3 ">
                                    </div>
                                    <div class="col-5 mb-3 mt-3 ">
                                        <div id ="documentButton1 " class="col-md-6 d-flex justify-content-end gap-2">
                                            <button type="button"  id="btn_docSubmit3" class="btn btn-danger" onclick="docSubmitOffer()" >제출</button>
                                            <button type="button" id="btn_search3" class="btn btn-danger" onclick="docSaveSubmitOffer()">임시보관 </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </form>

                            <form id="r_documentRelease" name="r_documentRelease" action="documentInsert" method="post">
                                <div class="frame" id="do_pla_b"> <%--방출 문서--%>
                                    <div class="document-section">


                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">사원번호 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="emp_no2"  name="emp_no" value="<%=sessionVO.getEmp_no()%>">
                                            </div>
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">문서제목 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="document_title2" name="document_title" value=""  >
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">결재자  </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="approval_name2" name="approval_name" value="운영팀장">
                                            </div>
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">신청자 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="name2" name="name" value="<%=sessionVO.getName()%>" >
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">방출 선수 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <select id="playersList2" name="fa_name">
                                                    <% for (int i = 0; i < faList.size(); i++) {
                                                        ApprovalVO faVO = faList.get(i);
                                                        if (faVO != null && "키움".equals(faVO.getFa_team()) && "FA자유계약".equals(faVO.getFa_agent())){
                                                    %>
                                                    <option value="<%= faVO.getFa_name() %>"><%= faVO.getFa_name() %></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="col-2 mb-3 mt-3 "></div>
                                            <div class="col-4 mb-3 mt-3 "> </div>
                                        </div>

                                        <div class="row justify-content-center">
                                            <div class="col-auto mb-3 mt-3">
                                            <div class="text-wrapper-2">상기와 같이 방출 희망함 </div>
                                            </div>
                                        </div>
                                        <input type="hidden" id="stateRelease" name="state"    value="대기" >
                                        <input type="hidden" id="draftdayRelease" name="draftday"    value="" >
                                        <input type="hidden" class="value-input" id="document_category5"  name="document_category" value="방출" >
                                    </div>

                                    <div class="row">
                                        <div class="col-7 mb-3 mt-3 ">
                                        </div>
                                        <div class="col-5 mb-3 mt-3 ">
                                            <div id ="documentButton2 " class="col-md-6 d-flex justify-content-end gap-2">
                                                <button type="button"  id="btn_docSubmit2" class="btn btn-danger" onclick="docSubmitRelease()" >제출</button>
                                                <button type="button" id="btn_search2" class="btn btn-danger" onclick="docSaveSubmitRelease()">임시보관 </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>



                            <%-- (r_document)Recruitment document : 영입문서                   --%>
                            <form id="r_documentScout" name="r_documentScout" action="documentInsert" method="post">
                                <div class="frame" id="do_pla_c"> <%--영입 문서--%>
                                    <div class="document-section">
                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">사원번호 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="emp_no1"  name="emp_no" value="<%=sessionVO.getEmp_no()%>">
                                            </div>
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">문서제목 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="document_title1" name="document_title" value=""  >
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">결재자  </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="approval_name1" name="approval_name" value="운영팀장">
                                            </div>
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">신청자 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <input type="text" class="value-input" id="name1" name="name" value="<%=sessionVO.getName()%>" >
                                            </div>
                                        </div>


                                        <div class="row">
                                            <div class="col-2 mb-3 mt-3 ">
                                                <span class="title">영입 선수 </span>
                                            </div>
                                            <div class="col-4 mb-3 mt-3 ">
                                                <select id="playersList1" name="fa_name">
                                                    <% for (int i = 0; i < faList.size(); i++) {
                                                        ApprovalVO faVO = faList.get(i);
                                                        if (faVO != null && faVO.getFa_agent() != null && !"키움".equals(faVO.getFa_team())) {
                                                    %>
                                                    <option value="<%= faVO.getFa_name() %>"><%= faVO.getFa_name() %></option>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </select>
                                            </div>
                                            <div class="col-2 mb-3 mt-3 "></div>
                                            <div class="col-4 mb-3 mt-3 "> </div>
                                        </div>

                                    <div class="row justify-content-center">
                                        <div class="col-auto mb-3 mt-3">
                                            <div class="text-wrapper-2">상기와 같이 영입 희망함 </div>
                                        </div>
                                    </div>
                                    </div>
                                    <input type="hidden" id="stateScout" name="state"    value="대기" >
                                    <input type="hidden" id="draftdayScout" name="draftday"    value="" >
                                    <input type="hidden" class="value-input" id="document_category1"  name="document_category" value="영입" >
                                    <div class="row">
                                        <div class="col-7 mb-3 mt-3 ">
                                        </div>
                                        <div class="col-5 mb-3 mt-3 ">
                                            <div id ="documentButton5 " class="col-md-6 d-flex justify-content-end gap-2">
                                                <button type="button"  id="btn_docSubmit1" class="btn btn-danger" onclick="docSubmitScout()" >제출</button>
                                                <button type="button" id="btn_search1" class="btn btn-danger" onclick="docSaveSubmitScout()">임시보관 </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
<%--                            data-bs-toggle="modal" data-bs-target="#boardForm" --%>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
</body>
</html>