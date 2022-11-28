<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사 + 레벨 확인
		2. 파라메터 유효성 검사
		3. 데이터 묶기
		4. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		}
	
	// 파라메터 유효성 검사
	if(request.getParameter("categoryNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	}
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	// 데이터 묶기
	Category paramCategory = new Category();
	paramCategory.setCategoryNo(categoryNo);
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	int resultDelete = categoryDao.deleteCategory(paramCategory);
	if(resultDelete == 0){
		System.out.println("삭제 실패");
	} else {
		System.out.println("삭제 성공");
	}
	response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
%>