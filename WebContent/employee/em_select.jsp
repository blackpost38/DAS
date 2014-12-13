<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="spring.emp.DayDTO"%>
<%@page import="java.util.List"%>
<%@page import="spring.emp.EmpDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>Employee select</title>
		
		<script type='text/javascript'>

			$(document).ready(function() {
				
				<% 
				
					HttpSession se = request.getSession();
					List<DayDTO> list = (List)se.getAttribute("list");
					List<DayDTO> listVacation = (List)se.getAttribute("listVacation");
					
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
								

								String time = list.get(i).getDay_start();
								int hour = Integer.parseInt(time.substring(0, 2));
								int minutes = Integer.parseInt(time.substring(3, 5));
								
								System.out.println("hour: " + hour + "//minutes: " + minutes);
								String eventColor = "#dff0d8";
								
								if(hour > 9 || (minutes > 0 && hour == 9)) {
									eventColor = "#f2dede";
								} else {
									eventColor = "#dff0d8";
								}
						%>
						
						{
							id: <%=list.get(i).getDay_id()%>,
							title: '<%= list.get(i).getDay_start()%>', 
							start: new Date(<%=year%>, <%=Integer.parseInt(month)-1%>, <%=day%>),
							backgroundColor: "<%=eventColor%>",
							borderColor: "<%=eventColor%>",
							textColor: "gray"
						},
						
						<% } %>
						{}
					], dayRender: function( date, cell ) { 
				    	
						<%
						
							System.out.println(cal.get(Calendar.YEAR) + " // " + cal.get(Calendar.MONTH) + " // " + cal.get(Calendar.DAY_OF_MONTH));
							
							for(int i=0; i<listVacation.size(); i++){ 
								String date = listVacation.get(i).getDay_today();
								System.out.println(new Date(date));
								
						%>
						
							if (date.getTime() == "<%=new Date(date).getTime()%>") {
								$(cell).css('background-color', '#f2dede');
								var children = $(cell).children().children()[1];
								$(children).html("<h1 class='text-center text-error'>휴</h1>");
						    }
						
				    	<%	} %>
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
					<jsp:include page="../template/employee/em_menu.jsp"/>
				</div>
				<div class="span9">
				<div id='calendar'></div>
				</div>
			</div>	
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>

</html>