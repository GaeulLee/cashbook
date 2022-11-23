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
		String sql = "SELECT member_id memberId, member_name memberName FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
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
	
	// 회원가입 signInAction.jsp
	public int insertMember(Member paramMember) throws Exception {
		
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
			
		// 분기(아이디 중복 확인 -> 중복o: 메세지 출력, 중복x: 정보수정)
		String idSql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement idStmt = conn.prepareStatement(idSql);
		idStmt.setString(1, paramMember.getMemberId());
		ResultSet rs = idStmt.executeQuery();
		if(rs.next()) {
			resultRow = 2;
			rs.close();
			idStmt.close();
		} else {
			String sql = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?,PASSWORD(?),?,CURDATE(),CURDATE())";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			stmt.setString(3, paramMember.getMemberName());
			resultRow = stmt.executeUpdate();
			stmt.close();
		}
		conn.close();	
		return resultRow;
	}
	
	// 회원정보 수정 updateMemberAcion.jsp
	public int updateMember(Member paramMember, String loginMemberId) throws Exception {
		
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
		String sql = "UPDATE member SET member_name = ? ,updatedate = CURDATE() WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberName());
		stmt.setString(2, loginMemberId);
		resultRow = stmt.executeUpdate();
		
		stmt.close();
		conn.close();
		return resultRow;
	}
	
	// 회원 아이디 수정 updateIdAction.jsp
		public int updateId(Member paramMember, String loginMemberId) throws Exception {
			
			int resultRow = 0;
			
			DBUtil dbutil = new DBUtil();
			Connection conn = dbutil.getConnection();
				System.out.println("db 접속 확인");
			// 분기(아이디 중복 확인 -> 중복o: 메세지 출력, 중복x: 정보수정)
			String idSql = "SELECT member_id FROM member WHERE member_id = ?";
			PreparedStatement idStmt = conn.prepareStatement(idSql);
			idStmt.setString(1, paramMember.getMemberId());
			ResultSet rs = idStmt.executeQuery();
			if(rs.next()) {
				resultRow = 2;
				rs.close();
				idStmt.close();
			} else {
				String sql = "UPDATE member SET member_id = ?, updatedate = CURDATE() WHERE member_id = ?";
				PreparedStatement stmt = conn.prepareStatement(sql);
				stmt.setString(1, paramMember.getMemberId());
				stmt.setString(2, loginMemberId);
				resultRow = stmt.executeUpdate();
				stmt.close();
			}
			conn.close();
			return resultRow;
		}
	
	// 회원 비밀번호 수정 updatePwAction.jsp
	public int updatePw(String oldPw, String newPw, String loginMemberId) throws Exception {
		
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
		
		//분기(비민번호 확인 -> 일치: 비밀번호 수정, 불일치: 메세지 출력)
		String pwSql = "SELECT member_pw FROM member WHERE member_pw = PASSWORD(?)";
		PreparedStatement pwStmt = conn.prepareStatement(pwSql);
		pwStmt.setString(1, oldPw);
		ResultSet rs = pwStmt.executeQuery();
		if(rs.next() != true) {
			resultRow = 2;
			rs.close();
			pwStmt.close();
		} else {
			String sql = "UPDATE member SET member_pw = PASSWORD(?) ,updatedate = CURDATE()";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, newPw);
			resultRow = stmt.executeUpdate();
			stmt.close();
		}
		conn.close();
		return resultRow;
	}

	// 회원정보 삭제
}
