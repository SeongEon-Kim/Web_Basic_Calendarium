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

    // 커넥터를 불러오는 명령어 줄
    Class.forName("com.mysql.jdbc.Driver");  

    // DB 주소, 계정 아이디, 비밀번호 적어주기 mysql포트는 3306 : DB 연결 작업
    Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/Calendarium", "se" , "1234" );

    String sql="SELECT userID FROM user WHERE userID = ?" ; 
    PreparedStatement query =connect.prepareStatement(sql); 
    query.setString(1, idValue); 

    ResultSet result = query.executeQuery(); 
    Boolean isDuplicate = false; 

    String id="" ; 

    while (result.next()) 
    {id=result.getString(1);} 

    if(idValue.equals(id))
    { isDuplicate=true; }                           
    
%>

<head>
    <title></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>

    <script>
        window.onload = function () {
            if (<%= isDuplicate %>) {
                alert("중복아이디입니다.")
                window.history.back()
            }
            else{
                alert("사용 가능한 아이디입니다.")
                window.history.back();
            }
        }
    </script>

</body>