package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DbConnection {
	
	private DbConnection() {} // 생성자. 접근제어자 private ==? 객체생성하지마. DB컨넥션은 생성자를 막아놨기때문에 생성은 못하나, 모든 메소드가 static이라 쓸 수 있음.
	
	static Connection getConnection() { // DB와의 connection 객체
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
	
	static void close(Connection conn, Statement stmt, ResultSet rs) {  // 연결객체, 문장객체, 결과객체
		try {
			if(rs != null) rs.close();
			if(stmt != null) stmt.close();
			if(conn != null) conn.close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
