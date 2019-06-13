package com.atTrip.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.atTrip.persistence.BoardDao;
import com.atTrip.vo.BoardVo;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao dao;

	public void setDao(BoardDao dao) {
		this.dao = dao;
	}
	
	public static int pageSize = 5;
	public static int totalPage = 1;
	public static int totalRecord = 0;
	public static int pageGroup = 5;
	private int pageNumber=1;
	
	
	@Override
	public HashMap getPageInfo(HashMap map) throws Exception {
		
		HashMap pageMap = new HashMap();
		
		totalRecord = dao.getTotal(map);
	    totalPage = (int)Math.ceil(totalRecord/(double)pageSize);

	    pageNumber = (Integer) map.get("pageNum");	    
	    
	    int start = ( (pageNumber-1) / pageSize) * pageSize+1;
	    int end = start+pageSize-1;
	    if (end > totalPage) {
	        end = totalPage;
	    }
	    
	    pageMap.put("totalPage",totalPage );
	    pageMap.put("pageSize",pageSize);
	    pageMap.put("pageNumber",pageNumber);
	    pageMap.put("start", start);
	    pageMap.put("end", end);
	    
		return pageMap;
	}
	
	@Override
	public List<BoardVo> list(HashMap map)throws Exception {
		
		/* ÆäÀÌÁöÀÇ ½ºÅ¸Æ® ¿£µå*/
	    int startRecord = (pageNumber -1)*pageSize+1;
	    int endRecord = startRecord + pageSize-1; 
	    if (endRecord > totalRecord ) {
	         endRecord = totalRecord;
	    }
	    
	    map.put("startRecord",startRecord);
	    map.put("endRecord",endRecord);
	    
		List<BoardVo>list = dao.select(map);
	      
	    return list;
		
	}

	

	@Override
	public BoardVo detail(int b_no) throws Exception {

		BoardVo b = dao.detail(b_no);
		dao.hitUpdate(b_no);
		
		return b;
	}

	@Override
	public Integer insert(BoardVo b) throws Exception {
		
		String cont = b.getB_content();
		b.setB_content(cont.replace("\r\n", "<br>"));
		
		return dao.insert(b);
	}

	
	@Override
	public Integer delete(int b_no) throws Exception{

		BoardVo b = dao.detail(b_no);
		int re = dao.delete(b);

		return re;
	}

	@Override
	public BoardVo updateDetail(int b_no) throws Exception {
		
		return dao.detail(b_no);
	}

	@Override
	public Integer update(BoardVo b) throws Exception {
		
		return dao.update(b);
	}

}
