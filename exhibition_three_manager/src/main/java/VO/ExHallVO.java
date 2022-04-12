package VO;

public class ExHallVO {
	int exHallNum;
	String exName, address1, address2, mgrName, mgrTel, exTel, zipcode, inputDate, exLoc;
	double latitude, longtitude; 
	char hallDeleted;
	
	public ExHallVO() {
		super();
	}

	public ExHallVO(int exHallNum, String exName, String address1, String address2, String mgrName,
			String mgrTel, String exTel, String zipcode, String inputDate, String exLoc, double latitude,
			double longtitude, char hallDeleted) {
		super();
		this.exHallNum = exHallNum;
		this.exName = exName;
		this.address1 = address1;
		this.address2 = address2;
		this.mgrName = mgrName;
		this.mgrTel = mgrTel;
		this.exTel = exTel;
		this.zipcode = zipcode;
		this.inputDate = inputDate;
		this.exLoc = exLoc;
		this.latitude = latitude;
		this.longtitude = longtitude;
		this.hallDeleted = hallDeleted;
	}

	public int getExHallNum() {
		return exHallNum;
	}

	public void setExHallNum(int exHallNum) {
		this.exHallNum = exHallNum;
	}

	public String getExName() {
		return exName;
	}

	public void setExName(String exName) {
		this.exName = exName;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public String getMgrName() {
		return mgrName;
	}

	public void setMgrName(String mgrName) {
		this.mgrName = mgrName;
	}

	public String getMgrTel() {
		return mgrTel;
	}

	public void setMgrTel(String mgrTel) {
		this.mgrTel = mgrTel;
	}

	public String getExTel() {
		return exTel;
	}

	public void setExTel(String exTel) {
		this.exTel = exTel;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getInputDate() {
		return inputDate;
	}

	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}

	public String getExLoc() {
		return exLoc;
	}

	public void setExLoc(String exLoc) {
		this.exLoc = exLoc;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongtitude() {
		return longtitude;
	}

	public void setLongtitude(double longtitude) {
		this.longtitude = longtitude;
	}

	public char getHallDeleted() {
		return hallDeleted;
	}

	public void setHallDeleted(char hallDeleted) {
		this.hallDeleted = hallDeleted;
	}

	@Override
	public String toString() {
		return "ExhibitionHallVO [exHallNum=" + exHallNum + ", exName=" + exName + ", address1=" + address1
				+ ", address2=" + address2 + ", mgrName=" + mgrName + ", mgrTel=" + mgrTel + ", exTel=" + exTel
				+ ", zipcode=" + zipcode + ", inputDate=" + inputDate + ", exLoc=" + exLoc + ", latitude=" + latitude
				+ ", longtitude=" + longtitude + ", hallDeleted=" + hallDeleted + "]";
	}
	
	
	
}
