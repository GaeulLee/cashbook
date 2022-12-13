package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

import util.DBUtil;

public class StatsDao {
	
	// 년도별 수입/지출, 총합, 평균
	public ArrayList<HashMap<String, Object>> selectCashByYear(String memberId){
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
					+ "	YEAR(t2.cashDate) year"
					+ "	, COUNT(t2.outcome) outcomeCnt"
					+ "	, SUM(t2.outcome) outcomeSum"
					+ "	, AVG(ROUND(t2.outcome)) outcomeAvg"
					+ "	, COUNT(t2.income) incomeCnt"
					+ "	, SUM(t2.income) incomeSum"
					+ "	, AVG(ROUND(t2.income)) incomeAvg"
					+ " FROM (SELECT"
					+ "				memberId"
					+ "				, cashNo"
					+ "				, cashDate"
					+ "				, if(categoryKind = '수입', cashPrice, NULL) income"
					+ "				, if(categoryKind = '지출', cashPrice, NULL) outcome"
					+ "			FROM (SELECT c.cash_no cashNo"
					+ "						, c.cash_date cashDate"
					+ "						, c.cash_price cashPrice"
					+ "						, cg.category_kind categoryKind"
					+ "						, c.member_id memberId"
					+ "				FROM cash c INNER JOIN category cg"
					+ "				ON c.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ?" // memberId 입력
					+ " GROUP BY YEAR(t2.cashDate)"
					+ " ORDER BY YEAR(t2.cashDate) DESC";		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("year", rs.getInt("year"));
				map.put("outcomeCnt", rs.getInt("outcomeCnt"));
				map.put("outcomeAvg", rs.getInt("outcomeAvg"));
				map.put("outcomeSum", rs.getInt("outcomeSum"));
				map.put("incomeCnt", rs.getInt("incomeCnt"));
				map.put("incomeSum", rs.getInt("incomeSum"));
				map.put("incomeAvg", rs.getInt("incomeAvg"));
				list.add(map);
			}
		} catch (Exception e) {
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
	
	// 데이터에 있는 최소년도, 최대년도
	public HashMap<String, Object> selectMinMaxYear() {
		HashMap<String, Object> year = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT MIN(YEAR(cash_date)) minYear, MAX(YEAR(cash_date)) maxYear FROM cash";
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				year = new HashMap<String, Object>();
				year.put("minYear", rs.getInt("minYear"));
				year.put("maxYear", rs.getInt("maxYear"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return year;
	}
	
	
	// 월별 수입/지출, 총합, 평균
	public ArrayList<HashMap<String, Object>> selectCashByMonth(String memberId, int year){
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		String sql = "SELECT"
					+ " MONTH(t2.cashDate) month"
					+ "	, COUNT(t2.outcome) outcomeCnt"
					+ "	, IFNULL(SUM(t2.outcome), 0) outcomeSum"
					+ "	, IFNULL(AVG(ROUND(t2.outcome)), 0) outcomeAvg"
					+ "	, COUNT(t2.income) incomeCnt"
					+ "	, IFNULL(SUM(t2.income), 0) incomeSum"
					+ "	, IFNULL(AVG(ROUND(t2.income)), 0) incomeAvg"
					+ " FROM (SELECT"
					+ "				memberId"
					+ "				, cashNo"
					+ "				, cashDate"
					+ "				, if(categoryKind = '수입', cashPrice, NULL) income"
					+ "				, if(categoryKind = '지출', cashPrice, NULL) outcome"
					+ "			FROM (SELECT c.cash_no cashNo"
					+ "						, c.cash_date cashDate"
					+ "						, c.cash_price cashPrice"
					+ "						, cg.category_kind categoryKind"
					+ "						, c.member_id memberId"
					+ "				FROM cash c INNER JOIN category cg"
					+ "				ON c.category_no = cg.category_no) t) t2"
					+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?" // memberId, year 입력
					+ " GROUP BY YEAR(t2.cashDate), MONTH(t2.cashDate)"
					+ " ORDER BY YEAR(t2.cashDate), MONTH(t2.cashDate)";		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, memberId);
			stmt.setInt(2, year);
			rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				map.put("month", rs.getInt("month"));
				map.put("outcomeCnt", rs.getInt("outcomeCnt"));
				map.put("outcomeAvg", rs.getInt("outcomeAvg"));
				map.put("outcomeSum", rs.getInt("outcomeSum"));
				map.put("incomeCnt", rs.getInt("incomeCnt"));
				map.put("incomeSum", rs.getInt("incomeSum"));
				map.put("incomeAvg", rs.getInt("incomeAvg"));
				list.add(map);
			}
		} catch (Exception e) {
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
	
	// 월별 수입/지출, 총합, 평균
		public ArrayList<HashMap<String, Object>> selectCashByCate(String memberId){
			ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
			
			DBUtil dbUtil = new DBUtil();
			Connection conn = null;
			PreparedStatement stmt = null;
			ResultSet rs = null;

			String sql = "SELECT"
						+ " MONTH(t2.cashDate) month"
						+ "	, COUNT(t2.outcome) outcomeCnt"
						+ "	, IFNULL(SUM(t2.outcome), 0) outcomeSum"
						+ "	, IFNULL(AVG(ROUND(t2.outcome)), 0) outcomeAvg"
						+ "	, COUNT(t2.income) incomeCnt"
						+ "	, IFNULL(SUM(t2.income), 0) incomeSum"
						+ "	, IFNULL(AVG(ROUND(t2.income)), 0) incomeAvg"
						+ " FROM (SELECT"
						+ "				memberId"
						+ "				, cashNo"
						+ "				, cashDate"
						+ "				, if(categoryKind = '수입', cashPrice, NULL) income"
						+ "				, if(categoryKind = '지출', cashPrice, NULL) outcome"
						+ "			FROM (SELECT c.cash_no cashNo"
						+ "						, c.cash_date cashDate"
						+ "						, c.cash_price cashPrice"
						+ "						, cg.category_kind categoryKind"
						+ "						, c.member_id memberId"
						+ "				FROM cash c INNER JOIN category cg"
						+ "				ON c.category_no = cg.category_no) t) t2"
						+ " WHERE t2.memberId = ? AND YEAR(t2.cashDate) = ?" // memberId, year 입력
						+ " GROUP BY YEAR(t2.cashDate), MONTH(t2.cashDate)"
						+ " ORDER BY YEAR(t2.cashDate), MONTH(t2.cashDate)";		
			/*
			SELECT
				CONCAT(t2.categoryKind, ' ', t2.categoryName) 카테고리
				, COUNT(t2.outcome) 지출횟수
				, ifnull(SUM(t2.outcome), 0) 지출합계
				, ifnull(round(avg(t2.outcome)), 0) 지출평균
				, COUNT(t2.income) 수입횟수
				, ifnull(SUM(t2.income), 0) 수입합계
				, ifnull(round(avg(t2.income)), 0) 수입평균
			FROM (SELECT
							memberId
							, categoryName
							, categoryKind				
							, cashNo
							, cashDate
							, if(categoryKind = '수입', cashPrice, NULL) income
							, if(categoryKind = '지출', cashPrice, NULL) outcome
					FROM (SELECT c.cash_no cashNo
									, c.cash_date cashDate
									, c.cash_price cashPrice
									, cg.category_kind categoryKind
									, cg.category_name categoryName
									, c.member_id memberId
							FROM cash c INNER JOIN category cg 
							ON c.category_no = cg.category_no) t) t2
			WHERE t2.memberId = 'goodee'
			GROUP BY CONCAT(t2.categoryKind, ' ', t2.categoryName)
			ORDER BY t2.categoryKind, t2.categoryName
			*/
			return list;
		}
}
