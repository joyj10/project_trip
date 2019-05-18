package com.atTrip.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.LoginManager;
import com.atTrip.db.triplistManager;
import com.atTrip.vo.CityVo;
import com.atTrip.vo.MemberVo;
import com.atTrip.vo.PointviewVo;

@Repository
public class CityDao {
	
	//도시 전체 리스트 받는 메소드
	public List<CityVo> getCityList( HashMap map)
	{
		return triplistManager.getCityList(map);
	}
	
	// 해당 나라의 도시 리스트 받는 메소드
	public List<CityVo> getCityInCountryList(int country_no)
	{
		return triplistManager.getCityInCountryList(country_no);
	}
	
	// 해당 도시의 상세페이지 정보 받는 메소드
	public CityVo getCityDetail(int city_no)
	{
		return triplistManager.getCityDetail(city_no);
	}
	
	// 조회수 증가 메소드
	public int hitUpCity(int city_no)
	{
		return triplistManager.hitUpCity(city_no);
	}
	
	// 회원 정보를 가져오는 메소드
	public MemberVo mInfo(int m_no){
		return triplistManager.infoM(m_no);
	}
	
	//나라 이름으로 나라 번호 가져오는 메소드
	public List<Integer> getCountryNo(HashMap map){
		return triplistManager.getCountryNoBycity(map);
	}
}
