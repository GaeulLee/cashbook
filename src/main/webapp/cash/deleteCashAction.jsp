<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
		2. 파라메터 유효성 검사
		3. 모델 출력
	*/

	// 로그인 유효성 검사
	String msg = null;
	if(session.getAttribute("loginMember") == null){
		msg = URLEncoder.encode("로그인이 필요합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	
	// 파라메터 유효성 검사
	// 날짜, 가계부 내역 정보가 없으면 돌아가게
	if(request.getParameter("year") == null || request.getParameter("month") == null ||
	request.getParameter("date") == null || request.getParameter("cashNo") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
		System.out.println("cashNo: "+cashNo);
		
	// M
	CashDao cashDao = new CashDao();
	int deleteCashResult = cashDao.deleteCash(cashNo, loginMemberId);
	if(deleteCashResult != 0){
		System.out.println("삭제 성공");
	} else {
		System.out.println("삭제 실패");
	}
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?year="+year+"&month="+month+"&date="+date);
	// V
%>