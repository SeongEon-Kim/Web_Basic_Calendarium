<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

<head>
    <title>Document</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.85">
    <link rel="stylesheet" type="text/css" href="index.css">
</head>
<body>
    <div id="rapper">
        <form id="login" action="index_check.jsp" >
            <a href="index.jsp" id="Calendarium" >
                Calendarium
                <iconify-icon icon="mdi:palm-tree" style="color: #005247;" width="50" height="50"></iconify-icon>
            </a>
            <div>
                <input name="user_id" type="text" id="id_input_box" placeholder="아이디를 입력하세요">
            </div>
            <div>
                <input name="user_pw" type="password" id="pw_input_box" placeholder="비밀번호를 입력하세요">
            </div>
            <div>
                <!-- <button id="login_button" onclick="location.href='main.jsp';">로그인</button> -->
                <!-- <input type="submit" value="로그인" id="login_button" onclick="login()" > -->
                <!-- <input type="submit" value="로그인" id="login_button" onclick="login()" formaction="index_check.jsp">-->
                <input type="button" value="로그인" id="login_button" onclick="login()" >
                <!-- <button id="login_button" onclick="login()">로그인</button> -->
            </div>
            
            <div id="find_id_pw">
                <div class="notice_font">계정을 잊으셨나요? </div>
                <a href="find_id.jsp" id="find_id_link"> &nbsp; 아이디 찾기</a>
                <div class="notice_font">&nbsp; 또는</div>
                <a href="find_pw.jsp" id="find_pw_link"> &nbsp; 비밀번호 찾기</a>
            </div>
            <div id="sign">
                <div class="notice_font">아직 회원이 아닌가요?</div>
                <a href="signup.jsp" id="signup_link">&nbsp; 회원가입 ></a>
            </div>
        </form>
    </div>
    
</body>

<script src="https://code.iconify.design/iconify-icon/1.0.0-beta.3/iconify-icon.min.js"></script>
<script>
    function login(){
        var user_id = document.getElementById("id_input_box").value;
        var user_pw = document.getElementById("pw_input_box").value;

        console.log(user_id);
        console.log(user_pw);


        if (!user_id){
            alert('로그인 실패\n아이디를 입력해주세요.')
            // document.getElementById("id_input_box").focus(); //커서가 가도록 함
            return false; // 원상태로 되돌림
        }
        // 아이디 중복체크 해야함
        if (!user_pw){
            alert('로그인 실패\n비밀번호를 입력해주세요.')
            // document.getElementById("pw_input_box").focus(); //커서가 가도록 함
            return false; // 원상태로 되돌림
        }
        document.getElementById("login").submit();
    }

</script>