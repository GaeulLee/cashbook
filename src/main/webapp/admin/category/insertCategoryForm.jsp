<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// C
	/*
	1. 로그인 유효성 검사 + 레벨 확인
	2. 모델 출력
	*/
	// 로그인 유효성 검사 + 레벨 확인
		if(session.getAttribute("loginMember") == null){
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		}
		Member member = (Member)session.getAttribute("loginMember");
		int memberLevel = member.getMemberLevel();
		if(memberLevel < 1){
			response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
			return;
		}
	// M
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>insertCategoryeForm</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		table{
			text-align: center;
			height: 250px;
		}
		
		#font_color{
			color: #76838f;
		}
		label{
			margin: 0px;
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
			<jsp:param value="<%=member.getMemberId()%>" name="memberId"/>
		</jsp:include>
		
		<!--Content body start-->
		<div class="content-body">
			<div class="container-fluid">			
				<div class="row">				
					<div class="col">
						<div class="card">
							<!-- 본문시작 -->
							<div class="card-body">
								<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">back</a>
								<div class="mb-4 h3 text-center" id="font_color">
									<strong>카테고리 추가</strong>
								</div>
								<form action="<%=request.getContextPath()%>/admin/category/insertCategoryAction.jsp" method="post">
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
											<th class="align-middle">구분</th>
											<td class="align-middle text-left">
												<label>
													<input type="radio" id="categoryKind" name="categoryKind" value="수입"> 수입
												</label>
												&nbsp;
												<label>
													<input type="radio" id="categoryKind" name="categoryKind" value="지출"> 지출
												</label>
											</td>
										</tr>
										<tr>
											<th class="align-middle">항목</th>
											<td>
												<input type="text" name="categoryName" placeholder="카테고리 이름을 적어주세요. ex) 외식, 미용, 가전" class="form-control input-default">
											</td>
										</tr>
										<tr>
											<td colspan="2" class="text-right">
												<button type="submit" class="btn btn-outline-secondary">추가</button>
											</td>
										</tr>
									</table>
								</form>
								<div>
									
								</div>
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