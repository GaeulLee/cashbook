<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="java.net.*" %>
<%
	// C
	/*
		1. 인코딩
		2. 로그인 유효성 검사
		3. 파라메터 값 유효성 검사
		4. 모델 출력
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
	if(request.getParameter("memberPw") == null || request.getParameter("memberId") == null ||
	request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("비밀번호를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	String memberPw = request.getParameter("memberPw");
	String memberId = request.getParameter("memberId");
	
	// M
	MemberDao memberDao = new MemberDao();
	boolean checkPw = memberDao.checkPw(memberPw, memberId); // 비밃번호 확인
	if(!checkPw){
		msg = URLEncoder.encode("비밀번호가 일치하지 않습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
		return;
	}
	
	int resultDelete = memberDao.deleteMember(memberId); // 회원 삭제
	if(resultDelete == 0){
		System.out.println("삭제 실패");
		msg = URLEncoder.encode("회원 탈퇴에 실패하였습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/deleteMemberForm.jsp?msg="+msg);
	} else {
		System.out.println("삭제 성공");
		msg = URLEncoder.encode("회원 탈퇴에 성공하였습니다.", "utf-8");
		session.invalidate();// 탈퇴 후 세션 종료
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp?msg="+msg);
	}
%>