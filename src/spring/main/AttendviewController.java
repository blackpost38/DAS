package spring.main;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDTO;
import spring.emp.EmpDAO;
import spring.emp.EmpDTO;

public class AttendviewController implements Controller {
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
		EmpDTO edto = (EmpDTO)se.getAttribute("emp");
		
		DayDTO ddto = new DayDTO();
		ddto.setDay_empno(edto.getEmp_no());
		
		List<DayDTO> list = dao.getCuratt(ddto);
		if(list.size()==0)
		{
			request.setAttribute("flag", "false");
		
		
		}
		else
		{
			if(list.get(0).getDay_start()==null)
			{
				request.setAttribute("flag", "vacation");
			}
			else
			{
				request.setAttribute("flag", "true");
			}
		}
		
		
		if(edto.getEmp_jobno() >= 5)
		{
			return new ModelAndView("head/hd_check.jsp");
		} 
		else
		{
			return new ModelAndView("employee/em_check.jsp");
		}
		
		
	
		

	}
}