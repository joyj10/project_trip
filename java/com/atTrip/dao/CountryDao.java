package com.atTrip.dao;

import org.springframework.stereotype.Repository;

import com.atTrip.db.triplistManager;
import com.atTrip.vo.CountryVo;

@Repository
public class CountryDao {

	public CountryVo getCountryDetail(int country_no)
	{
		return triplistManager.getCountryDetail(country_no);
	}
	
	// ��ȸ�� ���� �޼ҵ�
	public int hitUpCountry(int country_no)
	{
		return triplistManager.hitUpCountry(country_no);
	}
}
