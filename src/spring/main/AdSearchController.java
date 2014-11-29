package spring.main;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.validation.BindException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractCommandController;
import org.springframework.web.servlet.mvc.Controller;

import spring.emp.EmpDAO;
import spring.emp.EmpDTO;

public class AdSearchController extends AbstractCommandController {

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

		System.out.println("AdSearchController");

		EmpDTO dto = (EmpDTO) command;
		List<EmpDTO> adname = new ArrayList<EmpDTO>();
		if (dto.getEmp_name().equals("") == false) {
			adname = dao.adempname(dto);
			System.out.println(dto.getEmp_name());
		} else if (dto.getDep_name().equals("") == false) {
			adname = dao.adempdep(dto);
		} else if (dto.getEmp_no() != 0) {
			adname = dao.adempsabun(dto);
		} else {
			adname = dao.adempSel(dto);
		}
		if (request.getParameter("totalRec") == null) {
			request.setAttribute("totalRecord", adname.size());
		} else {
			request.setAttribute("totalRecord",
					Integer.parseInt(request.getParameter("totalRec")));
		}

		request.setAttribute("adname", adname);

		return new ModelAndView("ad_sermain.go");

	}
}
