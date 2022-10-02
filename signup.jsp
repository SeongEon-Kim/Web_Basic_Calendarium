<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

<head>
    <title>Document</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.85">
    <link rel="stylesheet" type="text/css" href="signup.css">
</head>
<body>
    <div id="rapper" >
        <form id="login" action="signup_check.jsp">
            <a href="index.jsp"id="Calendarium">
                Calendarium
                <iconify-icon icon="mdi:palm-tree" style="color: #005247;" width="50" height="50"></iconify-icon>
            </a>
    
            <div id="find_pw"> 회원가입 </div>
    
            <div class="notice_font">회원가입을 통해 Calendarium에 가입하세요.
                <br>
                하단의 정보를 상세히 입력하세요.</div>

            <div id="id_input">
                <input name="user_id" type="text" id="id_input_box" placeholder="아이디를 입력하세요">
                <!-- <button type="button" id="duplicate_btn" onclick="signup_duplicate1()">&#9745;</button> -->
                <input type="submit" value="&#9745;" id="duplicate_btn" onclick="signup_duplicate3()" formaction="signup_duplicate.jsp">
            </div>

            <div><input name="user_pw" type="password" id="pw_input_box" placeholder="비밀번호를 입력하세요"></div>
            <div><input type="password" id="pw_check_input_box" placeholder="비밀번호를 한번 더입력하세요"></div>
            <div><input name="user_name" type="text" id="name_input_box" placeholder="이름를 입력하세요"></div>
            <select name="user_department" id="department_select_box">
                <option value="총괄">총괄</option>
                <option value="개발 부서">개발 부서</option>
                <option value="교육 부서">교육 부서</option>
                <option value="마케팅 부서">마케팅 부서</option>
            </select>
            
            <select name="user_rank" id="rank_select_box">
                <option value="관리자">관리자</option>
                <option value="팀장">팀장</option>
                <option value="팀원">팀원</option>
            </select>
            
            <div><input name="user_email" type="text" id="email_input_box" placeholder="이메일을 입력하세요"></div>
            <div><input name="user_phone" type="text" id="phone_input_box" placeholder="휴대폰 번호를 입력하세요(-제외)"></div>
            <div>
                <!-- <input type="submit" value="회원가입" id="login_button" onclick="signup()" formaction="signup_check.jsp"> -->
                <button id="login_button" onclick="signup()">회원가입</button>
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

    var bDisplay = true; 
    function signup_duplicate1(){
        document.getElementById("login").submit();
        window.open("signup_duplicate.jsp")

        var con = document.getElementById("login_button"); 	
        if(con.style.display=='none'){ 		
            con.style.display = 'block'; 	
        }else{ 		
            con.style.display = 'none'; 	
        } 
    } 
    function signup_duplicate2(){

        var con = document.getElementById("login_button"); 	
        if(con.style.display=='none'){ 		
            con.style.display = 'block'; 	
        }else{ 		
            con.style.display = 'none'; 	
        } 
    } 

    function signup(){
        var user_id = document.getElementById("id_input_box").value;
        var user_pw = document.getElementById("pw_input_box").value;
        var user_pw_check = document.getElementById("pw_check_input_box").value;
        var user_name = document.getElementById("name_input_box").value;
        var user_department = document.getElementById("department_select_box").value;
        var user_rank = document.getElementById("rank_select_box").value;
        var user_email = document.getElementById("email_input_box").value;
        var user_phone = document.getElementById("phone_input_box").value;

        console.log(user_id);
        console.log(user_pw);
        console.log(user_name);
        console.log(user_department);
        console.log(user_rank);
        console.log(user_email);
        console.log(user_phone);

        if (!user_id){
            alert('회원가입 실패\n아이디를 입력해주세요.')
            document.getElementById("id_input_box").focus(); //커서가 가도록 함
            return ; // 원상태로 되돌림
        }
        // 아이디 중복체크 해야함
        if (!user_pw){
            alert('회원가입 실패\n비밀번호를 입력해주세요.')
            document.getElementById("pw_input_box").focus(); //커서가 가도록 함
            return ; // 원상태로 되돌림
        }
        if (!user_pw_check){
            alert('회원가입 실패\n비밀번호를 다시 한번 입력해주세요.')
            document.getElementById("pw_check_input_box").focus(); //커서가 가도록 함
            return; // 원상태로 되돌림
        }
        if (user_pw!=user_pw_check){
            alert('회원가입 실패\n비밀번호가 일치하지 않습니다.')
            document.getElementById("pw_input_box").value=''; //비밀번호와 비밀번호 확인 입력칸을 비워준다.
            document.getElementById("pw_check_input_box").value=''; 
            document.getElementById("pw_input_box").focus(); //커서가 가도록 함
            return; // 원상태로 되돌림
        }
        if (!user_name){
            alert('회원가입 실패\n이름을 입력해주세요.')
            document.getElementById("name_input_box").focus(); //커서가 가도록 함
            return; // 원상태로 되돌림
        }
        if (!user_email){
            alert('회원가입 실패\n이메일을 입력해주세요.')
            document.getElementById("email_input_box").focus(); //커서가 가도록 함
            return; // 원상태로 되돌림
        }
        if (!user_phone){
            alert('회원가입 실패\n휴대폰 번호를 입력해주세요.')
            document.getElementById("phone_input_box").focus(); //커서가 가도록 함
            return; // 원상태로 되돌림
        }
       
    }

</script>