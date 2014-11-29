package spring.main;

import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDAO;
import spring.emp.DayDTO;
import spring.emp.EmpDTO;


public class MultiInsertDayRecordController implements Controller{

	
	/*
	 * process 
	 * 
	 * 
	 */
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String startDay = request.getParameter("startDay");
		String startYear = request.getParameter("startYear");
		String startMonth = request.getParameter("startMonth");
		String startDate = request.getParameter("startDate");
		
		String endDay = request.getParameter("endDay");
		String endYear = request.getParameter("endYear");
		String endMonth = request.getParameter("endMonth");
		String endDate = request.getParameter("endDate");
		
		String gap = request.getParameter("gap");
		
		
//		String gap = request.getParameter("gap");
//		System.out.println("startYear : " + startYear + "startMonth : " + startMonth);
//		System.out.println("startDate : " + startDate + "gap : " + gap);

		// TEST DTO.. session에서 받아와야함.
		HttpSession session = request.getSession();
		EmpDTO empDto = (EmpDTO) session.getAttribute("emp");
		
		
		// DayDto에 data setting
		String day_empname = empDto.getEmp_name();
		int day_empno = empDto.getEmp_no();
		int day_jobno = empDto.getEmp_jobno();
		int day_depno = empDto.getEmp_depno();
		
		DayDTO dayDto = new DayDTO();
		dayDto.setDay_empname(day_empname);
		dayDto.setDay_empno(day_empno);
		dayDto.setDay_jobno(day_jobno);
		dayDto.setDay_depno(day_depno);
		
//		dto.setDay_vacation(day_vacation);
//		dto.setDay_id(day_id);

		// DB 연동..
		DayDAO dao = new DayDAO();
		
		// 알고리즘..
		Calendar cal = Calendar.getInstance();
		cal.set(Integer.parseInt(startYear), 
				Integer.parseInt(startMonth)-1,
				Integer.parseInt(startDate)-1);
		System.out.println("cal : " + cal.getTime() + " // gap : " + gap);
		
		for (int i = 0; i <= Integer.parseInt(gap); i++) {
			
			cal.add(Calendar.DAY_OF_MONTH, 1);
			System.out.println("year : " + cal.get(Calendar.YEAR) +
					"// month : " + (cal.get(Calendar.MONTH)+1) +
					"// date : " + cal.get(Calendar.DAY_OF_MONTH));
			String today = 
					cal.get(Calendar.YEAR) + "/" +
					((cal.get(Calendar.MONTH)+1) < 10 ? 
						"0" + (cal.get(Calendar.MONTH)+1):(cal.get(Calendar.MONTH)+1)) + "/" +
					(cal.get(Calendar.DAY_OF_MONTH) < 10 ? 
						"0" + cal.get(Calendar.DAY_OF_MONTH):cal.get(Calendar.DAY_OF_MONTH));
									 
			dayDto.setDay_today(today);
			
			dao.insertVacation(dayDto);
		}
		
		// dao.insertVacation(dayDto);
		return new ModelAndView("em_leave.jsp");
		
	}
	
}
