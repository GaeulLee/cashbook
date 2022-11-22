<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDao"%>
<%@ page import="vo.Member"%>
<%@ page import="java.net.URLEncoder" %>
<%
	/*
		1. 인코딩
		2. member 값 유효성 검사
		3. 받아온 값 묶기
		4. model
		5. session에 정보 저장
		6. 페이지 이동
	*/
	
	// C
	// 인코딩
	request.setCharacterEncoding("utf-8");

	String msg = null;
	String targetPage = "/loginForm.jsp";
	
	// member 값 유효성 검사
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
		System.out.println("memberId-> "+memberId+", memberPw-> "+memberPw);		
	if(request.getParameter("memberId") == null || request.getParameter("memberPw") == null ||
	request.getParameter("memberId").equals("") || request.getParameter("memberPw").equals("")){
		msg = URLEncoder.encode("로그인 정보를 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+targetPage+"?msg="+msg);
		return;
	}
	// 받아온 값 묶기
	Member paramMember = new Member(); // 모델 호출 시 매개 값
	paramMember.setMemberId(memberId);
	paramMember.setMemberPw(memberPw);
	
	// 분리된 M(model) 호출
	MemberDao memberDao = new MemberDao();
	Member resultMember = memberDao.login(paramMember);
	
	if(resultMember != null){
		System.out.println("로그인 성공");
		session.setAttribute("loginMember", resultMember);
		targetPage = "/cash/cashList.jsp";
	} else {
		msg = URLEncoder.encode("로그인에 실패하였습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+targetPage+"?msg="+msg);
		return;
	}
	response.sendRedirect(request.getContextPath()+targetPage);
%>