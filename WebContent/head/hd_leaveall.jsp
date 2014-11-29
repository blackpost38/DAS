<%@page import="java.util.Calendar"%>
<%@page import="spring.emp.DayDTO"%>
<%@page import="java.util.List"%>
<%@page import="spring.emp.EmpDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>Head Leave All</title>
		
		<script type='text/javascript'>
	
			var vacationDateArr = [];
			$(document).ready(function() {
				
	<% 
		List <DayDTO> list = (List)request.getAttribute("list");
	%>
				
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
					events: [
						<% 
						
							Calendar cal = Calendar.getInstance();
							System.out.println(cal.get(Calendar.YEAR) + " // " + cal.get(Calendar.MONTH) + " // " + cal.get(Calendar.DAY_OF_MONTH));
							
							for(int i=0; i<list.size(); i++){ 
								String date = list.get(i).getDay_today();
								int index = date.indexOf('/');
								String year = date.substring(0, index);
								date = date.substring(index+1);
								index = date.indexOf('/');
								String month = date.substring(0, index);
								index = date.indexOf('/');
								String day = date.substring(index+1);
								System.out.println(list.get(i).getDay_id());
								
						%>
						
						{
							id: <%=list.get(i).getDay_id()%>,
							title: 'ÈÞ°¡ - <%=list.get(i).getDay_empname()%>', 
							start: new Date(<%=year%>, <%=Integer.parseInt(month)-1%>, <%=day%>)
						},
						
						<% } %>
						
						{}
					], eventRender: function(event, element) {
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
					<h1>ºÎ¼­º° ÈÞ°¡ Á¶È¸</h1><br/>
					<div id='calendar'></div>
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>
</html>