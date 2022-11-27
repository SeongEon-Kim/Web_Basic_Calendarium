<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>
<% 

// 로그인 정보가 없을 때, 들어왔다면 돌려준다.
// 세션 유무 확인하는 코드가 있어야 함
// 세션을 안 썼을 때, reload 시 날라간다 (유지할 방법 x), login 정보를 계속 옮겨줘야하는데 이를 세션으로 해결할 수 있다.
// DB 통신은 속도가 느려진다. --> 그래서 다 가져온다,,,,,
// 세션은 RAM위에서 진행된다 --> 속도는 빠르지만, 비용이 비싸 다 올릴 수는 없다~
String user_id = (String)session.getAttribute("idValue");
String user_name = (String)session.getAttribute("nameValue");
String user_department = (String)session.getAttribute("departmentValue");
String user_rank = (String)session.getAttribute("rankValue");
if(user_department.equals("1")){
    user_department = "총괄";
}
else if (user_department.equals("2")){
    user_department = "개발 부서";
}
else if (user_department.equals("3")){
    user_department = "교육 부서";
}
else if (user_department.equals("4")){
    user_department = "마케팅 부서";
}

if(user_rank.equals("3")){
    user_rank = "관리자";
}
else if (user_rank.equals("2")){
    user_rank = "팀장";
}
else if (user_rank.equals("1")){
    user_rank = "팀원";
}

Class.forName("com.mysql.jdbc.Driver");  
Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/Calendarium", "se" , "1234" );

String coworker_value = request.getParameter("coworker");

String sql_coworker= "SELECT userID FROM user WHERE userName = ?" ; 
PreparedStatement query_coworker = connect.prepareStatement(sql_coworker); 
query_coworker.setString(1, coworker_value);
ResultSet result_coworker = query_coworker.executeQuery();
String coworker_value_todo="";
while(result_coworker.next()){
    coworker_value_todo = result_coworker.getString(1);
}

String month_year_info = request.getParameter("month_year_info");
if(month_year_info == null || month_year_info.equals("")){
    month_year_info = "2022-11";
}
String[] split_month_year_info = month_year_info.split("-");
String year_info = split_month_year_info[0];
String month_info = split_month_year_info[1];

String string_month_year_value_start = year_info+"-"+month_info+"-01 00:00:00";
String string_month_year_value_finish = year_info+"-"+month_info+"-31 23:59:59";

String sql_coworker_todo = "SELECT * FROM Todo WHERE TodoDate BETWEEN ? AND ? AND userID = ?" ; 
PreparedStatement query_coworker_todo = connect.prepareStatement(sql_coworker_todo); 
query_coworker_todo.setString(1, string_month_year_value_start);
query_coworker_todo.setString(2, string_month_year_value_finish);
query_coworker_todo.setString(3, coworker_value_todo);
ResultSet result_coworker_todo = query_coworker_todo.executeQuery();

ArrayList<String> coworker_todo = new ArrayList<String>();
    // JSP에서 fronted로 변수로 넘겨 줄 땐 자료형이 무시된 채 문자 자체가 넘어간다.  
    while(result_coworker_todo.next()){
        coworker_todo.add( "[" + "'" + result_coworker_todo.getString(1) + "'" + "," + "'" + result_coworker_todo.getString(2)+ "'" + "," + "'"+ result_coworker_todo.getString(3)+"'" +"," +"'" + result_coworker_todo.getString(4)+"'" +"]");
    }

%>

<head>
    <title>Document</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.5">
    <link rel="stylesheet" type="text/css" href="main.css">
</head>
<body>
    <header>
        <div id="top_bar">
            <iconify-icon icon="fontisto:nav-icon-a" id="side_nav_btn" onclick="openNav()"></iconify-icon>
            <a href="main.jsp"id="Calendarium">
            Calendarium
            <iconify-icon icon="mdi:palm-tree" style="color: #005247;" width="50" height="50"></iconify-icon>
            </a>
            <div id="profile">
                <%= user_department %> <%= user_name %> <%= user_rank %>님이 <%= coworker_value%>님의 일정 확인 중
            </div>
           
        </div>
   </header>

   <!-- 피드백 SEO -->
   <div id="mySidenav" class="sidenav">
    <!-- javascript:void(0) 링크 기능 무효화 
 -->
    <a id="nav_close" href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
    <div id="develope_department">
        <a id="develope_department_box" href="main.jsp">개발 부서</a>
        
    </div>
    <div id="education_department">
        <a id="education_department_box" href="main.jsp">교육 부서</a>
       
        
    </div>
    <div id="marketing_department"> 
        <a id="marketing_department_box" href="main.jsp">마케팅 부서</a>
        
    </div>
  </div>
      
  <div id="calendar">
    <div class="calendar_box">
        <div name="month_value" id="calendar_year_month" >
            <%= year_info %> 년 <%= month_info %> 월
            <!-- <input type="hidden" name="month_value"  id="hidden_calendar_year_month"> -->
        </div>
        <form class="year_month_change" action="main_friend_check.jsp">
            <button name="pre_month" type="button" class="year_month_change_btn" onclick="prevMonth()" >&lt;</button>
            <button name="now_month" type="button" class="year_month_change_btn" onclick="goToday()" >Today</button>
            <button name="next_month"type="button" class="year_month_change_btn"onclick="nextMonth()" >&gt;</button>
        </form>
    </div>
    
    <!-- <button id="add_btn" onclick="add()">&#43;</button> -->
    
    <!-- <iconify-icon icon="carbon:add" style="color: #005247;" width="40"></iconify-icon> -->
    <!-- <div class="dates"></div>  date그리기-->
    </div>

    <hr id="calendar_box_line">
   
   <div id="add_todo">
    <form id="add_todo_box" action="main_check.jsp" >
        <div id="add_todo_date_content" >
            <input name="content" type="text" id="add_todo_content" >
            <input name="date" type="date" id="date">
            <select id="ampm" name="ampm">
                <option value="오전">오전</option>
                <option value="오후">오후</option>
            </select>
            <select id="hour" name="hour">
                <option value="01">1시</option>
                <option value="02">2시</option>
                <option value="03">3시</option>
                <option value="04">4시</option>
                <option value="05">5시</option>
                <option value="06">6시</option>
                <option value="07">7시</option>
                <option value="08">8시</option>
                <option value="09">9시</option>
                <option value="10">10시</option>
                <option value="11">11시</option>
                <option value="12">12시</option>
            </select>
            <select id="minute" name="minute">
                <option value="0">00분</option>
                <option value="15">15분</option>
                <option value="30">30분</option>
                <option value="45">45분</option>
            </select>
        </div>
        <div id="edit_delete_btn">
            <input type="button" id="write_btn" onclick="write_todo()" value="&#9745;">
            <button id="cancle_btn">&#65794;</button>
        </div>
    </form>
   </div>

    <div class="alltodo"></div>

    
        <!-- <div class="alltodo">
        <div class="day">26일</div>
    <div class="todo_box">

        <div class="todo_date_content" >
            <div class="time">20:45</div>
            <div class="todo_content">두산 VS KT 야구보러 가기</div>
        </div>
        <div id="edit_delete_btn">
            <button>
                🗑
            </button>
            <button>
                ✎
            </button>
        </div>
    </div> 
</div> -->

</body>
<script>
    function add(){ 	
        var con = document.getElementById("add_todo_box"); 	
        if(con.style.display=='none'){ 		
            con.style.display = 'flex'; 	
        }else{ 		
            con.style.display = 'none'; 	
        } 
    } 

    function prevMonth(){
        var preMonth = parseInt(<%= month_info %>) - 1
        var curYear = parseInt(<%= year_info %>)
        
        if (preMonth==0){
            preMonth = 12
            curYear -= 1 
            console.log("curYear 입니다", curYear)
        }
        document.getElementById("calendar_year_month").innerHTML = curYear+ "년"+ preMonth + "월"

        var tmpInput = document.createElement('input');
        tmpInput.type = "hidden";
        tmpInput.value = curYear +"-"+ preMonth;
        tmpInput.name = "month_year_info";

        document.getElementsByClassName("year_month_change")[0].appendChild(tmpInput);
        document.getElementsByClassName("year_month_change")[0].submit();
    }

    function goToday(){
        let date = new Date();
        var nowDate = date.toISOString().replace("T", " ").replace(/\..*/, "").split("-");
        document.getElementById("calendar_year_month").innerHTML = nowDate[0] +"년 " +nowDate[1] + "월"       

        var tmpInput = document.createElement('input');
        tmpInput.type = "hidden";
        tmpInput.value = nowDate[0]+"-"+nowDate[1]
        tmpInput.name = "month_year_info";

        document.getElementsByClassName("year_month_change")[0].appendChild(tmpInput);
        document.getElementsByClassName("year_month_change")[0].submit();

    }
    
    function nextMonth(){
        var nextMonth = parseInt(<%= month_info %>) + 1
        var curYear = parseInt(<%= year_info %>)

        if (nextMonth==13){
            nextMonth = 1
            curYear +=1
            console.log("curYear 입니다", curYear)
        }
        document.getElementById("calendar_year_month").innerHTML = curYear+ "년"+ nextMonth + "월"

        var tmpInput = document.createElement('input');
        tmpInput.type = "hidden";
        tmpInput.value = curYear +"-"+ nextMonth;
        tmpInput.name = "month_year_info";

        document.getElementsByClassName("year_month_change")[0].appendChild(tmpInput);
        document.getElementsByClassName("year_month_change")[0].submit();
    }

    function openNav() {
        document.getElementById("mySidenav").style.width = "278px";
        document.getElementById("add_todo").style.padding = "0px 0px 0px 278px";
        document.getElementById("calendar").style.padding = "0px 0px 0px 278px";
        }
        
    function closeNav() {
        document.getElementById("mySidenav").style.width = "0";
        document.getElementById("add_todo").style.padding = "0px 0px 0px 0px";
        document.getElementById("calendar").style.padding = "0px 0px 0px 0px";
    }
   
     // 모든 일정 불러오는 함수
    let date = new Date(new Date() * 1 + 3600000 * 9);
    var curDate = date.toISOString().replace("T", " ").replace(/\..*/, "").split("-");
    console.log("curMonth   입니다", curDate)
 
 
    var Todo = <%= coworker_todo %>
    console.log(Todo)

    const tmpTodoDate = []
    const tmpTodoTime = [] 
    const tmpTodo = []
    for (var item of Todo){
        tmpTodoDate.push(item[3].slice(8, 10))
        tmpTodoTime.push(item[3].slice(12, 16))
        tmpTodo.push(item[2])
    }
    var k = 0 ;     
    console.log("TODOTIME",tmpTodoTime)  
    console.log("TODODATE", tmpTodoDate)
    console.log("TODOT",tmpTodo)

    
    for(k = 0; k< tmpTodoDate.length; k++){

        var month = <%= month_info %>

        var DayDiv = document.createElement('div');
        var TodoBoxDiv = document.createElement('div');
        var TodoDateContentDiv = document.createElement('div');
        var TimeDiv = document.createElement('div');
        var TodoContentDiv = document.createElement('div');

        DayDiv.className = "day";
        DayDiv.innerHTML = tmpTodoDate[k]+ "일"
        
        TodoBoxDiv.className = "todo_box";
        TodoDateContentDiv.className = "todo_date_content";
        TimeDiv.className = "time";
        TimeDiv.innerHTML = tmpTodoTime[k]

        if (month < curDate[1]){
            TodoContentDiv.className = "todo_content_line";
        }
        else{
            TodoContentDiv.className = "todo_content";
        }
        
        TodoContentDiv.innerHTML = tmpTodo[k]

        document.getElementsByClassName('alltodo')[0].appendChild(DayDiv)
        document.getElementsByClassName('alltodo')[0].appendChild(TodoBoxDiv)
        TodoBoxDiv.appendChild(TodoDateContentDiv)
        TodoDateContentDiv.appendChild(TimeDiv)
        TodoDateContentDiv.appendChild(TodoContentDiv)
    }
    
    </script>
<script src="https://code.iconify.design/iconify-icon/1.0.0-beta.3/iconify-icon.min.js"></script>
<script src="https://code.iconify.design/iconify-icon/1.0.0/iconify-icon.min.js"></script>
