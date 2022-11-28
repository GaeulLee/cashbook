<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	// C
	/*
		1. 인코딩
		2. 로그인 유효성 검사 + 레벨 확인
		3. 파라메터값 유효성 확인
		4. 데이터 묶기
		5. 모델 출력
	*/
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 로그인 유효성 검사 + 레벨 확인
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member member = (Member)session.getAttribute("loginMember");
	int memberLevel = member.getMemberLevel();
	if(memberLevel < 1){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터값 유효성 확인
	String msg = null;
	if(request.getParameter("categoryKind") == null || request.getParameter("categoryName") == null ||
	request.getParameter("categoryKind").equals("") || request.getParameter("categoryName").equals("")){
		msg = URLEncoder.encode("모든 항목을 입력해주세요.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/admin/category/insertCategoryForm.jsp?msg="+msg);
		return;
	}
	String categoryKind = request.getParameter("categoryKind");
	String categoryName = request.getParameter("categoryName");
	
	// 데이터 묶기
	Category paramCategory = new Category();
	paramCategory.setCategoryKind(categoryKind);
	paramCategory.setCategoryName(categoryName);
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	int resultInsert = categoryDao.insertCategory(paramCategory);
	if(resultInsert == 0){
		System.out.println("카테고리 추가 실패");	
		msg = URLEncoder.encode("카테고리 추가에 실패하였습니다.", "utf-8");
	} else {
		System.out.println("카테고리 추가 성공");
		msg = URLEncoder.encode("카테고리를 성공적으로 추가하였습니다.", "utf-8");
	}
	response.sendRedirect(request.getContextPath()+"/admin/category/insertCategoryForm.jsp?msg="+msg);
%>