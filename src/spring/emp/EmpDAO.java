package spring.emp;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class EmpDAO {
	SqlMapClient mapper;

	public EmpDAO() {
		try {
			Reader reader = Resources
					.getResourceAsReader("spring/emp/SqlMapConfig.xml");
			mapper = SqlMapClientBuilder.buildSqlMapClient(reader);
			reader.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	//
	public String selInfo(EmpDTO dto) {

		try {
			int count = (int) mapper.queryForObject("selid", dto);
			if (count == 0) {
				// System.out.println("일치하는아이디가없다");
				return "id";
			} else {
				String pwd = (String) mapper.queryForObject("selpwd", dto);
				if (dto.getEmp_pwd().equals(pwd)) {
					// System.out.println("패스워드 일치");
					return "suc";
				} else {
					// System.out.println("패스워드 불일치");
					return "pwd";
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;

	}

	public List<EmpDTO> getInfo(EmpDTO dto) {

		try {
			List<EmpDTO> arr = mapper.queryForList("selinfo", dto);
			// System.out.println(arr.size());
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;

	}

	public boolean saveDay(DayDTO ddto) {
		try {
			String date = (String) mapper.queryForObject("getToday");
			ddto.setDay_today(date);
			int count = (int) mapper.queryForObject("checkATT", ddto);

			if (count == 0) {
				Object o = mapper.insert("saveDay", ddto);
				return true;
			} else {
				return false;
			}
			// System.out.println("insert값 :" + o);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	public List <DayDTO> getMonthInfo(EmpDTO edto) {

		try {
			List <DayDTO> arr = mapper.queryForList("getmonthinfo", edto);
			System.out.println(arr.size());
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public int setOvertask(OvertaskDTO dto) 
	{

		try {
			String date = dto.getTask_startday();
			System.out.println(date);
			int index = date.indexOf('/');		
			String year = date.substring(0, index);
			date = date.substring(index+1);
			index = date.indexOf('/');
			String month = date.substring(0, index);	
			workDTO wd = new workDTO(dto.getTask_empno(), month, year);
			System.out.println(year + " " + month);
			
			int count = (int)mapper.queryForObject("getMaxworkcount", wd);
		
			if(count != 0)
			{
				int max = (int)mapper.queryForObject("getMaxwork", wd);
				if(max>=1200)
					return 2;
				
			}
			int res = (int)mapper.queryForObject("checksameOvertask", dto);
			if(res==0)
			{
				int sametime = (int)mapper.queryForObject("checktimeOvertask", dto);
				if(sametime==1)
				{
					return 3;
				}
				mapper.insert("saveOvertask", dto);
				return 1;
			}
			else
				return 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;

	}

	public List<OvertaskDTO> getOvertask(EmpDTO dto) {

		try {
			List<OvertaskDTO> arr = mapper.queryForList("getOvertask", dto);
			// System.out.println(arr.size());
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<DayDTO> getAttendall(EmpDTO dto) {

		try {
			List<DayDTO> arr = mapper.queryForList("getAttendall", dto);
			// System.out.println(arr.size());
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;

	}

	public String getJobname(int day_jobno) {

		try {
			String jobname = (String) mapper.queryForObject("getJobname",
					day_jobno);
			return jobname;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getDepname(int day_depno) {
		try {
			String depname = (String) mapper.queryForObject("getDepname",
					day_depno);
			return depname;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<OvertaskDTO> getOvertaskAll(EmpDTO dto) {
		try {
			List<OvertaskDTO> arr = mapper.queryForList("getOvertaskAll", dto);
			// System.out.println(arr.size());
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void updateTask(taskDTO ud) {
		try {

			mapper.update("updateTask", ud);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void finishTask(workDTO fd, EmpDTO dto, int finalWork) {
		try {
			int count = (int) mapper.queryForObject("selOverwork", fd);
			Map<Object, Object> parameters = new HashMap<Object, Object>();
			parameters.put("curyear", fd.getCuryear());
			parameters.put("curmonth", fd.getCurmonth());
			parameters.put("empno", dto.getEmp_no());
			parameters.put("jobno", dto.getEmp_jobno());
			parameters.put("depno", dto.getEmp_depno());
			parameters.put("empname", dto.getEmp_name());
			parameters.put("max", finalWork);
			if (count == 0) {	
				mapper.insert("saveOverwork", parameters);
			} else {				
				mapper.update("updTotalWork", parameters);
			}		
			int max = (int)mapper.queryForObject("getMaxwork", fd);	
			if(max >= 1200)
			{
				mapper.update("updMaxWork", fd);
			}
			
			// mapper.update("updateTask", ud);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void finishTask(taskDTO td) {
		try {

			mapper.update("finishTask", td);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getFinishTime(taskDTO dto) {
		try {
			String time = (String) mapper.queryForObject("getFinishTime", dto);
			return time;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<EmpDTO> adempSel(EmpDTO dto) { // admin 전체조회
		List<EmpDTO> list = null;
		try {
			list = mapper.queryForList("empsel");
			// System.out.println("전체사원 :" + list.size());
			return list;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;

	}

	public List<EmpDTO> adempname(EmpDTO dto) { // admin 이름조회
		List<EmpDTO> list = null;
		try {
			list = mapper.queryForList("empname", dto);
			System.out.println("이름사이즈 :" + list.size());
			return list;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;

	}

	public List<EmpDTO> adempdep(EmpDTO dto) { // admin 부서조회
		List<EmpDTO> list = null;
		try {
			list = mapper.queryForList("empdep", dto);
			System.out.println("부서사이즈 :" + list.size());
			return list;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;

	}

	public List<EmpDTO> adempsabun(EmpDTO dto) { // admin 사번조회
		List<EmpDTO> list = null;
		try {
			list = mapper.queryForList("empsabun", dto);
			// System.out.println(list.size());
			return list;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;

	}

	public List<DayDTO> getselATT(DayDTO dto) {
		try {
			List<DayDTO> list = mapper.queryForList("getselATT", dto);
			System.out.println("ss" + list.size());
			return list;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean chkEmpno(String emp_no) {
		// TODO Auto-generated method stub
		try {

			int count = (int) mapper.queryForObject("empNumChk", emp_no);
			if (count == 0) {
				return true;
			} else
				return false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;

	}

	public int InsnewEMP(EmpDTO dto) {
		try {
			mapper.insert("empIns", dto);
			return 1;

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;

	}

	public List<EmpDTO> infoall(EmpDTO dto) {

		try {
			List<EmpDTO> arr = mapper.queryForList("infoall", dto);
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<EmpDTO> info(EmpDTO edto){

		try {
			List<EmpDTO> arr = mapper.queryForList("info", edto);
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	
	public String getDepno(int emp_depno) {
		try {
			String depno = (String) mapper
					.queryForObject("getDepno", emp_depno);
			return depno;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getJobno(int emp_jobno) {
		try {
			String jobno = (String) mapper
					.queryForObject("getJobno", emp_jobno);
			return jobno;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void holdOntask(taskDTO ud) {
		try {

			mapper.update("holdontask", ud);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	public EmpDTO getempInfo(String empno) {
		try {
			EmpDTO dto = (EmpDTO) mapper.queryForObject("getempInfo", empno);
			return dto;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public void finishholdTask(taskDTO td) {
		try {

			mapper.update("finishholdTask", td);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public List<OverworkDTO> OverworkAll(EmpDTO dto) {

	
			try {
				List<OverworkDTO> arr = mapper.queryForList("selAllWork", dto);
				System.out.println(arr.size() + "gdfoijdfoijdfoij");
		
				return arr;
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return null;


	}
	
	public List<DayDTO> selectVacation(EmpDTO dto) {
		
		try {
			System.out.println("selectVacation start...");
			@SuppressWarnings("unchecked")
			List<DayDTO> arr = mapper.queryForList("selectVacation", dto);
			System.out.println("selectVacation finished...");
			return arr;
		} catch (SQLException e) {
			System.out.println("selectVacation Error!");
			e.printStackTrace();
		}
		return null;
	}

	public void refusetask(taskDTO ud) {
		// TODO Auto-generated method stub
		try {

			mapper.update("refuseTask", ud);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public List<DayDTO> getCuratt(DayDTO ddto) {
		// TODO Auto-generated method stub

		try {
			String today = (String)mapper.queryForObject("getToday");
			ddto.setDay_today(today);
			
			List<DayDTO> list  = mapper.queryForList("getCuratt", ddto);
	
			return list;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	public int changeATT(DayDTO dto) {
		// TODO Auto-generated method stub
		try {

			int count = (int)mapper.update("changeATT", dto);
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public int deleteATT(DayDTO dto) {
		try {

			int count = (int)mapper.delete("deleteATT", dto);
			return count;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}

	public String getToday() {
		try
		{
			String date = (String) mapper.queryForObject("getToday");
			return date;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	public String getNow() {
		try
		{
			String now = (String) mapper.queryForObject("getNow");
			return now;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public boolean chkEmpid(String empid) {
		try {

			int count = (int) mapper.queryForObject("empIdChk", empid);
			if (count == 0) {
				return true;
			} else
				return false;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

}
