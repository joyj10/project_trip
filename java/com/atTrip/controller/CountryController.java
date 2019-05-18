package com.atTrip.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.atTrip.dao.CountryDao;

@Controller
public class CountryController {
	
	@Autowired
	private CountryDao dao;

	public void setDao(CountryDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping("/country/*")
	public ModelAndView getCountryDetail(int no)
	{
		ModelAndView mav = new ModelAndView();
		
		int re = dao.hitUpCountry(no);
		
		mav.addObject("country", dao.getCountryDetail(no));
		mav.setViewName("country");
		return mav;
	}
}
