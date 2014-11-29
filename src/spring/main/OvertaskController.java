package spring.main;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractCommandController;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDTO;
import spring.emp.EmpDAO;
import spring.emp.EmpDTO;
import spring.emp.OvertaskDTO;
public class OvertaskController extends AbstractCommandController {
	public EmpDAO dao;
	

	public EmpDAO getDao() {
		return dao;
	}
	public void setDao(EmpDAO dao) {
		this.dao = dao;
	}

	protected ModelAndView handle(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {

		OvertaskDTO dto = (OvertaskDTO)command;
		HttpSession se = request.getSession();
		EmpDTO edto = (EmpDTO)se.getAttribute("emp");
		

		dto.setTask_res("0");
		dto.setTask_depno(edto.getEmp_depno());
		dto.setTask_jobno(edto.getEmp_jobno());
		
		if(dao.setOvertask(dto)==1)
		{
			request.setAttribute("result", "true");
		}
		else if(dao.setOvertask(dto)==2)
		{	
			request.setAttribute("result", "max");
		}
		else if(dao.setOvertask(dto)==3)
		{	
			request.setAttribute("result", "time");
		}
		else
		{
			request.setAttribute("result", "false");
		}
	
		return new ModelAndView("./overtaskinsview.go");

	}

}