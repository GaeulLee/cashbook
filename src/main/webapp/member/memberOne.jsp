<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>MemberOne</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/combine/npm/bootswatch@5.2.2/dist/sandstone/bootstrap.min.css,npm/bootswatch@5.2.2/dist/sandstone/bootstrap.min.css">
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <style>
			th{
				text-align: center;
			}
			
			#align_center{
				text-align: center;
			}
			table{
				border-radius: 8px;
				height: 300px;
			}
		</style>
	</head>
	<body>
	<!-- header -->
	<jsp:include page="../inc/header.jsp"></jsp:include>
	<!-- 본문 시작 -->
	<div class="container">
		<table class="table table-borderless w-75 mx-auto align-middle shadow-sm mt-3">
			<tr>
				<th colspan="2" class="h4"><strong>내 정보</strong></th>
			</tr>
			<tr>
				<th>회원 ID</th>
				<td><%=memberId%></td>
			</tr>
			<tr>
				<th>회원 PW</th>
				<td>
					<a href="<%=request.getContextPath()%>/member/updatePwForm.jsp" class="btn btn-outline-primary btn-sm">비밀번호 변경</a>
				</td>
			</tr>
			<tr>
				<th>회원 이름</th>
				<td><%=memberName%></td>
			</tr>
		</table>
		<div id="align_center">
			<span>
				<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp" class="btn btn-outline-primary">회원정보 수정</a>
			</span>
			<span>
				<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp" class="btn btn-outline-primary">회원 탈퇴</a>
			</span>
		</div>
	</div>
	</body>
</html>