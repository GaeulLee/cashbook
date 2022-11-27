package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Member;

public class MemberDao { // 값을 받으면 param.. , 값을 리턴하면 result..
	
	// admin memberList 출력
	public ArrayList<Member> selectMemberListByPage(int beginRow, int ROW_PER_PAGE) throws Exception{
		
		ArrayList<Member> list = new ArrayList<Member>();
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("selectMemberListByPage db 접속 확인");
		String sql = "SELECT"
				+ " member_no memberNo"
				+ ", member_id memberId"
				+ ", member_name memberName"
				+ ", member_level memberLevel"
				+ ", createdate"
				+ ", updatedate"
				+ " FROM member"
				+ " ORDER BY createdate DESC"
				+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, ROW_PER_PAGE);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Member m = new Member();
			m.setMemberNo(rs.getInt("memberNo"));
			m.setMemberId(rs.getString("memberId"));
			m.setMemberName(rs.getString("memberName"));
			m.setMemberLevel(rs.getInt("memberLevel"));
			m.setCreatedate(rs.getString("createdate"));
			m.setUpdatedate(rs.getString("updatedate"));
			list.add(m);
		}
		dbutil.close(rs, stmt, conn);
		return list;
	}
	
	// 관리자 멤버 리스트 출력 카운트
	
	// 관리자 멤버 레벨 수정
	
	// 회원정보 삭제
	public int deleteMember(String memberId) throws Exception{ // member type으로 수정 -> memberId로 쿼리입력
		
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
		String sql = "DELETE FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		resultRow = stmt.executeUpdate();
		
		dbutil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	// 관리자 회원정보 삭제
	public int deleteMemberByAdmin(String memberId) throws Exception{ // member type으로 수정 -> memberNo 로 쿼리입력
		
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
		String sql = "DELETE FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		resultRow = stmt.executeUpdate();
		
		dbutil.close(null, stmt, conn);
		
		return resultRow;
	}
	
	// 로그인
	public Member login(Member paramMember) throws Exception {
		
		Member resultMember = null;
		/*
		  Class.forName("org.mariadb.jdbc.Driver");
		  Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cashbook", "root", "java1234");
		  같은 코드가 계속 반복된다 -> 메서드화 하자 -> 입력값x, 반환값o(Connection 타입)
		*/
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection(); // 메서드화 된 db연결
			System.out.println("db 접속 확인");
		String sql = "SELECT member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMember = new Member();
			resultMember.setMemberId(rs.getString("memberId"));
			resultMember.setMemberName(rs.getString("memberName"));
			resultMember.setMemberLevel(rs.getInt("memberLevel"));
		}
		
		dbUtil.close(rs, stmt, conn); // 메서드화 된 db종료
		return resultMember;
	}
	
	// 회원가입 insertMemberAction.jsp
	// 1) 중복확인 -> 반환 값 true이면 아이디 사용가능, false이면 사용불가(중복아이디 존재)
	public boolean checkId(String memberId) throws Exception {
		
		boolean resultCheck = false;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		ResultSet rs = stmt.executeQuery();
		if(!rs.next()) {
			resultCheck = true;
		}
		
		dbutil.close(rs, stmt, conn);
		return resultCheck;
	}
	
	// 2) 회원가입 -> 메서드 안에 두개의 쿼리가 있는 것은 사실상 기능이 두 개인 것임 -> 나누자
	public int insertMember(Member paramMember) throws Exception {
		
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");

		String sql = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?,PASSWORD(?),?,CURDATE(),CURDATE())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		stmt.setString(2, paramMember.getMemberPw());
		stmt.setString(3, paramMember.getMemberName());
		resultRow = stmt.executeUpdate();
		
		dbutil.close(null, stmt, conn);
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
		
		dbutil.close(null, stmt, conn);
		return resultRow;
	}

	
	// 회원 비밀번호 수정 updatePwAction.jsp
	// 1) 비밀번호 확인 -> 일치하면 true, 아니면 false
	public boolean checkPw(String oldPw, String loginMemberId) throws Exception {
		
		boolean resultCheck = false;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
		String sql = "SELECT member_pw FROM member WHERE member_pw = PASSWORD(?) AND member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, oldPw);
		stmt.setString(2, loginMemberId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultCheck = true;
		}

		dbutil.close(rs, stmt, conn);
		return resultCheck;
	}
	
	// 2) 비밀번호 수정
	public int updatePw(String newPw, String loginMemberId) throws Exception {
		
		int resultRow = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
			System.out.println("db 접속 확인");
		String sql = "UPDATE member SET member_pw = PASSWORD(?) ,updatedate = CURDATE() WHERE member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, loginMemberId);
		resultRow = stmt.executeUpdate();
		
		dbutil.close(null, stmt, conn);
		return resultRow;
	}


	
}
