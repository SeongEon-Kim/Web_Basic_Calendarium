<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.ArrayList"%>

<% 

String month =request.getParameter("month");

if (month == null || month.equals("")){
    month = "9";
}
else{

}

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

    // 커넥터를 불러오는 명령어 줄
    Class.forName("com.mysql.jdbc.Driver");  

    // DB 주소, 계정 아이디, 비밀번호 적어주기 mysql포트는 3306 : DB 연결 작업
    Connection connect=DriverManager.getConnection("jdbc:mysql://localhost:3306/Calendarium", "se" , "1234" );

    String sql2="SELECT userName FROM user WHERE userDepartment = 1" ; 
    PreparedStatement query2 =connect.prepareStatement(sql2); 
    String sql3="SELECT userName FROM user WHERE userDepartment = 2" ; 
    PreparedStatement query3 =connect.prepareStatement(sql3); 
    String sql4="SELECT userName FROM user WHERE userDepartment = 3" ; 
    PreparedStatement query4 =connect.prepareStatement(sql4); 
    String sql5="SELECT userName FROM user WHERE userDepartment = 4" ; 
    PreparedStatement query5 =connect.prepareStatement(sql5); 


    String userID="" ; 
    String userTodo="" ; 
    String TodoDate="" ; 

    
    String sql6="SELECT * FROM Todo WHERE userID= ?" ; 
    PreparedStatement query6 =connect.prepareStatement(sql6); 
    query6.setString(1, user_id);
    ResultSet result6 = query6.executeQuery();

    String[] TodoDateArr = TodoDate.split(" ");
    String TodoDateArr2 = TodoDateArr[0];
    String[] TodoDateArr3 = TodoDateArr2.split("-");

    ResultSet result2 = query2.executeQuery(); 
    ResultSet result3 = query3.executeQuery();  
    ResultSet result4 = query4.executeQuery();
    ResultSet result5 = query5.executeQuery();

    ArrayList<String> Todo = new ArrayList<String>(); 
        while(result6.next()){
            Todo.add( "[" +"'" + result6.getString(1) + "'" + "," + "'"+ result6.getString(2)+ "'" + "," + "'"+ result6.getString(3)+"'" +"," +"'" + result6.getString(4)+"'" +"]");
        }

    ArrayList<String> master = new ArrayList<String>(); 

        while (result2.next()) 
        { master.add(result2.getString(1));
        } 

    ArrayList<String> develope = new ArrayList<String>(); 

        while (result3.next()) 
        { develope.add(result3.getString(1));
        } 

    ArrayList<String> education = new ArrayList<String>(); 

        while (result4.next()) 
        { education.add(result4.getString(1));
        } 

    ArrayList<String> marketing = new ArrayList<String>(); 

        while (result5.next()) 
        { marketing.add(result5.getString(1));
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
            <a href="index.jsp"id="Calendarium">
            Calendarium
            <iconify-icon icon="mdi:palm-tree" style="color: #005247;" width="50" height="50"></iconify-icon>
            </a>
            <div id="profile">
                <%= user_department %> <%= user_name %> <%= user_rank %>
                <%=month %> 
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
        <div id="calendar_year_month"></div>
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
        <div id="edit_delete_btn">
            <input type="button" id="write_btn" onclick="write_todo()" value="&#9745;">
            <button id="cancle_btn">&#65794;</button>
        </div>
    </form>
   </div>

    <div class="alltodo"></div>

    
        <div class="alltodo">
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
</div>

</body>
<script>
    console.log(<%= userID %>)
    function add(){ 	
        var con = document.getElementById("add_todo_box"); 	
        if(con.style.display=='none'){ 		
            con.style.display = 'flex'; 	
        }else{ 		
            con.style.display = 'none'; 	
        } 
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
    var Today = new Date(new Date() * 1 + 3600000 * 9).toISOString().replace("T", " ").replace(/\..*/, ""); 
    console.log(Today)




    let date = new Date();
    const renderCalendar = () => {
    const viewYear = date.getFullYear();
    const viewMonth = date.getMonth() + 1; 
    console.log(viewMonth,viewYear)
    // year-month 채우기
    document.getElementById("calendar_year_month").innerHTML = viewYear+"년 "+viewMonth+"월";
    // 지난 달 마지막 Date, 이번 달 마지막 Date
    const prevLast = new Date(viewYear, viewMonth, 0);
    const thisLast = new Date(viewYear, viewMonth + 1, 0);
    
    const PLDate = prevLast.getDate();
    const PLDay = prevLast.getDay();
    
    const TLDate = thisLast.getDate();
    const TLDay = thisLast.getDay();
    
    // Dates 기본 배열들
    const prevDates = [];
    //const thisDates = [...Array(TLDate + 1).keys()].slice(1);
    const nextDates = [];
        // prevDates 계산
        if (PLDay !== 6) {
          for (let i = 0; i < PLDay + 1; i++) {
            prevDates.unshift(PLDate - i);
          }
        }
      
         for (let i = 1; i < 7 - TLDay; i++) {
          nextDates.push(i)
        }
      }
      
      renderCalendar();

    const prevMonth = () => {
    date.setMonth(date.getMonth() - 1);
    renderCalendar();

    var tmpInput = document.createElement('input');
    tmpInput.type = "hidden";
    tmpInput.value = date.getMonth() + 1 ;
    tmpInput.name = "month";
    document.getElementsByClassName("year_month_change")[0].appendChild(tmpInput);
    document.getElementsByClassName("year_month_change")[0].submit();

    }

    const nextMonth = () => {
    date.setMonth(date.getMonth() + 1);
    renderCalendar();

    var tmpInput = document.createElement('input');
    tmpInput.type = "hidden";
    tmpInput.value = date.getMonth() + 1 ;
    tmpInput.name = "month";
    document.getElementsByClassName("year_month_change")[0].appendChild(tmpInput);
    document.getElementsByClassName("year_month_change")[0].submit();
    }

    const goToday = () => {
    date = new Date();
    renderCalendar();
    document.getElementsByClassName("year_month_change").submit();
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
   

    <% for (int i = 0; i < develope.size(); i++){ %>
        var tmpBtn = document.createElement("button")
        tmpBtn.id = "team";
        document.getElementById("develope_department").appendChild(tmpBtn);
        console.log("<%=develope.get(i)%>")
        tmpBtn.innerHTML ="<%=develope.get(i)%>";
    <%}%>
    
    <% for (int i = 0; i < education.size(); i++){ %>
        var tmpBtn = document.createElement("button")
        tmpBtn.id = "team";
        document.getElementById("education_department").appendChild(tmpBtn);
        console.log("<%=education.get(i)%>")
        tmpBtn.innerHTML ="<%=education.get(i)%>";
    <%}%>

    <% for (int i = 0; i < marketing.size(); i++){ %>
        var tmpBtn = document.createElement("button")
        tmpBtn.id = "team";
        document.getElementById("marketing_department").appendChild(tmpBtn);
        console.log("<%=marketing.get(i)%>")
        tmpBtn.innerHTML ="<%=marketing.get(i)%>";
    <%}%>



    var Todo = <%=Todo%>
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
    console.log(tmpTodoDate)
    console.log(tmpTodo)
    
    for(k = 0; k< tmpTodoDate.length; k++){

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

        TodoContentDiv.className = "todo_content";
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
