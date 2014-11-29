package spring.emp;

public class workDTO {
	String empno;
	String curmonth;
	String curyear;
	public workDTO(String empno, String curmonth, String curyear) {
	
		this.empno = empno;
		this.curmonth = curmonth;
		this.curyear = curyear;
	}
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getCurmonth() {
		return curmonth;
	}
	public void setCurmonth(String curmonth) {
		this.curmonth = curmonth;
	}
	public String getCuryear() {
		return curyear;
	}
	public void setCuryear(String curyear) {
		this.curyear = curyear;
	}



	
	
}
