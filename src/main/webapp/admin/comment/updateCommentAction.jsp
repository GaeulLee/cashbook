<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%

	// C
	/*
	1. 인코딩
	2. 로그인 유효성 검사
	3. 파라메터 유효성 검사
	4. 데이터 묶기
	5. 모델 출력
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
	if(request.getParameter("commentNo") == null || request.getParameter("commentMemo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
		return;
	}	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	if(request.getParameter("commentMemo").equals("")){
		msg = URLEncoder.encode("답변 내용을 입력하세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/comment/updateCommentForm.jsp?msg="+msg+"&commentNo="+commentNo);
		return;
	}
	String commentMemo = request.getParameter("commentMemo");
	
	// 데이터 묶기
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	comment.setCommentMemo(commentMemo);

	
	// M
	CommentDao commentDao = new CommentDao(); 
	int resultUpdate = commentDao.updateComment(comment);
	if(resultUpdate == 0){
		System.out.println("답변 수정 실패");
	} else {
		System.out.println("답변 수정 성공");
	}
	response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");

%>