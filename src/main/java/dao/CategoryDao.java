package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	
	// admin -> 카테고리 검색 -> 카테고리 목록(카테고리 번호, 수입지출 구분, 항목, 수정일, 생성일)
	public ArrayList<Category> selectCategoryListByAdmin() throws Exception{
		
		ArrayList<Category> categoryList = null;
		categoryList = new ArrayList<Category>();
		
		// db자원(jdbc API자원) 초기화
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = dbUtil.getConnection();
			System.out.println("selectCategoryListByAdmin db 접속 확인");
		String sql = "SELECT"
				+ " category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ ", createdate"
				+ ", updatedate"
				+ " FROM category"
				+ " ORDER BY createdate";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryKind(rs.getString("categoryKind"));
			c.setCategoryName(rs.getString("categoryName"));
			c.setCreatedate(rs.getString("createdate"));
			c.setUpdatedate(rs.getString("updatedate"));
			categoryList.add(c);
		}
		// db자원(jdbc API자원) 반납
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
	
	
	// 카테고리 리스트 출력 cashDateList.jsp
	public ArrayList<Category> selectCategoryList() throws Exception{ // 입력값 x, 출력값 o
		
		ArrayList<Category> categoryList = new ArrayList<Category>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		/*
			SELECT category_no categoryNo
				, category_name categoryName
				, category_kind categoryKind
			FROM category
			ORDER BY category_kind;
		*/
		String sql = "SELECT category_no categoryNo"
				+ ", category_name categoryName"
				+ ", category_kind categoryKind"
				+ " FROM category"
				+ " ORDER BY category_kind";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryName(rs.getNString("categoryName"));
			c.setCategoryKind(rs.getNString("categoryKind"));
			categoryList.add(c);
		}
		dbUtil.close(rs, stmt, conn);
		return categoryList;
	}
}