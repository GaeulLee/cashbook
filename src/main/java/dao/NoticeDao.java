package dao;

import java.util.ArrayList;

import java.sql.*;

import util.DBUtil;
import vo.Notice;

public class NoticeDao {
	
	// 마지막 페이지 구하기 위해 전체 행 수 구하기
	public int selectNoticeCount() throws Exception {
		
		int cnt = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
			System.out.println("selectNoticeCount db 접속 확인");
		String sql = "SELECT COUNT(*) cnt FROM notice";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			cnt = rs.getInt("cnt");
		}
		dbUtil.close(rs, stmt, conn);
		return cnt;
	}

	// loginForm.jsp 공지목록
	public ArrayList<Notice> selectNoticeListByPage(int beginRow, int rowPerPage) throws Exception {
		
		ArrayList<Notice> list = new ArrayList<Notice>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
			System.out.println("selectNoticeListByPage db 접속 확인");
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate"
				+ " FROM notice ORDER BY createdate DESC"
				+ " LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Notice n = new Notice();
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeMemo(rs.getString("noticeMemo"));
			n.setCreatedate(rs.getString("createdate"));
			list.add(n);
		}
		dbUtil.close(rs, stmt, conn);
		return list;
	}
	
	// 수정할 notice 데이터 불러오기 updateNoticeForm.jsp
	public Notice selectNoticeOne(Notice paramNotice) throws Exception {
		
		Notice oldNotice = new Notice();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
			System.out.println("selectNoticeOne db 접속 확인");
		String sql = "SELECT notice_no noticeNo, notice_memo noticeMemo, createdate FROM notice"
				+ " WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, paramNotice.getNoticeNo());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			oldNotice.setNoticeNo(rs.getInt("noticeNo"));
			oldNotice.setNoticeMemo(rs.getString("noticeMemo"));
			oldNotice.setCreatedate(rs.getString("createdate"));
		}
		dbUtil.close(rs, stmt, conn);
		return oldNotice;
	}
	
	// notice 수정 updateNoticeAction.jsp
	public int updateNotice(Notice paramNotice) throws Exception{ // crud를 할때 삭제를 하든 업데이트를 하든 기본적으로 전체를 다 받아주는 것이 좋음
		
		int resultUpdate = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
			System.out.println("updateNotice db 접속 확인");
		String sql = "UPDATE notice SET"
				+ " notice_memo = ?"
				+ ", updatedate = NOW()"
				+ " WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, paramNotice.getNoticeMemo());
		stmt.setInt(2, paramNotice.getNoticeNo());
		resultUpdate = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return resultUpdate;
		
	}
	
	// notice 삭제 deleteNoticection.jsp
	public int deleteNotice(Notice notice) throws Exception{
		
		int resultDelete = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
			System.out.println("deleteNotice db 접속 확인");
		String sql = "DELETE FROM notice WHERE notice_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		resultDelete = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return resultDelete;
	}
	
	
	// notice 추가 insertNoticeAction.jsp
	public int insertNotice(Notice notice) throws Exception{
		
		int resultInsert = 0;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
			System.out.println("insertNotice db 접속 확인");
		String sql = "INSERT INTO notice"
				+ " (notice_memo, createdate, updatedate)"
				+ " VALUES"
				+ " (?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeMemo());
		resultInsert = stmt.executeUpdate();
		
		dbUtil.close(null, stmt, conn);
		return resultInsert;
		
	}
	
}
