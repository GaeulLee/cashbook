<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%	
	// C
	/*
		1. 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
		2. 파라메터 유효성 검사
		3. 모델 출력
	*/
	
	// 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
	String msg = null;
	if(session.getAttribute("loginMember") == null){
		msg = URLEncoder.encode("로그인이 필요합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// 파라메터 유효성 검사
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	if(request.getParameter("cashNo") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	// M
	
	// 카테고리 리스트
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCashForm</title>
	</head>
	<body>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp">back</a>
		<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp?cashNo=<%=cashNo%>" method="post">
			<table border="1">
				<%
					String paramMsg = request.getParameter("msg");
					if(paramMsg != null){
				%>
						<tr>
							<th colspan="2"><%=paramMsg%></th>
						</tr>
				<%
					}
				%>
				<tr>
					<th>No</th>
					<td>
						<input type="text" name="cashNo" value="<%=cashNo%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>날짜</th>
					<td>
						<input type="text" name="cashDate" placeholder="yyyy-mm-dd 형식으로 입력">
					</td>
				</tr>
				<!-- categoryName 출력 list로-->
				<tr>
					<th>구분</th>
					<td>
						<select name="categoryNo">
						<%
							for(Category c : categoryList){
						%>
								<option value="<%=c.getCategoryNo()%>">
									[<%=c.getCategoryKind()%>]-<%=c.getCategoryName()%>
								</option>
						<%
							}
						%>
						</select>
					</td>
				</tr>
				<tr>
					<th>금액</th>
					<td>
						<input type="number" name="cashPrice">
					</td>
				</tr>
				<tr>
					<th>메모</th>
					<td>
						<textarea name="cashMemo" rows="3" cols="50"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>