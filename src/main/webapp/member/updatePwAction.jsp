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
		4. 모델 출력
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
	String oldPw = request.getParameter("oldPw");
	String newPw = request.getParameter("newPw");
		System.out.println("oldPw-> "+oldPw+", newPw-> "+newPw);
	if(request.getParameter("oldPw") == null || oldPw.equals("") ||
	request.getParameter("newPw") == null || newPw.equals("")){
		msg = URLEncoder.encode("비밀번호를 모두 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updatePwForm.jsp?msg="+msg);
		return;
	}
	
	// M
	MemberDao memberDao = new MemberDao();
	boolean resultCheck = memberDao.checkPw(oldPw, loginMemberId); // 비밀번호 일치 확인
	if(!resultCheck){
		System.out.println("비밀번호 불일치");
		msg = URLEncoder.encode("비밀번호가 일치하지 않습니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/updatePwForm.jsp?msg="+msg);
		return;
	}

	int resultRow = memberDao.updatePw(newPw, loginMemberId); // 비밀번호 일치하면 변경
	if(resultRow == 0){
		System.out.println("수정 실패");
		msg = URLEncoder.encode("비밀번호 수정에 실패했습니다.", "utf-8");
	} else {
		System.out.println("수정 성공");
		msg = URLEncoder.encode("비밀번호 수정에 성공했습니다.", "utf-8");
	}
	response.sendRedirect(request.getContextPath()+"/member/updatePwForm.jsp?msg="+msg);
	
	
%>