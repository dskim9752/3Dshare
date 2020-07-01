package dto;

import java.sql.Timestamp;

public class CommentBean {
	
	private int cnum;
	private int pnum;
	private String id;
	private Timestamp date;
	private String text;
	private int depth;
	private String name;
	
	public CommentBean() {
		this(-1,-1,null,null,null,0,null);
	}


	public CommentBean(int cnum, int pnum, String id, Timestamp date, String text,int depth,String name ) {
		super();
		this.cnum = cnum;
		this.pnum = pnum;
		this.id = id;
		this.date = date;
		this.text = text;
		this.depth = depth;
		this.name = name;
	}


	public int getCnum() {
		return cnum;
	}

	public void setCnum(int cnum) {
		this.cnum = cnum;
	}

	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}

	public Timestamp getDate() {
		return date;
	}

	public void setDate(Timestamp date) {
		this.date = date;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}
	
	public int getDepth() {
		return depth;
	}


	public void setDepth(int depth) {
		this.depth = depth;
	}
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	@Override
	public String toString() {
		return "CommentBean [cnum=" + cnum + ", pnum=" + pnum + ", id=" + id + ", date=" + date + ", text=" + text
				+ ", depth=" + depth + ", name=" + name + "]";
	}





	

	
	
	
	

}
