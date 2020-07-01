package dto;

import java.sql.Timestamp;


public class PostBean implements java.io.Serializable {
	private int pnum;
	private String id;
	private String name;
	private Timestamp date;
	private String title;
	private String text;
	private String category;
	
	
	
	public PostBean() {
		this(-1,null,null,null,null,null,null);
	}

	

	public PostBean(int pnum, String id, String name, Timestamp date, String title, String text, String category) {
		super();
		this.pnum = pnum;
		this.id = id;
		this.name = name;
		this.date = date;
		this.title = title;
		this.text = text;
		this.category = category;
	}

	public int getPnum() {
		return pnum;
	}



	public void setPnum(int pnum) {
		this.pnum = pnum;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}

	public Timestamp getTimeStamp() {
		return date;
	}



	public void setTimeStamp(Timestamp date) {
		this.date = date;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getText() {
		return text;
	}



	public void setText(String text) {
		this.text = text;
	}



	public String getCategory() {
		return category;
	}



	public void setCategory(String category) {
		this.category = category;
	}



	@Override
	public String toString() {
		return "PostBean [pnum=" + pnum + ", id=" + id + ", name=" + name +", date=" + date + ", title=" + title + ", text=" + text
				+ ", category=" + category + "]";

	}

	
	
	
	
	

}
