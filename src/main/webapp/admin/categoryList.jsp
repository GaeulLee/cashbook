<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사(회원 레벨 확인)
		2. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> list = categoryDao.selectCategoryListByAdmin();
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>categoryList</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		#font_color{
			color: #76838f;
		}
		
		th{
			background-color: #ededf8;
			text-align: center;
			height: 10px;
		}
		
		table{
			height: 400px;
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
		<jsp:include page="../inc/adminMainHeader.jsp"></jsp:include>
		
		<!--Content body start-->
		<div class="content-body">
			<div class="container-fluid">
			
				<div class="row">
				
					<div class="col">
						<div class="card">
							<!-- 본문시작 -->
							<div class="card-body w-75 mx-auto">								
								<!-- 카테고리 목록 -->
								<div>
									<div class="mb-2 h3 text-center" id="font_color">
										<strong>카테고리 목록</strong>
									</div>
									<div class="text-right">
										<a href="<%=request.getContextPath()%>/admin/category/insertCategoryForm.jsp" class="btn btn-outline-secondary mb-2">카테고리 추가</a>
									</div>
									<table class="table text-center">
										<tr>
											<th>카테고리 번호</th>
											<th>구분</th>
											<th>항목</th>
											<th>생성일</th>
											<th>수정일</th>
											<th>편집</th>
										</tr>
										<%
											for(Category c : list){
										%>
												<tr>
													<td><%=c.getCategoryNo()%></td>
													<td><%=c.getCategoryKind()%></td>
													<td><%=c.getCategoryName()%></td>
													<td><%=c.getCreatedate()%></td>
													<td><%=c.getUpdatedate()%></td>
													<td>
														<a href="<%=request.getContextPath()%>/admin/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>" class="btn btn-light btn-sm">수정</a>
														<a href="<%=request.getContextPath()%>/admin/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>" class="btn btn-light btn-sm">삭제</a>
													</td>
												</tr>
										<%
											}
										%>
									</table>
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