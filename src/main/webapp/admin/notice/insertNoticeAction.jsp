<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*" %>
<%
	// C
	/*
		0. 인코딩
		1. 로그인 유효성 검사, 레벨 확인
		2. 파라메터 유효성 검사
		3. 데이터 묶기 - noticeMemo
		4. 모델 출력
	*/
	
	// 인코딩
	request.setCharacterEncoding("utf-8");

	//세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터 유효성 검사
	String msg = null;
	if( request.getParameter("noticeMemo") == null || request.getParameter("noticeMemo").equals("")){
		msg = URLEncoder.encode("공지 내용을 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/insertNoticeForm.jsp?msg="+msg);
		return;
	}
	String noticeMemo = request.getParameter("noticeMemo");
	
	// 데이터 묶기
	Notice notice = new Notice();
	notice.setNoticeMemo(noticeMemo);
	
	// M
	NoticeDao noticeDao = new NoticeDao();
	int resultInsert = noticeDao.insertNotice(notice);
	if(resultInsert == 0){
		System.out.println("공지 추가 실패");
	} else {
		System.out.println("공지 추가 성공");
	}
	response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp?msg="+msg);
%>