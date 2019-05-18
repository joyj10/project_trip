package com.atTrip.db;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.atTrip.vo.CityVo;
import com.atTrip.vo.CountryVo;
import com.atTrip.vo.MemberVo;
import com.atTrip.vo.PointviewVo;

public class triplistManager {
	
	public static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/atTrip/db/sqlConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}
		
	}
	
	public static CountryVo getCountryDetail(int country_no)
	{
		SqlSession session = factory.openSession();
		CountryVo country = session.selectOne("triplist.countryDetail", country_no);
		session.close();
		
		return country;
	}
	
	public static List<CityVo> getCityList(HashMap map)
	{
		SqlSession session = factory.openSession();

		List<CityVo> list = session.selectList("triplist.cityAll", map);
		session.close();
		
		return list;
	}
	
	public static List<CityVo> getCityInCountryList(int country_no)
	{
		SqlSession session = factory.openSession();
		List<CityVo> list = session.selectList("triplist.cityInCountry", country_no);
		session.close();
		
		return list;
	}
	
	public static CityVo getCityDetail(int city_no)
	{
		SqlSession session = factory.openSession();
		CityVo city = session.selectOne("triplist.cityDetail", city_no);
		session.close();
		
		return city;
	}
	
	public static List<PointviewVo> getpointviewListInCity(int city_no)
	{
		SqlSession session = factory.openSession();
		List<PointviewVo> list = session.selectList("triplist.pointviewListInCity", city_no);
		session.close();
		
		return list;
	}
	
	public static List<PointviewVo> getpointviewListInCountry(int country_no)
	{
		SqlSession session = factory.openSession();
		List<PointviewVo> list = session.selectList("triplist.pointviewListInCountry", country_no);
		session.close();
		
		return list;
	}
	
	public static PointviewVo getPointviewDetail(int pointview_no)
	{
		SqlSession session = factory.openSession();
		PointviewVo pv = session.selectOne("triplist.pointviewDetail", pointview_no);
		session.close();
		
		return pv;
	}
	
	// 메인, 네비바 검색 기능 
		public static List<CityVo> getCityKeyword(HashMap map)
		{
			SqlSession session = factory.openSession();
			List<CityVo> list = session.selectList("triplist.search_city",map);
			session.close();
			
			return list;
		}
		public static List<CountryVo> getCountryKeyword(HashMap map)
		{
			SqlSession session = factory.openSession();
			List<CountryVo> list = session.selectList("triplist.search_country",map);
			session.close();
			
			return list;
		}
		public static List<PointviewVo> getPVKeyword(HashMap map)
		{
			SqlSession session = factory.openSession();
			List<PointviewVo> list = session.selectList("triplist.search_pointview",map);
			session.close();
			
			return list;
		}
		
		
	// 나라, 도시, 관광지 조회수 증가
	public static int hitUpCountry(int country_no) {
		SqlSession session = factory.openSession();
		int re = session.update("triplist.hitUpCountry",country_no);
		session.commit();
		session.close();
		return re;
	}
	
	public static int hitUpCity(int city_no) {
		SqlSession session = factory.openSession();
		int re = session.update("triplist.hitUpCity",city_no);
		session.commit();
		session.close();
		return re;
	}
	
	public static int hitUpPointview(int pointview_no) {
		SqlSession session = factory.openSession();
		int re = session.update("triplist.hitUpPV",pointview_no);
		session.commit();
		session.close();
		return re;
	}
	
	
	//메인에서 큐레이션 하는 회원은 정보를 가져오는 메소드
		public static MemberVo infoM(int m_no){ 

			SqlSession session = factory.openSession();
			
			MemberVo mv = session.selectOne("triplist.mInfo",m_no);
			session.close();
			return mv;
		}
		
	//도시 이름으로 도시 번호 가져오는 메소드
	public static List<Integer> getCountryNoBycity(HashMap map){
		SqlSession session = factory.openSession();
		System.out.println(map.get("m_country_name"));
		List<Integer> arr = session.selectList("triplist.getCountryNo", map);
		return arr;
		
	}
}
