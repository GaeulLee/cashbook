<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updatePwForm</title>
	</head>
	<body>
		<form action="<%=request.getContextPath()%>/member/updatePwAction.jsp" method="post">
			<table border="1">
				<tr>
					<th colspan="2">비밀번호 변경</th>
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
						<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>현재 PW</th>
					<td>
						<input type="password" name="oldPw">
					</td>
				</tr>
				<tr>
					<th>바꿀 PW</th>
					<td>
						<input type="password" name="newPw">
					</td>
				</tr>
				<tr>
					<th>회원 이름</th>
					<td>
						<input type="text" name="memberId" value="<%=memberName%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
		<div>
			<span>
				<a href="<%=request.getContextPath()%>/member/memberOne.jsp">back</a>
			</span>
		</div>
	</body>
</html>