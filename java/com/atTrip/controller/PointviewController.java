package com.atTrip.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.atTrip.dao.PointviewDao;
import com.atTrip.vo.PointviewVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class PointviewController {
	
	@Autowired
	private PointviewDao dao;

	public void setDao(PointviewDao dao) {
		this.dao = dao;
	}
	
	ObjectMapper mapper = new ObjectMapper();
	
	@RequestMapping(value="pointviewList.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getPointviewListInCity(String no )
	{
		String str="";
		
		int city_no = Integer.parseInt(no);
		
		List<PointviewVo> list = dao.pointviewListInCity(city_no);
		
		try {
			str = mapper.writeValueAsString(list);
			
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}

		return str;
	}
	
	
	@RequestMapping(value="pointviewListInCountry.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String getPointviewListInCountry(int country_no)
	{
		String str = "";
		
		List<PointviewVo> list = dao.pointviewListInCountry(country_no);
		
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		
		return str;
	}
	
	@RequestMapping("pointview")
	public ModelAndView pointviewDetail(int no)
	{
		ModelAndView mav = new ModelAndView();
		
		PointviewVo pv = dao.getPointviewDetail(no);
		mav.addObject("pv", pv);
		return mav;
	}
}
