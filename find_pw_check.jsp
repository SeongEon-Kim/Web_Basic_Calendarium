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
    String nameValue=request.getParameter("user_name"); 
    String phoneValue=request.getParameter("user_phone");

    Class.forName("com.mysql.jdbc.Driver");  // 커넥터를 불러오는 명령어 줄

    // DB 주소, 계정 아이디, 비밀번호 적어주기 mysql포트는 3306 : DB 연결 작업
    Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/Calendarium", "se" , "1234" );

    String sql="SELECT userPassword FROM user WHERE userID = ? AND userName = ? AND userPhone = ?" ;
    PreparedStatement query=connect.prepareStatement(sql); 
    query.setString(1, idValue);
    query.setString(2, nameValue);
    query.setString(3, phoneValue); 

    ResultSet result=query.executeQuery(); 
    Boolean state=false;
    String pw="" ; 
    while(result.next())
        { pw=result.getString(1); } 


    // SQL문 전송 및 결과 받기 디비에서 가져오기!
    //ResultSet result = query.executeQuery();

    // 값 업데이트 삽입 삭제
    // 데이터베이스에 값 삽입, 수정, 삭제
    //query.executeUpdate();
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
     window.onload = function () {
        
        alert("당신의 비밀번호는 <%= pw%> 입니다.")
        window.history.back() }
</script>