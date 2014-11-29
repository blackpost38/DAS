package spring.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.EmpDAO;
import spring.emp.EmpDTO;

public class MainviewController implements Controller {


	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HttpSession se = request.getSession();
		EmpDTO edto = (EmpDTO)se.getAttribute("emp");
		
		if(edto==null)
		{
			return new ModelAndView("admin/ad_main.jsp");
		}
		
		
		if(edto.getEmp_jobno() >= 5){
			return new ModelAndView("head/hd_main.jsp");
		} else{
			return new ModelAndView("employee/em_main.jsp");
		}
	
	
	}
}
