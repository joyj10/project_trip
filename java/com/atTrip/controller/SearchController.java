package com.atTrip.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atTrip.dao.SearchDao;
import com.atTrip.vo.CityVo;
import com.atTrip.vo.CountryVo;
import com.atTrip.vo.PointviewVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class SearchController {

	@Autowired
	private SearchDao dao;

	public void setDao(SearchDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping(value="searchCity" ,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getCityKeyword(String keyword)
	{
		String str="";
		ObjectMapper mapper = new ObjectMapper();
		
		HashMap map = new HashMap();
		map.put("keyword", keyword);
		
		List<CityVo> list = dao.getCityKeyword(map);
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="searchCountry" ,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getCountryKeyword(String keyword)
	{
		String str="";
		ObjectMapper mapper = new ObjectMapper();
		
		HashMap map = new HashMap();
		map.put("keyword", keyword);
		
		List<CountryVo> list = dao.getCountryKeyword(map);
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return str;
	}
	
	@RequestMapping(value="searchPV" ,produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getPvKeyword(String keyword)
	{
		String str="";
		ObjectMapper mapper = new ObjectMapper();
		
		HashMap map = new HashMap();
		map.put("keyword", keyword);
		
		List<PointviewVo> list = dao.getPVKeyword(map);
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return str;
	}
}
