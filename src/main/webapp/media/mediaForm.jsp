<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>게시글 작성</title>
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
                    <a class="text-muted fs-6" href="#">우리구단</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">우리구단 소식</div>
                </div>
            </div>
            <div class="d-flex align-items-center mt-3">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0" ></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">게시글 작성</div>
                    <div class="text-muted ms-3">우리구단 소식을 작성할 수 있는 페이지입니다.</div>
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
                                <h4 style="font-weight: bold; margin-left: 2rem" >게시글 작성</h4>
                                <hr />
                                <div class="container">
                                    <%@include file="/common/summernote.jsp"%>
                                    <form id="insert" method="post" action="/media/mediaInsert" enctype="multipart/form-data">
                                        <input type="hidden" name="emp_no" id="emp_no" value="<%=sessionVO.getEmp_no()%>">
                                        <div>
                                            <input type="text" name="board_title" class="form-control mb-3"  placeholder="제목을 입력해주세요." id="subject">
                                        </div>
                                        <textarea id="summernote" name="board_content"></textarea>
                                        <div class="d-flex gap-2 justify-content-end mt-3">
                                            <button type="button" class="btn btn-primary" onclick="mediaNoticeInsert()">작성</button>
                                            <button type="button" class="btn btn-primary" onclick="mediaNoticeList()">이전</button>
                                        </div>
                                    </form>
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

                                    function mediaNoticeList(){
                                        Swal.fire({
                                            title: '페이지 나가기',
                                            text: '지금까지 작성한 내용이 사라집니다. 이 페이지를 나가시겠습니까?',
                                            icon: 'warning',
                                            showCancelButton: true,
                                            confirmButtonText: '나가기',
                                            cancelButtonText: '취소',
                                            customClass: {
                                                confirmButton: 'swal2-styled swal2-confirm'
                                            }
                                        }).then((result) => {
                                            if (result.isConfirmed) {
                                                // 확인을 눌렀을 때의 동작
                                                location.href="/media/mediaNotice";
                                            } else {
                                                // 취소를 눌렀을 때의 동작
                                                console.log("나가기 취소");
                                            }
                                        });
                                    }

                                    const mediaNoticeInsert =()=> {
                                        console.log("작성")

                                        const id_subject = document.querySelector('#subject');
                                        const markupStr = $('#summernote').summernote('code');

                                        if (id_subject.value == '') {
                                            Swal.fire({
                                                title: '알림',
                                                text: '제목을 입력하세요.',
                                                icon: 'warning',
                                                confirmButtonText: '확인',
                                                customClass: {
                                                    confirmButton: 'swal2-styled swal2-confirm'
                                                },
                                                didOpen: () => {
                                                    // 알림창이 열린 후에 실행될 함수
                                                    id_subject.focus();
                                                },
                                                didClose: () => {
                                                    // 알림창이 닫힌 후에 실행될 함수
                                                    // 마우스 커서를 특정 입력 필드로 이동
                                                    id_subject.focus();
                                                }
                                            });
                                        } else if (markupStr === '<p><br></p>') {
                                            Swal.fire({
                                                title: '알림',
                                                text: '내용을 입력하세요.',
                                                icon: 'warning',
                                                confirmButtonText: '확인',
                                                customClass: {
                                                    confirmButton: 'swal2-styled swal2-confirm'
                                                },
                                                didOpen: () => {
                                                    // 알림창이 열린 후에 실행될 함수
                                                    $('#summernote').summernote('focus');
                                                },
                                                didClose: () => {
                                                    // 알림창이 닫힌 후에 실행될 함수
                                                    // 마우스 커서를 특정 입력 필드로 이동
                                                    $('#summernote').summernote('focus');
                                                }
                                            });
                                        } else {
                                            // 성공 시 알림창 띄우기
                                            Swal.fire({
                                                title: '알림',
                                                text: '작성이 성공적으로 완료되었습니다.',
                                                icon: 'success',
                                                confirmButtonText: '확인',
                                                customClass: {
                                                    confirmButton: 'swal2-styled swal2-confirm'
                                                }
                                            }).then(() => {
                                                // 알림창이 닫힌 후에 실행될 함수
                                                document.querySelector('#insert').submit();
                                            });
                                        }
                                    };
                                </script>
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
