package com.atTrip.controller;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.atTrip.dao.BoardDao;
import com.atTrip.vo.BoardVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class BoardController {

	public static int pageSize = 5;
	public static int totalPage = 1;
	public static int totalRecord = 0;
	public static int pageGroup = 5;
	
	@Autowired
	private BoardDao dao;

	public void setDao(BoardDao dao) {
		this.dao = dao;
	}
	
	@RequestMapping("/listBoard.do")
	   public ModelAndView list(String pageNum, String keyword, String item,HttpSession session, HttpServletRequest request) {
	      ModelAndView m = new ModelAndView();
	      HashMap map = new HashMap();
	      // 페이징
	      int pageNumber = 1;
	      if(   pageNum != null   ) {
	         pageNumber = Integer.parseInt(pageNum);
	      }
	      // 검색
	      if(keyword != null && item != null){         
	         map.put("keyword", keyword);
	         map.put("item", item);

	         
	         m.addObject("keyword", keyword);
	         m.addObject("item", item);
	      }   
	      totalRecord = dao.getTotal(map);
	      totalPage = (int)Math.ceil(totalRecord/(double)pageSize);

	      int start = ((pageNumber-1) / pageSize) * pageSize+1;
	      int end = start+pageSize-1;
	      if (end > totalPage) {
	         end = totalPage;
	      }

	      /* 페이지의 스타트 엔드*/
	       int startRecord = (pageNumber -1)*pageSize+1;
	       int endRecord = startRecord + pageSize-1; 
	        if (endRecord > totalRecord ) {
	           endRecord = totalRecord;
	        }
	       
	      map.put("startRecord",startRecord);
	      map.put("endRecord",endRecord);
	      List<BoardVo>list = dao.select(map);
	      m.addObject("list", list);
	      m.addObject("totalPage",totalPage);
	      m.addObject("pageSize",pageSize);
	      m.addObject("pageNumber",pageNumber);
	      m.addObject("start", start);
	      m.addObject("end", end);
	      return m;

	}

	@RequestMapping("/detailBoard.do")
	public ModelAndView detail(int b_no) {
		ModelAndView m = new ModelAndView();
		BoardVo b = dao.detail(b_no);
		int hit = dao.hitUpdate(b_no);
		m.addObject("b", b);	
		return m;		
	}
	
	@RequestMapping(value="insertBoard.do", method=RequestMethod.GET)
	public void insert() {
	}
	
	@RequestMapping(value="insertBoard.do", method=RequestMethod.POST)
	public ModelAndView insert(BoardVo b) {
		
		String cont = b.getB_content();
		b.setB_content(cont.replace("\r\n", "<br>"));
		
		int re = dao.insert(b);
		ModelAndView m = new ModelAndView();
		if(re>0) {
			m.addObject(b.getB_no());
		}
		else {
			m.addObject(b.getB_no());
		}
		
		m.setViewName("redirect:/listBoard.do");
		return m;
	}
	@RequestMapping("/deleteBoard.do")
	public ModelAndView delete(int b_no) {
		ModelAndView m = new ModelAndView();
		BoardVo b = dao.detail(b_no);
		int re = dao.delete(b);
		if(re>0) {
			m.addObject("msg","삭제 성공");
		}
		else {
			m.addObject("msg", "삭제 실패");
		}
		m.setViewName("redirect:/listBoard.do");
		return m;		
	}
	
	@RequestMapping(value="updateBoard.do", method=RequestMethod.GET)
	public ModelAndView update(int b_no) {
		int bn = b_no;
		ModelAndView m = new ModelAndView();
		BoardVo b = dao.detail(b_no);
		m.addObject("b", b);
		m.addObject("bno", bn);
		m.setViewName("updateBoard");
		return m;
	}
		
	@RequestMapping(value="updateBoard.do", method=RequestMethod.POST)
	public ModelAndView update(BoardVo b) {
		int re = dao.update(b);
		ModelAndView m = new ModelAndView();
		if(re>0) {
			m.addObject(b.getB_no());
		}
		else {
			m.addObject(b.getB_no());
		}
		m.setViewName("redirect:	detailBoard.do?b_no="+b.getB_no());
		return m;
	}
	
	@RequestMapping(value="checkBoard.do", method=RequestMethod.POST)
	@ResponseBody
	public String check(String b_pwd, int b_no) {
		HashMap map = new HashMap();
		ObjectMapper mapper = new ObjectMapper();
		BoardVo b = dao.check(map);
		String str = "";
		try {
			str = mapper.writeValueAsString(b);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return str;
	}
}
