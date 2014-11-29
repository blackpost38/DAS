package spring.main;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDTO;
import spring.emp.EmpDAO;
import spring.emp.EmpDTO;
public class OvertaskinsviewController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		HttpSession se = request.getSession();
		EmpDTO edto = (EmpDTO)se.getAttribute("emp");

		request.setAttribute("result", 
				request.getAttribute("result"));
		return new ModelAndView("employee/em_timeInsert.jsp");
		
		


	}
	
	



}