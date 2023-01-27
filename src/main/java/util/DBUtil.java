package util;

import java.sql.*;

public class DBUtil {
	
	// db 연결 메서드화
	public Connection getConnection() throws Exception{
	
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://15.164.200.2:3306/cashbook", "root", "java1234");
		return conn;
	}
	
	// db 연결 종료 메서드화
	public void close(ResultSet rs, PreparedStatement stmt, Connection conn) throws Exception {
		// rs가 없는 경우도 있기 때문에 분기를 시켜줌(값이 없으면 null값)
		if(rs != null) {
			rs.close();
		}
		if(stmt != null) {
			stmt.close();
		}
		if(conn != null) {
			conn.close();
		}
	}
}
