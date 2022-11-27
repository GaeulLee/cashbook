<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="vo.Notice"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// M
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	int beginRow = 0;
	int rowPerPage = 5;
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); // 최근 공지 5개
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage); // 최근 추가 멤버 5개씩
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>adminMain</title>
	</head>
	<body>
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버 관리</a></li><!-- 레벨 수정, 멤버 목록, 강제 회원탈퇴 -->
			<li><a href="<%=request.getContextPath()%>/cash/cashList.jsp">가계부</a></li>			
		</ul>
		<!-- admin contents -->
		<!-- 최근 공지 5개 -->
		<div>
			<h3><strong>공지사항</strong></h3>
			<table border="1">
				<tr>
					<th>내용</th>
					<th>날짜</th>
				</tr>
				<%
					for(Notice n : noticeList){
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
		<!-- 최근 추가 멤버 5개 -->
		<div>
			<h3><strong>최근 생성된 회원</strong></h3>
			<table border="1">
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>회원레벨</th>
					<th>이름</th>
					<th>수정일</th>
					<th>회원 생성일</th>
				</tr>
				<%
					for(Member m : memberList){
				%>
						<tr>
							<td><%=m.getMemberNo()%></td>
							<td><%=m.getMemberId()%></td>
							<td><%=m.getMemberLevel()%></td>
							<td><%=m.getMemberName()%></td>
							<td><%=m.getUpdatedate()%></td>
							<td><%=m.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>