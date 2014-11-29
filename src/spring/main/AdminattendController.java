package spring.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractCommandController;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDTO;
import spring.emp.EmpDAO;
import spring.emp.EmpDTO;


public class AdminattendController extends AbstractCommandController {

	EmpDAO dao;
	public EmpDAO getDao() {
		return dao;
	}


	public void setDao(EmpDAO dao) {
		this.dao = dao;
	}
	@Override
	protected ModelAndView handle(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
		//System.out.println("AdSearchController");
		DayDTO dto = (DayDTO)command;
	//	List<EmpDTO>adname = new ArrayList<EmpDTO>();

		return null;
	//	request.setAttribute("adname", adname);
	//	return new ModelAndView("ad_sermain.go");
			

	}
}






