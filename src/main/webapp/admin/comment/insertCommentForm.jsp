<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 파라메터 유효성 검사
		3. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터 유효성 검사
	if(request.getParameter("helpNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
		return;
	}	
	int helpNo = Integer.parseInt(request.getParameter("helpNo"));
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>insertNoticeForm</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		table{
			text-align: center;
			border-radius: 8px;
		}
		
		#font_color{
			color: #76838f;
		}
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
								<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">back</a>
								<div class="mb-4 h3 text-center" id="font_color">
									<strong>답변 등록</strong>
								</div>
								<form action="<%=request.getContextPath()%>/admin/comment/insertCommentAction.jsp" method="post">
									<input type="hidden" name="helpNo" value="<%=helpNo%>">
									<table class="table table-borderless w-75 mx-auto">										
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
											<th class="align-middle">답변 내용</th>
											<td>
												<textarea name="commentMemo" rows="10" cols="50" placeholder="입력할 답변을 입력해주세요." class="form-control input-default"></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="2" class="text-right">
												<button type="submit" class="btn btn-outline-secondary">등록</button>
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