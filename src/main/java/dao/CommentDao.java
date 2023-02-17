package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBUtil;
import vo.Comment;

public class CommentDao {
	
	// 답변 추가
	public int insertComment(Comment comment) {
		
		int resultInsert = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO comment"
				+ " (help_no, comment_memo, member_id, updatedate, createdate)"
				+ " VALUES (?, ?, ?, NOW(), NOW())";

		try {
			conn = dbUtil.getConnection();
				System.out.println("insertComment db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getHelpNo());
			stmt.setString(2, comment.getCommentMemo());
			stmt.setString(3, comment.getMemberId());
			resultInsert = stmt.executeUpdate();
		}catch(Exception e) {
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
	
	// 답변 수정 전 글 불러오기 (int commentNo만 받아도 됨)
	public Comment selectCommentOne(Comment comment) {
		
		Comment oldComment = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT"
				+ "	comment_no commentNo"
				+ "	, comment_memo commentMemo"
				+ " FROM comment"
				+ " WHERE comment_no = ?;";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("selectCommentOne db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getCommentNo());
			rs = stmt.executeQuery();
			if(rs.next()) {
				oldComment = new Comment();
				oldComment.setCommentNo(rs.getInt("commentNo"));
				oldComment.setCommentMemo(rs.getString("commentMemo"));
			}		
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(rs, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return oldComment;
	}
	
	// 답변 수정
	public int updateComment(Comment comment) {
		
		int resultUpdate = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "UPDATE comment SET"
				+ " comment_memo = ?"
				+ ", updatedate = now()"
				+ "WHERE comment_no = ?";

		try {
			conn = dbUtil.getConnection();
				System.out.println("updateComment db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, comment.getCommentMemo());
			stmt.setInt(2, comment.getCommentNo());
			resultUpdate = stmt.executeUpdate();
			}catch(Exception e) {
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
	
	// 답변 삭제 (int commentNo만 받아도 됨)
	public int deleteComment(Comment comment) {
		
		int resultDelete = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM comment"
				+ " WHERE comment_no = ?";
	
		try {
			conn = dbUtil.getConnection();
				System.out.println("deleteComment db 접속 확인");
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, comment.getCommentNo());
			resultDelete = stmt.executeUpdate();
		}catch(Exception e) {
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
