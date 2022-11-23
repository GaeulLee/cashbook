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
		
	// 가계부 내역 수정 updateCashAction.jsp
	public int updateCash(int cateNo, long cashPrice, String cashMemo, int cashNo, String memberId) throws Exception {
		
		int updateCashResult = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE cash_no = ? AND member_id = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cateNo);
		stmt.setLong(2, cashPrice);
		stmt.setString(3, cashMemo);
		stmt.setInt(4, cashNo);
		stmt.setString(5, memberId);
		updateCashResult = stmt.executeUpdate();
		
		return updateCashResult;
	}
	
	// 가계부 내역 삭제
	
}
