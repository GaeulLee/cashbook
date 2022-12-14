<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사 + 레벨 확인
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
	if(request.getParameter("categoryNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/categoryList.jsp");
		return;
	}
	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	
	// 데이터 묶기
	Category paramCategory = new Category();
	paramCategory.setCategoryNo(categoryNo);
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	Category oldCategory = categoryDao.selectCategoryOne(paramCategory);
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>updateCategoryeForm</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		table{
			text-align: center;
			height: 350px;
		}
		
		#font_color{
			color: #76838f;
		}
		label{
			margin: 0px;
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
								<a href="<%=request.getContextPath()%>/admin/categoryList.jsp">back</a>
								<div class="mb-4 h3 text-center" id="font_color">
									<strong>카테고리 수정</strong>
								</div>
								<form action="<%=request.getContextPath()%>/admin/category/updateCategoryAction.jsp" method="post">
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
											<th class="align-middle">카테고리 번호</th>
											<td>
												<input type="number" name="categoryNo" value="<%=oldCategory.getCategoryNo()%>" readonly="readonly" class="form-control input-default w-50">
											</td>
										</tr>
										<tr>
											<th class="align-middle">구분</th>
											<td class="align-middle text-left">
											<%
												String categoryKind = oldCategory.getCategoryKind();
												if(categoryKind.equals("수입")){
											%>
													<label>
														<input type="radio" id="categoryKind" name="categoryKind" value="수입" checked> 수입
													</label>
													&nbsp;
													<label>
														<input type="radio" id="categoryKind" name="categoryKind" value="지출" disabled> 지출
													</label>
											<%
												} else {
											%>
													<label>
														<input type="radio" id="categoryKind" name="categoryKind" value="수입" disabled> 수입
													</label>
													&nbsp;
													<label>
														<input type="radio" id="categoryKind" name="categoryKind" value="지출" checked> 지출
													</label>
											<%
												}
											%>
												
											</td>
										</tr>
										<tr>
											<th class="align-middle">항목</th>
											<td>
												<input type="text" name="categoryName" value="<%=oldCategory.getCategoryName()%>" placeholder="수정할 카테고리 이름을 적어주세요." class="form-control input-default">
											</td>
										</tr>
										<tr>
											<th class="align-middle">생성일</th>
											<td class="align-middle text-left"><%=oldCategory.getCreatedate()%></td>
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