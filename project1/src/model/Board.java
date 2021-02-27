package model;

import java.util.Date;

public class Board {
	private int btype;
	private int num;
	private String area;
	private String category;
	private Date period_from;
	private Date period_to;
	private String subject;
	private String content;
	private String coordinate;
	private int readcnt;
	private Date regdate;
	private String imgfile;
	private String id;
	private String nickname;
	private String comp;
	private int commentcnt;
	
	
	public int getCommentcnt() {
		return commentcnt;
	}
	public void setCommentcnt(int commentcnt) {
		this.commentcnt = commentcnt;
	}
	//getter, setter, tostring
	public int getBtype() {
		return btype;
	}
	public void setBtype(int btype) {
		this.btype = btype;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Date getPeriod_from() {
		return period_from;
	}
	public void setPeriod_from(Date period_from) {
		this.period_from = period_from;
	}
	public Date getPeriod_to() {
		return period_to;
	}
	public void setPeriod_to(Date period_to) {
		this.period_to = period_to;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCoordinate() {
		return coordinate;
	}
	public void setCoordinate(String coordinate) {
		this.coordinate = coordinate;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getImgfile() {
		return imgfile;
	}
	public void setImgfile(String imgfile) {
		this.imgfile = imgfile;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getComp() {
		return comp;
	}
	public void setComp(String comp) {
		this.comp = comp;
	}
	@Override
	public String toString() {
		return "Board [btype=" + btype + ", num=" + num + ", area=" + area + ", category=" + category + ", period_from="
				+ period_from + ", period_to=" + period_to + ", subject=" + subject + ", content=" + content
				+ ", coordinate=" + coordinate + ", readcnt=" + readcnt + ", regdate=" + regdate + ", imgfile="
				+ imgfile + ", id=" + id + ", nickname=" + nickname + ", comp=" + comp + ", commentcnt=" + commentcnt
				+ "]";
	}
	

	
	
}
