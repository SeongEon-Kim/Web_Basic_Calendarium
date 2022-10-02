<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%> 


<%
    // 이전 페이지로부터 온 값 인코딩 설정
    request.setCharacterEncoding("utf-8");

    String user_id = (String)session.getAttribute("idValue");
    // 이전 페이지로부터 값 받아오는 부분
    String contentValue=request.getParameter("content"); 
    String dateValue=request.getParameter("date"); 
    String ampmValue=request.getParameter("ampm");
    int hourValue;
    if(ampmValue.equals("오전")){
        hourValue=Integer.parseInt(request.getParameter("hour"));
    } 
    else{
        hourValue=Integer.parseInt(request.getParameter("hour"))+12;
    }

    String minuteValue=request.getParameter("minute"); 
    String TodoDateValue = dateValue+" " + hourValue + ":"+minuteValue+ ":00";

    // 커넥터를 불러오는 명령어 줄
    Class.forName("com.mysql.jdbc.Driver");  

    // DB 주소, 계정 아이디, 비밀번호 적어주기 mysql포트는 3306 : DB 연결 작업
    Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/Calendarium", "se" , "1234" );

    String sql="INSERT INTO Todo (userID, userTodo, TodoDate, commentAvailable) VALUES (?, ?, ?, ?)"; 
    PreparedStatement query =connect.prepareStatement(sql); 
    
    query.setString(1, user_id);
    query.setString(2, contentValue);
    query.setString(3, TodoDateValue); 

    query.setInt(4, 1);    

    query.executeUpdate();
                           
    
%>

<head>
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>

    <script>
        window.history.back();
    </script>

</body>