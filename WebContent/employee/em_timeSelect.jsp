<%@page import="spring.emp.OvertaskDTO"%>
<%@page import="spring.emp.OverworkDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>time</title>
		<script>

		
		
		function finishTask(a,b,c)
		{
			location.href = "finishtask.go?empno=" + a + "&startday=" + b + "&start=" + c  + "&gubun=1"; 
		}
		function holdTime(a,b,c)
		{	
	
			location.href="holdontask.go?empno=" + a + "&startday=" + b + "&start=" + c;
		}
		
		

		</script>
		
	</head>
	<%
	
	
	List <OvertaskDTO> list = (List)request.getAttribute("over_list");
	List <String> jobname = (List)request.getAttribute("jobname");
	List <String> depname = (List)request.getAttribute("depname");
	List <OverworkDTO> work_list = (List)request.getAttribute("over_work");
	String today = (String)request.getAttribute("today");
	String now = (String)request.getAttribute("now");
	
	if(list!=null)
	{
	%>
	<body>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp" flush="true"/>
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/employee/em_menu.jsp"/>
				</div>
				<div class="span9">
					<h1>시간외 근무 조회</h1> <br/>	
				
					<div class="alert alert-error">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<h5>월당 최대 신청시간은 20시간(1200분) 입니다.</h5>
					</div>
					
					<table class="table">
						<tr>
							<td>사번</td>
							<td>부서</td>
							<td>직책</td>
							<td>이름</td>
							<td>시작날짜</td>
							<td>시작시간</td>
							<td>업무내용</td>
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
					
								<%
								if(list.get(i).getTask_res().equals("0"))
								{
									%>
									<td><span>승인대기중</span> <button class="btn btn-info" onClick="holdTime('<%=list.get(i).getTask_empno()%>',
																												'<%=list.get(i).getTask_startday()%>',
																												'<%=list.get(i).getTask_start()%>'
																												)">&nbsp;
																												수동입력(미승인시)</button></td>
								<%
								}
								else if(list.get(i).getTask_res().equals("1"))
								{ 
									if(today.equals(list.get(i).getTask_startday()))
									{
			
										String starttime = list.get(i).getTask_start();
										int cut = starttime.indexOf(':');
										String h = starttime.substring(0, cut);
										String m = starttime.substring(cut+1);
										
										int start = Integer.parseInt(h+m);
								
										h = now.substring(0, cut);
										m = now.substring(cut+1);
										int nowtime = Integer.parseInt(h+m);
									
									
										if(start >= nowtime)
										{
											%>	
											<td> 시작시간이아닙니다 </td>
											<%
										
										}
										else
										{
											%>
											<td><button class="btn btn-info" onClick="finishTask('<%=list.get(i).getTask_empno() %>',
																								'<%=list.get(i).getTask_startday() %>',
																								'<%=list.get(i).getTask_start() %>'	)">근무 종료</button></td>
											<%
										}
									}
									else
									{
										%>
										<td> 오늘근무가아닙니다 </td>
										<%
									}
								}
								else if(list.get(i).getTask_res().equals("2"))
								{
									%>
									
									<td> 근무 종료 </td>
									<%
								}
								else if(list.get(i).getTask_res().equals("4"))
								{
									%>
									
									<td> 거절됨 </td>
									<%
								}
								else 
								{
									%>
									
									<td> 보류확인 대기중 </td>
									<%
								}
						} 
								%>
							</tr>
				
						<tr>			
						<td colspan="8" align="right">
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
					<br><br>
					<%
					if(work_list!=null)
					{	

					%>
					<table class="table">
					<tr>
					<td>년도</td>
					<td>월별</td>
					<td>월 시간외근무시간(분)</td>
					<td>월 시간외근무수당</td>
					</tr>
					<%
					
					int totalRecSus = (Integer)request.getAttribute("totalRecords");	
					int recSus = 3;
					int totalPages = (int)Math.ceil((double)totalRecSus/recSus);
					int nowPages=0;
					if(request.getParameter("nowPages")!=null)
						nowPages = Integer.parseInt(request.getParameter("nowPages"));
					
					int beginPages = nowPages* recSus;		
					
					for(int i=beginPages; i<(beginPages + recSus); i++)
					{
						if(i==totalRecSus) break;	
						%> 
						<tr> 
						<td><%= work_list.get(i).getOver_curyear()+"년" %> </td>
						<td><%= work_list.get(i).getOver_curmonth()+"월"%> </td>
						<td><%= work_list.get(i).getOver_max()+"분"%> </td>
						<td><%= "￦"+work_list.get(i).getOver_max()*250%> </td>
						</tr>
						<%
					}
					%>
					<tr>			
					<td colspan="4" align="right">
					<%if(totalRecSus != 0) {
						for(int i=0; i<totalPages; i++) {
							%><a href="./overtaskselview.go?nowPages=<%=i%>&totalRecs=<%=totalRecSus%>">
								<%=i + 1%>
							</a>	
						<% }
						}else{out.println("등록된 게시물이 없습니다.");}%>
					</td>
					</tr>	
					</table><%
				}
			}
					%>
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
		
	</body>

</html>