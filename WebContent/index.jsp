<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="template/HeadTagSetting.jsp"/>
		<title>index</title>
		<script type="text/javascript" >
		
			var today;
			$.post(location.href, function(data,status,xhr){
				today = new Date(xhr.getResponseHeader("Date"));
				sessionStorage.setItem("today", today);
			});
			// 라디오 버튼에 체크를 했는지를 확인.
			// 체크가 안되어 있으면 경고창, 체크되어 있으면 Form Action을 취한다.
			function check()
			{
				document.forms[0].elements[0].checked = true;
				document.login.emp_id.focus();
			}

			function checkInput() {
				var isChecked = false;
				
 				for(var i = 0; i < document.forms[0].elements.length; i++){
 					if(document.forms[0].elements[i].checked)	isChecked = true;
 	
				}
 				if(document.forms[0].elements[1].checked)
 					document.forms[0].action = "admin.go";
 				
				if (isChecked) {
					document.forms[0].submit();
				} else {
					alert("체크해주세요!!!!!");
				}
				
			}
	
		</script>
	</head>
		<% 
		String res = (String)request.getAttribute("res");
		if(res!=null)
		{
			if(res.equals("id"))
			{
				%>
				<script>
				alert("아이디를 확인하세요!!");</script>
				<% 
			}
			else if(res.equals("pwd"))
			{
				%>
				<script>
				alert("PWD를 확인하세요!!");</script>
				<% 
			}
		}
		%>
	<body onLoad="check()">
		<div class="container-fluid">
			<br><br><br><br>
			<div class="row">
				<div class="span3">
				</div>
				<div class="span9">
					<form name="login" action="result.go" method="post">
						<table width="737" height="389"  background="img/loginForm2.jpg" style="border-radius:20px;">
							<tr align="right">
								<td>
									<input type="radio" name="emp_jobno">사용자
									<input type="radio" name="emp_jobno">관리자<p/>
									<span>ID</span>&nbsp;&nbsp;<input type="text" name="emp_id"/><br/>
									<span>PW</span>&nbsp;&nbsp;<input type="password" name="emp_pwd"/><br/>
									<input class="btn" type="submit" onClick="checkInput()" value="로그인"/>
									&nbsp;&nbsp; <input class="btn" type="reset" value="취소"/><br/>
							
								</td>
							</tr>
						</table> <br>
						<br>
						<img src="img/bottomFooter.jpg"/>
					</form>	
				</div>
			</div>
			<jsp:include page="template/BottomTemplate.jsp"/>
		</div>
	</body>
</html>