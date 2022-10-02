<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%> 
<%
    // 이전 페이지로부터 온 값 인코딩 설정
    request.setCharacterEncoding("utf-8");

    // 이전 페이지로부터 값 받아오는 부분
    String idValue=request.getParameter("user_id"); 
    String pwValue=request.getParameter("user_pw");
    String nameValue=request.getParameter("user_name");
    String departmentValue=request.getParameter("user_department"); 
    String rankValue=request.getParameter("user_rank"); 
    String emailValue=request.getParameter("user_email"); 
    String phoneValue=request.getParameter("user_phone"); 


    Class.forName("com.mysql.jdbc.Driver");  // 커넥터를 불러오는 명령어 줄

    // DB 주소, 계정 아이디, 비밀번호 적어주기 mysql포트는 3306 : DB 연결 작업
    Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/Calendarium", "se" , "1234" );


    // SQL문 준비 작업
    String sql="INSERT INTO user (userID, userPassword, userName, userDepartment, userRank, userEmail, userPhone, userAvailable ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"; 
    PreparedStatement query = connect.prepareStatement(sql);
    query.setString(1, idValue);
    query.setString(2, pwValue);
    query.setString(3, nameValue);

    if(departmentValue.equals("총괄")){
        query.setString(4, "1"); 
    }
    else if (departmentValue.equals("개발 부서")){
        query.setString(4, "2"); 
    }
    else if (departmentValue.equals("교육 부서")){
        query.setString(4, "3"); 
    }
    else{
        query.setString(4, "4"); 
    }
    
    if(rankValue.equals("관리자")){
        query.setString(5, "3"); 
    }
    else if (rankValue.equals("팀장")){
        query.setString(5, "2"); 
    }
    else{
        query.setString(5, "1"); 
    }
    
    query.setString(6, emailValue); 
    query.setString(7, phoneValue); 
    query.setInt(8,1);

    // SQL문 전송 및 결과 받기 디비에서 가져오기!
    // ResultSet result = query.executeQuery();

    // 값 업데이트 삽입 삭제
    // 데이터베이스에 값 삽입, 수정, 삭제
    
    query.executeUpdate();
%>

<head>
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
</body>
<script>
    alert("회원가입 성공\n로그인 페이지로 이동합니다.")
    var popUrl = "index.jsp";
    window.open(popUrl);
</script>