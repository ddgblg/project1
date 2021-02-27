package model;

import java.util.Date;

public class Comment {
	private String nickname;
	private String content;
	private int seq;
	private Date regdate;
	private String id;
	private int num;
	private int cnum;
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	@Override
	public String toString() {
		return "Comment [nickname=" + nickname + ", content=" + content + ", seq=" + seq + ", regdate=" + regdate
				+ ", id=" + id + ", num=" + num + ", cnum=" + cnum + "]";
	}

}
