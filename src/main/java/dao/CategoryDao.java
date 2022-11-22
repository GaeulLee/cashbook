package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
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
		String sql = "SELECT category_no categoryNo, category_name categoryName, category_kind categoryKind FROM category ORDER BY category_kind";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Category c = new Category();
			c.setCategoryNo(rs.getInt("categoryNo"));
			c.setCategoryName(rs.getNString("categoryName"));
			c.setCategoryKind(rs.getNString("categoryKind"));
			categoryList.add(c);
		}
		rs.close();
		stmt.close();
		conn.close();
		return categoryList;
	}
}