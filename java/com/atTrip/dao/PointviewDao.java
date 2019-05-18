package com.atTrip.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.triplistManager;
import com.atTrip.vo.PointviewVo;

@Repository
public class PointviewDao {
	
	//해당 도시의 모든 관광지 리스트 가져오는 메소드
	public List<PointviewVo> pointviewListInCity(int city_no)
	{
		return triplistManager.getpointviewListInCity(city_no);
	}
	
	//해당 나라의 모든 관광지 리스트 가져오는 메소드
	public List<PointviewVo> pointviewListInCountry(int country_no)
	{
		return triplistManager.getpointviewListInCountry(country_no);
	}
	
	//관광지 세부 정보 가져오는 메소드
	public PointviewVo getPointviewDetail(int pointview_no)
	{
		return triplistManager.getPointviewDetail(pointview_no);
	}
}
