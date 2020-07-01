package dto;

public class StarBean {
private int pnum;
private String id;
public StarBean(int pnum, String id) {
	super();
	this.pnum = pnum;
	this.id = id;
}
public StarBean() {
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
	return "StarBean [pnum=" + pnum + ", id=" + id + "]";
}





}
