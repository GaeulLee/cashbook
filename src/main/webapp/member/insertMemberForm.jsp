<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 유효성 검사(로그인이 되어있으면 회원가입을 할 수 없게)
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm</title>
	</head>
	<body>
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post">
			<table>
				<tr>
					<th colspan="2">회원가입</th>
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
					<th>회원 ID</th>
					<td>
						<input type="text" name="memberId">
					</td>
				</tr>
				<tr>
					<th>회원 PW</th>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
				<tr>
					<th>회원 이름</th>
					<td>
						<input type="text" name="memberName">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">가입</button>
					</td>
				</tr>
			</table>
		</form>
		<a href="<%=request.getContextPath()%>/loginForm.jsp">back</a>
	</body>
</html>