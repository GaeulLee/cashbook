<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	// 달력의 특정 일을 클릭하면 그 날의 수입 지출 목록이 보이게 + 수정 삭제 기능
	
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
	if(request.getParameter("year") == null || request.getParameter("month") == null || request.getParameter("date") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> dateList = cashDao.selectCashListByDate(memberId, year, month, date);
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>cashDateList</title>
    <!-- Custom Stylesheet -->
    <link href="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
    <style>
    	th{
    		text-align: center;
    	}
    	
    	td{
    		word-break: break-all;
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
								<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">back</a>
								<!-- cash 입력 폼 -->
								<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
									<!-- memberId와 날짜는 hidden 값으로 넘기기 -->
									<input type="hidden" name="memberId" value="<%=memberId%>">
									<input type="hidden" name="year" value="<%=year%>">
									<input type="hidden" name="month" value="<%=month%>">
									<input type="hidden" name="date" value="<%=date%>">
									
									<table class="table table-borderless w-50 mx-auto align-middle">
										<tr>
											<th colspan="2">
												<h3 class="mt-1" id="font_color"><strong>가계부 추가</strong></h3>
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
											<th class="align-middle w-25">날짜</th>
											<td>
												<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly" class="form-control input-default">
											</td>
										</tr>
										<!-- categoryName 출력 list로-->
										<tr>
											<th class="align-middle">구분</th>
											<td>
												<select name="categoryNo" class="form-control input-default">
												<%
													for(Category c : categoryList){
												%>
														<option value="<%=c.getCategoryNo()%>">
															[<%=c.getCategoryKind()%>]-<%=c.getCategoryName()%>
														</option>
												<%
													}
												%>
												</select>
											</td>
										</tr>
										<tr>
											<th class="align-middle">금액</th>
											<td>
												<input type="number" name="cashPrice" class="form-control input-default">
											</td>
										</tr>
										<tr>
											<th class="align-middle">메모</th>
											<td>
												<textarea name="cashMemo" rows="3" cols="50" class="form-control input-default"></textarea>
											</td>
										</tr>
										<tr>
											<td colspan="2" class="text-right">
												<button type="submit" class="btn btn-outline-secondary">추가</button>
											</td>
										</tr>
									</table>
								</form>
								
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col">
						<div class="card">
							<div class="card-body">
								<!-- cash 목록 출력 -->
								<table class="table table-borderless w-75 mx-auto align-middle">
									<tr>
										<th>구분</th>
										<th>항목</th>
										<th>금액</th>
										<th>메모</th>
										<th>수정일</th>
										<th>작성일</th>
										<th>수정</th>
									</tr>
									<%
										for(HashMap<String, Object> m : dateList){				
									%>
										<tr class="text-center">
										<%
											String cateKind = (String)(m.get("categoryKind"));
											if(cateKind.equals("수입")){
											%>													
													<td><span class="badge badge-light" id="income"><%=(String)(m.get("categoryKind"))%></span></td>
											<%
												} else {
											%>													
													<td><span class="badge badge-light" id="outcome"><%=(String)(m.get("categoryKind"))%></span></td>
											<%
												}
											%>	
											<td><%=(String)m.get("categoryName")%></td>
											<td><%=(Long)m.get("cashPrice")%></td>
											<td class="w-25 text-left"><%=(String)m.get("cashMemo")%></td>
											<td><%=(String)m.get("updatedate")%></td>
											<td><%=(String)m.get("createdate")%></td>
											<td>
												<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=(Integer)m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>" class="btn btn-light btn-sm">수정</a>
												<a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=(Integer)m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>" class="btn btn-light btn-sm">삭제</a>
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