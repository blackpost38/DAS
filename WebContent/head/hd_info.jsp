<%@page import="java.util.Calendar"%>
<%@page import="spring.emp.DayDTO"%>
<%@page import="java.util.List"%>
<%@page import="spring.emp.EmpDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp" flush="true"/>
		<title>Employee main</title>
		<script type="text/javascript" src="../js/jquery-1.9.1.js"></script>
	</head>
	<%
	
		List <EmpDTO> list = (List)request.getAttribute("list");
		List <String> depno = (List)request.getAttribute("depno");
		List <String> jobno = (List)request.getAttribute("jobno");

	%>
	<body>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp" flush="true"/>
			<div class="row">
			
				<div class="span3">
					<jsp:include page="../template/head/hd_menu.jsp"/>
				</div>
				<div class="span9">
					<h1>사원정보 조회</h1> <br/>			
					<table class="table">
						<tr>
							<td>사번</td>
							<td>이름</td>
							<td>부서</td>
							<td>직급</td>
							<td>입사일</td>		
						</tr>
				<%
				for(int i=0; i<list.size(); i++)
				{
					%>
						<tr>
					
					<td><%=list.get(i).getEmp_no()%></td>
					<td><%=list.get(i).getEmp_name() %></td>
					<td><%=depno.get(i)%></td>
					<td><%=jobno.get(i)%></td>
					<td><%=list.get(i).getEmp_hiredate()%></td>
					
					</tr>
				<%
				}		
				%>
			</table>
				</div>
		
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>
</html>