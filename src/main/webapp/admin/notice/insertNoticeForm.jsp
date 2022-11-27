<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// C
	/*
	1. 로그인 유효성 검사, 레벨 확인
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertNoticeForm</title>
	</head>
	<body>
		<h3><strong>공지 추가</strong></h3>
		<form action="<%=request.getContextPath()%>/admin/notice/insertNoticeAction.jsp" method="post">
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
					<th>공지 내용</th>
					<td>
						<textarea name="noticeMemo" rows="5" cols="70" placeholder="공지할 내용을 입력해주세요."></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">추가</button>
					</td>
				</tr>
			</table>
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/admin/noticeList.jsp">back</a>
		</div>
	</body>
</html>