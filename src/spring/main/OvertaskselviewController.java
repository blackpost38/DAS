package spring.main;


import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.EmpDAO;
import spring.emp.EmpDTO;
import spring.emp.OvertaskDTO;
import spring.emp.OverworkDTO;

public class OvertaskselviewController implements Controller {
	public EmpDAO dao;
	

	public EmpDAO getDao() {
		return dao;
	}
	public void setDao(EmpDAO dao) {
		this.dao = dao;
	}
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		
		HttpSession se = request.getSession();
		EmpDTO dto = (EmpDTO)se.getAttribute("emp");
		
		if(dto.getEmp_jobno() >= 5)
		{
			List<OvertaskDTO>list = dao.getOvertaskAll(dto);
			if(request.getParameter("totalRec")==null)
			{
				request.setAttribute("totalRecord", list.size());
			}
			else
			{
				request.setAttribute("totalRecord", Integer.parseInt(request.getParameter("totalRec")));
			}
			
	
			request.setAttribute("over_listall", list);
			List<String> job = new ArrayList<String>();
			List<String> dep = new ArrayList<String>();
	
			
			for(OvertaskDTO d : list)
			{
				String jobname = dao.getJobname(d.getTask_jobno());
				String depname = dao.getDepname(d.getTask_depno());
				job.add(jobname);
				dep.add(depname);
			}
		
			request.setAttribute("jobnamehd", job);
			request.setAttribute("depnamehd", dep);
			
			return new ModelAndView("head/hd_timeSelect.jsp");
		} 
		else
		{
		
 	   		List<OvertaskDTO>list = dao.getOvertask(dto);
			List<OverworkDTO>work_list = dao.OverworkAll(dto);
			String today = dao.getToday();
			String now = dao.getNow();
			request.setAttribute("today", today);
			request.setAttribute("now", now);
			
			if(request.getParameter("totalRec")==null)
    		{
    			request.setAttribute("totalRecord", list.size());
    		}
    		else
    		{
    			request.setAttribute("totalRecord", Integer.parseInt(request.getParameter("totalRec")));
    		}
    		

			
			request.setAttribute("over_list", list);
			request.setAttribute("over_work", work_list);
				
			List<String> job = new ArrayList<String>();
			List<String> dep = new ArrayList<String>();
			for(OvertaskDTO d : list)
			{
				String jobname = dao.getJobname(d.getTask_jobno());
				String depname = dao.getDepname(d.getTask_depno());
				job.add(jobname);
				dep.add(depname);
			}
			if(request.getParameter("totalRecs")==null)
			{
				request.setAttribute("totalRecords", work_list.size());
			}
			else
			{
				request.setAttribute("totalRecords", Integer.parseInt(request.getParameter("totalRecs")));
			}
			
			request.setAttribute("jobname", job);
			request.setAttribute("depname", dep);
			
			return new ModelAndView("employee/em_timeSelect.jsp");
		}
  

    	

	}
}