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
public class SeltimeController implements Controller {
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

		System.out.println("Seltime");
		
		HttpSession se = request.getSession();
		EmpDTO edto = (EmpDTO)se.getAttribute("emp");
		System.out.println(edto.getEmp_no());
		
		List<DayDTO> list = dao.getMonthInfo(edto);
		List<DayDTO> listVacation = dao.selectVacation(edto);
		se.setAttribute("list", list);
		se.setAttribute("listVacation", listVacation);
		
		
		if(edto.getEmp_jobno() >= 5)
		{
			return new ModelAndView("./head/hd_select.jsp");
		} 
		else
		{
			return new ModelAndView("./employee/em_select.jsp");
		}
		

	}
	
}