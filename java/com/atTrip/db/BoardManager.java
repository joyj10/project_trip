package com.atTrip.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.atTrip.vo.BoardVo;

public class BoardManager {

	public static SqlSessionFactory factory;
	
	static {
		try {
			String resource = "com/atTrip/db/sqlConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			factory = new SqlSessionFactoryBuilder().build(inputStream);
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public static List<BoardVo> select(HashMap map){
		List<BoardVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("board.select",map);
		session.close();
		return list;
	}
	
	public static BoardVo detail (int b_no) {
		BoardVo b = null;
		SqlSession session = factory.openSession();
		b = session.selectOne("board.detail", b_no);
		session.close();		
		return b;
	}	
	
	public static int insert(BoardVo b) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.insert("board.insert", b);
		return re;
	}
	
	public static int update(BoardVo b) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.update("board.update", b);
		return re;
	}
	
	public static int delete(BoardVo b) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.delete("board.delete",b);
		return re;
		}
	
	public static Integer getTotal(HashMap map) {
		Integer r = null;
		SqlSession session = factory.openSession();
		r = session.selectOne("board.count",map);
		return r;
	}
	
	public static int hitUpdate(int b_no) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.update("board.hitCount",b_no);
		return re;		
	}
	
	public static BoardVo check(HashMap map) {
		BoardVo b = null;
		SqlSession session = factory.openSession();
		b = session.selectOne("board.check",map);
		session.close();
		return b;
	}
}