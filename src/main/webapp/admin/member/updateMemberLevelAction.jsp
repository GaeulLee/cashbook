<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*" %>
<%
	// C
	/*
		1. 로그인 유효성 검사 + 멤버 레벨 확인
		2. 파라메터 유효성 검사
		3. 데이터 묶기
		3. 모델 출력
	*/
	// 로그인 유효성 검사
	Member member = (Member)session.getAttribute("loginMember");
	if(session.getAttribute("loginMember") == null || member.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터 유효성 검사
	if(request.getParameter("memberNo") == null || request.getParameter("memberLevel") == null){
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
		return;
	}
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));

	String msg = null;
	if(request.getParameter("memberLevel").equals("")){
		msg = URLEncoder.encode("회원 레벨을 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/member/updateMemberLevelForm.jsp?memberNo="+memberNo+"&msg="+msg);
		return;
	}
	int memberLevel = Integer.parseInt(request.getParameter("memberLevel"));
	
	// 데이터 묶기
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);
	paramMember.setMemberLevel(memberLevel);
	
	// M
	MemberDao memberDao = new MemberDao();
	int resultUpdate = memberDao.updateMemberLevel(paramMember);
	if(resultUpdate == 0){
		System.out.println("회원 레벨 수정 실패");
	} else {
		System.out.println("회원 레벨 수정 성공");
	}
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>