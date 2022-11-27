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
	if(request.getParameter("noticeNo") == null || request.getParameter("noticeMemo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/noticeList.jsp");
		return;
	}
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	if(request.getParameter("noticeMemo").equals("")){
		msg = URLEncoder.encode("공지 내용을 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/notice/updateNoticeForm.jsp?msg="+msg+"&noticeNo="+noticeNo);
		return;
	}
	String noticeMemo = request.getParameter("noticeMemo");
	
	// 데이터 묶기
	Notice paramNotice = new Notice();
	paramNotice.setNoticeNo(noticeNo);
	paramNotice.setNoticeMemo(noticeMemo);
	
	// M
	NoticeDao noticeDao = new NoticeDao();
	int resultUpdate = noticeDao.updateNotice(paramNotice);
	if(resultUpdate == 0){
		System.out.println("공지 수정 실패");
		msg = URLEncoder.encode("공지 수정에 실패하였습니다.", "utf-8");
	} else {
		System.out.println("공지 수정 성공");
		msg = URLEncoder.encode("공지를 성공적으로 수정하였습니다.", "utf-8");
	}
	response.sendRedirect(request.getContextPath()+"/admin/notice/updateNoticeForm.jsp?msg="+msg+"&noticeNo="+noticeNo);
%>