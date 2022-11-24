<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// C
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("login");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	// M
	// 최근 공지, 최근 추가 멤버 5개씩 
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>adminMain</title>
	</head>
	<body>
		<ul>
			<li><a>공지 관리</a></li>
			<li><a>카테고리 관리</a></li>
			<li><a>멤버 관리</a></li><!-- 레벨 수정, 멤버 목록, 강제 회원탈퇴 -->
			<li><a>공지관리</a></li>
		</ul>
		
		<!-- 메뉴 아래 썰렁하니까 조금 보여주기 -->
		<!-- 최근 공지 5개 -->
		<!-- 최근 추가 멤버 5개 -->
	</body>
</html>