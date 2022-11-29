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
		<title>updatePwForm</title>
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
	<%	
		String targetPage = "../inc/header.jsp";
		if(loginMember.getMemberLevel() > 0){
			targetPage = "../inc/adminHeader.jsp";
		}
	%>
		<jsp:include page="<%=targetPage%>"></jsp:include>
	<!-- 본문 시작 -->
	<div class="container">
		<form action="<%=request.getContextPath()%>/member/updatePwAction.jsp" method="post">
			<table class="table table-borderless w-75 mx-auto align-middle shadow-sm mt-3">
				<tr>
					<th colspan="2">
						<h4 class="mt-3"><strong>비밀번호 변경</strong></h4>
					</th>
				</tr>
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
				%>
						<tr>
							<th colspan="2" class="text-info">&#10069;<%=msg%></th>
						</tr>	
				<%
					}
				%>
				<tr>
					<th class="w-50">회원 ID</th>
					<td>
						<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly" class="form-control w-75">
					</td>
				</tr>
				<tr>
					<th class="w-50">현재 PW</th>
					<td>
						<input type="password" name="oldPw" class="form-control w-75">
					</td>
				</tr>
				<tr>
					<th class="w-50">바꿀 PW</th>
					<td>
						<input type="password" name="newPw" class="form-control w-75">
					</td>
				</tr>
				<tr>
					<th class="w-50">회원 이름</th>
					<td>
						<input type="text" name="memberId" value="<%=memberName%>" readonly="readonly" class="form-control w-75">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<a href="<%=request.getContextPath()%>/member/memberOne.jsp"  class="btn btn-outline-primary float-start">back</a>
						<button type="submit" class="btn btn-outline-primary float-end">수정</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>