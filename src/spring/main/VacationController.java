package spring.main;

import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDAO;
import spring.emp.DayDTO;
import spring.emp.EmpDTO;


public class VacationController implements Controller{

	
	/*
	 * process 
	 * 
	 * 
	 */
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		EmpDTO dto = (EmpDTO)session.getAttribute("emp");
		
		if(dto.getEmp_jobno() >= 5){
			return new ModelAndView("head/hd_leave.jsp");
		} else {
			return new ModelAndView("employee/em_leave.jsp");
		}
		
	}
	
}
