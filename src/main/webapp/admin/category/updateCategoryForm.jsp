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
	Category oldCategory = categoryDao.selectCategoryOne(paramCategory);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCategoryForm</title>
	</head>
	<body>
	<!-- header -->
	<jsp:include page="../../inc/adminMainHeader.jsp"></jsp:include>
	<!-- 본문 시작 -->
	<div>
		<h3><strong>카테고리 수정</strong></h3>
		<form action="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp" method="post">
			<table>
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
				%>
						<tr>
							<th colspan="2"><strong><%=msg%></strong></th>
						</tr>
				<%
					}
				%>
				<tr>
					<th>카테고리 번호</th>
					<td>
						<input type="number" name="categoryNo" value="<%=oldCategory.getCategoryNo()%>" readonly="readonly">
					</td>
				</tr>
				<tr>
					<th>구분</th>
					<td>
					<%
						String categoryKind = oldCategory.getCategoryKind();
						if(categoryKind.equals("수입")){
					%>
							<label>
								<input type="radio" id="categoryKind" name="categoryKind" value="수입" checked>수입
							</label>
							<label>
								<input type="radio" id="categoryKind" name="categoryKind" value="지출" disabled>지출
							</label>
					<%
						} else {
					%>
							<label>
								<input type="radio" id="categoryKind" name="categoryKind" value="수입" disabled>수입
							</label>
							<label>
								<input type="radio" id="categoryKind" name="categoryKind" value="지출" checked>지출
							</label>
					<%
						}
					%>
						
					</td>
				</tr>
				<tr>
					<th>항목</th>
					<td>
						<input type="text" name="categoryName" value="<%=oldCategory.getCategoryName()%>" placeholder="수정할 카테고리 이름을 적어주세요.">
					</td>
				</tr>
				<tr>
					<th>생성일</th>
					<td><%=oldCategory.getCreatedate()%></td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit">수정</button>
					</td>
				</tr>
			</table>
		</form>
		<div>
			<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">back</a>
		</div>
	</div>
	</body>
</html>