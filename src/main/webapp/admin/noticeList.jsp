<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="vo.Notice"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사(회원 레벨 확인)
		2. 페이징(페이지 값 있다면 바꿔주기)
		3. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	NoticeDao noticeDao = new NoticeDao();
	int cnt = noticeDao.selectNoticeCount();
	final int ROW_PER_PAGE = 15;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage*PAGE_COUNT;
	int lastPage = cnt/ROW_PER_PAGE;
	
	if(cnt%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){
		endPage = lastPage;
	}
	
	// M
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>noticeList</title>
	</head>
	<body>
		<ul>
			<li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지 관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리 관리</a></li>
			<li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">멤버 관리</a></li><!-- 레벨 수정, 멤버 목록, 강제 회원탈퇴 -->
		</ul>
		<!-- 공지목록 페이징 (상세보기 없음 타이틀만 보이게, 댓글 기능) -->
		<div>
			<h3><strong>공지사항</strong></h3>
			<table border="1">
				<tr>
					<th>공지번호</th>
					<th>내용</th>
					<th>날짜</th>
					<th>편집</th>
				</tr>
				<%
					for(Notice n : noticeList){
				%>
						<tr>
							<td><%=n.getNoticeNo()%></td>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/notice/updateNoticeForm.jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a>
								<a href="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction.jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a>
							</td>
						</tr>
				<%
					}
				%>
			</table>
			<div>
				<a href="<%=request.getContextPath()%>/admin/notice/insertNoticeForm.jsp">공지 추가</a>
			</div>
			<!-- paging -->
			<ul style="list-style: none;">				
				<li>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
					for(int i=beginPage; i<=endPage; i++){
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=i%>"><%=i%></a>
				<%	
					}
					if(currentPage < lastPage){
				%>
						<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>
					<a href="<%=request.getContextPath()%>/admin/noticeList.jsp?currentPage=<%=lastPage%>">마지막</a>	
				</li>
			</ul>
		</div>
	</body>
</html>