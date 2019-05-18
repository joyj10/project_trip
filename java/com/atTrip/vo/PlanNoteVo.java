package com.atTrip.vo;

import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

public class PlanNoteVo {
	private int plannote_no;
	private int plan_no;
	private int pointview_no;
	private String pointview_name;
	private String pointview_addr;
	private String plannote_image;
	private Date plannote_startday;
	private Date plannote_endday;
	private int plannote_datecnt;
	private int plannote_order;
	private String plan_name;
	private String city_name;
	private int plan_day;
	private String plannote_location_x;
	private String plannote_location_y;
	public PlanNoteVo(int plannote_no, int plan_no, int pointview_no, String pointview_name, String pointview_addr,
			String plannote_image, Date plannote_startday, Date plannote_endday, int plannote_datecnt,
			int plannote_order, String plan_name, String city_name, int plan_day, String plannote_location_x,
			String plannote_location_y) {
		super();
		this.plannote_no = plannote_no;
		this.plan_no = plan_no;
		this.pointview_no = pointview_no;
		this.pointview_name = pointview_name;
		this.pointview_addr = pointview_addr;
		this.plannote_image = plannote_image;
		this.plannote_startday = plannote_startday;
		this.plannote_endday = plannote_endday;
		this.plannote_datecnt = plannote_datecnt;
		this.plannote_order = plannote_order;
		this.plan_name = plan_name;
		this.city_name = city_name;
		this.plan_day = plan_day;
		this.plannote_location_x = plannote_location_x;
		this.plannote_location_y = plannote_location_y;
	}
	public PlanNoteVo() {
		super();
		// TODO Auto-generated constructor stub
	}
	public int getPlannote_no() {
		return plannote_no;
	}
	public void setPlannote_no(int plannote_no) {
		this.plannote_no = plannote_no;
	}
	public int getPlan_no() {
		return plan_no;
	}
	public void setPlan_no(int plan_no) {
		this.plan_no = plan_no;
	}
	public int getPointview_no() {
		return pointview_no;
	}
	public void setPointview_no(int pointview_no) {
		this.pointview_no = pointview_no;
	}
	public String getPointview_name() {
		return pointview_name;
	}
	public void setPointview_name(String pointview_name) {
		this.pointview_name = pointview_name;
	}
	public String getPointview_addr() {
		return pointview_addr;
	}
	public void setPointview_addr(String pointview_addr) {
		this.pointview_addr = pointview_addr;
	}
	public String getPlannote_image() {
		return plannote_image;
	}
	public void setPlannote_image(String plannote_image) {
		this.plannote_image = plannote_image;
	}
	public Date getPlannote_startday() {
		return plannote_startday;
	}
	public void setPlannote_startday(Date plannote_startday) {
		this.plannote_startday = plannote_startday;
	}
	public Date getPlannote_endday() {
		return plannote_endday;
	}
	public void setPlannote_endday(Date plannote_endday) {
		this.plannote_endday = plannote_endday;
	}
	public int getPlannote_datecnt() {
		return plannote_datecnt;
	}
	public void setPlannote_datecnt(int plannote_datecnt) {
		this.plannote_datecnt = plannote_datecnt;
	}
	public int getPlannote_order() {
		return plannote_order;
	}
	public void setPlannote_order(int plannote_order) {
		this.plannote_order = plannote_order;
	}
	public String getPlan_name() {
		return plan_name;
	}
	public void setPlan_name(String plan_name) {
		this.plan_name = plan_name;
	}
	public String getCity_name() {
		return city_name;
	}
	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}
	public int getPlan_day() {
		return plan_day;
	}
	public void setPlan_day(int plan_day) {
		this.plan_day = plan_day;
	}
	public String getPlannote_location_x() {
		return plannote_location_x;
	}
	public void setPlannote_location_x(String plannote_location_x) {
		this.plannote_location_x = plannote_location_x;
	}
	public String getPlannote_location_y() {
		return plannote_location_y;
	}
	public void setPlannote_location_y(String plannote_location_y) {
		this.plannote_location_y = plannote_location_y;
	}
	

	
	

	
}
