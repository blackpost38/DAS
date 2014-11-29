package spring.emp;

public class taskDTO {
	String empno;
	String startday;
	String start;
	String finish;
	public String getEmpno() {
		return empno;
	}
	public void setEmpno(String empno) {
		this.empno = empno;
	}
	public String getStartday() {
		return startday;
	}
	public void setStartday(String startday) {
		this.startday = startday;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getFinish() {
		return finish;
	}
	public void setFinish(String finish) {
		this.finish = finish;
	}
	public taskDTO(String empno, String startday, String start) {

		this.empno = empno;
		this.startday = startday;
		this.start = start;
	}


	
	
}
