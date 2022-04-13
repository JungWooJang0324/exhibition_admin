package VO;

import java.sql.Date;

public class ExhibitionVO {
	private int exNum,totalCount,watchCount,exHallNum;
	private String exName,exInfo,exIntro,exhibitionPoster,addImg;
	private char exStatus;
	private Date exhibitionDate,deadLine,inputDate;
	
	
	public ExhibitionVO() {
	}
	
	
	public ExhibitionVO(int exNum, int totalCount, int watchCount, int exHallNum, String exName, String exInfo,
			String exIntro, String exhibitionPoster, String addImg, char exStatus, Date exhibitionDate, Date deadLine,
			Date inputDate) {
		this.exNum = exNum;
		this.totalCount = totalCount;
		this.watchCount = watchCount;
		this.exHallNum = exHallNum;
		this.exName = exName;
		this.exInfo = exInfo;
		this.exIntro = exIntro;
		this.exhibitionPoster = exhibitionPoster;
		this.addImg = addImg;
		this.exStatus = exStatus;
		this.exhibitionDate = exhibitionDate;
		this.deadLine = deadLine;
		this.inputDate = inputDate;
	}


	public int getExNum() {
		return exNum;
	}
	public void setExNum(int exNum) {
		this.exNum = exNum;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getWatchCount() {
		return watchCount;
	}
	public void setWatchCount(int watchCount) {
		this.watchCount = watchCount;
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
	public String getExInfo() {
		return exInfo;
	}
	public void setExInfo(String exInfo) {
		this.exInfo = exInfo;
	}
	public String getExIntro() {
		return exIntro;
	}
	public void setExIntro(String exIntro) {
		this.exIntro = exIntro;
	}
	public String getExhibitionPoster() {
		return exhibitionPoster;
	}
	public void setExhibitionPoster(String exhibitionPoster) {
		this.exhibitionPoster = exhibitionPoster;
	}
	public String getAddImg() {
		return addImg;
	}
	public void setAddImg(String addImg) {
		this.addImg = addImg;
	}
	public char getExStatus() {
		return exStatus;
	}
	public void setExStatus(char exStatus) {
		this.exStatus = exStatus;
	}
	public Date getExhibitionDate() {
		return exhibitionDate;
	}
	public void setExhibitionDate(Date exhibitionDate) {
		this.exhibitionDate = exhibitionDate;
	}
	public Date getDeadLine() {
		return deadLine;
	}
	public void setDeadLine(Date deadLine) {
		this.deadLine = deadLine;
	}
	public Date getInputDate() {
		return inputDate;
	}
	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}
		
}
