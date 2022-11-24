<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기 -> deleteAction으로 세션에 저장된 아이디 값을 넘겨주기 위함
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deleteMemberForm</title>
	</head>
	<body>
		<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
			<table border="1">
				<input type="hidden" name="memberId" value="<%=memberId%>">
				<tr>
					<th colspan="2">회원탈퇴</th>
				</tr>
				<tr>
					<th colspan="2">
					<%
					String msg = request.getParameter("msg");
						if(msg != null){
					%>
							<%=msg%>						
					<%
						}else{
					%>
							회원 탈퇴를 위한 비밀번호를 입력해주세요.
					<%
						}
					%>
					</th>
				</tr>
				<tr>
					<th>비밀번호 입력</th>
					<td>
						<input type="password" name="memberPw">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">탈퇴</button>
					</td>
				</tr>
			</table>
		</form>
		<a href="<%=request.getContextPath()%>/member/memberOne.jsp">back</a>
	</body>
</html>