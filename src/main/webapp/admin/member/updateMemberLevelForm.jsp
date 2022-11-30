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
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
		return;
	}
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// 받아온 memberNo값 Member에 넣기
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);
	
	// M -> 수정할 정보 가져오기
	MemberDao memberDao = new MemberDao();
	Member oldMember = memberDao.selectMemberOne(paramMember);

	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateMemberLevelForm</title>
	</head>
	<body>
	<!-- header -->
	<jsp:include page="../../inc/adminMainHeader.jsp"></jsp:include>
	<!-- 본문 시작 -->
	<div>
		<h3><strong>멤버 수정</strong></h3>
		<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp" method="post">
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
					<th>회원번호</th>
					<td>
						<input type="number" name="memberNo" value="<%=oldMember.getMemberNo()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<input type="text" name="memberId" value="<%=oldMember.getMemberId()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>회원레벨</th>
					<td>
						<input type="number" name="memberLevel" value="<%=oldMember.getMemberLevel()%>" placeholder="회원은 0, 관리자는 1">
					</td>
				</tr>
				<tr>
					<th>이름</th>
					<td>
						<input type="text" name="memberName" value="<%=oldMember.getMemberName()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>회원 생성일</th>
					<td><%=oldMember.getCreatedate()%></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/admin/memberList.jsp">back</a>
		</div>
	</div>
	</body>
</html>