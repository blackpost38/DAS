<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>admin employee insert</title>
		<script type="text/javascript">
		
			function dd(val)
			{
				if(val=="")
					alert("입력해주세요!!!");
				else {
					location.href="finalchkempnum.go?emp_no="+val;	
				}
			}
			
			function dd1(val)
			{
				if(val=="")
					alert("입력해주세요!!!");
				else {
					location.href="finalchkempnum.go?emp_id="+val;
				}
			}
			
			function sendVal(val)
			{
				document.empInfoAdd.emp_no.value=val;
				$('#myModal').modal('hide');
			}
			
			function sendVal1(val)
			{
				document.empInfoAdd.emp_id.value=val;
				$('#myModalThird').modal('hide');
			}
			
			// 사원번호 숫자만 입력
			function numChk(){
				if(event.keyCode<48|| event.keyCode>57) {
					event.returnValue=false;
				}
			}
		
			// 날짜 입력폼 '__/__/__' 추가
			function addSlash(dateCtl) {
				var txt = window.event.keyCode;
				if (txt >= 48 && txt <= 57) {
					if (dateCtl.value.length == 4 || dateCtl.value.length == 7) {
						dateCtl.value += "/";
					}
					window.event.returnValue = true;
				} else {
					window.event.returnValue = false;
				}
			}
			
			// 사원번호 숫자만 입력
			function numChk(){
				if(event.keyCode<48|| event.keyCode>57) {
					event.returnValue=false;
				}
			}
			
			
			function blankChk(){		
				if(document.empInfoAdd.emp_no.value != "" && 
					document.empInfoAdd.emp_id.value != "" &&
					document.empInfoAdd.emp_name.value != "" &&
					document.empInfoAdd.emp_pwd.value != "" &&
					document.empInfoAdd.emp_hiredate.value != "" &&
					document.empInfoAdd.emp_depno.value != "" &&
				    document.empInfoAdd.emp_jobno.value != ""){
					
					document.empInfoAdd.method ="post";
					document.empInfoAdd.action = "empIns.go";
					document.empInfoAdd.submit();
				
					
				}else{		
					alert("값을 입력하지 않으셨습니다.");
				}
				
			}
			
			$(document).ready(function() {
				$('#myModalSecond').on('shown', function () {
					var calendar = $('#calendar').fullCalendar({
						header: {
							left: 'prev,next today',
							center: 'title',
							right: 'month, year'
						}, dayClick : function(date, allDay, jsEvent, view) {
							
							var input = document.getElementById("emp_hiredate");
							var clickedDay = date.getFullYear() + "/" +
											(date.getMonth()+1 < 10 ? 
												"0" + (date.getMonth()+1):(date.getMonth()+1)) + "/" +
											(date.getDate() < 10 ? 
												"0" + date.getDate() : date.getDate());
													
							input.value = clickedDay;
							$('#myModalSecond').modal("hide");
						}
					});
				});
			});
			
		</script>
	</head>
	<body>
	<%
		String res = (String)request.getAttribute("count");
		if(res!=null)
		{
			if(res=="true")
			{
				%><script>alert("사원이등록되었습니다..!!");</script>	<%
			}
			else
			{ %>
				<script> alert("사원이등록되었습니다..!!");</script>	<%
			}
		}
	
	%>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp"/>
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/admin/ad_menu.jsp"/>
				</div>
				<div class="span9">
					<div class="page-header">
						<h1>사원추가</h1>
					</div>
					<div class="row">
						<div class="span6">
							<form class="form-horizontal pull-right" name="empInfoAdd">
								<div class="control-group">
									<label class="control-label" for="emp_no">사원번호</label>
									<div class="controls">
										<input type="text" class="span2" id="emp_no" name="emp_no" 
										maxlength="8" readonly onkeypress="numChk();" style='IME-MODE:disabled;'>
										<!-- <input type="button" class="btn btn-primary"
								 		onClick="empNumChk()" value="중복체크"> -->
										<a href="#myModal" role="button" class="btn btn-primary" data-toggle="modal">중복체크</a> <br/>
									 </div>
								</div>
								<div class="control-group">
									<label class="control-label" for="emp_id">사원ID</label>
									<div class="controls">
										<input type="text" class="span2" id="emp_id" name="emp_id" readonly>
										<a href="#myModalThird" role="button" class="btn btn-primary" data-toggle="modal">중복체크</a> <br/>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="emp_name">사원이름</label>
									<div class="controls">
										<input type="text" class="span3" id="emp_name" name="emp_name">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="emp_pwd">사원PWD</label>
									<div class="controls">
										<input type="password" class="span3" id="emp_pwd" name="emp_pwd">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="emp_hiredate" >입사일</label>
									<div class="controls">
										<input type="text" class="span2" id="emp_hiredate" name="emp_hiredate" readonly>
										<a href="#myModalSecond" role="button" class="btn btn-primary" data-toggle="modal">날짜선택</a>
								 	</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="emp_depno">부서</label>
									<div class="controls">
										<select id="emp_depno" name="emp_depno" class="span3">
											<option value="">부서선택</option>
											<option value="10">총무부</option>
											<option value="20">영업부</option>
											<option value="30">기획부</option>
											<option value="40">관리부</option>
											<option value="50">인사부</option>
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="emp_jobno">직책</label>
									<div class="controls">
										<select id="emp_jobno" name="emp_jobno" class="span3">
		  									<option value="">직책선택</option>
		  									<option value="1">사원</option>
		  									<option value="2">대리</option>
		  									<option value="3">과장</option>
		  									<option value="4">차장</option>
		  									<option value="5">부장</option>
		  							
										</select>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label" for="emp_total">총근무시간</label>
									<div class="controls">
										<input type="text" class="span3" id="emp_total" name="emp_total" value="0">
									</div>
								</div>
								<input type="button" value="사원추가" class="btn btn-primary pull-right" onClick="blankChk()">
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
		<h3 id="myModalLabel">중복 체크</h3>
	</div>
	<div class="modal-body">
		<form class="form-inline">
			사원번호
			<input type="text" class="span2" name="empNo" id="empNo" 
			maxlength="8"  onkeypress="numChk()">
			<input type="button" class="btn btn-primary" value="조회"
			onClick="dd(document.getElementById('empNo').value);"/>
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
					String empno = (String)request.getAttribute("empno");
					%>
					<div class="alert alert-success">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>성공!</strong><br/> 등록할 수 있는 사번입니다.
					</div>
					<form class="form-inline">
						<input type="text" class="span2" name="txt" readonly value="<%= empno %>">
						<input type="button" class="btn btn-primary" 
						onClick="sendVal(txt.value)" value = "등록"/>
					</form>
					
					<%	
					
				} else{
					%>
					<div class="alert">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>경고!</strong><br/> 이미 등록된 사번입니다.
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


<!-- Modal -->
<div id="myModalSecond" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
<div id="myModalThird" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="myModalLabel">중복 체크</h3>
	</div>
	<div class="modal-body">
		<form class="form-inline">
			사원ID
			<input type="text" class="span2" name="empId" id="empId">
			<input type="button" class="btn btn-primary" value="조회"
			onClick="dd1(document.getElementById('empId').value);"/>
		</form>
		<%
			String result1 = (String)request.getAttribute("result1");
    		if(result1 != null)
			{
    			%>
    			<script>$('#myModalThird').modal();</script>
    			<%
				if(result1.equals("true"))
				{
					String empid = (String)request.getAttribute("empid");
					%>
					<div class="alert alert-success">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>성공!</strong><br/> 등록할 수 있는 사번입니다.
					</div>
					<form class="form-inline">
						<input type="text" class="span2" name="txt2" readonly value="<%= empid %>">
						<input type="button" class="btn btn-primary" 
						onClick="sendVal1(txt2.value)" value = "등록"/>
					</form>
					
					<%	
					
				} else{
					%>
					<div class="alert">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>경고!</strong><br/> 이미 등록된 ID입니다.
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