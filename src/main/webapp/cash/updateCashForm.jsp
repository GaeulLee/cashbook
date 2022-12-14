<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%	
	// C
	/*
		1. 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
		2. 파라메터 유효성 검사
		3. 모델 출력
	*/
	
	// 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
	String msg = null;
	if(session.getAttribute("loginMember") == null){
		msg = URLEncoder.encode("로그인이 필요합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// 파라메터 유효성 검사
	if(request.getParameter("cashNo") == null ||
	request.getParameter("year") == null ||
	request.getParameter("month") == null ||
	request.getParameter("date") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));

	// M	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList(); // 카테고리 리스트
	
	CashDao cashDao = new CashDao();
	Cash oldCash = cashDao.selectCashOne(cashNo);
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>updateCashForm</title>
    <!-- Custom Stylesheet -->
    <link href="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
    <style>
    	th{
    		text-align: center;
    	}
    	
    	#font_color{
			color: #76838f;
		}
		
		#income{
			background-color: skyblue;
		}
		
		#outcome{
			background-color: pink;
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
								<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month%>&date=<%=date%>">back</a>
								<form action="<%=request.getContextPath()%>/cash/updateCashAction.jsp?cashNo=<%=cashNo%>" method="post">
									<input type="hidden" name="year" value="<%=year%>">
									<input type="hidden" name="month" value="<%=month%>">
									<input type="hidden" name="date" value="<%=date%>">
									<table class="table table-borderless w-50 mx-auto align-middle">
										<tr>
											<th colspan="2">
												<h3 class="mt-1" id="font_color"><strong>가계부 수정</strong></h3>
											</th>
										</tr>
										<%
											String paramMsg = request.getParameter("msg");
											if(paramMsg != null){
										%>
												<tr>
													<th colspan="2" class="text-info">&#10069;<%=paramMsg%></th>
												</tr>
										<%
											}
										%>
										<tr>
											<th class="align-middle">No</th>
											<td>
												<input type="text" name="cashNo" value="<%=cashNo%>" readonly="readonly" class="form-control input-default">
											</td>
										</tr>
										<!-- categoryName 출력 list로-->
										<tr>
											<th class="align-middle">구분</th>
											<td>
												<select name="categoryNo" class="form-control input-default">
												<%
													for(Category c : categoryList){														
														if(c.getCategoryNo() == oldCash.getCategoryNo()){
														%>
															<option value="<%=c.getCategoryNo()%>" selected>
																[<%=c.getCategoryKind()%>]-<%=c.getCategoryName()%>
															</option>
														<%														
														} else {
														%>
															<option value="<%=c.getCategoryNo()%>">
																[<%=c.getCategoryKind()%>]-<%=c.getCategoryName()%>
															</option>
														<%
														}
													}
												%>
												</select>
											</td>
										</tr>
										<tr>
											<th class="align-middle">금액</th>
											<td>
												<input type="number" name="cashPrice" value="<%=oldCash.getCashPrice()%>" class="form-control input-default">
											</td>
										</tr>
										<tr>
											<th class="align-middle">메모</th>
											<td>
												<textarea name="cashMemo" rows="10" cols="50" class="form-control input-default"><%=oldCash.getCashMemo()%></textarea>
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