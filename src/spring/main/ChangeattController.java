package spring.main;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDTO;
import spring.emp.EmpDAO;
import spring.emp.EmpDTO;
import spring.emp.OvertaskDTO;
import spring.emp.taskDTO;
import spring.emp.workDTO;

public class ChangeattController implements Controller {
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
		
		int empno = Integer.parseInt(request.getParameter("empno"));
		String start = request.getParameter("start");
		String today = request.getParameter("today");
		
		System.out.println(empno + " " + start + " " + today);
		//HttpSession se = request.getSession();
		//EmpDTO dto = (EmpDTO)se.getAttribute("emp");
	//	String startday = request.getParameter("startday");
	//	int empno = Integer.parseInt(request.getParameter("empno"));
		
		DayDTO dto = new DayDTO();
		dto.setDay_today(today);
		dto.setDay_empno(empno);
		dto.setDay_start(start);
		
		if(dao.changeATT(dto)==1)
			request.setAttribute("result", "true");
		else
			request.setAttribute("result", "false");
		
		
		return new ModelAndView("./getattview.go");

	}
}