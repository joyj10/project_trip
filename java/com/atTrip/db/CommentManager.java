package com.atTrip.db;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.atTrip.vo.CommentVo;

public class CommentManager {
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
	
	public static List<CommentVo> select(int b_no){
		List<CommentVo> list = null;
		SqlSession session = factory.openSession();
		list = session.selectList("re.select",b_no);
		session.close();	
		return list;
	}
	
	public static int insert(HashMap map) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.insert("re.insert",map);
		return re;
	}
	
	public static int update(HashMap map) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.update("re.update", map);
		session.close();
		return re;
	}
	
	public static int delete(HashMap map) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.delete("re.delete",map);
		session.close();
		return re;
	}
	
	public static int re_update(HashMap map) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.update("re.update", map);
		session.close();
		return re;
	}
	
	public static int re_delete(HashMap map) {
		int re = -1;
		SqlSession session = factory.openSession(true);
		re = session.delete("re.delete",map);
		session.close();
		return re;
	}
	

	
}
