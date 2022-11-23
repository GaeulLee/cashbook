<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="vo.Member"%>
<%@ page import="dao.MemberDao"%>
<%
	// C
	/*
		1. 인코딩
		2. 로그인 유효성 검사 -> session 정보가 있다면 가져오기
		3. 파라메터 값 유효성 검사
		4. 데이터 묶기
		5. 모델 출력
	*/
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	//로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String loginMemberId = loginMember.getMemberId();
	
	// 파라메터 값 유효성 검사
	String msg = null;
	String memberName = request.getParameter("memberName");
		System.out.println("memberName-> "+memberName);
	if(request.getParameter("memberId") == null || request.getParameter("memberName") == null || memberName.equals("")){
		msg = URLEncoder.encode("모든 정보를 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
		return;
	}
	// 데이터 묶기
	Member member = new Member();
	member.setMemberId(loginMemberId); // 기존 세션에 있는 아이디 값
	member.setMemberName(memberName); // 새로 받은 회원정보(이름) 값
	
	// M
	MemberDao memberDao = new MemberDao();
	int resultRow = memberDao.updateMember(member, loginMemberId);
	if(resultRow == 0){
		System.out.println("수정 실패");
		msg = URLEncoder.encode("정보수정에 실패했습니다.", "utf-8");
	} else {
		System.out.println("수정 성공");
		msg = URLEncoder.encode("정보수정에 성공했습니다.", "utf-8");
		session.setAttribute("loginMember", member); // 수정에 성공했다면 기존 세션에 있는 값을 입력받은 값으로 바꾸기
	}
	response.sendRedirect(request.getContextPath()+"/member/updateMemberForm.jsp?msg="+msg);
	
%>