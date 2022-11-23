<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	// 달력의 특정 일을 클릭하면 그 날의 수입 지출 목록이 보이게 + 수정 삭제 기능
	
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
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	if(request.getParameter("year") == null || request.getParameter("month") == null || request.getParameter("date") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> dateList = cashDao.selectCashListByDate(memberId, year, month, date);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashDateList</title>
	</head>
	<body>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">back</a>
		<!-- cash 입력 폼 -->
		<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
			<!-- memberId 는 hidden 값으로 넘기기 -->
			<input type="hidden" name="memberId" value="<%=memberId%>">
			<table border="1">
				<tr>
					<th colspan="2"><%=year%>년 <%=month%>월 <%=date%>일 가계부 입력</th>
				</tr>
				<tr>
					<th>날짜</th>
					<td>
						<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly">
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
						<button type="submit">추가</button>
					</td>
				</tr>
			</table>
		</form>
		<!-- cash 목록 출력 -->
		<table border="1">
			<tr>
				<th colspan="9"><%=year%>년 <%=month%>월 <%=date%>일</th>
			</tr>
			<tr>
				<th>구분</th>
				<th>항목</th>
				<th>금액</th>
				<th>메모</th>
				<th>작성일</th>
				<th>수정일</th>
				<th>수정</th>
			</tr>
			<%
				for(HashMap<String, Object> m : dateList){
			%>
				<tr>
					<td><%=(String)m.get("categoryKind")%></td>
					<td><%=(String)m.get("categoryName")%></td>
					<td><%=(Long)m.get("cashPrice")%></td>
					<td><%=(String)m.get("cashMemo")%></td>
					<td><%=(String)m.get("updatedate")%></td>
					<td><%=(String)m.get("createdate")%></td>
					<td>
						<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=(Integer)m.get("cashNo")%>">수정</a>
						<span> / </span>
						<a href="<%=request.getContextPath()%>/cash/deleteCashAction.jspcashNo=<%=(Integer)m.get("cashNo")%>">삭제</a>
					</td>
				</tr>
			<%
				}
			%>
		</table>
	</body>
</html>