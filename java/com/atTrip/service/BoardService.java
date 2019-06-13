package com.atTrip.service;

import java.util.HashMap;
import java.util.List;

import com.atTrip.vo.BoardVo;

public interface BoardService {
	
	public HashMap getPageInfo(HashMap map)throws Exception;
	
	public List<BoardVo> list(HashMap map)throws Exception;

	public BoardVo detail(int b_no)throws Exception;
		
	public Integer insert(BoardVo b)throws Exception;
	
	public Integer delete(int b_no)throws Exception;
	
	public BoardVo updateDetail(int b_no)throws Exception;
		
	public Integer update(BoardVo b)throws Exception;
	
}
