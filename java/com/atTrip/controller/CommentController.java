package com.atTrip.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atTrip.dao.CommentDao;
import com.atTrip.vo.CommentVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class CommentController {
	
	@Autowired
	private CommentDao dao;

	public void setDao(CommentDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping(value="/listComment.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String list(int b_no) {
		ObjectMapper mapper = new ObjectMapper();
		List<CommentVo> list = dao.select(b_no);
		String str = "";
		try {
			str = mapper.writeValueAsString(list);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;		
	}
	
	@RequestMapping(value="/insertComment.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String insert(String name, String pwd, String subject, int b_no,int r_step,int r_no) {
		HashMap map = new HashMap();
		map.put("r_writer", name);
		map.put("r_pwd", pwd);
		map.put("r_content", subject);
		map.put("b_no", b_no);
		map.put("r_step", r_step);
		map.put("r_no", r_no);
		String str = "";
		int re = dao.insert(map);
		str = re + "";
		return str;		
	}	
	
	@RequestMapping(value="/updateComment.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String update(String r_content, int r_no) {
		HashMap map = new HashMap();
		map.put("r_content", r_content);
		map.put("r_no", r_no);
		String str = "";
		int re = dao.update(map);		
		str = re + "";
		return str;		
	}	
	
	@RequestMapping(value="/deleteComment.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String delete(int r_no) {
		HashMap map = new HashMap();
		map.put("r_no", r_no);
		String str = "";
		int re = dao.delete(map);
		str = re + "";
		return str;		
	}	
	
	@RequestMapping(value="/re_updateComment.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String update(String r_content, int r_no,int r_step,int r_level) {
		HashMap map = new HashMap();
		map.put("r_content", r_content);
		map.put("r_no", r_no);
		map.put("r_step", r_step);
		map.put("r_level", r_level);
		String str = "";
		int re = dao.re_update(map);		
		str = re + "";
		return str;		
	}	
	
	@RequestMapping(value="/re_deleteComment.do",produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String re_delete(int r_no, int r_step, int r_level) {
		HashMap map = new HashMap();
		map.put("r_no", r_no);
		map.put("r_step", r_step);
		map.put("r_level", r_level);
		String str = "";
		int re = dao.re_delete(map);
		str = re + "";
		return str;		
	}	
	
	
}
