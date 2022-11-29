<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%

	// C
	/*
	1. 인코딩
	2. 로그인 유효성 검사
	3. 파라메터 유효성 검사
	4. 데이터 묶기
	5. 모델 출력
	*/
	
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 로그인 유효성 검사
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터 유효성 검사
	String msg = null;
	if(request.getParameter("memberId") == null || request.getParameter("helpMemo") == null || request.getParameter("helpMemo").equals("")){
		msg = URLEncoder.encode("문의 내용을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/insertHelpForm.jsp?msg="+msg);
		return;
	}
	String memberId = request.getParameter("memberId");
	String helpMemo = request.getParameter("helpMemo");
	
	// 데이터 묶기
	Help paramHelp = new Help();
	paramHelp.setMemberId(memberId);
	paramHelp.setHelpMemo(helpMemo);
	
	// M
	HelpDao helpDao = new HelpDao();
	int insertResult = helpDao.insertHelp(paramHelp);
	if(insertResult == 0){
		System.out.println("문의 추가 실패");
	} else {
		System.out.println("문의 추가 성공");
	}
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");

%>