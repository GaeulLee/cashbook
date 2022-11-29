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
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId = loginMember.getMemberId();
	
	// 파라메터 유효성 검사
	String msg = null;
	if(request.getParameter("helpNo") == null || request.getParameter("helpMemo") == null){
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		return;
	}
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	if(request.getParameter("helpMemo").equals("")){
		msg = URLEncoder.encode("문의 내용을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/help/updateHelpForm.jsp?helpNo="+helpNo+"&msg="+msg);
		return;
	}	
	String helpMemo = request.getParameter("helpMemo");
	
	// 데이터 묶기
	Help paramHelp = new Help();
	paramHelp.setMemberId(memberId);
	paramHelp.setHelpNo(helpNo);
	paramHelp.setHelpMemo(helpMemo);
	
	// M
	HelpDao helpDao = new HelpDao();
	int resultUpdate = helpDao.updateHelp(paramHelp);
	if(resultUpdate == 0){
		System.out.println("문의 수정 실패");
	} else {
		System.out.println("문의 수정 성공");
	}
	response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");

%>