package spring.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDAO;
import spring.emp.DayDTO;
import spring.emp.EmpDTO;

public class SelectDayRecordController implements Controller {
	public DayDAO dao;
	

	public DayDAO getDao() {
		return dao;
	}
	public void setDao(DayDAO dao) {
		this.dao = dao;
	}
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HttpSession se = request.getSession();
		EmpDTO edto = (EmpDTO)se.getAttribute("emp");
		
		List<DayDTO> dto = dao.selectDeptVacation(edto);
		request.setAttribute("list", dto);
		
		return new ModelAndView("./head/hd_leaveall.jsp");
		
	}
}