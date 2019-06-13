package com.atTrip.persistence;

import java.util.HashMap;
import java.util.List;

import com.atTrip.vo.BoardVo;

public interface BoardDao {
	
	public List<BoardVo> select(HashMap map)throws Exception;

	public BoardVo detail(int b_no)throws Exception;
	
	public int insert(BoardVo b)throws Exception;
	
	public int update(BoardVo b)throws Exception;
	
	public int delete(BoardVo b)throws Exception;
	
	public Integer getTotal(HashMap map)throws Exception;
	
	public int hitUpdate(int b_no)throws Exception;
	
	public BoardVo check(HashMap map)throws Exception;

}
