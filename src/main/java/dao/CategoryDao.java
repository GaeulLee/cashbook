package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Category;

public class CategoryDao {
	
	// admin -> 카테고리 검색 -> 카테고리 목록(카테고리 번호, 수입지출 구분, 항목, 수정일, 생성일)
	public ArrayList<Category> selectCategoryListByAdmin() {
		
		ArrayList<Category> categoryList = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ " category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ ", createdate"
				+ ", updatedate"
				+ " FROM category"
				+ " ORDER BY createdate DESC";		
		
		try {
				conn = dbUtil.getConnection();
				System.out.println("selectCategoryListByAdmin db 접속 확인");
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();
			
			categoryList = new ArrayList<Category>();
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryKind(rs.getString("categoryKind"));
				c.setCategoryName(rs.getString("categoryName"));
				c.setCreatedate(rs.getString("createdate"));
				c.setUpdatedate(rs.getString("updatedate"));
				categoryList.add(c);
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
		return categoryList;
	}
	
	
	// 카테고리 리스트 출력 cashDateList.jsp
	public ArrayList<Category> selectCategoryList() { // 입력값 x, 출력값 o
		
		ArrayList<Category> categoryList = null; 
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;		
		DBUtil dbUtil = new DBUtil();
		
		String sql = "SELECT category_no categoryNo"
				+ ", category_name categoryName"
				+ ", category_kind categoryKind"
				+ " FROM category"
				+ " ORDER BY category_kind";
		
		try {
			conn = dbUtil.getConnection();
			stmt = conn.prepareStatement(sql);
			rs = stmt.executeQuery();		
			categoryList = new ArrayList<Category>();
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryNo(rs.getInt("categoryNo"));
				c.setCategoryName(rs.getNString("categoryName"));
				c.setCategoryKind(rs.getNString("categoryKind"));
				categoryList.add(c);
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
		return categoryList;
	}
	
	// 카테고리 추가 insertCategoryAction.jsp
	public int insertCategory(Category paramCategory) { // 입력값 있음 알아서 적으셈
		
		int resultInsert = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil(); 
		
		String sql = "INSERT INTO category("
				+ " category_kind"
				+ ", category_name"
				+ ", updatedate"
				+ ", createdate"
				+ ") VALUES (?,?,NOW(),NOW())";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("insertCategory db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCategory.getCategoryKind());
			stmt.setString(2, paramCategory.getCategoryName());
			resultInsert = stmt.executeUpdate();
		} catch(Exception e) {
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
	
	// 카테고리 삭제 deleteCategoryAction.jsp
	public int deleteCategory(Category paramCategory) {
		
		int resultDelete = 0;
		DBUtil dbUtil = new DBUtil(); 
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM category WHERE category_no = ?";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("deleteCategory db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCategory.getCategoryNo());
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
	
	// 카테고리 수정(기존 카테고리 불러오기) updateCategoryForm.jsp
	public Category selectCategoryOne(Category paramCategory) {
		
		Category oldCategory = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil(); 
		
		String sql = "SELECT category_no categoryNo"
				+ ", category_kind categoryKind"
				+ ", category_name categoryName"
				+ ", createdate"
				+ " FROM category"
				+ " WHERE category_no = ?";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("selectCategoryOne db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramCategory.getCategoryNo());
			rs = stmt.executeQuery();
			if(rs.next()) {
				oldCategory = new Category();
				oldCategory.setCategoryNo(rs.getInt("categoryNo"));
				oldCategory.setCategoryKind(rs.getString("categoryKind"));
				oldCategory.setCategoryName(rs.getString("categoryName"));
				oldCategory.setCreatedate(rs.getString("createdate"));
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
		return oldCategory;
	}
	
	// 카테고리 수정(이름만) updateCategoryAction.jsp
	public int updateCategory(Category paramCategory) {
		
		int resultUpdate = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "UPDATE category SET"
				+ " category_name = ?"
				+ ", updatedate = NOW()"
				+ " WHERE category_no = ?";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("updateCategory db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramCategory.getCategoryName());
			stmt.setInt(2, paramCategory.getCategoryNo());
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
}