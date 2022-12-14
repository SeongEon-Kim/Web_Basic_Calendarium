<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>

<% 
String month_year_info = request.getParameter("month_year_info");
if(month_year_info == null || month_year_info.equals("")){
    month_year_info = "2022-11";
}
String[] split_month_year_info = month_year_info.split("-");
String year_info = split_month_year_info[0];
String month_info = split_month_year_info[1];

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

// 1119 파라미터 받는 것을 먼저 써야 한다. 
// 
// 커넥터를 불러오는 명령어 줄
Class.forName("com.mysql.jdbc.Driver");  

// DB 주소, 계정 아이디, 비밀번호 적어주기 mysql포트는 3306 : DB 연결 작업
Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/Calendarium", "se" , "1234" );

String string_month_year_value_start = year_info+"-"+month_info+"-01 00:00:00";
String string_month_year_value_finish = year_info+"-"+month_info+"-31 23:59:59";

String sql_month_year= "SELECT * FROM Todo WHERE TodoDate BETWEEN ? AND ? AND userID = ?";

PreparedStatement query_month_year_value =connect.prepareStatement(sql_month_year); 
query_month_year_value.setString(1, string_month_year_value_start);
query_month_year_value.setString(2, string_month_year_value_finish);
query_month_year_value.setString(3, user_id);
ResultSet result_month_year = query_month_year_value.executeQuery();


String sql_master="SELECT userName FROM user WHERE userDepartment = 1" ; 
PreparedStatement query_master =connect.prepareStatement(sql_master); 

String sql_develope="SELECT userName FROM user WHERE userDepartment = 2" ; 
PreparedStatement query_develope =connect.prepareStatement(sql_develope); 

String sql_education="SELECT userName FROM user WHERE userDepartment = 3" ; 
PreparedStatement query_education =connect.prepareStatement(sql_education); 

String sql_marketing="SELECT userName FROM user WHERE userDepartment = 4" ; 
PreparedStatement query_marketing =connect.prepareStatement(sql_marketing); 

String userID="" ; 
String userTodo="" ; 
String TodoDate="" ; 

ResultSet result_master = query_master.executeQuery(); 
ResultSet result_develope = query_develope.executeQuery();  
ResultSet result_education = query_education.executeQuery();
ResultSet result_marketing = query_marketing.executeQuery();

ArrayList<String> Todo = new ArrayList<String>();
    // JSP에서 fronted로 변수로 넘겨 줄 땐 자료형이 무시된 채 문자 자체가 넘어간다.  
    while(result_month_year.next()){
        Todo.add( "[" + "'" + result_month_year.getString(1) + "'" + "," + "'" + result_month_year.getString(2)+ "'" + "," + "'"+ result_month_year.getString(3)+"'" +"," +"'" + result_month_year.getString(4)+"'" +"]");

    }

ArrayList<String> master = new ArrayList<String>(); 
    while (result_master.next()) 
    { master.add(result_master.getString(1));
    } 

ArrayList<String> develope = new ArrayList<String>(); 
    //while (result_develope.next()) 
    //{ develope.add(result_develope.getString(1));
    //} 
    while(result_develope.next()){
        develope.add( "[" + "'" + result_develope.getString(1) + "'" + "]");
    }

ArrayList<String> education = new ArrayList<String>(); 
    while(result_education.next()){
        education.add( "[" + "'" + result_education.getString(1) + "'" + "]");
    }

ArrayList<String> marketing = new ArrayList<String>(); 
    while(result_marketing.next()){
        marketing.add( "[" + "'" + result_marketing.getString(1) + "'" + "]");
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
                <%= user_department %> <%= user_name %> <%= user_rank %>
                <button id = "logout" onclick="logout()">로그아웃</button>
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
        <form class="year_month_change" action="main.jsp">
            <button name="pre_month" type="button" class="year_month_change_btn" onclick="prevMonth()" >&lt;</button>
            <button name="now_month" type="button" class="year_month_change_btn" onclick="goToday()" >Today</button>
            <button name="next_month"type="button" class="year_month_change_btn"onclick="nextMonth()" >&gt;</button>
        </form>
    </div>
    
    <button id="add_btn" onclick="add()">&#43;</button>
    
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
        <div id="edit_delete_btns">
            <input type="button" id="write_btn" onclick="write_todo()" value="&#9745;">
            <button id="cancle_btn" onClick="window.location.reload()">&#65794;</button>
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

    function logout(){
        document.location.href = 'logout_action.jsp'
    }
    console.log(<%= userID %>)
    function add(){ 	
        var con = document.getElementById("add_todo_box"); 	
        if(con.style.display=='none'){ 		
            con.style.display = 'flex'; 	
        }else{ 		
            con.style.display = 'none'; 	
        } 
    } 

    var develope = <%= develope %>
    console.log(develope)
    const tmpdevelope = []
    
    for (var i = 0; i < develope.length; i++){
        var tmpBtn = document.createElement("form")
        tmpBtn.onclick = search_coworker
        tmpBtn.action = "main_friend_check.jsp"
        tmpBtn.id = "team";
        document.getElementById("develope_department").appendChild(tmpBtn);
        tmpBtn.innerHTML =develope[i];

        var tmpInput = document.createElement('input');
        tmpInput.type = "hidden";
        tmpInput.value = develope[i]
        tmpInput.name = "coworker";

        tmpBtn.appendChild(tmpInput);
    }
    
    var education = <%= education %>
    console.log(education)
    const tmpeducation = []
    
    for (var i = 0; i < education.length; i++){
        var tmpBtn = document.createElement("form")
        //tmpBtn.onclick = search_coworker
        
        tmpBtn.action = "main_friend_check.jsp"
        tmpBtn.className = "team";
        
        tmpBtn.innerHTML = education[i];
        
        tmpBtn.addEventListener("click", function(){
            //document.getElementsByClassName("team")[i].submit();
            tmpBtn.submit();
        })
    
        var tmpInput = document.createElement('input');
        tmpInput.type = "hidden";
        tmpInput.value = education[i]
        tmpInput.name = "coworker";

        tmpBtn.appendChild(tmpInput);
        // tmpbtn 준비 끝나고 상속해주겠다~
        document.getElementById("education_department").appendChild(tmpBtn);
    }

    var marketing = <%= marketing %>
    console.log(marketing)
    const tmpmarketing = []
    
    for (var i = 0; i < marketing.length; i++){
        var tmpBtn = document.createElement("form")
        tmpBtn.onclick = search_coworker
        tmpBtn.action = "main_friend_check.jsp"
        tmpBtn.id = "team";
        document.getElementById("marketing_department").appendChild(tmpBtn);
        tmpBtn.innerHTML =marketing[i];
        
        var tmpInput = document.createElement('input');
        tmpInput.type = "hidden";
        tmpInput.value = marketing[i]
        tmpInput.name = "coworker";

        tmpBtn.appendChild(tmpInput);
    }
    function search_coworker(){
        //document.getElementById("team").submit();
        document.getElementsByClassName("team").submit();
    }

    function write_cancle(){
        document.location.href = 'main.jsp'
    }
    function write_todo(){ 

        var content = document.getElementById("add_todo_content").value;
        var date = document.getElementById("date").value;
        var slice_date = date.split("-");
        var ampm = document.getElementById("ampm").value;
        var hour = document.getElementById("hour").value;
        var minute = document.getElementById("minute").value;
        var form = document.getElementsByTagName("form")[0];

        console.log(date);
        console.log(slice_date[2]);

        var todo = document.createElement("div")
        todo.className= "todo"
        form.after(todo);

        var day = document.createElement("div")
        day.className = "day"
        day.innerHTML = slice_date[2] + "일";
        todo.appendChild(day)

        var todo_box = document.createElement("div")
        todo_box.className = "todo_box"
        todo.appendChild(todo_box)

        var todo_date_content = document.createElement("div")
        todo_date_content.className = "todo_date_content"
        todo_box.appendChild(todo_date_content)

        var time = document.createElement("div")
        time.className = "time"
        time.innerHTML = ampm + hour +"시" + minute + "분";
        todo_date_content.appendChild(time);

        var todo_content = document.createElement("div");
        todo_content.className = "todo_content";
        todo_content.innerHTML = content;
        todo_date_content.appendChild(todo_content)

        document.getElementById("add_todo_box").submit();
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
    window.onload = function() {
     // 모든 일정 불러오는 함수
    let date = new Date(new Date() * 1 + 3600000 * 9);
    var curDate = date.toISOString().replace("T", " ").replace(/\..*/, "").split("-");
    console.log("curMonth   입니다", curDate)
    //var curDate_split = curDate.split(":")
 
 
    var Todo = <%= Todo %>
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

        //&& (tmpTodoDate[k] <curDate_split[0])
        if (month < curDate[1]){
            TodoContentDiv.className = "todo_content_line";
        }
        else{
            TodoContentDiv.className = "todo_content";
        }
        /*
        var EditDeleteDiv = document.createElement('div');
        EditDeleteDiv.className = "edit_delete_btn";

        document.getElementsByClassName("todo_date_content")[k].appendChild(EditDeleteDiv)

        var deleteBtn = document.createElement('button');
        deleteBtn.innerHTML = "🗑";
        document.getElementsByClassName("edit_delete_btn")[k].appendChild(deleteBtn);
*/

        TodoContentDiv.innerHTML = tmpTodo[k]

        document.getElementsByClassName('alltodo')[0].appendChild(DayDiv)
        document.getElementsByClassName('alltodo')[0].appendChild(TodoBoxDiv)
        TodoBoxDiv.appendChild(TodoDateContentDiv)
        TodoDateContentDiv.appendChild(TimeDiv)
        TodoDateContentDiv.appendChild(TodoContentDiv)

    }
}
    
    </script>
<script src="https://code.iconify.design/iconify-icon/1.0.0-beta.3/iconify-icon.min.js"></script>
<script src="https://code.iconify.design/iconify-icon/1.0.0/iconify-icon.min.js"></script>
