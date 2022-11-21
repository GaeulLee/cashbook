<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.Member"%>

<%
	// Controller
	/*
		0. 인코딩
		1. member 값 유효성 검사
		2. 로그인 유효성 검사
		3. 받아온 값 묶기
		4. model
		5. session에 정보 저장
		6. 페이지 이동
	*/
	request.setCharacterEncoding("utf-8");
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
		System.out.println("memberId-> "+memberId+", memberPw-> "+memberPw+", memberName-> "+memberName);	
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null || request.getParameter("memberName") == null ||
	request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("") || request.getParameter("memberName").equals("")){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 로그인 유효성 검사
	
	MemberDao memberDao = new MemberDao();
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	paramMember.setMemberName(memberName);
	
	Member resultMember = memberDao.login(paramMember);
	if(resultMember == null){
		System.out.println("로그인 실패");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	} else {
		System.out.println("로그인 성공");
		session.setAttribute("loginMember", resultMember);
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
	}
%>