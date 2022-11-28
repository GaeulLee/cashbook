<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// C
	/*
	1. 로그인 유효성 검사 + 레벨 확인
	2. 모델 출력
	*/
	// 로그인 유효성 검사 + 레벨 확인
		if(session.getAttribute("loginMember") == null){
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		}
		Member member = (Member)session.getAttribute("loginMember");
		int memberLevel = member.getMemberLevel();
		if(memberLevel < 1){
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		}
	// M
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertCategoryForm</title>
	</head>
	<body>
		<h3><strong>카테고리 추가</strong></h3>
		<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
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
					<th>구분</th>
					<td>
						<label>
							<input type="radio" id="categoryKind" name="categoryKind" value="수입">수입
						</label>
						<label>
							<input type="radio" id="categoryKind" name="categoryKind" value="지출">지출
						</label>
					</td>
				</tr>
				<tr>
					<th>항목</th>
					<td>
						<input type="text" name="categoryName" placeholder="카테고리 이름을 적어주세요. ex) 외식, 미용, 가전">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">추가</button>
					</td>
				</tr>
			</table>
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">back</a>
		</div>
	</body>
</html>