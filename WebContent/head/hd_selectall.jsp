<%@page import="java.util.Calendar"%>
<%@page import="spring.emp.DayDTO"%>
<%@page import="java.util.List"%>
<%@page import="spring.emp.EmpDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>Head Select All</title>
		<script type='text/javascript'>
		
			$(document).ready(function() {
				$('#myModal').on('shown', function () {
					var calendar = $('#calendar').fullCalendar({
						header: {
							left: 'prev,next today',
							center: 'title',
							right: 'month'
						}, dayClick : function(date, allDay, jsEvent, view) {
							var input = document.getElementsByTagName("input");
							var clickedDay = date.getFullYear() + "/" +
											(date.getMonth()+1 < 10 ? 
												"0" + (date.getMonth()+1):(date.getMonth()+1)) + "/" +
											(date.getDate() < 10 ? 
												"0" + date.getDate() : date.getDate());
													
							input[0].value = clickedDay;
							$('#myModal').modal("hide");
		
							location.replace("selattendall.go?date=" + clickedDay);
						}
					});
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
					<h1>해당부서 출근 기록 조회</h1><br/>
					<form class="form-inline">
						<label class="text"> 
							날짜 : <input type="text" class="input-small" 
									value = "<%=request.getParameter("date") != null ? 
											request.getParameter("date"):"" %>" readonly />
						</label> 
						<a href="#myModal" role="button" class="btn btn-primary" data-toggle="modal">날짜 선택</a> <br/>
					</form>
					
					<% 
						List<DayDTO> list = (List)request.getAttribute("list");
						
						List<String> dep = (List)request.getAttribute("depno");
						List<String> jono = (List)request.getAttribute("jobno");	
			
						System.out.println("ward 1");
						System.out.println(list != null);
						System.out.println("ward 2");
						System.out.println(dep != null);
						System.out.println("ward 3");
						System.out.println(jono != null);
						System.out.println("ward 4");
						
						if(list != null && dep != null && jono != null) {
							System.out.println("ward 5");
							if(list.size() != 0) {
								System.out.println("ward 6");
					%>
									
					<table class="table">
						<caption><h3><%=request.getParameter("date")%></h3></caption>
						<tr>
							<td>부서</td>
							<td>직책</td>
							<td>사번</td>
							<td>이름</td>
							<td>출근시간</td>
						</tr>
						
							<%
							int totalRecSu = (Integer)request.getAttribute("totalRecord");	
							int recSu = 10;
							int totalPage = (int)Math.ceil((double)totalRecSu/recSu);
							int nowPage=0;
							if(request.getParameter("nowPage")!=null)
								nowPage = Integer.parseInt(request.getParameter("nowPage"));
											
							int beginPage = nowPage* recSu;		

								for(int i=beginPage; i<(beginPage + recSu); i++)
								{
									if(i==totalRecSu) break;
									String time = list.get(i).getDay_start();
							
									int hour = Integer.parseInt(time.substring(0, 2));
									int minutes = Integer.parseInt(time.substring(3, 5));
									
									//System.out.println("hour : " + hour);
									//System.out.println("minutes : " + minutes);
									
									if(hour > 9 || (minutes > 0 && hour == 9)) {
										
										%>
										
						<tr class="error">
										
										<%
										
									} else {
									
										%>
										
						<tr class="success">
										
										<%
										
									}
									
									%>
						
							<td><%=dep.get(i) %></td>
							<td><%=jono.get(i) %></td>
							<td><%=list.get(i).getDay_empno() %></td>
							<td><%=list.get(i).getDay_empname() %></td>
							<td><%=list.get(i).getDay_start()%></td>
						
						</tr>
						
							<%	
								}
							%>
							<tr>			
						<td colspan="5" align="right">
						<%if(totalRecSu != 0) {
							for(int i=0; i<totalPage; i++) {
								%>
								<a href="./selattendall.go?date=<%=list.get(i).getDay_today()%>&nowPage=<%=i%>&totalRec=<%=totalRecSu%>">
									<%=i + 1%>
								</a>	
							<% }
							}else{out.println("등록된 게시물이 없습니다.");}%>
						</td>
						</tr>	
					</table>
							
					<%	
							} else {
								
					%>
								<div class="alert alert-block">
									<button type="button" class="close" data-dismiss="alert">&times;</button>
									<h4>출근 기록이 없습니다.</h4>
								</div>
					<%	
							}
						}
					%>
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>

</html>


<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">날짜 선택</h3>
	</div>
	<div class="modal-body">
		<div id='calendar'></div>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
	</div>
</div>