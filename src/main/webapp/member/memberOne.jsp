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
		<title>MemberOne</title>
	</head>
	<body>
		<table border="1">
			<tr>
				<th colspan="2">내 정보</th>
			</tr>
			<tr>
				<th>회원 ID</th>
				<td><%=memberId%></td>
			</tr>
			<tr>
				<th>회원 PW</th>
				<td>
					<a href="<%=request.getContextPath()%>/member/updatePwForm.jsp">비밀번호 변경</a>
				</td>
			</tr>
			<tr>
				<th>회원 이름</th>
				<td><%=memberName%></td>
			</tr>
		</table>
		<div>
			<span>
				<a href="<%=request.getContextPath()%>/cash/cashList.jsp">back</a>
			</span>
			<span>
				<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">회원정보 수정</a>
			</span>
			<span>
				<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원 탈퇴</a>
			</span>
		</div>
	</body>
</html>