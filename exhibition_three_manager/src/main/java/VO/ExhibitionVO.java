package VO;

import java.sql.Date;

public class ExhibitionVO {
	private int exNum,totalCount,watchCount,exHallNum,adult,teen,child;
	private String exName,exInfo,exIntro,exhibitionPoster,addImg,exHallName,exStatus,mgrName;
	private Date exhibitionDate,deadLine,inputDate;
	private String exhibitDateText, deadLineText, inputDateText;
	
	public ExhibitionVO() {
	}

	public ExhibitionVO(int exNum, int totalCount, int watchCount, int exHallNum, int adult, int teen, int child,
			String exName, String exInfo, String exIntro, String exhibitionPoster, String addImg, String exHallName,
			String exStatus, String mgrName, Date exhibitionDate, Date deadLine, Date inputDate, String exhibitDateText,
			String deadLineText, String inputDateText) {
		this.exNum = exNum;
		this.totalCount = totalCount;
		this.watchCount = watchCount;
		this.exHallNum = exHallNum;
		this.adult = adult;
		this.teen = teen;
		this.child = child;
		this.exName = exName;
		this.exInfo = exInfo;
		this.exIntro = exIntro;
		this.exhibitionPoster = exhibitionPoster;
		this.addImg = addImg;
		this.exHallName = exHallName;
		this.exStatus = exStatus;
		this.mgrName = mgrName;
		this.exhibitionDate = exhibitionDate;
		this.deadLine = deadLine;
		this.inputDate = inputDate;
		this.exhibitDateText = exhibitDateText;
		this.deadLineText = deadLineText;
		this.inputDateText = inputDateText;
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

	public int getAdult() {
		return adult;
	}

	public void setAdult(int adult) {
		this.adult = adult;
	}

	public int getTeen() {
		return teen;
	}

	public void setTeen(int teen) {
		this.teen = teen;
	}

	public int getChild() {
		return child;
	}

	public void setChild(int child) {
		this.child = child;
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

	public String getExHallName() {
		return exHallName;
	}

	public void setExHallName(String exHallName) {
		this.exHallName = exHallName;
	}

	public String getExStatus() {
		return exStatus;
	}

	public void setExStatus(String exStatus) {
		this.exStatus = exStatus;
	}

	public String getMgrName() {
		return mgrName;
	}

	public void setMgrName(String mgrName) {
		this.mgrName = mgrName;
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

	public String getExhibitDateText() {
		return exhibitDateText;
	}

	public void setExhibitDateText(String exhibitDateText) {
		this.exhibitDateText = exhibitDateText;
	}

	public String getDeadLineText() {
		return deadLineText;
	}

	public void setDeadLineText(String deadLineText) {
		this.deadLineText = deadLineText;
	}

	public String getInputDateText() {
		return inputDateText;
	}

	public void setInputDateText(String inputDateText) {
		this.inputDateText = inputDateText;
	}


}
