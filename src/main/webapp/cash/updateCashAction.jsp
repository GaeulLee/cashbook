<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	
	// C
	/*
		0. 인코딩
		1. 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
		2. 파라메터 유효성 검사
		3. 파라메터 묶기
		4. 모델 출력
	*/
	request.setCharacterEncoding("utf-8");
	
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
	if(request.getParameter("year") == null || request.getParameter("month") == null ||
	request.getParameter("date") == null || request.getParameter("date") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}	
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	
	if(request.getParameter("categoryNo").equals("") || request.getParameter("cashPrice").equals("") || request.getParameter("cashMemo").equals("")){
		msg = URLEncoder.encode("모든 정보를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?cashNo="+cashNo+"&year="+year+"&month="+month+"&date="+date+"&msg="+msg);
		return;
	}
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	long cashPrice = Long.parseLong(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");

	// M
	CashDao cashDao = new CashDao();
	int updateCashResult = cashDao.updateCash(categoryNo, cashPrice, cashMemo, cashNo, memberId);
	if(updateCashResult != 0){
		System.out.println("수정 성공");
		msg = URLEncoder.encode("수정 성공!", "utf-8");
	} else {
		System.out.println("수정 실패");
		msg = URLEncoder.encode("수정 실패!", "utf-8");
	}
	response.sendRedirect(request.getContextPath()+"/cash/cashDateList.jsp?cashNo="+cashNo+"&year="+year+"&month="+month+"&date="+date+"&msg="+msg);
	// V
%>