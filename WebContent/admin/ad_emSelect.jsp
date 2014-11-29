<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="spring.emp.EmpDTO, java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<jsp:include page="../template/HeadTagSetting.jsp"/>
		<title>admin employee select</title>
	</head>
	<script>
	
		
		function send(val, str){
		
			if (val == "name") 	
			{
				document.frm.emp_name.value =	str;
			}
			else if (val == "dept")
			{
				
				document.frm.dep_name.value =	str;
			}
			else if (val == "sabun")
			{
				document.frm.emp_no.value = str;
			}
			document.frm.action = "ad_search.go";
			document.frm.submit();
			
	
		}
	

	</script>
	<body>
		<div class="container-fluid">
			<jsp:include page="../template/TopTemplate.jsp"/>
			<div class="row">
				<div class="span3">
					<jsp:include page="../template/admin/ad_menu.jsp"/></div>
				<div class="span9">
					<h1>사원조회메인</h1>
					<form name="frm" class="form-inline"
						method="post" >
						<select name="searchKey">
	                        <option value="all">전체</option>
	                        <option value="name">이름</option>
	                        <option value="dept">부서</option>
	                        <option value="sabun">사번</option>
	                    </select>
	                    <div class="input-append">
							<input class="span2" name="txt" type="text">
							<input type="button" class="btn btn-primary" value="검색" onclick="send(searchKey.value, txt.value)" >
						</div>
	                    <input type="hidden" name="emp_name">
	                    <input type="hidden" name="dep_name">
	                    <input type="hidden" name="emp_no">
					</form>	
					<table class="table">
						<tr>
							<td>사번</td>
							<td>이름</td>
							<td>아이디</td>
							<td>부서</td>
							<td>직책</td>
							<td>입사일</td>
						</tr>
			
			<% 

								
			List<EmpDTO> dtoL = (List)request.getAttribute("adname"); 
			List<EmpDTO> reDTO = (List)request.getAttribute("reDTO"); 
	
			if(reDTO==null)
			{
				if(dtoL!=null)
				{
					HttpSession se = request.getSession();
					
					se.setAttribute("reaDTO", dtoL);
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
						%>
				
							<tr>
								<td><%=dtoL.get(i).getEmp_no() %></td>
								<td><%=dtoL.get(i).getEmp_name()%></td>
								<td><%=dtoL.get(i).getEmp_id()%></td>
								<td><%=dtoL.get(i).getDep_name() %></td>
								<td><%=dtoL.get(i).getJob_name() %>
								<td><%=dtoL.get(i).getEmp_hiredate()%></td>
															
								
							</tr>
							<%
							
				
						}
				
					
						%>
							<tr>			
							<td colspan="6" align="right">
							<%if(totalRecSu != 0) {
								for(int i=0; i<totalPage; i++) {
									%><a href="./ad_research.go?nowPage=<%=i%>&totalRec=<%=totalRecSu%>">
										<%=i + 1%>
									</a>	
								<% }
								}else{out.println("등록된 게시물이 없습니다.");}%>
							</td>
							</tr>	
						</table>
						<%} 
				
			}
			else
			{
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
					%>
			
						<tr>
							<td><%=reDTO.get(i).getEmp_no() %></td>
							<td><%=reDTO.get(i).getEmp_name()%></td>
							<td><%=reDTO.get(i).getEmp_id()%></td>
							<td><%=reDTO.get(i).getDep_name() %></td>
							<td><%=reDTO.get(i).getJob_name() %>
							<td><%=reDTO.get(i).getEmp_hiredate()%></td>
														
							
						</tr>
						<%
					}
	
					%>
						<tr>			
						<td colspan="6" align="right">
						<%if(totalRecSu != 0) {
							for(int i=0; i<totalPage; i++) {
								%><a href="./ad_research.go?nowPage=<%=i%>&totalRec=<%=totalRecSu%>">
									<%=i + 1%>
								</a>	
							<% }
							}
						else
						{
							out.println("등록된 게시물이 없습니다.");
						
						}%>
						</td>
						</tr>	
					</table>
					<% }  %>
			
			
			
				</div>
			</div>
			<jsp:include page="../template/BottomTemplate.jsp"/>
		</div>
	</body>
</html>