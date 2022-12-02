package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Member;

public class MemberDao { // 값을 받으면 param.. , 값을 리턴하면 result..
	
	// admin memberList 출력
	public ArrayList<Member> selectMemberListByPage(int beginRow, int ROW_PER_PAGE){
		
		ArrayList<Member> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;		
		DBUtil dbutil = new DBUtil();
		
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
		
		try {
			conn = dbutil.getConnection();
				System.out.println("selectMemberListByPage db 접속 확인");			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, ROW_PER_PAGE);
			rs = stmt.executeQuery();
			
			list = new ArrayList<Member>();
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
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 관리자 멤버 리스트 출력 카운트
	public int selectMemberCount() {
		
		int cnt = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbutil = new DBUtil();
		
		String sql = "SELECT COUNT(*) cnt FROM member";
		
		try {
			conn = dbutil.getConnection();
				System.out.println("memberCount db 접속 확인");			
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
		}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return cnt; 
	}
	
	// 관리자 멤버 레벨 수정 updateMemberLevelAction.jsp
	public int updateMemberLevel(Member paramMember) {
		
		int resultUpdate = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbutil = new DBUtil();
		
		String sql =  "UPDATE member SET member_level = ?, updatedate = NOW() WHERE member_no = ?";

		try {
			conn = dbutil.getConnection();
				System.out.println("updateMemberLevel db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramMember.getMemberLevel());
			stmt.setInt(2, paramMember.getMemberNo());
			resultUpdate = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultUpdate;
	}
	
	// 멤버 정보 가져오기 updateMemberLevelForm.jsp
	public Member selectMemberOne(Member paramMember) {
		
		Member selectMember = new Member();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbutil = new DBUtil();		
		
		String sql =  "SELECT"
				+ " member_no memberNo"
				+ ", member_id memberId"
				+ ", member_name memberName"
				+ ", member_level memberLevel"
				+ ", createdate"
				+ " FROM member"
				+ " WHERE member_no = ?";

		try {
			conn = dbutil.getConnection();
				System.out.println("selectMemberOne db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramMember.getMemberNo());
			rs = stmt.executeQuery();
			if(rs.next()) {
				selectMember.setMemberNo(rs.getInt("memberNo"));
				selectMember.setMemberId(rs.getString("memberId"));
				selectMember.setMemberName(rs.getString("memberName"));
				selectMember.setMemberLevel(rs.getInt("memberLevel"));
				selectMember.setCreatedate(rs.getString("createdate"));
			}		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return selectMember;
	}
	
	
	// 회원정보 삭제
	public int deleteMember(String memberId) { // member type으로 수정 -> memberId로 쿼리입력
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbutil = new DBUtil();
		
		String sql = "DELETE FROM member WHERE member_id = ?";

		try {
			conn = dbutil.getConnection();
				System.out.println("db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			resultRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	// 관리자 회원정보 삭제
	public int deleteMemberByAdmin(Member paramMember) {
		
		int resultDelete = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbutil = new DBUtil();
		
		String sql = "DELETE FROM member WHERE member_no = ?";
		
		try {
			conn = dbutil.getConnection();
				System.out.println("deleteMemberByAdmin db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramMember.getMemberNo());
			resultDelete = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultDelete;
	}
	
	// 로그인
	public Member login(Member paramMember) {
		/*
		  Class.forName("org.mariadb.jdbc.Driver");
		  Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/cashbook", "root", "java1234");
		  같은 코드가 계속 반복된다 -> 메서드화 하자 -> 입력값x, 반환값o(Connection 타입)
		*/
		Member resultMember = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "SELECT member_id memberId, member_name memberName, member_level memberLevel FROM member WHERE member_id = ? AND member_pw = PASSWORD(?)";

		try {
			conn = dbUtil.getConnection(); // 메서드화 된 db연결
				System.out.println("db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultMember = new Member();
				resultMember.setMemberId(rs.getString("memberId"));
				resultMember.setMemberName(rs.getString("memberName"));
				resultMember.setMemberLevel(rs.getInt("memberLevel"));
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn); // 메서드화 된 db종료
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultMember;
	}
	
	// 회원가입 insertMemberAction.jsp
	// 1) 중복확인 -> 반환 값 true이면 아이디 사용가능, false이면 사용불가(중복아이디 존재)
	public boolean checkId(String memberId) {
		
		boolean resultCheck = false;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbutil = new DBUtil();
		
		String sql = "SELECT member_id FROM member WHERE member_id = ?";
		
		try {
			conn = dbutil.getConnection();
				System.out.println("db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			if(!rs.next()) {
				resultCheck = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultCheck;
	}
	
	// 2) 회원가입 -> 메서드 안에 두개의 쿼리가 있는 것은 사실상 기능이 두 개인 것임 -> 나누자
	public int insertMember(Member paramMember) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbutil = new DBUtil();
		
		String sql = "INSERT INTO member (member_id, member_pw, member_name, updatedate, createdate) VALUES (?,PASSWORD(?),?,CURDATE(),CURDATE())";

		try {
			conn = dbutil.getConnection();
				System.out.println("db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			stmt.setString(2, paramMember.getMemberPw());
			stmt.setString(3, paramMember.getMemberName());
			resultRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
	
	// 회원정보 수정 updateMemberAcion.jsp
	public int updateMember(Member paramMember, String loginMemberId) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbutil = new DBUtil();
		
		String sql = "UPDATE member SET member_name = ? ,updatedate = CURDATE() WHERE member_id = ?";

		try {
			conn = dbutil.getConnection();
				System.out.println("db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberName());
			stmt.setString(2, loginMemberId);
			resultRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}

	
	// 회원 비밀번호 수정 updatePwAction.jsp
	// 1) 비밀번호 확인 -> 일치하면 true, 아니면 false
	public boolean checkPw(String oldPw, String loginMemberId) {
		
		boolean resultCheck = false;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbutil = new DBUtil();
		
		String sql = "SELECT member_pw FROM member WHERE member_pw = PASSWORD(?) AND member_id = ?";

		try {
			conn = dbutil.getConnection();
				System.out.println("db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, oldPw);
			stmt.setString(2, loginMemberId);
			rs = stmt.executeQuery();
			if(rs.next()) {
				resultCheck = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultCheck;
	}
	
	// 2) 비밀번호 수정
	public int updatePw(String newPw, String loginMemberId) {
		
		int resultRow = 0;
		Connection conn = null;
		PreparedStatement stmt = null;		
		DBUtil dbutil = new DBUtil();
		
		String sql = "UPDATE member SET member_pw = PASSWORD(?) ,updatedate = CURDATE() WHERE member_id = ?";

		try {
			conn = dbutil.getConnection();
				System.out.println("db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, newPw);
			stmt.setString(2, loginMemberId);
			resultRow = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbutil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultRow;
	}
}
