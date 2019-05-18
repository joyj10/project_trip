package com.atTrip.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.CommentManager;
import com.atTrip.vo.CommentVo;

@Repository
public class CommentDao {
	
	public List<CommentVo> select(int b_no){
		return CommentManager.select(b_no);
	}

	public int insert(HashMap map) {
		return CommentManager.insert(map);
	}
	
	public int update(HashMap map) {
		return CommentManager.update(map);
	}
	
	public int delete(HashMap map) {
		return CommentManager.delete(map);
	}
	
	public int re_update(HashMap map) {
		return CommentManager.re_update(map);
	}
	
	public int re_delete(HashMap map) {
		return CommentManager.re_delete(map);
	}
	
}
