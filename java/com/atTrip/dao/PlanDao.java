package com.atTrip.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.atTrip.db.PlanManager;
import com.atTrip.vo.CityVo;
import com.atTrip.vo.LikeVo;
import com.atTrip.vo.PlanNoteVo;
import com.atTrip.vo.PlanVo;
import com.atTrip.vo.PointviewVo;


@Repository
public class PlanDao {
	public List<PlanVo> planlist(int m_no) {
		return PlanManager.listPlan(m_no);
	}
	public List<PlanVo> selectPlan1(int plan_no) {
		return PlanManager.selectPlan1(plan_no);
	}
	public int deleteplan(int m_no) {
		return PlanManager.deleteplan(m_no);
}
	public int deletenote1(int m_no) {
		return PlanManager.deletenote1(m_no);
}
	public List<PlanNoteVo> planline(HashMap map) {
		return PlanManager.listPlannote(map);
		}
	public int updatePlan(PlanVo vo) {
		// TODO Auto-generated method stub
		return PlanManager.updateplan(vo);
	}
	public int insertPlan(PlanVo vo) {
		// TODO Auto-generated method stub
		return PlanManager.insertPlan(vo);
	}
	public int insertPlannote(PlanNoteVo vo) {
		// TODO Auto-generated method stub
		return PlanManager.insertPlannote(vo);
	}
	public int maxPlan() {
		// TODO Auto-generated method stub
		return PlanManager.maxPlan();
	}
	public int maxPlannote() {
		// TODO Auto-generated method stub
		return PlanManager.maxPlannote();
	}
	public PlanVo listPl(int plan_no) {
		// TODO Auto-generated method stub
		return PlanManager.listPl(plan_no);
	}
	public List<LikeVo> likelist(HashMap map) {
		// TODO Auto-generated method stub
		//System.out.println("city_no"+city_no);
		return PlanManager.listLike(map);
	}

	public CityVo cityName(int city_no) {
		// TODO Auto-generated method stub
		//System.out.println("city_no"+city_no);
		return PlanManager.cityName(city_no);
	}
	public List<CityVo> citylist() {
		
		return PlanManager.listCity();
		}
	public List<PointviewVo> pointlist(int city_no) {
		
		return PlanManager.listPoint(city_no);
	}
	public int deletenote(HashMap map) {
		return PlanManager.deletenote(map);
}
}
