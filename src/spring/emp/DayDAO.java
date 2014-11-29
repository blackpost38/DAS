package spring.emp;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;

import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class DayDAO {
	SqlMapClient mapper;
	public DayDAO()
	{
		try {
			Reader reader = Resources.
					getResourceAsReader("spring/emp/SqlMapConfig.xml");
			mapper = SqlMapClientBuilder.buildSqlMapClient(reader);
			reader.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void saveDay(DayDTO ddto)
	{
		try {

			Object o =  mapper.insert("saveDay", ddto);
	//		System.out.println((int)o);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	}

	public List selectAttendance(EmpDTO dto) {
		
		try {
			List arr =  mapper.queryForList("selectAttendance", dto);
			System.out.println(arr.size());
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public void deleteDayRecord(DayDTO dto) {
		
		try {
			System.out.println("dto.id : " + dto.getDay_id());
			Object o =  mapper.delete("deleteDayRecord", dto);
			System.out.println("finished..!");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public void insertVacation(DayDTO dto)
	{
		try {
			System.out.println("insertVacation start...");
			mapper.insert("insertVacation", dto);
			System.out.println("insertVacation finished...");
		} catch (SQLException e) {
			System.out.println("insertVacation error!!");
			e.printStackTrace();
		}
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
	
	public List<DayDTO> selectDeptVacation(EmpDTO dto) {
		
		try {
			List<DayDTO> arr = mapper.queryForList("selectDeptVacation", dto);
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public List selectAttendance(DayDTO dto) {
		
		try {
			List<DayDTO> arr =  mapper.queryForList("selectAttendance", dto);
			System.out.println(arr.size());
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
}
