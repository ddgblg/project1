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
	static { // ��ü �������ϰ� �ϰ�, �̰��� �޼ҵ�θ� ���� �뵵��. // model2�� MyBatis ���·� �ٲٴ°̴ϴ�.
		String resource = "model/mapper/mybatis-config.xml"; 
		// Ŭ���������� ��Ű�� ������ ������, �ý��������� ������. �츮������ ��Ű�� ������, ������ ��Ű�� ������ ����.
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
