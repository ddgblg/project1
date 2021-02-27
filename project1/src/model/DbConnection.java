package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbConnection {
	
	private DbConnection() {} // ������. ���������� private ==? ��ü����������. DB���ؼ��� �����ڸ� ���Ƴ��⶧���� ������ ���ϳ�, ��� �޼ҵ尡 static�̶� �� �� ����.
	
	static Connection getConnection() { // DB���� connection ��ü
		Connection conn = null;
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection
					("jdbc:mariadb://localhost:3306/classdb","scott","1234");
		}catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	static void close(Connection conn, Statement stmt, ResultSet rs) {  // ���ᰴü, ���尴ü, �����ü
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
