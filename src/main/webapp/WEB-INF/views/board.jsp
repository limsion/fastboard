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
        if(msg=="WRT_ERR") alert("게시물 등록이 실패하였습니다 다시 시도해주세요");
        if(msg=="MOD_ERR") alert("게시물 수정이 실패하였습니다 다시 시도해주세요");

    </script>
<div style="text-align:center">
    <h2>게시물 ${mode=="new" ? "글쓰기" : "읽기"}</h2>

    <form action="" id="form">
        <input type="hidden" name="bno" value="${boardDto.bno}">
        <input type="text" name="title" value="${boardDto.title}" ${ mode == "new" ? '' : "readonly='readonly'"}>
        <textarea name="content" id="" cols="30" rows="10" ${ mode == "new" ? '' : "readonly='readonly'"}> ${boardDto.content}</textarea>
        <button type="button" id="writeBtn" class="btn" ${mode == "new" ? "show" : "hidden" }>글쓰기</button>
        <button type="button" id="modifyBtn" class="btn" ${mode == "new" ? "hidden" : "show" }>수정</button>
        <button type="button" id="removeBtn" class="btn" ${mode == "new" ? "hidden" : "show" }>삭제</button>
        <button type="button" id="listBtn" class="btn">목록</button>
    </form>
</div>
<script>
<%--    목록 버튼 제이쿼리--%>
    $(document).ready(function () {
        $('#listBtn').on("click", function () {
            location.href = "<c:url value='/board/list'/>?page=${page}&pageSize=${pageSize}";
        })

    // 삭제 버튼

        $('#removeBtn').on("click", function () {
            if (! confirm("정말로 삭제하시겠습니까?")) return;
            let form = $('form');
            form.attr("action", "<c:url value='/board/remove'/>?page=${page}&pageSize=${pageSize}");
            form.attr("method", "post");
            form.submit();
        })

    // 쓰기버튼

        $('#writeBtn').on("click", function () {
            let form = $('#form');
            form.attr("action", "<c:url value='/board/write'/>");
            form.attr("method", "post");
            form.submit();
        })

    // 수정 버튼

        $('#modifyBtn').on("click", function () {
            // 1. 읽기 상태이면 수정 상태로 변경
            let form = $("#form");
            let isReadOnly = $("input[name=title]").attr('readonly');

            if (isReadOnly != null) {
                $("input[name=title]").attr('readonly', false);   // 제목
                $("textarea").attr('readonly', false);          // 내용
                $("#modifyBtn").html("등록");               //수정버튼 등록으로 변경
                $("#writeBtn").hide();                      // 글쓰기 버튼 숨김
                $("h2").html("게시물 수정");
                return;
            }

            // 2. 수정 상태이면 수정된 내용을 서버로 전송
            form.attr("action", "<c:url value='/board/modify'/>");
            form.attr("method", "post");

                  form.submit();
        })
    });
</script>
</body>
</html>