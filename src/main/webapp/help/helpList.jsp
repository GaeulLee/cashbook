<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 세션에서 회원 아이디 받기
		3. 데이터 묶기
		4. 모델 출력(회원이 작성한 모든 글)
	*/
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// 데이터 묶기
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);

	// M
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(paramMember);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>helpList</title>
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
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<div class="container-fluid">
				<div class="collapse navbar-collapse" id="navbarColor01">
					<ul class="navbar-nav me-auto">
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">Home</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#">Help</a>
						</li>
						<%
							if(loginMember.getMemberLevel() > 0){
						%>
								<li class="nav-item">
									<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">Admin</a>
								</li>
						<%
							}
						%>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle active" data-toggle="dropdown" href="#">My page</a>
							<span class="visually-hidden">(current)</span>
							<ul class="dropdown-menu">
								<li>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/member/memberOne.jsp">내 정보</a>
								</li>
								<li>
									<div class="dropdown-divider"></div>
								</li>
								<li>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<!-- 본문 시작 -->
	<div class="container">
		<table>
			<tr>
				<th colspan="2" class="h4"><strong>문의사항</strong></th>
			</tr>
			<!-- 답변 달린 글, 달리지 않은 글 모두 보이게 -->
			<tr>
				<th>문의번호</th>
				<th>문의내용</th>
				<th>작성일</th>
				<th>편집</th>
			</tr>
			<%
				for(HashMap<String, Object> m : helpList){
			%>
					<tr>
						<td><%=m.get("helpNo")%></td>
						<td><%=m.get("helpMemo")%></td>
						<td><%=m.get("helpCreatedate")%></td>
						<td>
							<!-- 수정 삭제 링크 -->
							<!-- 답변 있으면 if문 사용 disabled로 -->
						</td>
					</tr>
			<%
				}
			%>
			
		</table>	
	</div>
	</body>
</html>