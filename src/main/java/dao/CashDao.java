package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class CashDao {
	
	/*
	SELECT 
		c.cash_no cashNo
		, c.cash_date cashDate -> 수입지출 발생 날짜
		, c.cash_price cashPrice -> 금액
		, c.category_no categoryNo -> 카테고리 분류 번호
		, ct.category_kind categoryKind -> 수입 지출 여부
		, ct.category_name categoryName -> 수입 지출 항목
	FROM cash c INNER JOIN category ct
	ON c.category_no = ct.category_no
	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?
	ORDER BY c.cash_date ASC;
	 */
	
	// 월별 기계부 출력 cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT"
				+ "		c.cash_no cashNo"
				+ "		, c.cash_date cashDate"
				+ "		, c.cash_price cashPrice"
				+ "		, c.category_no categoryNo"
				+ "		, ct.category_kind categoryKind"
				+ "		, ct.category_name categoryName"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind;";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("categoryNo", rs.getInt("categoryNo"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
		
	// 일별 가계부 출력 cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT "
				+ "		c.cash_no cashNo"
				+ "		, c.cash_date cashDate"
				+ "		, ct.category_kind categoryKind"
				+ "		, ct.category_name categoryName"
				+ "		, c.cash_price cashPrice"
				+ "		, c.cash_memo cashMemo"
				+ "		, c.updatedate"
				+ "		, c.createdate"
				+ "	FROM cash c INNER JOIN category ct"
				+ "	ON c.category_no = ct.category_no"
				+ "	WHERE c.member_id = ? AND YEAR(c.cash_date) = ? AND MONTH(c.cash_date) = ? AND DAY(c.cash_date) = ?"
				+ "	ORDER BY c.cash_date ASC, ct.category_kind";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, memberId);
		stmt.setInt(2, year);
		stmt.setInt(3, month);
		stmt.setInt(4, date);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("cashNo", rs.getInt("cashNo"));
			m.put("cashDate", rs.getString("cashDate"));
			m.put("categoryKind", rs.getString("categoryKind"));
			m.put("categoryName", rs.getString("categoryName"));
			m.put("cashPrice", rs.getLong("cashPrice"));
			m.put("cashMemo", rs.getString("cashMemo"));
			m.put("updatedate", rs.getString("updatedate"));
			m.put("createdate", rs.getString("createdate"));
			list.add(m);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
	}
		
	// 가계부 내역 수정
	public int updateCash(HashMap<String, Object> paramUpdateCash) throws Exception {
		
		int updateCashResult = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		/*
		 	update cash c INNER JOIN category ct
			ON c.category_no = ct.category_no
			SET
				c.cash_date = CURDATE()
				, ct.category_kind = '수입'
				, ct.category_name = '의복'
				, c.cash_price = '40000'
				, c.cash_memo = '테스트 수정'
				, c.updatedate = CURDATE()
			WHERE c.cash_no = 1001;
		*/
		String sql = "UPDATE cash c INNER JOIN category ct"
				+ "			ON c.category_no = ct.category_no"
				+ "			SET"
				+ "				c.cash_date = ?"
				+ "				, ct.category_kind = ?"
				+ "				, ct.category_name = ?"
				+ "				, c.cash_price = ?"
				+ "				, c.cash_memo = ?"
				+ "				, c.updatedate = CURDATE()"
				+ "			WHERE c.cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, (String)paramUpdateCash.get("cashDate"));
		stmt.setString(2, (String)paramUpdateCash.get("categoryKind"));
		stmt.setString(3, (String)paramUpdateCash.get("categoryName"));
		stmt.setLong(4, (Long)paramUpdateCash.get("cashPrice"));
		stmt.setString(5, (String)paramUpdateCash.get("cashMemo"));
		stmt.setInt(6, (Integer)paramUpdateCash.get("cashNo"));
		
		return updateCashResult;
	}
	
	// 가계부 내역 삭제
	
}
