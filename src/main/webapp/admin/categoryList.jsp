<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="vo.Notice"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사(회원 레벨 확인)
		2. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// M

	
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
			<li><a href="<%=request.getContextPath()%>/admin/adminMain.jsp">back</a></li>
		</ul>
		<!-- 카테고리 목록 -->
		<div>
			<h3><strong>카테고리 목록</strong></h3>
			<table border="1">
				<tr>
					<th>카테고리 번호</th>
					<th>구분</th>
					<th>항목</th>
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
								<a href="<%=request.getContextPath()%>/admin/notice/UpdateNoticeForm/jsp?noticeNo=<%=n.getNoticeNo()%>">수정</a>
								<a href="<%=request.getContextPath()%>/admin/notice/deleteNoticeAction/jsp?noticeNo=<%=n.getNoticeNo()%>">삭제</a>
							</td>
						</tr>
				<%
					}
				%>
			</table>
			<div>
				<a href="<%=request.getContextPath()%>/admin/notice/insertNoticeForm/jsp">공지 추가</a>
			</div>
		</div>
	</body>
</html>