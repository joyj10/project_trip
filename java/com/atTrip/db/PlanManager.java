package com.atTrip.db;

import java.io.Reader;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.atTrip.vo.CityVo;
import com.atTrip.vo.LikeVo;
import com.atTrip.vo.PlanNoteVo;
import com.atTrip.vo.PlanVo;
import com.atTrip.vo.PointviewVo;

public class PlanManager {
	public static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/atTrip/db/sqlConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
		}catch(Exception ex1) {
			System.out.println(ex1.getMessage());
		}
	}
	public static List<CityVo> listCity(){
		List<CityVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("plan.selectCity");
		
		session.close();
		return list;
	}
	public static List<PointviewVo> listPoint(int city_no){
		List<PointviewVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("plan.selectpoint",city_no);
		
		session.close();
		return list;
	}
	public static List<PlanVo> listPlan(int m_no){
		List<PlanVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("plan.selectPlan",m_no);
		//System.out.println(list);
		session.close();
		return list;
	}
	public static List<PlanVo> selectPlan1(int plan_no){
		List<PlanVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("plan.selectPlan1",plan_no);
		//System.out.println(list);
		session.close();
		return list;
	}
	public static int deleteplan(int m_no) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.delete("plan.deleteplan", m_no);
		session.close();
		return re;
	}
	public static int deletenote1(int m_no) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.delete("plan.deletenote1", m_no);
		session.close();
		return re;
	}
	public static int updateplan(PlanVo g) {
		int re = 0;
		SqlSession session = factory.openSession(true);
		re = session.delete("plan.updatePlan", g);
		session.close();
		return re;
	}

	public static List<PlanNoteVo> listPlannote(HashMap map){
		List<PlanNoteVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("plan.selectPlanNoteDay",map);
		//System.out.println(list);
		session.close();
		return list;
	}
	public static List<LikeVo> listLike(HashMap map){
		List<LikeVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("plan.selectlike",map);
		//System.out.println(list);
		session.close();
		return list;
	}
	
	
	public static int maxPlan() {
		// TODO Auto-generated method stub
		int max = 1;
		SqlSession session = factory.openSession();
		max = session.selectOne("plan.selectMaxPlanNo");
		//System.out.println(list);
		session.close();
		return max;
	}
	public static int maxPlannote() {
		// TODO Auto-generated method stub
		int max = 1;
		SqlSession session = factory.openSession();
		max = session.selectOne("plan.selectMaxPlannoteNo");
		//System.out.println(list);
		session.close();
		return max;
	}
	public static PlanVo listPl(int plan_no){
		PlanVo list = null;
		SqlSession session = factory.openSession();
		list = session.selectOne("plan.selectDetail",plan_no);
		//System.out.println(list);
		session.close();
		return list;
	}
	public static CityVo cityName(int city_no) {
		CityVo m = new CityVo();
		SqlSession session = factory.openSession();
		//System.out.println("city_no"+city_no);
		m=session.selectOne("plan.selectname",city_no);
		//System.out.println("list"+list);
		session.close();
		
		return m;
	}
	public static int insertPlan(PlanVo g) {
		// TODO Auto-generated method stub
		int re=0;
		List<PlanVo> list = null;
		SqlSession session = factory.openSession(true);
		session.insert("plan.insertPlan",g);
		//System.out.println(list);
		session.close();
		return re;
	}
	public static int insertPlannote(PlanNoteVo vo) {
		// TODO Auto-generated method stub
		int re=0;
		PlanNoteVo list = null;
		SqlSession session = factory.openSession(true);
		session.insert("plan.insertPlannote",vo);
		//System.out.println(list);
		session.close();
		return re;
	}
	public static int deletenote(HashMap map) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.delete("plan.deletenote", map);
		session.close();
		return re;
	}

	


}
