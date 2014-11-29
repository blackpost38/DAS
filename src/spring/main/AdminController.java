package spring.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractCommandController;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.AdmDAO;
import spring.emp.AdmDTO;
import spring.emp.EmpDAO;
import spring.emp.EmpDTO;



public class AdminController extends AbstractCommandController {

	AdmDAO dao;
	public AdmDAO getDao() {
		return dao;
	}

	public void setDao(AdmDAO dao) {
		this.dao = dao;
	}
	
	@Override
	protected ModelAndView handle(HttpServletRequest request,
			HttpServletResponse response, Object command, BindException errors)
			throws Exception {
	
		EmpDTO dto = (EmpDTO)command;
		String res = dao.selInfo(dto);
		request.setAttribute("res", res);
		
		HttpSession session = request.getSession();
		
		if(res.equals("id")||res.equals("pwd"))
			return new ModelAndView("index.jsp");
		else
		{
			List<AdmDTO>arr = dao.getInfo(dto);
			AdmDTO element = arr.get(0);
			
			session.setAttribute("adm", element);
			
			return new ModelAndView("admin/ad_main.jsp");
		}	

	}
}




