<%@ page language="java" contentType="text/html" pageEncoding="utf-8"%>

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
                김성언 관리자
            </div>
           
        </div>
   </header>

   <!-- 피드백 SEO -->
   <div id="mySidenav" class="sidenav">
    <!-- javascript:void(0) 링크 기능 무효화 
 -->
    <a id="nav_close" href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
    <div class="department">
        <a class="department_box" href="main.jsp">개발 부서</a>
        <div id="team">안태현 팀장</div>
        <div id="team">이민영 팀원</div>
        <div id="team">한만욱 팀원</div>
    </div>
    <div class="department">
        <a class="department_box" href="main.jsp">교육 부서</a>
        <div id="team">김재연 팀장</div>
        <div id="team">잉현아 팀원</div>
        <div id="team">김재걸 팀원</div>
    </div>
    <div class="department"> 
        <a class="department_box" href="main.jsp">마케팅 부서</a>
        <div id="team">허채연 팀장</div>
        <div id="team">에서현 팀원</div>
    </div>
  </div>
      
  <div id="calendar">
    <div class="calendar_box">
        <div id="calendar_year_month"></div>
        <div class="year_month_change">
            <button class="year_month_change_btn" onclick="prevMonth()">&lt;</button>
            <button class="year_month_change_btn" onclick="goToday()">Today</button>
            <button class="year_month_change_btn"onclick="nextMonth()">&gt;</button>
        </div>
    </div>
    <iconify-icon icon="carbon:add" style="color: #005247;" width="40"></iconify-icon>
    <!-- <div class="dates"></div>  date그리기-->
    </div>

    <hr id="calendar_box_line">
   
   <div id="todo">
    <div id="todo_box">
        <div id="todo_date_content" >
            <div id="day">18일</div>
            <div id="todo_content">스테이지어스 과제 하기</div>
        </div>
        
        <div id="edit_delete_btn">
            <iconify-icon icon="clarity:note-edit-solid" style="color: #005247;" width="20"></iconify-icon>
            <iconify-icon icon="ep:delete-filled" style="color: #005247;" width="20"></iconify-icon>
        </div>
    </div>
   </div>
    
</body>

<script>

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
      
        // nextDates 계산
        for (let i = 1; i < 7 - TLDay; i++) {
          nextDates.push(i)
        }
      
        // Dates 합치기
        //const dates = prevDates.concat(thisDates, nextDates);
      
        // Dates 그리기
        // document.querySelector('.dates').innerHTML = dates.join('');
      }
      
      renderCalendar();

    const prevMonth = () => {
    date.setMonth(date.getMonth() - 1);
    renderCalendar();
    }

    const nextMonth = () => {
    date.setMonth(date.getMonth() + 1);
    renderCalendar();
    }

    const goToday = () => {
    date = new Date();
    renderCalendar();
    }

    function openNav() {
        document.getElementById("mySidenav").style.width = "278px";
        document.getElementById("todo").style.padding = "0px 0px 0px 278px";
        document.getElementById("calendar").style.padding = "0px 0px 0px 278px";
        }
        
    function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("todo").style.padding = "0px 0px 0px 0px";
    document.getElementById("calendar").style.padding = "0px 0px 0px 0px";
    }
    
    </script>
<script src="https://code.iconify.design/iconify-icon/1.0.0-beta.3/iconify-icon.min.js"></script>
<script src="https://code.iconify.design/iconify-icon/1.0.0/iconify-icon.min.js"></script>