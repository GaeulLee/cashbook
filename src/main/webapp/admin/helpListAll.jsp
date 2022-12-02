<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사 + 레벨 확인
		2. 페이징
		3. 모델 출력(모든 문의 글)
	*/
	// 세션값 받고 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}

	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	HelpDao helpDao = new HelpDao();
	int cnt = helpDao.selectHelpCount();
	final int ROW_PER_PAGE = 5;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage*PAGE_COUNT;
	int lastPage = cnt/ROW_PER_PAGE;
	
	if(cnt%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){
		endPage = lastPage;
	}
	

	// M
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, ROW_PER_PAGE);
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>helpListAll</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		th{
			text-align: center;
		}		
		
		details {
			background-color: #ededf8;
			padding: 30px;
			border-radius: 8px;		 
		}
		
		summary {
			cursor: pointer;
			font-weight: bold;
			font-size: 1.1em;
		}
		
		#font_color{
			color: #76838f;
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
								<div class="mb-4 h3 text-center" id="font_color">
									<strong>회원 문의 내역</strong>
								</div>
								<!-- 문의글 출력 -->
								<div class="w-75 mx-auto">
								<%			
									for(HashMap<String, Object> m : helpList){ // helpList를 반복해서 출력
										// 받아온 날짜를 년, 월, 일, 시, 분 까지만 나오게 문자열 자르기
										String helpCreatedate = (String)m.get("helpCreatedate");
										helpCreatedate = helpCreatedate.substring(0,16);
										String commentCreatedate = (String)m.get("commentCreatedate"); // commentCreatedate에 값이 없으면 null로 들어옴
										if(m.get("commentCreatedate") != null){ // commentCreatedate이 null이 아닐 경우에만 문자열 자르기 
											commentCreatedate = commentCreatedate.substring(0,16);
										}	
								%>
										<!-- 조건에 맞게 문의글 출력 -->
										<details class="mb-3">
											<!-- 질문 -->
											<summary>
												<span class="h4" id="font_color"><strong><%=m.get("helpMemo")%></strong></span>
												<div class="text-right">작성일 <%=helpCreatedate%> </div>
												<div class="text-right">작성자 <%=m.get("memberId")%></div>
												
											</summary> 
											<!-- 답변 -->
											<%
												if(m.get("commentMemo") == null){
											%>
													<div class="mt-4">
														<span>답변 전입니다.</span>
														<div class="text-right">
															<a href="<%=request.getContextPath()%>/admin/comment/insertCommentForm.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-light btn-sm">답변하기</a>															
														</div>
													</div>
											<%
												}else{	
											%>
													<div class="mt-4">
														<span><%=m.get("commentMemo")%></span>
														<div class="text-right">
															<a href="<%=request.getContextPath()%>/admin/comment/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>" class="btn btn-light btn-sm">수정</a>
															<a href="<%=request.getContextPath()%>/admin/comment/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>" class="btn btn-light btn-sm">삭제</a>
														</div>
													</div>
											<%
												}
											%>
										</details>
								<%
									}
								%>
								</div>
								<!-- paging -->
								<div>
									<ul class="pagination justify-content-center">				
										<li class="page-item">
											<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1" class="page-link">처음</a>
										</li>
										<%
											if(currentPage > 1){
										%>
												<li class="page-item">
													<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
												</li>
										<%
											}
											for(int i=beginPage; i<=endPage; i++){
												if(currentPage == i){
												%>
													<li class="page-item active">
														<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%		
												}else{
												%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%	
												}
											}
											if(currentPage < lastPage){
										%>
												<li class="page-item">
													<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
												</li>
										<%
											}
										%>
										<li class="page-item">
											<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
										</li>
									</ul>
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