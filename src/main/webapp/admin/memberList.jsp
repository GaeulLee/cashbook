<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사(회원 레벨 확인)
		2. 페이징(페이지 값 있다면 바꿔주기)
		3. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	MemberDao memberDao = new MemberDao();
	int cnt = memberDao.selectMemberCount();
	final int ROW_PER_PAGE = 15;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage*PAGE_COUNT;
	int lastPage = cnt/ROW_PER_PAGE;
	
	if(cnt%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){
		endPage = lastPage;
	}
	
	// M
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, ROW_PER_PAGE);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>memberList</title>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="../inc/adminMainHeader.jsp"></jsp:include>
		<!-- 멤버목록 페이징 -->
		<div>
			<h3><strong>멤버목록</strong></h3>
			<table border="1">
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>회원레벨</th>
					<th>이름</th>
					<th>수정일</th>
					<th>회원 생성일</th>
					<th>편집</th>
				</tr>
				<%
					for(Member m : memberList){
				%>
						<tr>
							<td><%=m.getMemberNo()%></td>
							<td><%=m.getMemberId()%></td>
							<td><%=m.getMemberLevel()%></td>
							<td><%=m.getMemberName()%></td>
							<td><%=m.getUpdatedate()%></td>
							<td><%=m.getCreatedate()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/admin/member/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>">레벨수정</a>
								<a href="<%=request.getContextPath()%>/admin/member/deleteMemberAction.jsp?memberNo=<%=m.getMemberNo()%>">삭제</a>
							</td>
						</tr>
				<%
					}
				%>
			</table>
		</div>
	</body>
</html>