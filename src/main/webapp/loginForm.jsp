<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.Notice"%>
<%
	/*
	1. 로그인 유효성 검사 -> 로그인이 되어있으면 가계부로 가게
	2. 페이징(cnt는 메서드로)
	3. 공지 출력
	*/

	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// paging
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 5; // 한 페이지 당 보여줄 게시글(행) 수
	int beginRow = (currentPage-1)*ROW_PER_PAGE; // 쿼리에 작성할 게시글(행) 시작 값
	final int PAGE_COUNT = 10; // 한 페이지 당 보여줄 페이징 목록 수
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1; // 페이징 목록 시작 값
	int endPage = beginPage+PAGE_COUNT-1; // 페이징 목록 끝 값
	
	NoticeDao noticeDao = new NoticeDao();
	int cnt = noticeDao.selectNoticeCount(); // 전체 행 구하기
	int lastPage = cnt/ROW_PER_PAGE; // 마지막 페이지
	if(lastPage%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){ // 페이지 목록이 lastPage까지만 보이도록
		endPage = lastPage;
	}
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE); // 공지 출력

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
	</head>
	<body>
		<!-- 공지(5개)목록 페이징 (상세보기 없음 타이틀만 보이게, 댓글 기능) -->
		<div>
			<h3><strong>공지사항</strong></h3>
			<table border="1">
				<tr>
					<th>내용</th>
					<th>날짜</th>
				</tr>
				<%
					for(Notice n : list){
				%>
						<tr>
							<td><%=n.getNoticeMemo()%></td>
							<td><%=n.getCreatedate()%></td>
						</tr>
				<%
					}
				%>
			</table>
			<!-- paging -->
			<ul style="list-style: none;">				
				<li>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1">처음</a>
				<%
					if(currentPage > 1){
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>">이전</a>
				<%
					}
					for(int i=beginPage; i<=endPage; i++){
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>"><%=i%></a>
				<%	
					}
					if(currentPage < lastPage){
				%>
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>">다음</a>
				<%
					}
				%>
					<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>">마지막</a>	
				</li>
			</ul>
		</div>
		<!-- 회원 로그인 폼 -->
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post">
			<table>
				<tr>
					<th>로그인</th>
				</tr>
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
				%>
						<tr>
							<th colspan="2"><%=msg%></th>
						</tr>	
				<%
					}
				%>
				<tr>
					<td>회원ID</td>
					<td>
						<input type="text" name="memberId">
					</td>
				</tr>
				<tr>
					<td>회원PW</td>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
			</table>
			<button type="submit">로그인</button>
		</form>
		<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp">회원가입</a>
	</body>
</html>