package spring.main;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.AdmDTO;
import spring.emp.EmpDTO;
public class LogoutController implements Controller {

	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		HttpSession se = request.getSession();
	
		se.invalidate();
		return new ModelAndView("index.jsp");

	}
}