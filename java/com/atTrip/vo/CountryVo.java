package com.atTrip.vo;

public class CountryVo {
	
	private int country_no;
	private String country_name_kor;
	private String country_name_eng;
	private String country_topinfo;
	private String country_info;
	private String country_money;
	private String country_language;
	private String country_image1;
	private String country_image2;
	private String country_image3;
	private String country_image4;
	private String country_location_X;
	private String country_location_Y;
	private int country_hit;
	private int country_liketot;
	
	
	public CountryVo(int country_no, String country_name_kor, String country_name_eng, String country_topinfo,
			String country_info, String country_money, String country_language, String country_image1,
			String country_image2, String country_image3, String country_image4, String country_location_X,
			String country_location_Y, int country_hit, int country_liketot) {
		super();
		this.country_no = country_no;
		this.country_name_kor = country_name_kor;
		this.country_name_eng = country_name_eng;
		this.country_topinfo = country_topinfo;
		this.country_info = country_info;
		this.country_money = country_money;
		this.country_language = country_language;
		this.country_image1 = country_image1;
		this.country_image2 = country_image2;
		this.country_image3 = country_image3;
		this.country_image4 = country_image4;
		this.country_location_X = country_location_X;
		this.country_location_Y = country_location_Y;
		this.country_hit = country_hit;
		this.country_liketot = country_liketot;
	}
	public CountryVo() {
		super();
	}
	public int getCountry_no() {
		return country_no;
	}
	public void setCountry_no(int country_no) {
		this.country_no = country_no;
	}
	public String getCountry_name_kor() {
		return country_name_kor;
	}
	public void setCountry_name_kor(String country_name_kor) {
		this.country_name_kor = country_name_kor;
	}
	public String getCountry_name_eng() {
		return country_name_eng;
	}
	public void setCountry_name_eng(String country_name_eng) {
		this.country_name_eng = country_name_eng;
	}
	public String getCountry_topinfo() {
		return country_topinfo;
	}
	public void setCountry_topinfo(String country_topinfo) {
		this.country_topinfo = country_topinfo;
	}
	public String getCountry_info() {
		return country_info;
	}
	public void setCountry_info(String country_info) {
		this.country_info = country_info;
	}
	
	public String getCountry_money() {
		return country_money;
	}
	public void setCountry_money(String country_money) {
		this.country_money = country_money;
	}
	public String getCountry_language() {
		return country_language;
	}
	public void setCountry_language(String country_language) {
		this.country_language = country_language;
	}
	public String getCountry_image1() {
		return country_image1;
	}
	public void setCountry_image1(String country_image1) {
		this.country_image1 = country_image1;
	}
	public String getCountry_image2() {
		return country_image2;
	}
	public void setCountry_image2(String country_image2) {
		this.country_image2 = country_image2;
	}
	public String getCountry_image3() {
		return country_image3;
	}
	public void setCountry_image3(String country_image3) {
		this.country_image3 = country_image3;
	}
	public String getCountry_image4() {
		return country_image4;
	}
	public void setCountry_image4(String country_image4) {
		this.country_image4 = country_image4;
	}
	public String getCountry_location_X() {
		return country_location_X;
	}
	public void setCountry_location_X(String country_location_X) {
		this.country_location_X = country_location_X;
	}
	public String getCountry_location_Y() {
		return country_location_Y;
	}
	public void setCountry_location_Y(String country_location_Y) {
		this.country_location_Y = country_location_Y;
	}
	public int getCountry_hit() {
		return country_hit;
	}
	public void setCountry_hit(int country_hit) {
		this.country_hit = country_hit;
	}
	public int getCountry_liketot() {
		return country_liketot;
	}
	public void setCountry_liketot(int country_liketot) {
		this.country_liketot = country_liketot;
	}
	
	
}
