<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>fastcampus</title>
    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        .container {
            width : 50%;
            margin : auto;
        }
        .writing-header {
            position: relative;
            margin: 20px 0 0 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #323232;
        }
        input {
            width: 100%;
            height: 35px;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            padding: 8px;
            background: #f8f8f8;
            outline-color: #e6e6e6;
        }
        textarea {
            width: 100%;
            background: #f8f8f8;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            resize: none;
            padding: 8px;
            outline-color: #e6e6e6;
        }
        .frm {
            width:100%;
        }
        .btn {
            background-color: rgb(236, 236, 236); /* Blue background */
            border: none; /* Remove borders */
            color: black; /* White text */
            padding: 6px 12px; /* Some padding */
            font-size: 16px; /* Set a font size */
            cursor: pointer; /* Mouse pointer on hover */
            border-radius: 5px;
        }
        .btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div id="menu">
    <ul>
        <li id="logo">fastcampus</li>
        <li><a href="<c:url value='/'/>">Home</a></li>
        <li><a href="<c:url value='/board/list'/>">Board</a></li>
        <li><a href="<c:url value='/login/login'/>">login</a></li>
        <li><a href="<c:url value='/register/add'/>">Sign in</a></li>
        <li><a href=""><i class="fas fa-search small"></i></a></li>
    </ul>
</div>
    <script>
        let msg="${msg}";
        if(msg=="WRT_ERR") alert("????????? ????????? ????????????????????? ?????? ??????????????????");
        if(msg=="MOD_ERR") alert("????????? ????????? ????????????????????? ?????? ??????????????????");

    </script>
<div style="text-align:center">
    <h2>????????? ${mode=="new" ? "?????????" : "??????"}</h2>

    <form action="" id="form">
        <input type="hidden" name="bno" value="${boardDto.bno}">
        <input type="text" name="title" value="${boardDto.title}" ${ mode == "new" ? '' : "readonly='readonly'"}>
        <textarea name="content" id="" cols="30" rows="10" ${ mode == "new" ? '' : "readonly='readonly'"}> ${boardDto.content}</textarea>
        <button type="button" id="writeBtn" class="btn" ${mode == "new" ? "show" : "hidden" }>?????????</button>
        <button type="button" id="modifyBtn" class="btn" ${mode == "new" ? "hidden" : "show" }>??????</button>
        <button type="button" id="removeBtn" class="btn" ${mode == "new" ? "hidden" : "show" }>??????</button>
        <button type="button" id="listBtn" class="btn">??????</button>
    </form>
</div>
<script>
<%--    ?????? ?????? ????????????--%>
    $(document).ready(function () {
        $('#listBtn').on("click", function () {
            location.href = "<c:url value='/board/list'/>?page=${page}&pageSize=${pageSize}";
        })

    // ?????? ??????

        $('#removeBtn').on("click", function () {
            if (! confirm("????????? ?????????????????????????")) return;
            let form = $('form');
            form.attr("action", "<c:url value='/board/remove'/>?page=${page}&pageSize=${pageSize}");
            form.attr("method", "post");
            form.submit();
        })

    // ????????????

        $('#writeBtn').on("click", function () {
            let form = $('#form');
            form.attr("action", "<c:url value='/board/write'/>");
            form.attr("method", "post");
            form.submit();
        })

    // ?????? ??????

        $('#modifyBtn').on("click", function () {
            // 1. ?????? ???????????? ?????? ????????? ??????
            let form = $("#form");
            let isReadOnly = $("input[name=title]").attr('readonly');

            if (isReadOnly != null) {
                $("input[name=title]").attr('readonly', false);   // ??????
                $("textarea").attr('readonly', false);          // ??????
                $("#modifyBtn").html("??????");               //???????????? ???????????? ??????
                $("#writeBtn").hide();                      // ????????? ?????? ??????
                $("h2").html("????????? ??????");
                return;
            }

            // 2. ?????? ???????????? ????????? ????????? ????????? ??????
            form.attr("action", "<c:url value='/board/modify'/>");
            form.attr("method", "post");

                  form.submit();
        })
    });
</script>
</body>
</html>