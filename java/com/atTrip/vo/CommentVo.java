package com.atTrip.vo;

import java.sql.Date;

public class CommentVo {
	private int r_no;
	private String r_writer;
	private String r_pwd;
	private String r_content;
	private Date b_wdate;
	private int r_level;
	private int r_step;
	private int b_no;
	public CommentVo(int r_no, String r_writer, String r_pwd, String r_content, Date b_wdate, int r_level, int r_step,
			int b_no) {
		super();
		this.r_no = r_no;
		this.r_writer = r_writer;
		this.r_pwd = r_pwd;
		this.r_content = r_content;
		this.b_wdate = b_wdate;
		this.r_level = r_level;
		this.r_step = r_step;
		this.b_no = b_no;
	}
	public CommentVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getR_no() {
		return r_no;
	}
	public void setR_no(int r_no) {
		this.r_no = r_no;
	}
	public String getR_writer() {
		return r_writer;
	}
	public void setR_writer(String r_writer) {
		this.r_writer = r_writer;
	}
	public String getR_pwd() {
		return r_pwd;
	}
	public void setR_pwd(String r_pwd) {
		this.r_pwd = r_pwd;
	}
	public String getR_content() {
		return r_content;
	}
	public void setR_content(String r_content) {
		this.r_content = r_content;
	}
	public Date getB_wdate() {
		return b_wdate;
	}
	public void setB_wdate(Date b_wdate) {
		this.b_wdate = b_wdate;
	}
	public int getR_level() {
		return r_level;
	}
	public void setR_level(int r_level) {
		this.r_level = r_level;
	}
	public int getR_step() {
		return r_step;
	}
	public void setR_step(int r_step) {
		this.r_step = r_step;
	}
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	
	
	
}