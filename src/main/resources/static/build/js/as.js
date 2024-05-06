// 원본소스 코드
// let canvas = document.getElementById('signature-pad');
// let signaturePad = new SignaturePad(canvas);

 // 차이는 ? Canvans 란 signaturePad 는 modal 창 나오기 전까지  존재하지않는다 , 이러므로  show modal function 작동되야  api 가 정상적으로 사용이 가능함
$('#boardForm').on('shown.bs.modal', function (e) {
    let canvas = document.getElementById('signature-pad');
    let blobMiddle = dataURItoBlob(dataURL);
    let blobFinal = dataURItoBlob(dataURL);

    $.ajax({
        type: 'POST',
        url: '/fileSave',
        data: formData,
        processData: false, // FormData를 처리하지 않도록 설정
        contentType: false, // 컨텐츠 타입을 false로 설정하여 jQuery가 컨텐츠 타입을 설정하지 않도록 함
        success: function (response) {
            console.log('파일 전송 성공');
            $('.modal').modal('hide');
            document.querySelector("#signImage").src = "/fileUpload/sign/<%=empDetail.getEmp_no()%>.png";
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


    if (canvas) {
        let signaturePad = new SignaturePad(canvas, {
            minWidth: 1, //min
            maxWidth: 8, // max
            penColor: "rgb(66, 133, 244)"  // 컬러 변경가능
        });
    }

});







// button save  입력한 이미지  submit 필요
// document.getElementById('save').addEventListener('click', function () {
//     var dataURL = signaturePad.toDataURL();      // 후속 처리 부분
// });



