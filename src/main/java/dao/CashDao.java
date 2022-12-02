package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;
import vo.Cash;

public class CashDao {
	
	// 월별 기계부 출력 cashList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByMonth(String memberId, int year, int month) {
		
		// try catch 구문에서 사용할 변수 생성
		ArrayList<HashMap<String, Object>> list = null; // 리턴타입 변수
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil(); // db 접속 메서드 호출
		// 쿼리문
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
		try {			
			conn = dbUtil.getConnection();			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
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
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
		
	// 일별 가계부 출력 cashDateList.jsp
	public ArrayList<HashMap<String, Object>> selectCashListByDate(String memberId, int year, int month, int date) throws Exception{
		
		ArrayList<HashMap<String, Object>> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
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
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			stmt.setInt(3, month);
			stmt.setInt(4, date);
			rs = stmt.executeQuery();
			
			list = new ArrayList<HashMap<String, Object>>();
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
		} catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 수정할 가계부 불러오기 (cashNo만 받아오기) updateCashForm.jsp
	public Cash selectCashOne(int cashNo) {
		
		Cash oldCash = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "SELECT"
				+ " cash_date cashDate"
				+ ", category_no cateNo"
				+ ", cash_price cashPrice"
				+ ", cash_memo cashMemo"
				+ " FROM cash"
				+ " WHERE cash_no = ?";
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			rs = stmt.executeQuery();
			if(rs.next()) {
				oldCash = new Cash();
				oldCash.setCashDate(rs.getString("cashDate"));
				oldCash.setCategoryNo(rs.getInt("cateNo"));
				oldCash.setCashPrice(rs.getInt("cashPrice"));
				oldCash.setCashMemo(rs.getString("cashMemo"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return oldCash;
	}
	
	
	// 가계부 내역 수정 updateCashAction.jsp
	public int updateCash(int cateNo, long cashPrice, String cashMemo, int cashNo, String memberId) throws Exception {
		
		int updateCashResult = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "UPDATE cash SET category_no = ?, cash_price = ?, cash_memo = ?, updatedate = CURDATE() WHERE cash_no = ? AND member_id = ?";
		
		try {
			conn = dbUtil.getConnection();			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cateNo);
			stmt.setLong(2, cashPrice);
			stmt.setString(3, cashMemo);
			stmt.setInt(4, cashNo);
			stmt.setString(5, memberId);
			updateCashResult = stmt.executeUpdate();		
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return updateCashResult;
	}
	
	// 가계부 내역 추가 insertCashAction.jsp
	public int insertCash(String cashDate, int categoryNo, long cashPrice, String cashMemo, String memberId) throws Exception{
		
		int insertCashResult = 0;
		Connection conn = null;
		PreparedStatement stmt = null;		
		DBUtil dbUtil = new DBUtil();
		
		String sql = "INSERT INTO cash (cash_date, category_no, cash_price, cash_memo, member_id, updatedate, createdate) VALUES(?,?,?,?,?,CURDATE(),CURDATE())";
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, cashDate);
			stmt.setInt(2, categoryNo);
			stmt.setLong(3, cashPrice);
			stmt.setString(4, cashMemo);
			stmt.setString(5, memberId);
			insertCashResult = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return insertCashResult;
	}
	
	// 가계부 내역 삭제 deleteCashAction.jsp
	public int deleteCash(int cashNo, String memberId) throws Exception{
		
		int deleteCashResult = 0;
		Connection conn = null;
		PreparedStatement stmt = null;		
		DBUtil dbUtil = new DBUtil();
		
		String sql = "DELETE FROM cash WHERE cash_no = ? AND member_id = ?";
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, cashNo);
			stmt.setString(2, memberId);
			deleteCashResult = stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return deleteCashResult;
	}
}
