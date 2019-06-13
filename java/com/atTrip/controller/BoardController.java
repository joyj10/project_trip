package com.atTrip.controller;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.atTrip.service.BoardService;
import com.atTrip.vo.BoardVo;

@Controller
public class BoardController {

	
	@Autowired
	private BoardService service;
	
	
	
	@RequestMapping("/listBoard.do")
	public ModelAndView list(String pageNum, String keyword, String item)throws Exception {
      ModelAndView m = new ModelAndView();
      HashMap map = new HashMap();
      
      // 페이지 번호
      int pageNumber = 1;
      if(   pageNum != null   ) {
         pageNumber = Integer.parseInt(pageNum);
      }
      map.put("pageNum",pageNumber);
      
      // 검색
      if(keyword != null && item != null){         
         map.put("keyword", keyword);
         map.put("item", item);
         m.addObject("keyword", keyword);
         m.addObject("item", item);
      }
      	      
      //Service method
      HashMap pageMap= service.getPageInfo(map);
      List<BoardVo> list = service.list(map);
      
      m.addObject("list", list);
      m.addObject("totalPage",pageMap.get("totalPage"));
      m.addObject("pageSize",pageMap.get("pageSize"));
      m.addObject("pageNumber",pageMap.get("pageNumber"));
      m.addObject("start", pageMap.get("start"));
      m.addObject("end", pageMap.get("end"));
      
      return m;

	}
	
	
	@RequestMapping("/detailBoard.do")
	public ModelAndView detail(int b_no)throws Exception {
		ModelAndView m = new ModelAndView();
		m.addObject("b", service.detail(b_no));	
		return m;		
	}
	
	@RequestMapping(value="insertBoard.do", method=RequestMethod.GET)
	public void insert() {
	}
	
	@RequestMapping(value="insertBoard.do", method=RequestMethod.POST)
	public String insert(BoardVo b)throws Exception {
	
		service.insert(b);
		
		return "redirect:/listBoard.do";
	}
	
	@RequestMapping("/deleteBoard.do")
	public String delete(int b_no)throws Exception {
		service.delete(b_no);
		return "redirect:/listBoard.do";		
	}
	
	@RequestMapping(value="updateBoard.do", method=RequestMethod.GET)
	public ModelAndView update(int b_no)throws Exception {
		ModelAndView m = new ModelAndView();
		
		m.addObject("b", service.detail(b_no));

		return m;
	}
		
	@RequestMapping(value="updateBoard.do", method=RequestMethod.POST)
	public ModelAndView update(BoardVo b)throws Exception {
		ModelAndView m = new ModelAndView();
		service.update(b);
		m.setViewName("redirect:detailBoard.do?b_no="+b.getB_no());
		return m;
	}

}
