package com.atTrip.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.type.TypeReference;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.atTrip.dao.PlanDao;
import com.atTrip.vo.CityVo;
import com.atTrip.vo.LikeVo;
import com.atTrip.vo.PlanNoteVo;
import com.atTrip.vo.PlanVo;
import com.atTrip.vo.PointviewVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class PlanController {
	
	@Autowired
	public PlanDao dao;
	public void setDao(PlanDao dao) {
		this.dao = dao;
    }

	@RequestMapping(value="/makeplan.do",method = RequestMethod.GET)
	public ModelAndView listcity() {
		ModelAndView m = new ModelAndView();
		m.addObject("m", dao.citylist());		
		return m;
	}
	@RequestMapping(value="/makeplan.do",method = RequestMethod.POST)
	public ModelAndView insertcity(PlanVo vo,HttpSession session,HttpServletRequest request) {
		CityVo g = new CityVo();
		int city_no = vo.getCity_no();
		
		
		g = dao.cityName(city_no);
		
		String city_name_kor = g.getCity_name_kor();
		String plan_image = g.getCity_image1();
		Date s_day = vo.getPlan_startday();
		Date e_day = vo.getPlan_endday();
		long day = s_day.getTime()-e_day.getTime();
		long calDateDays = day / ( 24*60*60*1000);

		calDateDays = Math.abs(calDateDays);
		
		int calDateDay = (int)calDateDays;

		vo.setCity_name(city_name_kor);
		vo.setPlan_image(plan_image);
		vo.setPlan_day(calDateDay);
		int re = dao.insertPlan(vo);

		ModelAndView m = new ModelAndView();
			
		
		m.addObject("m", vo);

		return m;
	}
	@RequestMapping("/plan.do")
	public ModelAndView listplan(HttpSession session) {

		ModelAndView m = new ModelAndView();
		return m;
	}
	@RequestMapping(value="/makeplanUpdate.do",method = RequestMethod.GET)
	public ModelAndView updateplan(int plan_no,HttpSession session) {

		ModelAndView m = new ModelAndView();
	
		m.addObject("m", dao.selectPlan1(plan_no));			
		return m;
	}
	
	@RequestMapping(value="/planlist01",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String list(HttpSession session, int m_no) 
       {
		
		String str="";
		
		ObjectMapper mapper = new ObjectMapper();
		List<PlanVo> list =dao.planlist(m_no);

		try {
		str =mapper.writeValueAsString(list);
		
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		
		return str;
	   }
	
	
	
	
	@RequestMapping(value="/planline.do",method = RequestMethod.POST)
	public ModelAndView submit(PlanVo vo,HttpSession session,HttpServletRequest request) 
       {

		CityVo g = new CityVo();
		int city_no = vo.getCity_no();
		
		g = dao.cityName(city_no);
		
		String city_name_kor = g.getCity_name_kor();
		String plan_image = g.getCity_image1();
		Date s_day = vo.getPlan_startday();
		Date e_day = vo.getPlan_endday();
		long day = s_day.getTime()-e_day.getTime();
		long calDateDays = day / ( 24*60*60*1000);

		calDateDays = Math.abs(calDateDays);
		
		int calDateDay = (int)calDateDays;
		
		vo.setCity_name(city_name_kor);
		vo.setPlan_image(plan_image);
		vo.setPlan_day(calDateDay);
		
		int re = dao.insertPlan(vo);

		int plan_no = dao.maxPlan();
		
		vo.setPlan_no(plan_no);
 
		ModelAndView m = new ModelAndView();
			
		
		m.addObject("m", vo);

		return m;
	   }

	@RequestMapping(value="/planline.do",method = RequestMethod.GET)
	public ModelAndView submitget(@RequestParam(value="plan_no", defaultValue="1")int plan_no,HttpSession session) 
       {

		PlanVo list =dao.listPl(plan_no);
		
		ModelAndView m = new ModelAndView();
		
		m.addObject("m", list);
		
		return m;
	
	   }
	
	@RequestMapping(value="/planlinelist.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String plannotelist(HttpSession session,@RequestParam(value="plan_no", defaultValue="1")int plan_no,@RequestParam(value="plannote_datecnt", defaultValue="1")int plannote_datecnt) 
       {
			String str="";
	
			HashMap map = new HashMap();
			map.put("plan_no", plan_no);
			map.put("plannote_datecnt", 1);
			
			ObjectMapper mapper = new ObjectMapper();
			List<PlanNoteVo> list =dao.planline(map);
			try {
			str =mapper.writeValueAsString(list);
			}catch(Exception ex) {
				System.out.println(ex.getMessage());
			}
			
			return str;
	   }
	@RequestMapping(value="/planlinelist2.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String plannotelist2(HttpSession session,@RequestParam(value="plan_no", defaultValue="1")int plan_no,@RequestParam(value="plannote_datecnt", defaultValue="1")int plannote_datecnt) 
       {
		
		String str="";
		HashMap map = new HashMap();
		map.put("plan_no", plan_no);
		map.put("plannote_datecnt", plannote_datecnt);

		
		ObjectMapper mapper = new ObjectMapper();
		List<PlanNoteVo> list =dao.planline(map);
		try {
		str =mapper.writeValueAsString(list);
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		
		return str;
	   }
	@RequestMapping(value="/planlinelike.do",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String planlike(HttpSession session, int m_no, int plan_no) 
       {
		
		PlanVo vv = new PlanVo();
		String str="";

		vv = dao.listPl(plan_no);
		int city_no = vv.getCity_no();
		HashMap map = new HashMap();
		map.put("city_no", city_no);
		map.put("m_no", m_no);
		ObjectMapper mapper = new ObjectMapper();
		List<LikeVo> list =dao.likelist(map);
		
		try {
		str =mapper.writeValueAsString(list);
		
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		
		return str;
	   }
       @RequestMapping(value="/planpoint.do",produces="text/plain;charset=utf-8")
		@ResponseBody
		public String planpoint(HttpSession session,int plan_no) 
	       {
    	   PlanVo vo;

			String str="";

			ObjectMapper mapper = new ObjectMapper();
			 vo = dao.listPl(plan_no);
			 int city_no = vo.getCity_no();
			List<PointviewVo> list =dao.pointlist(city_no);

			try {
			str =mapper.writeValueAsString(list);
			
			}catch(Exception ex) {
				System.out.println(ex.getMessage());
			}
			
			return str;
		   }
       @RequestMapping(value = "/delPlan",produces="text/plain;charset=utf-8")
       @ResponseBody
    	public String delPlan(int plan_no,HttpSession session) 
    	{
    	   
	   		int re = 0;
	   		int i;
	   		
	   		String str="";
	   		int redel1 = dao.deletenote1(plan_no);	
	   		int redel = dao.deleteplan(plan_no);
	   		
    	   	return str;
    	   			
    	}
       @RequestMapping(value = "/savePlannote",produces="text/plain;charset=utf-8")
       @ResponseBody
    	public String plannote(PlanNoteVo g,HttpSession session) 
    	{

	   		int re = 0;
	   		int i;
	   		
	   		String str="";
	   			
	   		HashMap map = new HashMap();
			map.put("plan_no", g.getPlan_no());
			map.put("plannote_datecnt", g.getPlannote_datecnt());
	   		int redel = dao.deletenote(map);
	   		
			re = dao.insertPlannote(g);
       
    	   	return str;
    	   			
    	}

       
	
}
