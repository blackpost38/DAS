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


public class ChangeattviewController implements Controller {


	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {


		return new ModelAndView("./admin/ad_attend.jsp");

	}
	



}