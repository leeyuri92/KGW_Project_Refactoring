<%@ page language="java"	contentType="text/html;charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*"%>
<%@ page import="com.vo.EmpVO" %>
<%
    // 현재 날짜를 가져와서 형식을 지정하여 문자열로 변환
    Date date = new Date();
    SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
    String strDate = simpleDate.format(date);

    // 사원 정보를 받아옴
    List<EmpVO> empList = (List) request.getAttribute("empList");
    EmpVO rmap = empList.get(0); // 첫 번째 사원 정보를 사용 (증명서는 개별 사원 정보를 표시하기 때문에 첫 번째 사원 정보만 사용)

%>
<html>
<head>
    <title>Title</title>
    <%@include file="/common/bootstrap_common.jsp"%>
    <link rel="stylesheet" href="/css/certificate.css" />
</head>
<body>
<div class="container-md" >
    <div style="margin-top: 2%;" > <h3 style="text-align: center">재 직 증 명 서</h3></div>
    <table class="table-bordered" style="margin-top: 2%;" >
        <tbody>
        <tr>
            <td class="fs-5" colspan="3" style="background-color: lightgray">기업 정보</td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">기 업 명</td>

            <td colspan="2" style="text-align: left; padding-left: 20px;">KIWOOM HEROES</td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">주&nbsp;&nbsp;&nbsp;&nbsp;소 </td>
            <td colspan="2" style="text-align: left; padding-left: 20px;">서울 금천구 가산디지털2로 95</td>
        </tr>
        <tr>
            <td class="fs-5" colspan="3" style="background-color: lightgray">임직원 정보</td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">소     속</td>
            <td colspan="2" style="text-align: left; padding-left: 20px;"><%=rmap.getTeam_name()%></td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">직위/직책</td>
            <td colspan="2" style="text-align: left; padding-left: 20px;"><%=rmap.getEmp_position()%></td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">성   명</td>
            <td colspan="2" style="text-align: left; padding-left: 20px;"><%=rmap.getName()%></td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">입 사 일 </td>
            <td colspan="2" style="text-align: left; padding-left: 20px;"><%=rmap.getHire_date()%></td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">사   번</td>
            <td colspan="2" style="text-align: left; padding-left: 20px;"><%=rmap.getEmp_no()%></td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">전화번호</td>
            <td colspan="2" style="text-align: left; padding-left: 20px;"><%=rmap.getPhone_num()%></td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">주    소</td>
            <td colspan="2" style="text-align: left; padding-left: 20px;"><%=rmap.getAddress()%></td>
        </tr>
        <tr>
            <td class="fs-5" style="background-color: lightgray">용   도</td>
            <td colspan="2" style="text-align: left; padding-left: 20px;">제출용</td>
        </tr>
        <tr>
            <td colspan="3" style="height:200px">
                위와 같이 재직하고 있음을 증명합니다.
                <br>
                <br>
                <%=strDate%>
                <br>
                <input class="print-button" type="button" value="인쇄하기" id="print" onclick="window.print()"/>

            </td>

        </tr>
        </tbody>
    </table>
</div>
</body>
</html>
