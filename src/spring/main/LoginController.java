package spring.main;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractCommandController;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.EmpDAO;
import spring.emp.EmpDTO;



public class LoginController extends AbstractCommandController {

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
	
		EmpDTO dto = (EmpDTO)command;
		String res = dao.selInfo(dto);
		request.setAttribute("res", res);
		
		HttpSession session = request.getSession();
		
		if(res.equals("id")||res.equals("pwd"))
			return new ModelAndView("index.jsp");
		else
		{
			List<EmpDTO>arr = dao.getInfo(dto);
			
			EmpDTO element = arr.get(0);

			session.setAttribute("emp", element);
		
			if(element.getEmp_jobno() >= 5)
			{
				return new ModelAndView("head/hd_main.jsp");
			} 
			else
			{
				return new ModelAndView("employee/em_main.jsp");
			}
		
		}	

	}
}




