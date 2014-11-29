<%@page import="spring.emp.OvertaskDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>time</title>
	<%

	List <OvertaskDTO> list = (List)request.getAttribute("over_listall");
	List <String> jobname = (List)request.getAttribute("jobnamehd");
	List <String> depname = (List)request.getAttribute("depnamehd");

if(list!=null)
{
%>
	<script>

	function apply(a,b,c)
	{
		location.href = "applytime.go?empno=" + a + "&startday=" + b + "&start=" + c; 
	}
	
	function refuse(a,b,c)
	{
		location.href = "refusetask.go?empno=" + a + "&startday=" + b + "&start=" + c; 
	}
	
	
	function holdtaskapply(a,b,c)
	{
		location.href = "finishtask.go?empno=" + a + "&startday=" + b + "&start=" + c + "&gubun=2"; 
	}
	</script>
	</head>

	<body>

		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp" flush="true"/>
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/head/hd_menu.jsp"/>
				</div>
				<div class="span9">
					<h1>시간외 근무 조회</h1> <br/>	
					<table class="table">
						<tr>
							<td>사번</td>
							<td>부서</td>
							<td>직책</td>
							<td>이름</td>
							<td>시작날짜</td>
							<td>시작시간</td>
							<td>업무내용</td>
							<td>종료날짜</td>
							<td>종료시간</td>
							<td>비고</td>
							
						</tr>
					<%	

					int totalRecSu = (Integer)request.getAttribute("totalRecord");	
					int recSu = 7;
					int totalPage = (int)Math.ceil((double)totalRecSu/recSu);
					int nowPage=0;
					if(request.getParameter("nowPage")!=null)
						nowPage = Integer.parseInt(request.getParameter("nowPage"));
									
					int beginPage = nowPage* recSu;		

								
						for(int i=beginPage; i<(beginPage + recSu); i++)
						{
							if(i==totalRecSu) break;
							%>
								<tr>	
								<td><%=list.get(i).getTask_empno()%></td>
								<td><%=depname.get(i)%></td>
								<td><%=jobname.get(i)%></td>
								<td><%=list.get(i).getTask_empname()%></td>
								<td><%=list.get(i).getTask_startday()%></td>
								<td><%=list.get(i).getTask_start()%></td>
								<td><%=list.get(i).getTask_cont()%></td>
							
								
								
								
								<td><%if(list.get(i).getTask_finishday()==null)
								{
									%>...<%
								}
								else
								{
									%><%=list.get(i).getTask_finishday()%><%
								}
								%>
								</td>
								
								<td><%if(list.get(i).getTask_finish()==null)
								{
									%>...<%
								}
								else
								{
									%><%=list.get(i).getTask_finish()%><%
								}
								%>
							
								</td>
									
								<%
								if(list.get(i).getTask_res().equals("0"))
								{
									%>
									<td> <button class="btn btn-info" onClick="apply('<%=list.get(i).getTask_empno() %>',
																					'<%=list.get(i).getTask_startday() %>',
																						'<%=list.get(i).getTask_start() %>'																						
																						 )">승인</button>&nbsp;&nbsp;
										<button class="btn btn-info" onClick="refuse('<%=list.get(i).getTask_empno() %>',
																					'<%=list.get(i).getTask_startday() %>',
																						'<%=list.get(i).getTask_start() %>'																						
																						 )">거절</button>												 
																						 
																						 </td>
							<%
								}
								else if(list.get(i).getTask_res().equals("1") || list.get(i).getTask_res().equals("2"))
								{ %>
									<td>승인 완료</td>
							<%	}
								

								
								else if(list.get(i).getTask_res().equals("3"))
								{ %>
									<td> <button class="btn btn-info" onClick="holdtaskapply('<%=list.get(i).getTask_empno() %>',
																					'<%=list.get(i).getTask_startday() %>',
																						'<%=list.get(i).getTask_start() %>'																						
																						 )">보류시간확인</button></td>
							<%	} 
								
								else if(list.get(i).getTask_res().equals("4"))
								{ %>
									<td>거절 완료</td>
							<%	} %>
							
								</tr>
							<%
						}
						%>
						<tr>			
						<td colspan="10" align="right">
						<%if(totalRecSu != 0) {
							for(int i=0; i<totalPage; i++) {
								%><a href="./overtaskselview.go?nowPage=<%=i%>&totalRec=<%=totalRecSu%>">
									<%=i + 1%>
								</a>	
							<% }
							}else{out.println("등록된 게시물이 없습니다.");}%>
						</td>
						</tr>	
					</table>
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>
	<%} %>
</html>