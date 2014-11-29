package spring.main;

import java.util.ArrayList;
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

public class AdreSearchController implements Controller {



	@Override
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("AdreSearchController");
		

		HttpSession se = request.getSession();
		List ddto = (List)se.getAttribute("reaDTO");
		
		if (request.getParameter("totalRec") == null) {
			request.setAttribute("totalRecord", ddto.size());
		} else {
			request.setAttribute("totalRecord",
					Integer.parseInt(request.getParameter("totalRec")));
		}

		request.setAttribute("reDTO", ddto);

		return new ModelAndView("ad_sermain.go");
	}
}
