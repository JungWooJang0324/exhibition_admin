package VO;

import java.sql.Date;

public class BoardVO {

	int bdId, catNum, rnum;
	String title, userId,  catName, description, adminId, imgFile;
	char isdeleted;
	Date inputDate;
	
	
	public BoardVO() {
		super();
	}

	
	public BoardVO(int bdId, int catNum, int rnum, String title, String userId, Date inputDate, String catName,
			String description, String adminId, String imgFile, char isdeleted) {
		super();
		this.bdId = bdId;
		this.catNum = catNum;
		this.rnum = rnum;
		this.title = title;
		this.userId = userId;
		this.inputDate = inputDate;
		this.catName = catName;
		this.description = description;
		this.adminId = adminId;
		this.imgFile = imgFile;
		this.isdeleted = isdeleted;
	}






	public String getImgFile() {
		return imgFile;
	}


	public void setImgFile(String imgFile) {
		this.imgFile = imgFile;
	}


	public int getRnum() {
		return rnum;
	}


	public void setRnum(int rnum) {
		this.rnum = rnum;
	}


	public String getAdminId() {
		return adminId;
	}
	
	
	
	
	
	public void setAdminId(String adminId) {
		this.adminId = adminId;
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


	public Date getInputDate() {
		return inputDate;
	}


	public void setInputDate(Date inputDate) {
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
