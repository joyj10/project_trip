package com.atTrip.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atTrip.dao.LikeDao;
import com.atTrip.vo.LikeVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class likeController {
	
	@Autowired
	private LikeDao dao;
	
	public void setDao(LikeDao dao) {
		this.dao = dao;
	}
	
	ObjectMapper mapper = new ObjectMapper();
	
	@RequestMapping(value="/likeBtnInsert.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String likeFill(LikeVo l)
	{
		String str="";
		
		str = Integer.toString( dao.likeInsert(l) );
		
		return str;
	}
	
	@RequestMapping(value="/likeBtnDelete.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String likeDelete(LikeVo l){
		String str ="";
		str=""+dao.likeDelete(l);
		return str;
	}
	
	@RequestMapping(value="/likeNumberListMember.do", produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String likeNumberListMember(LikeVo lv)
	{
		String str = "";
		
		List<Integer> list =  dao.likeListMember(lv);
		
		try {
			str = mapper.writeValueAsString(list);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
		return str;
	}
	
}
