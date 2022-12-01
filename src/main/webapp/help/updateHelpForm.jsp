<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 세션 정보 저장
		3. 파라메터 유효성 검사
		4. 데이터 묶기
		5. 모델 출력
	*/
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null){
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	String memberId = loginMember.getMemberId();
	
	// 파라메터 유효성 검사
	if(request.getParameter("helpNo") == null){
		response.sendRedirect(request.getContextPath()+"/help/helpList.jsp");
		return;
	}	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// 데이터 묶기
	Help paramHelp = new Help();
	paramHelp.setHelpNo(helpNo);
	paramHelp.setMemberId(memberId);
	
	// M
	HelpDao helpDao = new HelpDao();
	Help oldHelp = helpDao.selectHelpOne(paramHelp);
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>updateHelpForm</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
			th{
				text-align: center;
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
		<jsp:include page="<%=targetPage%>"></jsp:include>
	
		<!--Content body start-->
		<div class="content-body">
			<div class="container-fluid">
			
				<div class="row">
				
					<div class="col">
						<div class="card">
							<!-- 본문시작 -->
							<div class="card-body">
								<form action="<%=request.getContextPath()%>/help/updateHelpAction.jsp" method="post">
									<input type="hidden" name="helpNo" value="<%=oldHelp.getHelpNo()%>">
									<table class="table table-borderless w-75 mx-auto align-middle">
										<tr>
											<th colspan="2">
												<h4><strong>문의 수정</strong></h4>
											</th>
										</tr>
										<%
											String msg = request.getParameter("msg");
											if(msg != null){
										%>
												<tr>
													<th class="text-info" colspan="2">&#10069;<%=msg%></th>
												</tr>	
										<%
											}
										%>
										<tr>
											<th class="align-middle">문의 내용</th>
											<td>
												<textarea name="helpMemo" rows="20" cols="50" placeholder="수정할 문의 내용을 입력해주세요." class="form-control input-default"><%=oldHelp.getHelpMemo()%></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="2" class="text-right">
												<button type="submit" class="btn btn-outline-secondary">수정</button>
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