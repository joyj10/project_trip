package com.atTrip.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.triplistManager;
import com.atTrip.vo.CityVo;
import com.atTrip.vo.CountryVo;
import com.atTrip.vo.PointviewVo;

@Repository
public class SearchDao {
	
	public List<CityVo> getCityKeyword(HashMap map)
	{
		return triplistManager.getCityKeyword(map);
	}
	
	public List<CountryVo> getCountryKeyword(HashMap map)
	{
		return triplistManager.getCountryKeyword(map);
	}
	
	public List<PointviewVo> getPVKeyword(HashMap map)
	{
		return triplistManager.getPVKeyword(map);
	}
}
