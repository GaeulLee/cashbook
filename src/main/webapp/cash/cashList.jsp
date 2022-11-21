<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import=""%>
<%
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashList</title>
	</head>
	
	<!-- 다이어리 형식으로 수입 지출을 확인할 수 있도록 -->
	<body>
		<div>
			<!-- 로그인 정보(세션에 loginMember 변수) 출력 -->
		</div>
	
	</body>
</html>