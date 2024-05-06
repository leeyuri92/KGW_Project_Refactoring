<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.vo.ApprovalVO" %>
<%
  List<ApprovalVO> list = (List<ApprovalVO>)request.getAttribute("approvalDetail");
  ApprovalVO approvalVO = list.get(0);
//    out.print(approvalVO.getApproval_category());

%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>결재 문서{계약}</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
    <link  rel="stylesheet " href="../css/approval.css">

  <script>
    const approvalExSubmit = () =>{
        document.querySelector('#approvalForm').submit();
    }

    const approvalExReject = () =>{
        let  rejection_content = prompt("반려 사유를 입력하세요:", "여기에 사유를 입력");
        $('#rejection_content').val(rejection_content);
        $('#approval_reject').submit();
    }
  </script>
</head>
<body>
<div class="wrapper">
    <%@include file="/include/KGW_bar.jsp"%>
    <div class="content-wrapper">
        <div class="box-header p-4" >
            <div class="d-flex align-items-center">
                <div class="d-flex align-items-center me-2">
                    <a class="text-muted fs-6" href="#">전자결재</a>
                    <div class="ms-2">></div>
                </div>
                <div class="d-flex align-items-center">
                    <div class="text-dark fs-6">결재함</div>
                </div>

            </div>
            <div class="d-flex align-items-center mt-2">
                <div class="position-relative">
                    <div class="position-absolute top-0 start-0" ></div>
                </div>
                <div class="d-flex align-items-center ms-2">
                    <div class="fw-bold fs-5">결재문서 </div>
                    <div class="text-muted ms-3">문서 을 결재할수 있는 페이지입니다.</div>
                </div>
            </div>
        </div>
        <section class="content">
            <div class="row">
                <div class="col-md-12">
                    <div class="box">
                        <div class="container">
                            <div class="box-header">
                                <h4 style="font-weight: bold; margin-left: 1.5rem">결재문서</h4>
                                <hr />
                            </div>
                            <!-- Document Sections -->
                                <div class="frame" id="frame_tool">
                                  <form id="approvalForm" name="approvalForm" method="POST" action="approvalUpdate">
                                    <div class="document-section">
                                        <div class="item">
                                            <span class="title">부서:</span>
                                            <input type="text"  value="<%=approvalVO.getTeam_name()%>" disabled>
                                        </div>
                                        <div class="item">
                                            <span class="title">신청자:</span>
                                          <input type="text"  value="<%=approvalVO.getName()%>" disabled>
                                        </div>

                                        <div class="item">
                                            <span class="title">계약연장 선수:</span>
                                          <input type="text"  value="<%=approvalVO.getFa_name()%>" disabled/>
                                        </div>
                                        <div class="item">
                                            <span class="title">계약기간:</span>

                                          <input type="text" value="<%=approvalVO.getContract_term()%>" disabled>
                                        </div>
                                        <div class="item">
                                            <span class="title">계약연봉:</span>
                                          <input type="text"   value="<%=approvalVO.getSalary()%>" disabled>

                                        </div>
                                            <hr>
                                        <div class="text-wrapper-2">상기와 같이 선수 연장계약  희망함</div>
                                    </div>
                                    <input type="hidden" id="fa_name" name="fa_name" value="<%=approvalVO.getFa_name()%>">
                                    <input type="hidden" id="salary" name="salary" value="<%=approvalVO.getSalary()%>">
                                    <input type="hidden" id="contract_term" name="contract_term" value="<%=approvalVO.getContract_term()%>">
                                    <input type="hidden" id="approval_no" name="approval_no" value="<%=approvalVO.getApproval_no()%>">
                                    <input type="hidden" id="action" name="action" value="승인">
                                    <input type="hidden" id="document_no" name="document_no" value="<%=approvalVO.getDocument_no()%>">
                                    <input type="hidden" id="document_category" name="document_category" value="<%=approvalVO.getDocument_category()%>">

                                    <%
                                      if (approvalVO.getApproval_category().equals("중간결재대기")){
                                    %>
                                    <input type="hidden" id="middlesign_name" name="middlesign_name" value="<%=approvalVO.getApproval_no()%>_middleSign.png">
                                    <input type="hidden" id="approval_category" name="approval_category" value="<%=approvalVO.getApproval_category()%>">
                                    <%
                                    }else if (approvalVO.getApproval_category().equals("최종결재대기")){
                                    %>
                                    <input type="hidden" id="finalsign_name" name="finalsign_name" value="<%=approvalVO.getApproval_no()%>_finalSign.png">
                                    <input type="hidden" id="approval_category" name="approval_category" value="최종결재승인">
                                    <%
                                      }
                                    %>
                                  </form>
                                  <form id="approval_reject" method="post" action="approvalUpdate">
                                    <input type="hidden" id="approvalno" name="approval_no" value="<%=approvalVO.getApproval_no()%>">
                                    <input type="hidden" id="action2" name="action" value="반려">
                                    <input type="hidden" id="rejection_content" name="rejection_content" value="">
                                    <input type="hidden" id="approvalcategory2" name="approval_category" value="<%=approvalVO.getApproval_category()%>">
                                    <input type="hidden" id="documentno" name="document_no" value="<%=approvalVO.getDocument_no()%>">
                                  </form>

                                  <div class="signature-section">
                                    <div class="signImg" style="border: 2px solid grey; width: 100px; height: 100px">
                                      <img id="" src="/fileUpload/sign/<%=approvalVO.getEmp_no()%>.png" style="width: 98px; height: 98px;" class="sign">
                                    </div>
                                    <div class="signImg" style="border: 2px solid grey; width: 100px; height: 100px">
                                      <%
                                        String realFolder2 = "";
                                        String realFolder3 = "";
                                        String filePath2 = "/fileUpload/approvalSign/"+approvalVO.getApproval_no()+"_middleSign.png"; // 파일 경로 설정
                                        String filePath3 = "/fileUpload/approvalSign/"+approvalVO.getApproval_no()+"_finalSign.png"; // 파일 경로 설정
                                        ServletContext context2 = request.getServletContext();
                                        ServletContext context3 = request.getServletContext();
                                        realFolder2 = context2.getRealPath(filePath2);
                                        realFolder3 = context3.getRealPath(filePath3);
                                        File file2 = new File(realFolder2);
                                        File file3 = new File(realFolder3);
                                        if (!(file2.exists())) { // 파일이 존재하는지 확인
                                          filePath2 = "/fileUpload/approvalSign/leader.png";
                                        }
                                        if (!(file3.exists())) { // 파일이 존재하는지 확인
                                          filePath3 = "/fileUpload/approvalSign/master.png";
                                        }
                                      %>
                                      <img id="middleSignImage" src="<%=filePath2%>" style="width: 100px; height: 100px;" class="sign" alt="팀장" data-bs-toggle="modal" data-bs-target="#middleSignSelect">
                                    </div>
                                    <div class="signImg" style="border: 2px solid grey; width: 100px; height: 100px">
                                      <img id="finalSignImage" src="<%=filePath3%>" style="width: 100px; height: 100px; " class="sign" alt="구단장" data-bs-toggle="modal" data-bs-target="#finalSignSelect">
                                    </div>
                                  </div>
                                </div>
                            </div>
                            <div id="documentButton" class="col-md-6 d-flex justify-content-end gap-2">
                              <button type="button" class="btn btn-danger" onclick="approvalExSubmit()">승인</button>
                              <button type="button" id="rejectButton" class="btn btn-danger"  onclick="approvalExReject()">반려</button>
                            </div>

                    </div>
                    </div>
                </div>
        </section>
            </div>
</div>

<%
  if (approvalVO.getApproval_category().equals("중간결재대기")){
%>
<div class="modal" id="middleSignSelect">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content rounded-4 shadow">
      <div class="modal-header p-5 pb-0 border-bottom-0" style="margin-bottom: -20px;">
        <h1 class="fw-bold  fs-2" >전자서명변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-5 pt-0">
        <form id="middleSignInsert" method="post" action="/approvalSignSave" enctype="multipart/form-data">
          <canvas id="middleSign-pad" width=400 height=200 style="margin-bottom: 20px; border: 2px solid black"></canvas>
          <input type="hidden" id="emp_no1" name="emp_no" value="">
          <div>
            <button type="button" id="middleSignClear" class="btn btn-danger">초기화</button>
            <button type="button" id="middleSignSave" class="btn btn-danger">저장</button>
            <button type="button" class="btn btn-danger button save" data-action="middleSignSave-png">내 pc에 저장</button>
          </div>
          <script>
              let canvas = document.getElementById('middleSign-pad');
              let signaturePad = new SignaturePad(canvas);
              //button clear
              document.getElementById('middleSignClear').addEventListener('click', function () {
                  signaturePad.clear();
              });
              // button action save-png  Event부여
              document.querySelector('[data-action="middleSignSave-png"]').addEventListener('click', function () {
                  let dataURL = signaturePad.toDataURL();
                  let downloadLink = document.createElement('a');
                  downloadLink.href = dataURL;
                  downloadLink.download = 'middleSignImage.png';
                  //다운로드 처리
                  document.body.appendChild(downloadLink);
                  downloadLink.click();
                  document.body.removeChild(downloadLink);
              });
              // button save
              document.getElementById('middleSignSave').addEventListener('click', function () {
                  let canvas = document.getElementById('middleSign-pad');
                  let dataURL = canvas.toDataURL('image/png'); // 캔버스 내용을 데이터 URL로 가져옴
                  // 데이터 URL을 Blob 객체로 변환
                  let blob = dataURItoBlob(dataURL);
                  // FormData 객체 생성
                  let formData = new FormData();
                  formData.append('image', blob, '<%=approvalVO.getApproval_no()%>_middleSign.png');
                  $.ajax({
                      type: 'POST',
                      url: '/approvalSignSave',
                      data: formData,
                      processData: false, // FormData를 처리하지 않도록 설정
                      contentType: false, // 컨텐츠 타입을 false로 설정하여 jQuery가 컨텐츠 타입을 설정하지 않도록 함
                      success: function (response) {
                          console.log('파일 전송 성공');
                          $('.modal').modal('hide');
                          document.querySelector("#middleSignImage").src = "/fileUpload/approvalSign/<%=approvalVO.getApproval_no()%>_middleSign.png";
                          signaturePad.clear();
                      },
                      error: function (xhr, status, error) {
                          console.error('파일 전송 실패:', error);
                          // 실패한 경우 처리할 내용 추가
                      }
                  });
                  // 데이터 URL을 Blob 객체로 변환하는 함수
                  function dataURItoBlob(dataURI) {
                      // Base64 데이터 부분 분리
                      let byteString = atob(dataURI.split(',')[1]);
                      let mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
                      // Blob 객체 생성
                      let arrayBuffer = new ArrayBuffer(byteString.length);
                      let intArray = new Uint8Array(arrayBuffer);
                      for (let i = 0; i < byteString.length; i++) {
                          intArray[i] = byteString.charCodeAt(i);
                      }
                      return new Blob([arrayBuffer], {type: mimeString});
                  }
              })
          </script>
        </form>
      </div>
    </div>
  </div>
</div>
<%
}else{
%>
<div class="modal" id="finalSignSelect">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content rounded-4 shadow">
      <div class="modal-header p-5 pb-0 border-bottom-0" style="margin-bottom: -20px;">
        <h1 class="fw-bold  fs-2" >전자서명변경</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-5 pt-0">
        <form id="finalSignInsert" method="post" action="/approvalSignSave" enctype="multipart/form-data">
          <canvas id="finalSign-pad" width=400 height=200 style="margin-bottom: 20px; border: 2px solid black"></canvas>
          <input type="hidden" id="emp_no" name="emp_no" value="">
          <div>
            <button type="button" id="finalSignClear" class="btn btn-danger">초기화</button>
            <button type="button" id="finalSignSave" class="btn btn-danger">저장</button>
            <button type="button" class="btn btn-danger button save" data-action="save-png">내 pc에 저장</button>
          </div>
          <script>
              let canvas = document.getElementById('finalSign-pad');
              let signaturePad = new SignaturePad(canvas);
              //button clear
              document.getElementById('finalSignClear').addEventListener('click', function () {
                  signaturePad.clear();
              });
              // button action save-png  Event부여
              document.querySelector('[data-action="save-png"]').addEventListener('click', function () {
                  let dataURL = signaturePad.toDataURL();
                  let downloadLink = document.createElement('a');
                  downloadLink.href = dataURL;
                  downloadLink.download = 'middleSignImage.png';
                  //다운로드 처리
                  document.body.appendChild(downloadLink);
                  downloadLink.click();
                  document.body.removeChild(downloadLink);
              });
              // button save
              document.getElementById('finalSignSave').addEventListener('click', function () {
                  let canvas = document.getElementById('finalSign-pad');
                  let dataURL = canvas.toDataURL('image/png'); // 캔버스 내용을 데이터 URL로 가져옴
                  // 데이터 URL을 Blob 객체로 변환
                  let blob = dataURItoBlob(dataURL);
                  // FormData 객체 생성
                  let formData = new FormData();
                  formData.append('image', blob, '<%=approvalVO.getApproval_no()%>_finalSign.png');
                  $.ajax({
                      type: 'POST',
                      url: '/approvalSignSave',
                      data: formData,
                      processData: false, // FormData를 처리하지 않도록 설정
                      contentType: false, // 컨텐츠 타입을 false로 설정하여 jQuery가 컨텐츠 타입을 설정하지 않도록 함
                      success: function (response) {
                          console.log('파일 전송 성공');
                          $('.modal').modal('hide');
                          document.querySelector("#finalSignImage").src = "/fileUpload/approvalSign/<%=approvalVO.getApproval_no()%>_finalSign.png";
                          signaturePad.clear();
                      },
                      error: function (xhr, status, error) {
                          console.error('파일 전송 실패:', error);
                          // 실패한 경우 처리할 내용 추가
                      }
                  });
                  // 데이터 URL을 Blob 객체로 변환하는 함수
                  function dataURItoBlob(dataURI) {
                      // Base64 데이터 부분 분리
                      let byteString = atob(dataURI.split(',')[1]);
                      let mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0];
                      // Blob 객체 생성
                      let arrayBuffer = new ArrayBuffer(byteString.length);
                      let intArray = new Uint8Array(arrayBuffer);
                      for (let i = 0; i < byteString.length; i++) {
                          intArray[i] = byteString.charCodeAt(i);
                      }
                      return new Blob([arrayBuffer], {type: mimeString});
                  }
              })
          </script>
        </form>
      </div>
    </div>
  </div>
</div>
<%
  }
%>
</body>
</html>
