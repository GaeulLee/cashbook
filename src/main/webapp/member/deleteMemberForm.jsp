<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기 -> deleteAction으로 세션에 저장된 아이디 값을 넘겨주기 위함
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>deleteMemberForm</title>
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
		<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
			<table class="table table-borderless w-50 mx-auto align-middle shadow-sm mt-3">
				<input type="hidden" name="memberId" value="<%=memberId%>">
				<tr>
					<th colspan="2">
						<h4 class="mt-3"><strong>회원탈퇴</strong></h4>
					</th>
				</tr>
				<tr>
					<th colspan="2">
					<%
					String msg = request.getParameter("msg");
						if(msg != null){
					%>
							<span class="text-info">&#10069;<%=msg%></span>						
					<%
						}else{
					%>
							<span>회원 탈퇴를 위한 비밀번호를 입력해주세요.</span>
					<%
						}
					%>
					</th>
				</tr>
				<tr>
					<th class="w-50">비밀번호 입력</th>
					<td>
						<input type="password" name="memberPw" class="form-control w-75">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<a href="<%=request.getContextPath()%>/member/memberOne.jsp" class="btn btn-outline-primary float-start">back</a>
						<button type="submit" class="btn btn-outline-primary float-end">탈퇴</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>