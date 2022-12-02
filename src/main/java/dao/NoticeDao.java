package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	
	// 마지막 페이지 구하기 위해 전체 행 수 구하기
	public int selectNoticeCount() {
		
		int cnt = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "SELECT COUNT(*) cnt FROM notice";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("selectNoticeCount db 접속 확인");			
			stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				dbUtil.close(null, stmt, conn);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return cnt;
	}

	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) {
		
		ArrayList<Notice> list = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?,?";		
		try {
			conn = dbUtil.getConnection();
				System.out.println("selectNoticeListByPage db 접속 확인");			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			rs = stmt.executeQuery();
			list = new ArrayList<Notice>();
			while(rs.next()) {
				Notice n = new Notice();
				n.setNoticeNo(rs.getInt("noticeNo"));
				n.setNoticeMemo(rs.getString("noticeMemo"));
				n.setCreatedate(rs.getString("createdate"));
				list.add(n);
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
		return list;
	}
	
	// 수정할 notice 데이터 불러오기 updateNoticeForm.jsp
	public Notice selectNoticeOne(Notice paramNotice) {
		
		Notice oldNotice = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice"
				+ " WHERE notice_no = ?";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("selectNoticeOne db 접속 확인");
			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, paramNotice.getNoticeNo());
			rs = stmt.executeQuery();
			oldNotice = new Notice();
			if(rs.next()) {
				oldNotice.setNoticeNo(rs.getInt("noticeNo"));
				oldNotice.setNoticeMemo(rs.getString("noticeMemo"));
				oldNotice.setCreatedate(rs.getString("createdate"));
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
		return oldNotice;
	}
	
	// notice 수정 updateNoticeAction.jsp
	public int updateNotice(Notice paramNotice) { // crud를 할때 삭제를 하든 업데이트를 하든 기본적으로 전체를 다 받아주는 것이 좋음
		
		int resultUpdate = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "UPDATE notice SET"
				+ " notice_memo = ?"
				+ ", updatedate = NOW()"
				+ " WHERE notice_no = ?";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("updateNotice db 접속 확인");			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, paramNotice.getNoticeMemo());
			stmt.setInt(2, paramNotice.getNoticeNo());
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
	
	// notice 삭제 deleteNoticection.jsp
	public int deleteNotice(Notice notice) {
		
		int resultDelete = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "DELETE FROM notice WHERE notice_no =?";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("deleteNotice db 접속 확인");			
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, notice.getNoticeNo());
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
	
	
	// notice 추가 insertNoticeAction.jsp
	public int insertNotice(Notice notice) {
		
		int resultInsert = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		DBUtil dbUtil = new DBUtil();
		
		String sql = "INSERT INTO notice"
				+ " (notice_memo, createdate, updatedate)"
				+ " VALUES"
				+ " (?, NOW(), NOW())";
		
		try {
			conn = dbUtil.getConnection();
				System.out.println("insertNotice db 접속 확인");			
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, notice.getNoticeMemo());
			resultInsert = stmt.executeUpdate();
		} catch (Exception e) {
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
}
