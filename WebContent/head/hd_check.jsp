<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type"
			name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Employee check</title>
		<link href="css/bootstrap.css" rel="stylesheet" media="screen">
		<link href="css/bootstrap-responsive.css" rel="stylesheet" media="screen">
	<script>
	
		function goA()
		{
	
				location.href = "./attend.go";

		}
		
		// 브라우저 종류
	       var ie4 = document.all; // Explorer
	       var ns6 = document.getElementById && !document.all; // Netscape
		   
		   // 시간 표시 방법
		   // 0 = 24, 1 = 12
		   var my12_hour = 1;

		   // 날짜를 출력할지 선택
		   // 0 = No, 1 = Yes
		   var DisplayDate = 1;
		   var mn = "일";
		   var yn = "년";

		   var daysOfWeek = ["<font color=red>일</font>", "월", "화", "수", "목", "금", "<font color=blue>토</font>"];
		   var monthsOfYear = ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"];

		   function showClock() {
			   var today = new Date(sessionStorage.getItem("today"));
		       var day = today.getDay(); // 요일(0:일요일, 1:월요일, 2:화요일, 3:수요일, 4:목요일, 5:금요일, 6:토요일)
		       var mday = today.getDate(); // 일
		       var month = today.getMonth(); // 월 (0부터 시작)
		       var year = today.getFullYear(); // 년
		       
		       var hours = today.getHours(); // 시간
		       var minutes = today.getMinutes(); // 분
		       var seconds = today.getSeconds(); // 초

		       // 시간 표시 설정
		       var dn='';
		       if (my12_hour) {
		           dn = "AM";
		           if (hours > 12) { 
		               dn = "PM"; 
		               hours = hours - 12; 
		           }
		           if (hours == 0) {
		               hours = 12; 
		           }
		       } 
		       
		       if (minutes <= 9) { 
		           minutes = "0" + minutes; 
		       }
		       if (seconds <= 9) { 
		           seconds = "0" + seconds; 
		       }

		       // 화면에 출력시킬 날짜 설정
		       myclock = '';
		       if (DisplayDate) { 
		           myclock += year + yn + ' ' + monthsOfYear[month] + ' ' +  mday + mn + ' '  + '('+daysOfWeek[day]+') ' 
		       }
		       myclock += hours + ':' + minutes + ':' + seconds;
		       myclock += ' ' + dn;

		       // 브라우저에 따라 객체에 HTML 추가
		       if (ie4) {
		           liveClock.innerHTML = myclock;
		       } else if (ns6) {
		           document.getElementById("liveClock").innerHTML = myclock;
		               }            

		       setTimeout("showClock()", 1000); //1초마다 실행
		   }
	</script>
	</head>
	<body  onLoad="showClock()">
		<% 
		String res = (String)request.getAttribute("result");
		if(res!=null)
		{
			if(res.equals("true"))
			{
				%>
				<script>
					alert("출근이 완료 되었습니다");</script>
					<%		
			}
			else
			{
				%>
			<script>
				alert("이미출근하셨습니다");</script>
				<%
			}
		}
		%>
		<%
		
			String flag = (String)request.getAttribute("flag");
		%>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp"/>
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/head/hd_menu.jsp"/>
				</div>
				<div class="span9">
					<h1>출근하기</h1>
					<%
						if(flag!=null)
						{
							if(flag.equals("false"))
							{
								%>
									<div class="alert alert-info">
										<button type="button" class="close" data-dismiss="alert">&times;</button>
										출근체크 안하셨습니다!! 출근체크하세요!!
									</div>
								<%
							}
							else if(flag.equals("vacation"))
							{
								%>
								
									<div class="alert">
										<button type="button" class="close" data-dismiss="alert">&times;</button>
										오늘은 휴가이십니다 휴가를 삭제해주세요!!
									</div>
									
								<%
							}
							else
							{
								%> 
								
									<div class="alert alert-success">
										<button type="button" class="close" data-dismiss="alert">&times;</button>
										오늘 출근체크를 하셨습니다!!
									</div>

								<%
							}
						}
					%>
					<div class="hero-unit">
						<h2 id="liveClock"></h2>
						<br/><br/>
						<p><a href="#" class="btn btn-primary btn-large span2 pull-right" 
						onClick="goA()">출근하기</a></p>
					</div>
				
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>

</html>