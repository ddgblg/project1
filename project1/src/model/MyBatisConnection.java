package model;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MyBatisConnection {
	private static SqlSessionFactory sqlMap;
	private MyBatisConnection() {}
	static { // 객체 생성못하게 하고, 이것을 메소드로만 쓰는 용도로. // model2를 MyBatis 형태로 바꾸는겁니다.
		String resource = "model/mapper/mybatis-config.xml"; 
		// 클래스파일은 패키지 단위로 되지만, 시스템파일은 폴더다. 우리눈에는 패키지 이지만, 파일은 패키지 개념이 없음.
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader(resource);
		}catch(IOException e) {
			e.printStackTrace();
		}
		sqlMap = new SqlSessionFactoryBuilder().build(reader);
	}
	static SqlSession getConnection() {
		return sqlMap.openSession();
	}
	static void close(SqlSession session) {
		session.commit();
		session.close();
	}
	
	
}
