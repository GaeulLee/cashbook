package dao;

import java.sql.*;

import java.util.*;

import util.DBUtil;

import vo.*;


public class HelpDao {
	
	// 관리자 문의글 출력 helpListAll.jsp (매개변수가 다르면 같은 이름의 메소드를 만들수 있음 -> 오버로딩)
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) {		 										

		ArrayList<HashMap<String, Object>> helpList = new ArrayList<HashMap<String, Object>>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT h.help_no helpNo"
			+ "		, h.help_memo helpMemo"
			+ "		, h.createdate helpCreatedate"
			+ "		, h.member_id memberId" // 누가 문의글 작성했는지 봐야 함
			+ "		, c.comment_no commentNo" // 회원 페이지에선 필요 없으나 관리자 페이지에선 필요
			+ "		, c.comment_memo commentMemo"
			+ "		, c.createdate commentCreatedate"
			+ " FROM help h left outer join comment c"
			+ " ON h.help_no = c.help_no"
			+ " ORDER BY h.createdate DESC"
			+ " LIMIT ?, ?";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("selectHelpList db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("memberId", rs.getString("memberId"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commentNo", rs.getInt("commentNo")); // null 이면 어떻게 들어올까 -> null
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));				
				helpList.add(m);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return helpList;
	}
	
	// 관리자 문의글 카운트 helpListAll.jsp
	public int selectHelpCount() {
		
		int cnt = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT COUNT(*) cnt FROM help";

		try {
			conn = dbUtil.getConnection();
				System.out.println("selectHelpCount db 접속 확인");
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}
	
	
	// 문의글 출력 helpList.jsp
	public ArrayList<HashMap<String, Object>> selectHelpList(Member paramMember) {
					// 키는 String 타입으로, 값은 Object 타입으로 
		ArrayList<HashMap<String, Object>> helpList = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT h.help_no helpNo"
				+ "		, h.help_memo helpMemo"
				+ "		, h.createdate helpCreatedate"
				+ "		, c.comment_no commemtNo" // 회원 페이지에선 필요 없으나 관리자 페이지에선 필요
				+ "		, c.comment_memo commentMemo"
				+ "		, c.createdate commentCreatedate"
				+ " FROM help h left outer join comment c"
				+ " ON h.help_no = c.help_no"
				+ " WHERE h.member_id = ?"
				+ " ORDER BY h.createdate DESC";

		try {
			conn = dbUtil.getConnection();
				System.out.println("selectHelpList db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramMember.getMemberId());
			rs = stmt.executeQuery();
			
			helpList = new ArrayList<HashMap<String, Object>>();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("helpNo", rs.getInt("helpNo"));
				m.put("helpMemo", rs.getString("helpMemo"));
				m.put("helpCreatedate", rs.getString("helpCreatedate"));
				m.put("commemtNo", rs.getInt("commemtNo")); // null 이면 어떻게 들어올까 -> null
				m.put("commentMemo", rs.getString("commentMemo"));
				m.put("commentCreatedate", rs.getString("commentCreatedate"));				
				helpList.add(m);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return helpList;
	}
	
	// 문의 추가 insertHelpAction.jsp (memo id create update)
	public int insertHelp(Help paramHelp) {
		
		int resultInsert = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO help"
				+ " (help_memo, member_id, createdate, updatedate)"
				+ " VALUES (?, ?, NOW(), NOW())";
		try {
			conn = dbUtil.getConnection();
				System.out.println("insertHelp db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramHelp.getHelpMemo());
			stmt.setString(2, paramHelp.getMemberId());
			resultInsert = stmt.executeUpdate();		
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultInsert;
	}
	
	// 문의 수정 전 글 불러오기 (no id -> no memo)
	public Help selectHelpOne(Help paramHelp) {
		
		Help oldHelp = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT"
				+ " help_no helpNo"
				+ ", help_memo helpMemo"
				+ " FROM help"
				+ " WHERE help_no = ? AND member_id = ?";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("selectHelpOne db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramHelp.getHelpNo());
			stmt.setString(2, paramHelp.getMemberId());
			rs = stmt.executeQuery();
			if(rs.next()) {
				oldHelp = new Help();
				oldHelp.setHelpNo(rs.getInt("helpNo"));
				oldHelp.setHelpMemo(rs.getString("helpMemo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return oldHelp;
	}
	
	
	// 문의 수정 updateHelpAction.jsp (no memo update + id)
	public int updateHelp(Help paramHelp) {
		
		int resultUpdate = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE help SET"
				+ " help_memo = ?"
				+ ", updatedate = NOW()"
				+ " WHERE help_no = ? AND member_id = ?";

		try {
			conn = dbUtil.getConnection();
				System.out.println("insertHelp db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramHelp.getHelpMemo());
			stmt.setInt(2, paramHelp.getHelpNo());
			stmt.setString(3, paramHelp.getMemberId());
			resultUpdate = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultUpdate;
	}
		
	// 문의 삭제 deleteHelpAction.jsp (no + id)
	public int deleteHelp(Help paramHelp) {
		
		int resultDelete = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM help"
				+ " WHERE help_no = ? AND member_id = ?";

		try {
			conn = dbUtil.getConnection();
				System.out.println("insertHelp db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramHelp.getHelpNo());
			stmt.setString(2, paramHelp.getMemberId());
			resultDelete = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultDelete;
	}
}
