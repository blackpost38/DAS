package spring.main;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.EmpDAO;
public class CheckempnoController implements Controller {
	EmpDAO dao;

	public void setDao(EmpDAO dao) {
		this.dao = dao;
	}
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		
		String empno = request.getParameter("emp_no");
		String empid = request.getParameter("emp_id");
		
		if(empno != null){
			if(dao.chkEmpno(empno))
			{
				request.setAttribute("result", "true");
				request.setAttribute("empno", empno);
			}
			else
			{
				request.setAttribute("result", "false");
			}
		}
		
		System.out.println("ward1");
		if(empid != null){
			System.out.println("ward2");
			if(dao.chkEmpid(empid))
			{
				request.setAttribute("result1", "true");
				request.setAttribute("empid", empid);
				System.out.println("ward3");
			}
			else
			{
				request.setAttribute("result1", "false");
				System.out.println("ward4");
			}
		}
	
		return new ModelAndView("./ad_insview.go");


	}

}