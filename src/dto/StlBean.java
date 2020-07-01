package dto;

import java.sql.Date;

public class StlBean implements java.io.Serializable {
	private int snum;
	private int pnum;
	private String stlName;
	private String stlSrc;
	
	
	
	public StlBean() {
		this(-1,-1,null,null);
	}



	public StlBean(int pnum, int snum, String stlName, String stlSrc) {
		super();
		this.snum = snum;
		this.pnum = pnum;
		this.stlName = stlName;
		this.stlSrc = stlSrc;
	}



	public int getSnum() {
		return snum;
	}



	public void setSnum(int snum) {
		this.snum = snum;
	}



	public int getPnum() {
		return pnum;
	}



	public void setPnum(int pnum) {
		this.pnum = pnum;
	}



	public String getStlName() {
		return stlName;
	}



	public void setStlName(String stlName) {
		this.stlName = stlName;
	}



	public String getStlSrc() {
		return stlSrc;
	}



	public void setStlSrc(String stlSrc) {
		this.stlSrc = stlSrc;
	}



	@Override
	public String toString() {
		return "StlBean [snum=" + snum + ", pnum=" + pnum + ", stlName=" + stlName + ", stlSrc=" + stlSrc + "]";
	}


	

}
