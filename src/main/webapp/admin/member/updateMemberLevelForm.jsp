<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	// C
	/*
		1. 로그인 유효성 검사, 레벨 확인
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
	if(request.getParameter("memberNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/memberList.jsp");
		return;
	}
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// 받아온 memberNo값 Member에 넣기
	Member paramMember = new Member();
	paramMember.setMemberNo(memberNo);
	
	// M -> 수정할 정보 가져오기
	MemberDao memberDao = new MemberDao();
	Member oldMember = memberDao.selectMemberOne(paramMember);

	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>updateMemberForm</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		table{
			text-align: center;
			height: 300px;
		}
		
		#font_color{
			color: #76838f;
		}
		@font-face {
		    font-family: 'Pretendard-Regular';
		    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
		    font-weight: 400;
		    font-style: normal;
		}
		
		* {
			font-family: 'Pretendard-Regular';
		}
	</style>	
</head>
<body>
<!--Preloader start-->
	<div id="preloader">
		<div class="loader">
			<svg class="circular" viewBox="25 25 50 50">
				<circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10">
			</svg>
		</div>
	</div>
	<!--Preloader end-->

	<!--Main wrapper start-->
	<div id="main-wrapper">
		<!-- header -->
		<jsp:include page="../../inc/adminMainHeader.jsp">
			<jsp:param value="<%=loginMember.getMemberId()%>" name="memberId"/>
		</jsp:include>
		
		<!--Content body start-->
		<div class="content-body">
			<div class="container-fluid">			
				<div class="row">				
					<div class="col">
						<div class="card">
							<!-- 본문시작 -->
							<div class="card-body">
								<a href="<%=request.getContextPath()%>/admin/memberList.jsp">back</a>
								<div class="mb-4 h3 text-center" id="font_color">
									<strong>멤버 수정</strong>
								</div>
								<form action="<%=request.getContextPath()%>/admin/member/updateMemberLevelAction.jsp" id="updateForm" method="post">
									<table class="table table-borderless w-50 mx-auto">
										<%
											String msg = request.getParameter("msg");
											if(msg != null){
										%>
												<tr>
													<th colspan="2" class="text-info"><strong>&#10069;<%=msg%></strong></th>
												</tr>
										<%
											}
										%>
										<tr>	
											<th class="align-middle">회원번호</th>
											<td>
												<input type="number" name="memberNo" value="<%=oldMember.getMemberNo()%>" readonly="readonly" class="form-control input-default ">
											</td>
										</tr>
										<tr>
											<th class="align-middle">아이디</th>
											<td>
												<input type="text" name="memberId" value="<%=oldMember.getMemberId()%>" readonly="readonly" class="form-control input-default">
											</td>
										</tr>
										<tr>
											<th class="align-middle">회원레벨</th>
											<td class="text-left">
											<%
												if(oldMember.getMemberLevel() == 0){
											%>
													<label>
														<input type="radio" class="memberLevel" name="memberLevel" value="1">관리자
													</label>
													&nbsp;
													<label>
														<input type="radio" class="memberLevel" name="memberLevel" value="0" checked>회원
													</label>
											<%	
												} else {
											%>
													<label>
														<input type="radio" class="memberLevel" name="memberLevel" value="1" checked>관리자
													</label>
													&nbsp;
													<label>
														<input type="radio" class="memberLevel" name="memberLevel" value="0" >회원
													</label>
											<%
												}
											%>
											</td>
										</tr>
										<tr>
											<th class="align-middle">이름</th>
											<td>
												<input type="text" name="memberName" value="<%=oldMember.getMemberName()%>" readonly="readonly" class="form-control input-default">
											</td>
										</tr>
										<tr>
											<th class="align-middle">회원 생성일</th>
											<td class="text-left"><%=oldMember.getCreatedate()%></td>
										</tr>
										<tr>
											<td colspan="2" class="text-right">
												<button type="button" id="updateBtn" class="btn btn-outline-secondary">수정</button>
											</td>
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>				   
				</div>			
			</div>
		<!-- #/ container -->
		</div>
		<!--Content body end--> 
		
		<!--Footer start-->
		<div class="footer">
			<div class="copyright">
				<p>Copyright &copy; Designed & Developed by <a href="https://themeforest.net/user/quixlab">Quixlab</a> 2018</p>
			</div>
		</div>
		<!--Footer end-->
	    
	</div>
	<!--Main wrapper end-->
	
	<!--Scripts-->
	<script>
	let updateBtn = document.querySelector('#updateBtn');
	updateBtn.addEventListener('click', function(){
		// debug
		console.log('updateBtn clicked');
		
		// form check
		let memberLevel = document.querySelectorAll('.memberLevel:checked');
		if(memberLevel.length != 1){
			alert('회원 등급을 선택하세요.');
			memberLevel.focus();
			return;
		}
		
		let updateForm = document.querySelector('#updateForm');
		updateForm.submit();
	});
	</script>
	
	<script src="<%=request.getContextPath()%>/Resources/plugins/common/common.min.js"></script>
	<script src="<%=request.getContextPath()%>/Resources/js/custom.min.js"></script>
	<script src="<%=request.getContextPath()%>/Resources/js/settings.js"></script>
	<script src="<%=request.getContextPath()%>/Resources/js/gleek.js"></script>
	<script src="<%=request.getContextPath()%>/Resources/js/styleSwitcher.js"></script>
	
	<script src="<%=request.getContextPath()%>/Resources/plugins/jqueryui/js/jquery-ui.min.js"></script>
	<script src="<%=request.getContextPath()%>/Resources/plugins/moment/moment.min.js"></script>
	<script src="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/js/fullcalendar.min.js"></script>
	<script src="<%=request.getContextPath()%>/Resources/js/plugins-init/fullcalendar-init.js"></script>

	</body>
</html>