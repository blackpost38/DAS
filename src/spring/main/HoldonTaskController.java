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
import spring.emp.taskDTO;

public class HoldonTaskController implements Controller {
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
	
		
		taskDTO ud = new taskDTO(request.getParameter("empno"),request.getParameter("startday"),request.getParameter("start"));
		
		dao.holdOntask(ud);
		
	
		

		return new ModelAndView("./overtaskselview.go");

	}
}