<%@page import="spring.emp.DayDAO"%>
<%@page import="spring.emp.DayDTO"%>
<%@page import="spring.emp.EmpDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>	
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>Head leave</title>
	<script>
		
		<% 
			/*
				process : 
					1. 휴가 날짜 클릭 
						-> dayClick으로 받아야 한다.
						-> select로 하면 start, end parameter 때문에 알고리즘이 복잡해진다.
					2. url 이용하여 Controller 실행 
						-> paramete가 길어서 url 숨기기 위해 body에 form(post) 태그 하나 생성
					3. DB에서 받아와 event로 뿌려줌.
			*/
			
			DayDAO dao = new DayDAO();
			List<DayDTO> list = (List)dao.selectVacation((EmpDTO)(session.getAttribute("emp")));
		
		%>
		
			var date;
			$.post(location.href, function(data,status,xhr){
	//			alert(xhr.getResponseHeader("Date"));
				date = new Date(xhr.getResponseHeader("Date"));
			}).done(function() {
	//			alert( "location.href success" );
			}).fail(function() {
	//			alert( "location.href error" );
			}).always(function() {
	//			alert( "location.href finished" );
	//			$(location).attr("href", "SimpleInsertVocation.jsp");
			});
			var vacationDateArr = [];
			
			$(document).ready(function() {
			
				var date = new Date();
				var d = date.getDate();
				var m = date.getMonth();
				var y = date.getFullYear();
				
				var calendar = $('#calendar').fullCalendar({
					header: {
						left: 'prev,next today',
						center: 'title',
						right: 'month'
					},
					selectable: true,
					selectHelper: true,
					select: function( startDate, endDate, allDay, jsEvent, view ) {
						
						if (startDate < new Date()){
							alert("오늘 이후만 가능합니다.");
							return;
						} else if (!confirm("휴가를 등록하시겠습니까?"))	return;
						
						var startDay; var endDay;
						
						if (new Date(startDate) > new Date(endDate)) {
							startDay = new Date(endDate);
							endDay = new Date(startDate);
						} else {
							startDay = new Date(startDate);
							endDay = new Date(endDate);
						}
						
						for ( var i in vacationDateArr) {
							
							// 하나 클릭
							if (startDay.toDateString() == endDay.toDateString()) {
								if (vacationDateArr[i].getTime() == startDay.getTime()) {
									alert("이미 신청하였습니다.");
									return;
								}
							// 다중 클릭
							} else {
								for ( var j = startDay.getTime() ; j <= endDay.getTime() ; j = j + 86400000) {
									if (vacationDateArr[i].getTime()  == j) {
										alert("휴가가 겹치는 날이 있습니다.");
										return;
									}
								}
							}
						}
						
						var startYear = startDay.getFullYear();
						var startMonth = startDay.getMonth() + 1;
						var startDate = startDay.getDate();
						
						var endYear = endDay.getFullYear();
						var endMonth = endDay.getMonth() + 1;
						var endDate = endDay.getDate();
						var gap = (endDay - startDay) / 86400000;
						
						var url = 'multiInsertVacation.go'
							+ '?startDay=' + startDay
							+ '&startYear=' + startYear
							+ '&startMonth=' + startMonth
							+ '&startDate=' + startDate
							+ '&endDay=' + endDay
							+ '&endYear=' + endYear
							+ '&endMonth=' + endMonth
							+ '&endDate=' + endDate
							+ '&gap=' + gap;
						
						$(this).css('background-color', 'red');

						$.post(url, function() {
						}).always(function() {
							location.replace("vacation.go");
//							$(location).attr("href", "SimpleInsertVocation.jsp");
						});
					},
					events: [
					         
					<% 
						
						Calendar cal = Calendar.getInstance();
						
						for(int i=0; i<list.size(); i++){
							if(list.get(i) == null) continue;
							String date = list.get(i).getDay_today();
							int index = date.indexOf('/');
							String year = date.substring(0, index);
							date = date.substring(index+1);
							index = date.indexOf('/');
							String month = date.substring(0, index);
							index = date.indexOf('/');
							String day = date.substring(index+1);
							//System.out.println(list.get(i).getDay_id());
							
					%>
						
						{
							id: <%=list.get(i).getDay_id()%>,
							title: '휴가',
							start: new Date(<%=year%>, <%=Integer.parseInt(month)-1%>, <%=day%>)
						},
						
					<% } %>
						{}
					], eventClick: function(calEvent, jsEvent, view) {
						if (!window.confirm("휴가를 삭제하시겠습니까?")) return;
						
						calendar.fullCalendar('removeEvents', calEvent.id);
						location.href = "deleteVacation.go?id=" + calEvent.id;
						
				    }, eventRender: function(event, element) {
				    	vacationDateArr.push(event.start);
				    }
				});
				
			});
		
		</script>
	</head>
	<body>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp"/>
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/head/hd_menu.jsp"/>
				</div>
				<div class="span9">
					<h1>휴가 신청</h1><br/>
					<div id='calendar'></div>
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>
</html>