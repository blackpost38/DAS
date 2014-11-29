package spring.emp;

import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import java.util.List;
import com.ibatis.common.resources.Resources;
import com.ibatis.sqlmap.client.SqlMapClient;
import com.ibatis.sqlmap.client.SqlMapClientBuilder;

public class AdmDAO {
	SqlMapClient mapper;
	public AdmDAO()
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
	
	// 
	public String selInfo(EmpDTO dto)
	{
	
		try {
			int count =  (int)mapper.queryForObject("admid", dto);
			if(count==0)
			{
				System.out.println("일치하는아이디가없다");
				return "id";
			}
			else {
			    String pwd =  (String)mapper.queryForObject("admpwd", dto);
			    if(dto.getEmp_pwd().equals(pwd)) {
		    	System.out.println("패스워드 일치");
			    	return "suc";
			    } else {
			    	System.out.println("패스워드 불일치");
			    	return "pwd";
			    }
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
	public List<AdmDTO> getInfo(EmpDTO dto) {
	
		try {
			List<AdmDTO> arr =  mapper.queryForList("adminfo",dto);
	//		System.out.println(arr.size());
			return arr;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
		
	}
	
}
