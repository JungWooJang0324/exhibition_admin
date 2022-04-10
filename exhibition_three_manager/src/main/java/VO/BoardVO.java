package VO;

public class BoardVO {

	int bdId;
	String title, userId, inputDate, catNum, catName;
	StringBuilder description; 
	char isdeleted;
	
	
	public BoardVO() {
		super();
	}


	public BoardVO(int bdId, String title, String userId, String inputDate, String catNum, String catName,
			StringBuilder description, char isdeleted) {
		super();
		this.bdId = bdId;
		this.title = title;
		this.userId = userId;
		this.inputDate = inputDate;
		this.catNum = catNum;
		this.catName = catName;
		this.description = description;
		this.isdeleted = isdeleted;
	}


	public int getBdId() {
		return bdId;
	}


	public void setBdId(int bdId) {
		this.bdId = bdId;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getInputDate() {
		return inputDate;
	}


	public void setInputDate(String inputDate) {
		this.inputDate = inputDate;
	}


	public String getCatNum() {
		return catNum;
	}


	public void setCatNum(String catNum) {
		this.catNum = catNum;
	}


	public String getCatName() {
		return catName;
	}


	public void setCatName(String catName) {
		this.catName = catName;
	}


	public StringBuilder getDescription() {
		return description;
	}


	public void setDescription(StringBuilder description) {
		this.description = description;
	}


	public char getIsdeleted() {
		return isdeleted;
	}


	public void setIsdeleted(char isdeleted) {
		this.isdeleted = isdeleted;
	}
	
	
	
}
