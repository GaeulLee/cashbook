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
				<%
					String msg = null;
					if(request.getParameter("msg") != null){
				%>
					<tr>
						<th><%=msg%></th>
					</tr>	
				<%
					}
				%>
				<tr>
					<th>로그인</th>
				</tr>
				<tr>
					<td>이름</td>
					<td>
						<input type="text" name="memberName">
					</td>
				</tr>
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
	</body>
</html>