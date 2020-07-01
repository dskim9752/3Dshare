package dto;

import java.sql.Date;

public class ImgBean implements java.io.Serializable {
	private int inum;
	private int pnum;
	private String imgName;
	private String imgSrc;
	
	
	
	public ImgBean() {
		this(-1,-1,null,null);
	}



	public ImgBean(int pnum, int inum, String imgName, String imgSrc) {
		super();
		this.inum = inum;
		this.pnum = pnum;
		this.imgName = imgName;
		this.imgSrc = imgSrc;
	}



	public int getInum() {
		return inum;
	}



	public void setInum(int inum) {
		this.inum = inum;
	}



	public int getPnum() {
		return pnum;
	}



	public void setPnum(int pnum) {
		this.pnum = pnum;
	}



	public String getImgName() {
		return imgName;
	}



	public void setImgName(String imgName) {
		this.imgName = imgName;
	}



	public String getImgSrc() {
		return imgSrc;
	}



	public void setImgSrc(String imgSrc) {
		this.imgSrc = imgSrc;
	}



	@Override
	public String toString() {
		return "imgBean [inum=" + inum + ", pnum=" + pnum + ", imgName=" + imgName + ", imgSrc=" + imgSrc + "]";
	}

	
	

}
