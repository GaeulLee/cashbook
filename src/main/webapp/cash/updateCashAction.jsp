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
		3. 파라메터 묶기
		4. 모델 출력
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
	String cashDate = request.getParameter("cashDate");
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	long cashPrice = Integer.parseInt(request.getParameter("cashPrice"));
	String cashMemo = request.getParameter("cashMemo");
	
	if(request.getParameter("cashNo") == null || cashNo == 0 ||
	request.getParameter("cashDate") == null || cashDate.equals("") ||
	request.getParameter("categoryKind") == null || categoryKind.equals("") ||
	request.getParameter("categoryName") == null || categoryName.equals("") ||
	request.getParameter("cashPrice") == null || cashPrice == 0 ||
	request.getParameter("cashMemo") == null || cashMemo.equals("")){
		msg = URLEncoder.encode("모든 정보를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	// 데이터 묶기
	HashMap<String, Object> paramUpdateCash = new HashMap<String, Object>();
	paramUpdateCash.put("cashNo", cashNo);
	paramUpdateCash.put("cashDate", cashDate);
	paramUpdateCash.put("categoryKind", categoryKind);
	paramUpdateCash.put("categoryName", categoryName);
	paramUpdateCash.put("cashPrice", cashPrice);
	paramUpdateCash.put("cashMemo", cashMemo);
	
	// M
	CashDao cashDao = new CashDao();
	int updateCashResult = cashDao.updateCash(paramUpdateCash);
	if(updateCashResult != 0){
		System.out.println("수정 성공");
		//response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
	} else {
		System.out.println("수정 실패");
		response.sendRedirect(request.getContextPath()+"/cash/updateCashForm.jsp?cashNo="+cashNo);
		return;
	}
	
	// V
%>