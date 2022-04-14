package VO;

public class PriceVO {
	private int exNum,child,adult,teen;

	
	
	public PriceVO() {
	}
	
	public PriceVO(int exNum, int child, int adult, int teen) {
		this.exNum = exNum;
		this.child = child;
		this.adult = adult;
		this.teen = teen;
	}



	public int getExNum() {
		return exNum;
	}

	public void setExNum(int exNum) {
		this.exNum = exNum;
	}

	public int getChild() {
		return child;
	}

	public void setChild(int child) {
		this.child = child;
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
	
	
	
}
