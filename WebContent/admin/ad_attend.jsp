<%@ page import="spring.emp.DayDTO, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<script>
			function getATT(a) {
		
				document.frm.day_empno.value = a;
				
				
				document.frm.day_today.value = document.frm.cal.value;
				document.frm.action = "getatt.go";
				document.frm.submit();
			}
			function delATT(empno, today)
			{
				if (!confirm("출근기록을 삭제하시겠습니까?"))	return;
				location.href="deleteatt.go?today="+today+"&empno="+empno;	
				
			}
			function updATT(start, empno, today)
			{
				if(start=="")
					alert("선택해주세요!!!");
				else {
			
					location.href="changeatt.go?today="+today+"&empno="+empno+"&start="+start;	
				}
			}
			function aa(a,b){
				
				$("#myModal").modal();
				document.getElementById('empno').value = a;
				document.getElementById('today').value = b;
			}
			$(document).ready(function() {
				$('#myModal2').on('shown', function () {
					var calendar = $('#calendar').fullCalendar({
						header: {
							left: 'prev,next today',
							center: 'title',
							right: 'month'
						}, dayClick : function(date, allDay, jsEvent, view) {
							
							var input = document.getElementById("cal");
							var clickedDay = date.getFullYear() + "/" +
											(date.getMonth()+1 < 10 ? 
												"0" + (date.getMonth()+1):(date.getMonth()+1)) + "/" +
											(date.getDate() < 10 ? 
												"0" + date.getDate() : date.getDate());
													
							input.value = clickedDay;
							$('#myModal2').modal("hide");
						}
					});
				});
			});
		
	
		</script>
	</head>
	<body>
		<%
		String res = (String)request.getAttribute("delresult");
		if(res!=null)
		{
			if(res.equals("true"))
			{
				%><script> alert("삭제성공!"); </script><%
			}
			else
			{
				%><script> alert("삭제실패!"); </script><%
			}
		}
	%>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp" />
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/admin/ad_menu.jsp" />
				</div>
				<div class="span9">
					<h1>출근 기록 관리</h1><br />
					<form name="frm" method="post" class="form-inline" >
						<input type="hidden" name="day_empno"> 
						<input type="hidden" name="day_today">
						사번 <input type="text" name="empno" id="empno">
						날짜 <input type="text" name="cal" id="cal" readonly>
						<a href="#myModal2" role="button" class="btn btn-primary" data-toggle="modal">날짜선택</a> <br/>
					</form>
					<a href="#" class="btn btn-large btn-primary" onClick="getATT(document.getElementById('empno').value)">조회</a>
					
					
						<% 
							List <DayDTO> list = (List)request.getAttribute("list");
							if(list != null) {
								if(list.size() != 0) {
						%>
						
					<table class="table">
						<tr>
						<td>부서</td>
							<td>직책</td>
							<td>사번</td>
							<td>날짜</td>
							<td>이름</td>
							<td>출근시간</td>
							<td>출근시간 수정/삭제</td>
						</tr>
						
						<%
									for(DayDTO d : list) {
						%>
						
						<tr>
							<td><%=d.getDep_name() %></td>
							<td><%=d.getJob_name() %></td>
							<td><%=d.getDay_empno() %></td>
							<td><%=d.getDay_today() %></td>
							<td><%=d.getDay_empname() %></td>
						
							<td><%=d.getDay_start()%></td>
							<td><a onClick="aa('<%=d.getDay_empno()%>', '<%=d.getDay_today()%>')" class="btn btn-primary" data-toggle="modal">수정</a>
						    <button class="btn btn-primary" onClick="delATT('<%=d.getDay_empno()%>', '<%=d.getDay_today()%>')">삭제</button></td>
			
						</tr>
						
						<%	
									}
						%>
						
					</table>
				
				<%	
							}	
						}
				%>
					
				</div>
				<div class="span1"></div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp" />
		</div>
	</body>
</html>

<!-- Modal -->
<div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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




<!-- Modal -->
<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">출근시간수정</h3>
	</div>
	<div class="modal-body">
		<form class="form-inline">
			수정시간
					<select name="start" id="start">
						<% 
									for(int i=0; i<24; i++)
									{
										
										for(int j=0; j<60; j+=10)
										{
											String hour = ""+i;
											String min = ""+j;
											if(i < 10)
											{
											   hour = "0"+i;
											}
										
											if(j == 0)
											{
												min = "00";
											}						
											%>									
											<option><%= hour %>:<%= min%></option><%
										}
									}
								%>
								</select>
		
						

			<input type="hidden" class="span2" name="empno" id="empno">
			<input type="hidden" class="span2" name="today" id="today">
			
			<input type="button" class="btn btn-primary" value="수정"	onClick="updATT(document.getElementById('start').value, document.getElementById('empno').value, document.getElementById('today').value);">
	
		</form>
		
		
			<%
			String result = (String)request.getAttribute("result");
    		if(result != null)
			{
    			%>
    			<script>$('#myModal').modal();</script>
    			<%
				if(result.equals("true"))
				{
					
					%>
					<div class="alert alert-success">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>성공!</strong><br/> 수정완료 되었습니다.
					</div>
				
					
					<%	
					
				} else{
					%>
					<div class="alert">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>경고!</strong><br/> 수정실패 되었습니다.
					</div>
					<%	
				}
	
			}

		%>
		
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">닫기</button>
	</div>
</div>



