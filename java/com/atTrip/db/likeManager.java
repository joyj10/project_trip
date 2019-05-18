package com.atTrip.db;

import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.atTrip.vo.LikeVo;

public class likeManager {
	public static SqlSessionFactory factory;
	static {
		try {
			Reader reader = Resources.getResourceAsReader("com/atTrip/db/sqlConfig.xml");
			factory = new SqlSessionFactoryBuilder().build(reader);
			reader.close();
		}catch (Exception e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
		}
	}
	
	public static int likeInsert(LikeVo l)
	{
		SqlSession session = factory.openSession(true);
		int re = session.insert("like.insert", l);
		session.close();
		return re;
	}
	
	public static int likeDelete(LikeVo l)
	{
		SqlSession session = factory.openSession(true);
		int re = session.delete("like.delete",l);
		session.close();
		return re;
	}
	
	public static List<Integer> likeListMember(LikeVo lv)
	{
		SqlSession session = factory.openSession();
		List<Integer> list = session.selectList("like.likeListMember",lv);
		session.close();
		return list;
	}
}
