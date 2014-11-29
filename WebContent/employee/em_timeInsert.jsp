<%@page import="spring.emp.EmpDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>time</title>
	</head>
	
	<script>
		
	var today = new Date(sessionStorage.getItem("today"));
//	$.post(location.href, function(data,status,xhr){
//		alert(xhr.getResponseHeader("Date"));
//		today = new Date(xhr.getResponseHeader("Date"));
//	});
	
		<%
			System.out.println("time insert");
			HttpSession se = request.getSession();
		
			EmpDTO dto = (EmpDTO)se.getAttribute("emp");
		%>
	
	function goTask1()
	{
		if(document.overtask.task_cont.value !="" &&
				document.overtask.task_startday.value !="")
			{
				document.overtask.method="post";
				document.overtask.action="overtask.go";
				document.overtask.submit();	
			}
			else		
				alert("값을 입력하지 않으셨습니다.");
	}


	$(document).ready(function() {
		
		$('#myModal').on('shown', function () {
			var calendar = $('#calendar').fullCalendar({
				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month'
				}, dayClick : function(date, allDay, jsEvent, view) {
					
					if (date < today &&
						!(date.getFullYear() == today.getFullYear() &&
						 date.getMonth() == today.getMonth() &&
						 date.getDate() == today.getDate())){
						alert("오늘 이후만 가능합니다.");
						return;
					}
					
					var input = document.getElementById("task_startday");
					var clickedDay = date.getFullYear() + "/" +
									(date.getMonth()+1 < 10 ? 
										"0" + (date.getMonth()+1):(date.getMonth()+1)) + "/" +
									(date.getDate() < 10 ? 
										"0" + date.getDate() : date.getDate());
											
					input.value = clickedDay;
					$('#myModal').modal("hide");
				}
			});
		});
	});
	
	
	</script>

	<body>
	<%
		String result = (String)request.getAttribute("result");
		System.out.println("result : " + result);
		if(result!=null)
		{
			if(result.equals("true"))
			{
				%><script>alert("시간외근무가 등록되었습니다.")</script> <%
			}
			else if(result.equals("max"))
			{
				%><script>alert("이번달 최대 20시간을 채우셨습니다!")</script> <%
			}
			else if(result.equals("time"))
			{
				%><script>alert("같은시간에 등록한 시간외근무가 있습니다. 시간을 확인해 주세요.")</script> <%
			}
			else
			{
				%><script>alert("오늘날짜로 등록한시간외근무가 중복됩니다.")</script> <%
			}
		}
	
	%>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp" flush="true"/>
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/employee/em_menu.jsp"/>
				</div>
				<div class="span9">
					<h1>시간외 근무 등록</h1> <br/>
					<div class="row">
						<div class="span6">
						<form name="overtask"
				 					class="form-horizontal pull-right">
				 				<div class="control-group">
									<label class="control-label" for="task_empno">사원번호</label>
									<div class="controls">
										<input type="text" name = "task_empno" id = "task_empno" value="<%= dto.getEmp_no()%>" readonly/>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="task_empname">사원이름</label>
									<div class="controls">
										<input type="text" name = "task_empname" id="task_empname" value="<%= dto.getEmp_name()%>" readonly/>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="task_startday">시작날짜</label>
									<div class="controls">
										<input type="text" name="task_startday" id="task_startday" readonly>
									 	<a href="#myModal" role="button" class="btn btn-primary" data-toggle="modal">선택</a>
								 	</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="task_start">시작시간</label>
									<div class="controls">
										<select name="task_start" id="task_start">
										<% 
											for(int i=0; i<24; i++)
											{
												
												for(int j=0; j<60; j+=30)
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
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="task_cont">업무내용</label>
									<div class="controls">
										<textarea class="span3" rows="7" 
										name="task_cont" id = "task_cont">
										</textarea>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"></label>
									<div class="controls">
										<div class="alert alert-error">
											<button type="button" class="close" data-dismiss="alert">&times;</button>
											<h6>월당 최대 신청시간은 20시간 입니다.</h6>
										</div>
									</div>
								</div>
								<input type="button" class="btn btn-primary pull-right" onclick="goTask1()" value="등록하기">	
							</form>
						</div>
					</div>
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