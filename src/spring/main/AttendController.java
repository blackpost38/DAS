package spring.main;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDTO;
import spring.emp.EmpDAO;
import spring.emp.EmpDTO;
public class AttendController implements Controller {
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
		// TODO Auto-generated method stub


		HttpSession se = request.getSession();
		EmpDTO edto = (EmpDTO)se.getAttribute("emp");

		DayDTO ddto = new DayDTO();
		ddto.setDay_empno(edto.getEmp_no());
		ddto.setDay_empname(edto.getEmp_name());
		ddto.setDay_depno(edto.getEmp_depno());
		ddto.setDay_jobno(edto.getEmp_jobno());

		ddto.setDay_res("1");
	
		if(dao.saveDay(ddto)==true)
			request.setAttribute("result", "true");
		else
			request.setAttribute("result", "false");
			
		se.setAttribute("day", ddto);
		
	
		return new ModelAndView("./attendview.go");
		


	}
	
	



}