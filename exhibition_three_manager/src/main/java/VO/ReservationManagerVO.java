package VO;

import java.sql.Date;

public class ReservationManagerVO {
	private int rezNum,rezCount,exNum;
	private Date visitData,rezData;
	private String userName,exName;
	private String rezStatus;
	public ReservationManagerVO() {
	}
	public ReservationManagerVO(int rezNum, int rezCount, int exNum, Date visitData, Date rezData, String userName,
			String exName, String rezStatus) {
		this.rezNum = rezNum;
		this.rezCount = rezCount;
		this.exNum = exNum;
		this.visitData = visitData;
		this.rezData = rezData;
		this.userName = userName;
		this.exName = exName;
		this.rezStatus = rezStatus;
	}
	public int getRezNum() {
		return rezNum;
	}
	public void setRezNum(int rezNum) {
		this.rezNum = rezNum;
	}
	public int getRezCount() {
		return rezCount;
	}
	public void setRezCount(int rezCount) {
		this.rezCount = rezCount;
	}
	public int getExNum() {
		return exNum;
	}
	public void setExNum(int exNum) {
		this.exNum = exNum;
	}
	public Date getVisitData() {
		return visitData;
	}
	public void setVisitData(Date visitData) {
		this.visitData = visitData;
	}
	public Date getRezData() {
		return rezData;
	}
	public void setRezData(Date rezData) {
		this.rezData = rezData;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getExName() {
		return exName;
	}
	public void setExName(String exName) {
		this.exName = exName;
	}
	public String getRezStatus() {
		return rezStatus;
	}
	public void setRezStatus(String rezStatus) {
		this.rezStatus = rezStatus;
	}
	
}
