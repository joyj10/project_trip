package com.atTrip.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.triplistManager;
import com.atTrip.vo.PointviewVo;

@Repository
public class PointviewDao {
	
	//�ش� ������ ��� ������ ����Ʈ �������� �޼ҵ�
	public List<PointviewVo> pointviewListInCity(int city_no)
	{
		return triplistManager.getpointviewListInCity(city_no);
	}
	
	//�ش� ������ ��� ������ ����Ʈ �������� �޼ҵ�
	public List<PointviewVo> pointviewListInCountry(int country_no)
	{
		return triplistManager.getpointviewListInCountry(country_no);
	}
	
	//������ ���� ���� �������� �޼ҵ�
	public PointviewVo getPointviewDetail(int pointview_no)
	{
		return triplistManager.getPointviewDetail(pointview_no);
	}
}
