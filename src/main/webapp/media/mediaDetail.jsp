<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vo.MediaNoticeVO" %>
<%@ page import="com.vo.MediaNoticeCommendVO" %>
<%@ page import="com.best.kgw.common.TimeUtil" %>

<%
    /*상세조회 */
    List<MediaNoticeVO> mediaNoticeList = (List)request.getAttribute("mediaNoticeDetail");
    MediaNoticeVO mediaVO = mediaNoticeList.get(0);

    List<MediaNoticeCommendVO> mediaNoticeCommend = (List)request.getAttribute("commendList");
    int commendSize = mediaNoticeCommend.size();

%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>우리구단소식 상세조회</title>
    <script>

        /*미디에게시글목록*/
        function mediaNoticeList(){
            location.href='/media/mediaNotice';
        }
        /*미디어게시글삭제*/
        const  mediaNoticeDelete =()=> {
            Swal.fire({
                title: '게시글 삭제',
                text: '게시글을 삭제하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '삭제',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 확인을 눌렀을 때의 동작
                    location.href = "/media/mediaDelete?board_no="+<%=mediaVO.getBoard_no()%>;
                } else {
                    // 취소를 눌렀을 때의 동작
                    console.log("삭제 취소");
                }
            });
        }
        /*댓글입력*/
        const commendInsert =()=> {
            console.log("댓글확인용")
            document.querySelector("#commentForm").submit();
        }
        /*댓글삭제*/
        const mediaCommendDelete =(commend_no)=> {
            Swal.fire({
                title: '댓글 삭제',
                text: '댓글을 삭제하시겠습니까?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: '삭제',
                cancelButtonText: '취소'
            }).then((result) => {
                if (result.isConfirmed) {
                    // 확인을 눌렀을 때의 동작
                    location.href = "/media/CommendDelete?commend_no="+commend_no+"&board_no="+<%=mediaVO.getBoard_no()%>
                } else {
                    // 취소를 눌렀을 때의 동작
                    console.log("삭제 취소");
                }
            });
        }
    </script>
</head>

<body class="hold-transition sidebar-mini sidebar-collapse">
<div class="wrapper">
    <!-- header start -->
    <%@include file="/include/KGW_bar.jsp"%>
    <link rel="stylesheet" href="/css/mediaNotice.css">
    <!-- header end -->
    <!-- body start -->
    <div class="content-wrapper">
        <!-- 페이지 path start -->
        <div class="box-header p-4">
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">우리구단</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">우리구단 소식</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0"></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">우리구단 소식 상세조회</div>
                    <div class="text-muted ms-3">우리구단 소식을 상세하게 조회할 수 있는 페이지입니다.</div>
                </div>
            </div>
        </div>
        <!-- 페이지 path end -->
        <section class="content">
            <!-- Info boxes -->
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="container">
                            <div class="box-header">
                                <h4 style="font-weight: bold; margin-left: 2rem" ><%=mediaVO.getBoard_title()%></h4>
                                <hr />
                                <%--상세조회--%>
                                <div class="board_view">
                                    <div class="info">
                                        <dl>
                                            <dt>번호</dt>
                                            <dd><%=mediaVO.getBoard_no()%>
                                        </dl>
                                        <dl>
                                            <dt>작성자</dt>
                                            <dd><%=mediaVO.getName()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>작성일</dt>
                                            <dd><%=mediaVO.getReg_date()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>수정일</dt>
                                            <dd><%=mediaVO.getMod_date()%></dd>
                                        </dl>
                                        <dl>
                                            <dt>조회</dt>
                                            <dd><%=mediaVO.getBoard_hit()%></dd>
                                        </dl>
                                    </div>
                                    <div class="cont">
                                        <img src=""/>
                                        <%=mediaVO.getBoard_content()%>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 justify-content-end mt-2">
                                    <button type="submit" class="btn btn-primary" onclick="mediaNoticeList()">목록</button>
                                    <% if (sessionVO.getEmp_no() == mediaVO.getEmp_no() || sessionVO.getEmp_access().equals("ROLE_ADMIN")) { %>
                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#mediaMod">수정</button>
                                    <button type="submit" class="btn btn-primary" onclick="mediaNoticeDelete()">삭제</button>
                                    <%}%>
                                </div>

                                <%--댓글목록--%>
                                <div class="comment-list">
                                    <div class="comment-list">
                                        <label for="commendContent" class="form-label">댓글 (<%=mediaVO.getCommend_cnt()%>)
                                            <%  if(commendSize > 0){
                                                long days = TimeUtil.newBadge(mediaNoticeCommend.get(0).getReg_date());
                                                    if (days < 2) { %>
                                            <span class="badge badge-small text-bg-danger">New</span>
                                                <% }
                                                }%></label>
                                        <%
                                            if (commendSize > 0){
                                                for(int i = 0; i < commendSize; i++){
                                                    MediaNoticeCommendVO commendVO =mediaNoticeCommend.get(i);
                                        %>
                                        <div class="comment">
                                            <input type="hidden" class="board_no" value="<%=mediaVO.getBoard_no()%>">
                                            <img src="/fileUpload/profile/<%=commendVO.getEmp_no()%>.png" class="user-avatar" alt="user-avatar">
                                            <div class="comment-content">
                                                <p class="user-name"><%=commendVO.getName()%></p>
                                                <p class="comment-text"><%=commendVO.getCommend_content()%></p>
                                                <div class="row">
                                                    <div class="col-9">
                                                        <p class="comment-date"><%=commendVO.getReg_date()%></p>
                                                    </div>
                                                    <% if (sessionVO.getEmp_no() == commendVO.getEmp_no() || sessionVO.getEmp_access().equals("ROLE_ADMIN")) { %>
                                                    <div class="col-3 justify-content-end">
                                                        <button type="button" class="btn btn-primary btn-small" onclick="mediaCommendDelete('<%=commendVO.getCommend_no()%>')">삭제</button>
                                                    </div>
                                                    <%
                                                        }
                                                    %>
                                                </div>
                                            </div>
                                        </div>
                                        <%
                                                }
                                            }
                                        %>
                                        <%--댓글작성--%>
                                        <form id="commentForm" method="post" action="/media/CommendInsert">
                                            <div class="mb-3">
                                                <input type="hidden" class="form-control mb-3" name="board_no" value="<%=mediaVO.getBoard_no()%>">
                                                <input type="hidden" class="form-control mb-3" name="emp_no" value="<%=sessionVO.getEmp_no()%>" >
                                                <textarea class="form-control" id="commendContent" rows="2" name="commend_content" placeholder='댓글을 입력해주세요.' required></textarea>
                                            </div>
                                            <div class="d-flex justify-content-end">
                                                <button type="button" class="btn btn-primary" onclick="commendInsert()">댓글 작성</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>

<%--수정 모달창--%>
<div class="modal" id="mediaMod">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content rounded-4 shadow">
            <div class="modal-header p-5 pb-4 border-bottom-0">
                <h4 style="font-weight: bold; margin-left: 2rem" >게시글 수정</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                <hr />
            </div>
            <div class="modal-body p-5 pt-0">
                <%@include file="/common/summernote.jsp"%>
                <form id="Modify" method="post" action="/media/mediaModify" enctype="multipart/form-data">
                    <div>
                        <input type="hidden" class="form-control mb-3" id="board_no" name="board_no" value="<%=mediaVO.getBoard_no()%>">
                        <input type="hidden" class="form-control mb-3" id="mod_date" name="mod_date" value="<%=mediaVO.getMod_date()%>">
                    </div>
                    <div>
                        <input type="text" class="form-control mb-3" id="board_title" name="board_title" placeholder="제목을 입력해주세요." value="<%=mediaVO.getBoard_title()%>">
                    </div>
                    <textarea id="summernote" name="board_content"><%=mediaVO.getBoard_content()%></textarea>
                    <input type="hidden" id="filename" name="filename" value="<%=mediaVO.getFilename()%>">
                    <div class="d-flex justify-content-end mt-3">
                        <button type="button" class="btn btn-primary" onclick="mediaNoticeModify()">수정</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    $('#summernote').summernote({
        placeholder: '글 내용을 입력해주세요.',
        tabsize: 2,
        height: 500,
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'underline', 'clear']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'video']],
            ['view', ['fullscreen', 'codeview', 'help']]
        ]
    });

    const mediaNoticeModify =()=> {
        console.log("수정버튼클릭")
        document.querySelector("#Modify").submit();
    }
</script>
</body>
</html>