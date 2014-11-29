package spring.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractCommandController;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.EmpDAO;
import spring.emp.EmpDTO;

public class AdinsController extends AbstractCommandController{
	EmpDAO dao;

	public void setDao(EmpDAO dao) {
		this.dao = dao;
	}

	@Override
	protected ModelAndView handle(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {

	
		EmpDTO dto = (EmpDTO)command;

		System.out.println(dto.getEmp_no());
		System.out.println(dto.getEmp_pwd());
		int count = dao.InsnewEMP(dto);
		if(count==0)
		{
			request.setAttribute("count","false");
		}
		else
		{
			request.setAttribute("count","true");
		
		}
		
	//	return null;
		return new ModelAndView("./ad_insview.go");
	}
}
