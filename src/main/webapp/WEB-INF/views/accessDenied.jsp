<%--
  Created by IntelliJ IDEA.
  User: yul
  Date: 2024-03-01
  Time: 오후 6:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>접근제한</title>
    <%@include file="/common/bootstrap_common.jsp" %>
    <link rel="stylesheet" href="/css/common.css">
<style>
    body, html {
        height: 100%;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #f8f9fa;
    }

    .container {
        text-align: center;
    }

    .title {
        color: #dc3545;
        font-size: 2.5rem;
        margin-bottom: 20px;
    }

    .link {
        margin-top: 20px;
    }

    .link a {
        color: #007bff;
        text-decoration: none;
        font-size: 1.2rem;
    }

    .link a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<div class="container">
    <div class="row">
        <h1 class="title">접근 권한이 없습니다.</h1>
    </div>
    <div class="links">
        <div class="link">
            <a href="/">메인페이지</a>
        </div>
    </div>
</div>
</body>
</html>
