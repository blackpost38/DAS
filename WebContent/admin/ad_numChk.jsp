<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="spring.emp.EmpDTO, java.util.*" %>
<%@ page import="spring.emp.EmpDAO, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
			name="viewport" content="width=device-width, initial-scale=1.0">
		<title>index</title>
		<link href="css/bootstrap.css" rel="stylesheet" media="screen">
		<link href="css/bootstrap-responsive.css" rel="stylesheet" media="screen">
		<script type="text/javascript">
		function dd(val)
		{
			if(val=="")
				alert("입력해주세요!!!");	
			else	
				location.href="finalchkempnum.go?emp_no="+val;
		}
		function sendVal(val)
		{
			 window.opener.document.empInfoAdd.emp_no.value=val;
			
			self.close();
		}
		
		// 사원번호 숫자만 입력
		function numChk(){
			if(event.keyCode<48|| event.keyCode>57) {
				event.returnValue=false;
			}
		}
		</script>
	</head>
	<body>
	
		<div class="container-fluid">

			<div class="row">
				<div class="span3">
				</div>
				<div class="span9">
					<table>
					<tr>
						 	<td align="center" valign="middle">사원번호</td><td><input type="text" name="EMP_NO"  maxlength="8" onkeypress="numChk();" 
					style='IME-MODE:disabled;'></td>
						 	<td><button class="btn btn-primary" onClick="dd(EMP_NO.value)">조회</button></td>
					</tr>

					</table>
	
					<center>
					
												
					<%
						String res = (String)request.getAttribute("result");
			
						if(res != null)
						{
							if(res.equals("true"))
							{
								String empno = (String)request.getAttribute("empno");
								%>
								<script> 		
									alert("등록할수있는 사번입니다.");
								</script>
									<center>
									<input type="text" name="txt" readonly value="<%= empno %>"><br>
									<button class="btn btn-primary" onClick="sendVal(txt.value)">등록</button>
									</center>
								<%	
								
							}
							else
							{
								%>
								<script> alert("이미등록된 사번입니다.");</script>		
								<%	
							}
				
						}
		
	
					%>
					
					</center>	
			
				</div>
			</div>

		</div>
		<script src="js/bootstrap.js"></script>
		<%
	
		%>
	</body>
</html>