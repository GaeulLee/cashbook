<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.net.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
		2. 파라메터 유효성 검사
		3. 데이터 묶기
		4. 모델 출력
	*/

	// 로그인 유효성 검사
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId = loginMember.getMemberId();
	
	// 파라메터 유효성 검사
	if(request.getParameter("helpNo") == null){
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		return;
	}	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// 데이터 묶기
	Help paramHelp = new Help();
	paramHelp.setHelpNo(helpNo);
	paramHelp.setMemberId(memberId);
		
	// M
	HelpDao helpDao = new HelpDao();
	int resultDelete = helpDao.deleteHelp(paramHelp);
	if(resultDelete != 0){
		System.out.println("삭제 성공");
	} else {
		System.out.println("삭제 실패");
	}
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
%>