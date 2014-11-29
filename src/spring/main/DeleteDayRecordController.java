package spring.main;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.DayDAO;
import spring.emp.DayDTO;
import spring.emp.EmpDAO;

public class DeleteDayRecordController implements Controller{

	
	/*
	 * process 
	 * 1. id값을 DayDTO에 할당.
	 * 2. DayDTO를 iBatis의 parameter값으로 한다.
	 * 3. deleteDayRecord로 Day table에 있는 record 중에 
	 * 	  day_id 값이 id와 같은 record를 삭제한다.
	 * 
	 */
	
	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		System.out.println("id : " + request.getParameter("id"));
		String dayId = request.getParameter("id");
		DayDTO dto = new DayDTO();
		DayDAO dao = new DayDAO();
		dto.setDay_id(Integer.parseInt(dayId));
		dao.deleteDayRecord(dto);
		
		return new ModelAndView("vacation.go");
		
	}
	
}
