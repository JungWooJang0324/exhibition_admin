package VO;

import java.sql.Date;

public class MemberVO {
	private String userId, password, name, tel, zipcode, address1, address2;
	private String isDeleted;
	private Date isubscribeDate;
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
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
	
	
	public String getIsDeleted() {
		return isDeleted;
	}
	public void setIsDeleted(String string) {
		this.isDeleted = string;
	}


	public Date getIsubscribeDate() {
		return isubscribeDate;
	}
	public void setIsubscribeDate(Date isubscribeDate) {
		this.isubscribeDate = isubscribeDate;
	}

	
	
	
}
