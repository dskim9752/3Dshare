package dto;

public class LikesBean {
private int pnum;
private String id;
public LikesBean(int pnum, String id) {
	super();
	this.pnum = pnum;
	this.id = id;
}
public LikesBean() {
	this(-1,null);
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
@Override
public String toString() {
	return "LikeBean [pnum=" + pnum + ", id=" + id + "]";
}





}
