<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
  

<div class="well sidebar-nav">
	<ul class="nav nav-list">
		<li class="nav-header"><h5>${sessionScope.adm.admin_name}님<br/> 안녕하세요</h5></li>
		<li><a href="logout.go">로그아웃</a></li>
		<li class="nav-header">관리자 기능</li>
		<li><a href="./ad_sermain.go">사원 조회</a></li>
		<li><a href="./ad_insview.go">사원 등록</a></li>
		<li><a href="./getattview.go">출근 기록</a></li>
	</ul>
</div>

