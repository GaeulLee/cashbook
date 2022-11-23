<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="vo.Member"%>
<%@ page import="dao.MemberDao"%>
<%
	// C
	/*
		1. 인코딩
		2. 로그인 유효성 검사
		3. 파라메터 값 유효성 검사
		4. 데이터 묶기
		5. 모델 출력
	*/
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	//로그인 유효성 검사(로그인이 되어있으면 회원가입을 할 수 없게)
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	
	// 파라메터 값 유효성 검사
	String msg = null;
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
		System.out.println("memberId-> "+memberId+", memberPw-> "+memberPw+", memberName-> "+memberName);
	if(request.getParameter("memberId") == null || memberId.equals("") ||
	request.getParameter("memberPw") == null || memberPw.equals("") ||
	request.getParameter("memberName") == null || memberName.equals("")){
		msg = URLEncoder.encode("모든 정보를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/signInForm.jsp?msg="+msg);
		return;
	}
	// 데이터 묶기
	Member member = new Member();
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	
	// M
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.insertMember(member);
	if(resultRow == 0){
		System.out.println("가입 실패");
		msg = URLEncoder.encode("가입에 실패했습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/signInForm.jsp?msg="+msg);
		return;
	} else {
		System.out.println("가입 성공");
		msg = URLEncoder.encode("가입에 성공했습니다. 로그인을 해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
	}
	
	
%>