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
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>updatePwForm</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		th{
			text-align: center;
		}
		
		table{
			height:400px;
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
		<!-- header & sidebar -->
		<%	
			String targetPage = "../inc/header.jsp";
			if(loginMember.getMemberLevel() > 0){
				targetPage = "../inc/adminHeader.jsp";
			}
		%>
		<jsp:include page="<%=targetPage%>">
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
								<a href="<%=request.getContextPath()%>/member/memberOne.jsp">back</a>
								<form action="<%=request.getContextPath()%>/member/updatePwAction.jsp" id="updateForm" method="post">
									<table class="table table-borderless w-50 mx-auto align-middle">
										<tr>
											<th colspan="2">
												<h3 id="font_color"><strong>비밀번호 변경</strong></h3>
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
											<th class="w-50 align-middle">회원 ID</th>
											<td>
												<input type="text" name="memberId" value="<%=memberId%>" readonly="readonly" class="form-control w-75 input-default">
											</td>
										</tr>
										<tr>
											<th class="w-50 align-middle">현재 PW</th>
											<td>
												<input type="password" name="oldPw" id="oldPw" class="form-control w-75 input-default">
											</td>
										</tr>
										<tr>
											<th class="w-50 align-middle">바꿀 PW</th>
											<td>
												<input type="password" name="newPw" id="newPw" class="form-control w-75 input-default">
											</td>
										</tr>
										<tr>
											<th class="w-50 align-middle">PW 확인</th>
											<td>
												<input type="password" id="newPwCheck" class="form-control w-75 input-default">
											</td>
										</tr>
										<tr>
											<th class="w-50">회원 이름</th>
											<td>
												<input type="text" name="memberId" value="<%=memberName%>" readonly="readonly" class="form-control w-75 input-default">
											</td>
										</tr>
										<tr>
											<td colspan="2" class="text-right">
												<button type="button" id="updateBtn" class="btn mb-1 btn-outline-secondary">수정</button>
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
    		// oldPw
    		let oldPw = document.querySelector('#oldPw');
    		if(oldPw.value == ''){
    			alert('현재 비밀번호를 입력하세요.');
    			oldPw.focus();
				return;
    		}
    		// newPw
    		let newPw = document.querySelector('#newPw');
    		if(newPw.value == ''){
    			alert('바꿀 비밀번호를 입력하세요.');
    			newPw.focus();
				return;
    		}
    		
    		// newPwCheck
    		let newPwCheck = document.querySelector('#newPwCheck');
    		if(newPwCheck.value == ''){
    			alert('확인 비밀번호를 입력하세요.');
    			newPwCheck.focus();
				return;
    		}
    		
    		// newPw, newPwCheck 일치 확인
    		if(newPwCheck.value != newPw.value){
    			alert('바꿀 비밀번호와 확인 비밀번호가 일치하지 않습니다.');
    			newPwCheck.focus();
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