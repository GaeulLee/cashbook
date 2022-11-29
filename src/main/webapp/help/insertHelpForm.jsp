<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 세션 정보 저장
	*/
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
		if(session.getAttribute("loginMember") == null){
			response.sendRedirect(request.getContextPath()+"loginForm.jsp");
			return;
		}

	// 세션에 정보가 있다면 정보 가져오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertHelpForm</title>
	</head>
	<body>
	<!-- header -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<!-- 본문 시작 -->
	<div>
		<form action="<%=request.getContextPath()%>/help/insertHelpAction.jsp" method="post">
			<input type="hidden" name="memberId" value="<%=memberId%>">
			<table border="1">
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
				%>
						<tr>
							<th class="text-info">&#10069;<%=msg%></th>
						</tr>	
				<%
					}
				%>
				<tr>
					<th>문의 내용</th>
					<td>
						<textarea name="helpMemo" rows="5" cols=50" placeholder="문의 내용을 입력해주세요."></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">작성</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>