<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
	</head>
	
	<body>
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
		<a href="<%=request.getContextPath()%>/signIn.jsp">회원가입</a>
	</body>
</html>