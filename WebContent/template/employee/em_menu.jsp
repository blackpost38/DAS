<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
       <% if(session.getAttribute("emp")==null){%>
    <script type="text/javascript">
  alert("로그인 후 사용해주세요");
  location.replace("index.jsp");
</script>  
    <% }%>
<div class="well sidebar-nav">
	<ul class="nav nav-list">
		<li class="nav-header"><h5>${sessionScope.emp.emp_name}님<br/> 안녕하세요</h5></li>
		<li><a href="logout.go">로그아웃</a></li>
		<li class="nav-header">출근 관리</li>
		<li><a href="./attendview.go">출근 하기</a></li>
		<li><a href="./seltime.go">출근 기록 조회</a></li>
		<li class="nav-header">시간외 근무 관리</li>
		<li><a href="./overtaskinsview.go">시간외 근무 등록</a></li>
		<li><a href="./overtaskselview.go">시간외 근무 조회</a></li>
		<li class="nav-header">휴가 관리</li>
		<li><a href="vacation.go">휴가 관리</a></li>
		<li class="nav-header">정보 조회</li>
		<li><a href="./info.go">사원정보 조회</a></li>	
	</ul>
</div>