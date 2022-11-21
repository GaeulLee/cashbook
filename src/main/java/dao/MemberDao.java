package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Member;

public class MemberDao { // 값을 받으면 param.. , 값을 리턴하면 result..
	
	// 로그인
	public Member login(Member paramMember) throws Exception {
		
		Member resultMember = null;
		/*
		  Class.forName("org.mariadb.jdbc.Driver");
		  Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cashbook", "root", "java1234");
		  같은 코드가 계속 반복된다 -> 메서드화 하자 -> 입력값x, 반환값o(Connection 타입)
		*/
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?) AND member_name = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
		}
		
		rs.close();
		stmt.close();
		conn.close();
		
		return resultMember;
	}
	
	// 회원가입
	public int insertMember(Member paramMember) throws Exception {
		
		int resultRow = 0;
		
		// 회원가입 알고리즘
		
		return resultRow;
	}
}
