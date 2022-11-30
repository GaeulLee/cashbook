<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// C
	/*
		1. 로그인 유효성 검사, 레벨 확인
		2. 파라메터 유효성 검사
		3. 데이터 묶기
		4. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터 유효성 검사
	if(request.getParameter("noticeNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	// 받아온 noticeNo값 Notice에 넣기
	Notice paramNotice = new Notice();
	paramNotice.setNoticeNo(noticeNo);
	
	// M -> 수정할 정보 가져오기
	NoticeDao noticeDao = new NoticeDao();
	Notice oldNotice = noticeDao.selectNoticeOne(paramNotice);

	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateNoticeForm</title>
	</head>
	<body>
	<!-- header -->
	<jsp:include page="../../inc/adminMainHeader.jsp"></jsp:include>
	<!-- 본문 시작 -->
	<div class="container">
		<h3><strong>공지 수정</strong></h3>
		<form action="<%=request.getContextPath()%>/admin/notice/updateNoticeAction.jsp" method="post">
			<table>
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
				%>
						<tr>
							<th colspan="2"><strong><%=msg%></strong></th>
						</tr>
				<%
					}
				%>
				<tr>
					<th>공지 번호</th>
					<td>
						<input type="number" name="noticeNo" value="<%=oldNotice.getNoticeNo()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>공지 내용</th>
					<td>
						<textarea name="noticeMemo" rows="5" cols="70"><%=oldNotice.getNoticeMemo()%></textarea>
					</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td><%=oldNotice.getCreatedate()%></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">back</a>
		</div>
	</div>
	</body>
</html>