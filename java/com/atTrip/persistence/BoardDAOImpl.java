package com.atTrip.persistence;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.BoardManager;
import com.atTrip.vo.BoardVo;

@Repository
public class BoardDAOImpl implements BoardDao {

	@Override
	public List<BoardVo> select(HashMap map) throws Exception {
		return BoardManager.select(map);
	}

	@Override
	public BoardVo detail(int b_no) throws Exception {
		return  BoardManager.detail(b_no);
	}

	@Override
	public int insert(BoardVo b) throws Exception {
		return BoardManager.insert(b);
	}

	@Override
	public int update(BoardVo b) throws Exception {
		return BoardManager.update(b);
	}

	@Override
	public int delete(BoardVo b) throws Exception {
		return BoardManager.delete(b);
	}

	@Override
	public Integer getTotal(HashMap map) throws Exception {
		return BoardManager.getTotal(map);
	}

	@Override
	public int hitUpdate(int b_no) throws Exception {
		return BoardManager.hitUpdate(b_no);
	}

	@Override
	public BoardVo check(HashMap map) throws Exception {
		return BoardManager.check(map);
	}

}
