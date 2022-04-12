package VO;

public class BoardVO {

	int bdId, catNum;
	String title, userId, inputDate, catName, description;
	char isdeleted;
	
	
	public BoardVO() {
		super();
	}


	public BoardVO(int bdId, String title, String userId, String inputDate, int catNum, String catName,
			String description, char isdeleted) {
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


	public int getCatNum() {
		return catNum;
	}


	public void setCatNum(int catNum) {
		this.catNum = catNum;
	}


	public String getCatName() {
		return catName;
	}


	public void setCatName(String catName) {
		this.catName = catName;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public char getIsdeleted() {
		return isdeleted;
	}


	public void setIsdeleted(char isdeleted) {
		this.isdeleted = isdeleted;
	}
	
	
	
}
