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
	
	//���� ��ü ����Ʈ �޴� �޼ҵ�
	public List<CityVo> getCityList( HashMap map)
	{
		return triplistManager.getCityList(map);
	}
	
	// �ش� ������ ���� ����Ʈ �޴� �޼ҵ�
	public List<CityVo> getCityInCountryList(int country_no)
	{
		return triplistManager.getCityInCountryList(country_no);
	}
	
	// �ش� ������ �������� ���� �޴� �޼ҵ�
	public CityVo getCityDetail(int city_no)
	{
		return triplistManager.getCityDetail(city_no);
	}
	
	// ��ȸ�� ���� �޼ҵ�
	public int hitUpCity(int city_no)
	{
		return triplistManager.hitUpCity(city_no);
	}
	
	// ȸ�� ������ �������� �޼ҵ�
	public MemberVo mInfo(int m_no){
		return triplistManager.infoM(m_no);
	}
	
	//���� �̸����� ���� ��ȣ �������� �޼ҵ�
	public List<Integer> getCountryNo(HashMap map){
		return triplistManager.getCountryNoBycity(map);
	}
}
