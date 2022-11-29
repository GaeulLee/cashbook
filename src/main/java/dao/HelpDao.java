package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Help;
import vo.Member;

public class HelpDao {
	
	// 관리자 문의글 출력 helpListAll.jsp (매개변수가 다르면 같은 이름의 메소드를 만들수 있음 -> 오버로딩)
	public ArrayList<HashMap<String, Object>> selectHelpList(int beginRow, int rowPerPage) throws Exception{		 										

		ArrayList<HashMap<String, Object>> helpList = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT h.help_no helpNo"
			+ "		, h.help_memo helpMemo"
			+ "		, h.createdate helpCreatedate"
			+ "		, c.comment_no commemtNo" // 회원 페이지에선 필요 없으나 관리자 페이지에선 필요
			+ "		, c.comment_memo commentMemo"
			+ "		, c.createdate commentCreatedate"
			+ " FROM help h left outer join comment c"
			+ " ON h.help_no = c.help_no"
			+ " ORDER BY h.createdate DESC"
			+ " LIMIT ?, ?";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
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
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commemtNo", rs.getInt("commemtNo")); // null 이면 어떻게 들어올까 -> null
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			
			helpList.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return helpList;
	}
	
	// 관리자 문의글 카운트 helpListAll.jsp
	
	
	
	// 관리자 댓글
	
	// 관리자
	
	
	// 문의글 출력 helpList.jsp
	public ArrayList<HashMap<String, Object>> selectHelpList(Member paramMember) throws Exception{
					// 키는 String 타입으로, 값은 Object 타입으로 
		ArrayList<HashMap<String, Object>> helpList = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT h.help_no helpNo"
				+ "		, h.help_memo helpMemo"
				+ "		, h.createdate helpCreatedate"
				+ "		, h.member_id memberId" // 누가 문의글 작성했는지 봐야 함
				+ "		, c.comment_no commemtNo" // 회원 페이지에선 필요 없으나 관리자 페이지에선 필요
				+ "		, c.comment_memo commentMemo"
				+ "		, c.createdate commentCreatedate"
				+ " FROM help h left outer join comment c"
				+ " ON h.help_no = c.help_no"
				+ " WHERE h.member_id = ?"
				+ " ORDER BY h.createdate DESC";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
			System.out.println("selectHelpList db 접속 확인");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		rs = stmt.executeQuery();
		
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
		
		dbUtil.close(rs, stmt, conn);
		return helpList;
	}
	
	// 문의 추가 insertHelpAction.jsp (memo id create update)
	public int insertHelp(Help paramHelp) throws Exception {
		
		int resultInsert = 0;
		
		String sql = "INSERT INTO help"
				+ " (help_memo, member_id, createdate, updatedate)"
				+ " VALUES (?, ?, NOW(), NOW())";
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;

		conn = dbUtil.getConnection();
			System.out.println("insertHelp db 접속 확인");
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramHelp.getHelpMemo());
		stmt.setString(2, paramHelp.getMemberId());
		resultInsert = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return resultInsert;
	}
}
