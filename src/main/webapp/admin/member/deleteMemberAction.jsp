<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// C
	/*
	1. 로그인 유효성 검사 + 회원 레벨 확인
	2. 파라메터 값 유효성 확인
	3. 
	4. 모델 출력
	*/
	// 로그인 유효성 검사
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터 값 유효성 확인
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath()+"/memberList.jsp");
		return;
	}
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	// 데이터 묶기
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);

	// M
	MemberDao memberDao = new MemberDao();
	int resultDelete = memberDao.deleteMemberByAdmin(paramMember);
	if(resultDelete == 0){
		System.out.println("회원 삭제 실패");
	} else {
		System.out.println("회원 삭제 성공");
	}
	response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
%>