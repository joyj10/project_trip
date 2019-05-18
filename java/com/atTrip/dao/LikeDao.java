package com.atTrip.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.likeManager;
import com.atTrip.vo.LikeVo;

@Repository
public class LikeDao {
	
	public int likeInsert(LikeVo l)
	{
		return likeManager.likeInsert(l);
	}
	
	public int likeDelete(LikeVo l)
	{
		return likeManager.likeDelete(l);
	}
	
	public List<Integer> likeListMember(LikeVo lv)
	{
		return likeManager.likeListMember(lv);
	}
}
