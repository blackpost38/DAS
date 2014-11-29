package spring.main;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDAO;
import spring.emp.DayDTO;
import spring.emp.EmpDAO;
import spring.emp.EmpDTO;

public class SelattendAllController implements Controller {
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
		
		DayDAO dayDao = new DayDAO();
		
		String dateValue = request.getParameter("date");
		if(dateValue == null)	dateValue = "";
		System.out.println("date : " + dateValue);
		
		DayDTO dto = new DayDTO();
		dto.setDay_today(dateValue);
		
		HttpSession session = request.getSession();
		EmpDTO empDto = (EmpDTO)session.getAttribute("emp");
		dto.setDay_depno(empDto.getEmp_depno());	// session에서 가져오기..
		
		List<DayDTO> dayList = dayDao.selectAttendance(dto);

		request.setAttribute("list", dayList);
		if(request.getParameter("totalRec")==null)
		{
			request.setAttribute("totalRecord", dayList.size());
		}
		else
		{
			request.setAttribute("totalRecord", Integer.parseInt(request.getParameter("totalRec")));
		}
		List<String> dep = new ArrayList<String>();
		List<String> jono = new ArrayList<String>();
		for(DayDTO d : dayList)
		{
			String depno = dao.getDepno(d.getDay_depno());
			String jobno = dao.getJobno(d.getDay_jobno());
			
			dep.add(depno);
			jono.add(jobno);
		}
		
		request.setAttribute("depno", dep);
		request.setAttribute("jobno", jono);
		
		
		return new ModelAndView("./head/hd_selectall.jsp");
		
	}
}