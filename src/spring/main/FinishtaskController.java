package spring.main;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.EmpDAO;
import spring.emp.EmpDTO;
import spring.emp.OvertaskDTO;
import spring.emp.taskDTO;
import spring.emp.workDTO;

public class FinishtaskController implements Controller {
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
		//EmpDTO dto = (EmpDTO)se.getAttribute("emp");
	


		String empno = request.getParameter("empno");
		EmpDTO dto = dao.getempInfo(empno);
		String date = request.getParameter("startday");
		String time = request.getParameter("start");
	
		taskDTO td = new taskDTO(empno,date,time);
		int index = date.indexOf('/');		
		String year = date.substring(0, index);
		date = date.substring(index+1);
		index = date.indexOf('/');
		String month = date.substring(0, index);	
		index = date.indexOf('/');
		String day = date.substring(index+1);
	
		if(request.getParameter("gubun").equals("1"))
		{	
			dao.finishTask(td);
		}
		else
		{
			dao.finishholdTask(td);
		}

		int finalWork = getFinalMin(time, td);

		workDTO wd = new workDTO(empno, month, year);

		dao.finishTask(wd, dto, finalWork);
		
	
		return new ModelAndView("./overtaskselview.go");

	}
	
	
	public int getFinalMin(String time, taskDTO td)
	{
		int cut = time.indexOf(':');
		String h = time.substring(0, cut);
		String m = time.substring(cut+1);

		int startHour = Integer.parseInt(h);
		int startMin = Integer.parseInt(m);

		String finishTime = dao.getFinishTime(td);
		h = finishTime.substring(0, cut);
		m = finishTime.substring(cut+1);
	
		int finishHour = Integer.parseInt(h);

		if(startHour > finishHour)
			finishHour+=24;
		
		int finishMin = Integer.parseInt(m);
		
		int startInt = (60*startHour) + startMin;
		int finishInt = (60*finishHour) + finishMin;

		int finalWork = finishInt - startInt;
		if(finalWork < 0) finalWork *= -1;
		
		return finalWork;
	}
}