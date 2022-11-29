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
	
	// 문의글 출력
	public ArrayList<HashMap<String, Object>> selectHelpList(Member paramMember) throws Exception{
		
		ArrayList<HashMap<String, Object>> helpList = new ArrayList<HashMap<String, Object>>();
		
		String sql = "SELECT h.help_no helpNo"
				+ "		, h.help_memo helpMemo"
				+ "		, h.createdate helpCreatedate"
				+ "		, c.comment_no commemtNo"
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
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramMember.getMemberId());
		rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("helpNo", rs.getInt("helpNo"));
			m.put("helpMemo", rs.getString("helpMemo"));
			m.put("helpCreatedate", rs.getString("helpCreatedate"));
			m.put("commemtNo", rs.getInt("commemtNo"));
			m.put("commentMemo", rs.getString("commentMemo"));
			m.put("commentCreatedate", rs.getString("commentCreatedate"));
			
			helpList.add(m);
		}
		
		dbUtil.close(rs, stmt, conn);
		return helpList;
	}
}
