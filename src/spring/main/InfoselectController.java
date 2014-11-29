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

public class InfoselectController implements Controller{
	
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
		HttpSession se = request.getSession();
		EmpDTO edto = (EmpDTO)se.getAttribute("emp");
		
		System.out.println(edto.getEmp_no());
		
		
		List<EmpDTO> dto = dao.info(edto);
		request.setAttribute("list", dto);
		
		List<String> dep = new ArrayList<String>();
		List<String> jono = new ArrayList<String>();
		for(EmpDTO d : dto)
		{
			String depno = dao.getDepno(d.getEmp_depno());
			String jobno = dao.getJobno(d.getEmp_jobno());
			
			dep.add(depno);
			jono.add(jobno);
			System.out.println(d.getEmp_depno());
		}
		request.setAttribute("depno", dep);
		request.setAttribute("jobno", jono);
			if(edto.getEmp_jobno() >= 5)
			{
				return new ModelAndView("./head/hd_info.jsp");
			} 
			else
			{
				return new ModelAndView("./employee/em_info.jsp");
			}
		
	}
	

}
