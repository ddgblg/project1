package model;

import java.util.Date;

// Bean Å¬·¡½º


public class Member {
	private int kbn;
	private int lv;
	private String id;
	private String pass;
	private String nickname;
	private String email;
	private String area;
	private String birth;
	private String name;
	private String comp;
	private String hobby;
	private Date regdate;
	private int apply;
	public int getKbn() {
		return kbn;
	}
	public void setKbn(int kbn) {
		this.kbn = kbn;
	}
	public int getLv() {
		return lv;
	}
	public void setLv(int lv) {
		this.lv = lv;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getBirth() {
		return birth;
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getComp() {
		return comp;
	}
	public void setComp(String comp) {
		this.comp = comp;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getApply() {
		return apply;
	}
	public void setApply(int apply) {
		this.apply = apply;
	}
	@Override
	public String toString() {
		return "Member [kbn=" + kbn + ", lv=" + lv + ", id=" + id + ", pass=" + pass + ", nickname=" + nickname
				+ ", email=" + email + ", area=" + area + ", birth=" + birth + ", name=" + name + ", comp=" + comp
				+ ", hobby=" + hobby + ", regdate=" + regdate + ", apply=" + apply + "]";
	}
	
	
	
	
	
}
