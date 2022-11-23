<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%
	// C
	/*
		0. 인코딩
		1. 로그인 유효성 검사
		2. 파라메터 유효성 검사
		3. 모델 출력
	*/
	request.setCharacterEncoding("utf-8");
	
	// 로그인 유효성 검사
	String msg = null;
	if(session.getAttribute("loginMember") == null){
		msg = URLEncoder.encode("로그인이 필요합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터 유효성 검사
	// 날짜, 회원id 정보가 없으면 돌아가게
	if(request.getParameter("year") == null || request.getParameter("month") == null ||
	request.getParameter("date") == null || request.getParameter("memberId") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	String memberId = request.getParameter("memberId");
	
	// 데이터 입력 값이 없으면 돌아가게
	if(request.getParameter("categoryNo").equals("") || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("")){
		msg = URLEncoder.encode("모든 정보를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date+"&msg="+msg);
		return;
	}
	String cashDate = request.getParameter("cashDate");
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
		System.out.println("cashDate: "+cashDate+", categoryNo: "+categoryNo+", cashPrice: "+cashPrice+", cashMemo: "+cashMemo);

	// M
	CashDao cashDao = new CashDao();
	int updateCashResult = cashDao.insertCash(cashDate, categoryNo, cashPrice, cashMemo, memberId);
	if(updateCashResult != 0){
		System.out.println("추가 성공");
	} else {
		System.out.println("추가 실패");
	}
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	// V
%>