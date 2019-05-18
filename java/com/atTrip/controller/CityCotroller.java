package com.atTrip.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.atTrip.dao.CityDao;
import com.atTrip.vo.CityVo;
import com.atTrip.vo.MemberVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class CityCotroller {

	@Autowired
	private CityDao dao;

	public void setDao(CityDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping(value="/cityList.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getMainInfo(String m_no)
	{
		String str = "";
		
		ObjectMapper mapper = new ObjectMapper();
		HashMap map = new HashMap();
		
		if (m_no != "" & m_no !=null) {
			MemberVo mv = dao.mInfo(Integer.parseInt(m_no));
			String m_interest = mv.getM_interest();
			String m_style = mv.getM_style();

			
			if (m_interest !=null) {
				String []m_ci = m_interest.split(";");
				ArrayList<String> m_city_name = new ArrayList<String>(Arrays.asList(m_ci));

				map.put("m_city", m_city_name);

			}
			if(m_style != null) {
				String []m_s = m_style.split(";");
				ArrayList<String> m_style_arr = new ArrayList<String>(Arrays.asList(m_s));
				
				map.put("m_style_arr",m_style_arr.get(0));
			}
		}
		
		List<CityVo> list = dao.getCityList(map);
		
		if (list.size() < 8 ) {
			HashMap map2 = new HashMap();
			List<CityVo> list2 = dao.getCityList(map2);
			list.addAll(list2);
		}

		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}

		
		return str;
	}
	
	@RequestMapping(value="/cityInCountryList.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String cityinCountry(int no)
	{
		String str = "";

		ObjectMapper mapper = new ObjectMapper();
		
		List<CityVo> list = dao.getCityInCountryList(no);
		
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		return str;
	}
	
	

	@RequestMapping(value="/city/*")
	public ModelAndView cityDetail(int no)
	{
		ModelAndView mav = new ModelAndView();
		
		int re = dao.hitUpCity(no);
		
		mav.addObject("city", dao.getCityDetail(no));
		mav.setViewName("city");
		return mav;
	}
	
}
