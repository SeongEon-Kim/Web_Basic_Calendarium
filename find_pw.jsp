<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

<head>
    <title>Document</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.85">
    <link rel="stylesheet" type="text/css" href="find_pw.css">
</head>
<body>
    <div id="rapper">
        <form id="login" action="find_pw_check.jsp">
   
            <a href="index.jsp"id="Calendarium">
                Calendarium
                <iconify-icon icon="mdi:palm-tree" style="color: #005247;" width="50" height="50"></iconify-icon>
            </a>
    
            <div id="find_pw"> 비밀번호 찾기 </div>
    
            <div class="notice_font">비밀번호를 잃어버리셨나요?
                <br>
                하단의 정보를 상세히 입력하세요.</div>
            
            <div><input name="user_id" type="text" id="id_input_box" placeholder="아이디를 입력하세요"></div>
    
            <div><input name="user_name" type="text" id="name_input_box" placeholder="이름를 입력하세요"></div>
            
            <div><input name="user_phone" type="text" id="phone_input_box" placeholder="휴대폰 번호를 입력하세요(-제외)"></div>
            <div><input type="submit" value="비밀번호 찾기" id="login_button"></div>
        
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