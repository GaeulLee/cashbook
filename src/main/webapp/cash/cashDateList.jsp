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
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> dateList = cashDao.selectCashListByDate(memberId, year, month);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashDateList</title>
	</head>
	<body>
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp">back</a>
		<table>
			<tr>
				<th colspan="7"><%=year%>년 <%=month%>월 <%=date%>일</th>
			</tr>
			<tr>
				<th>No</th>
				<th>날짜</th>
				<th>구분</th>
				<th>항목</th>
				<th>금액</th>
				<th>메모</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
			<%
				for(HashMap<String, Object> m : dateList){
					String cashDate = (String)(m.get("cashDate"));
					if(Integer.parseInt(cashDate.substring(8)) == date){ 
			%>
				<tr>
					<td><%=(Integer)m.get("cashNo")%></td>
					<td><%=(String)m.get("cashDate")%></td>
					<td><%=(String)m.get("categoryKind")%></td>
					<td><%=(String)m.get("categoryName")%></td>
					<td><%=(Long)m.get("cashPrice")%></td>
					<td><%=(String)m.get("cashMemo")%></td>
					<td><%=(String)m.get("updatedate")%></td>
					<td><%=(String)m.get("createdate")%></td>
				</tr>
			<%
					}
				}
			%>
		</table>
	</body>
</html>