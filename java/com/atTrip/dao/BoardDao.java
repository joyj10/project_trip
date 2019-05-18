package com.atTrip.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.BoardManager;
import com.atTrip.vo.BoardVo;

@Repository
public class BoardDao {

	public List<BoardVo> select(HashMap map){
		return BoardManager.select(map);
	}

	public BoardVo detail(int b_no) {
		return BoardManager.detail(b_no);
	}
	
	public int insert(BoardVo b) {
		return BoardManager.insert(b);
	}
	
	public int update(BoardVo b) {
		return BoardManager.update(b);
	}
	
	public int delete(BoardVo b) {
		return BoardManager.delete(b);
	}
	
	public Integer getTotal(HashMap map) {
		return BoardManager.getTotal(map);
	}
	
	public int hitUpdate(int b_no) {
		return BoardManager.hitUpdate(b_no);
	}
	
	public BoardVo check(HashMap map) {
		return BoardManager.check(map);
	}
}
