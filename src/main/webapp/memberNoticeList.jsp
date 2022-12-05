<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="vo.Notice"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 검색 값 검사
		2. 페이징(페이지 값 있다면 바꿔주기)
		3. 모델 출력
	*/
	// 로그인 유효성 검사
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 검색 값 받아오기
	String word = request.getParameter("word");
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	NoticeDao noticeDao = new NoticeDao();
	int cnt = 0;	
	// 검색 값 유무에 따라 분기
	if(word == null){
		cnt = noticeDao.selectNoticeCount();
	} else {
		cnt = 0; // 추후 수정
	}	
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage+PAGE_COUNT-1;
	int lastPage = cnt/ROW_PER_PAGE;
	
	if(cnt%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){
		endPage = lastPage;
	}
	
	// M
	// 검색 값 유무에 따라 분기
	ArrayList<Notice> noticeList = new ArrayList<Notice>();
	if(word == null){
		noticeList = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);
	} else {
		noticeList = null; // 추후 수정
	}
 
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>memberNoticeList</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		th{
			background-color: #ededf8;
			
			height: 10px;
		}
		
		table{
			text-align: center;
		}
		
		#td_width{
			width: 65%;
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
		<%	
		String targetPage = "./inc/header.jsp";
		if(loginMember.getMemberLevel() > 0){
			targetPage = "./inc/adminHeader.jsp";
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
							<div class="card-body w-75 mx-auto">																					
								<div class="mb-4 h3 text-center" id="font_color">
									<strong>공지 목록</strong>
								</div>
								<div class="mb-1 text-right">
									<form action="<%=request.getContextPath()%>/memberNoticeList.jsp?word=<%=word%>" method="post">
										<label>
											<input type="text" placeholder="제목 검색" class="form-control input-default">
										</label>
										<button type="submit" class="btn btn-light">Search</button>
									</form>
								</div>						
								<table class="table">
									<tr>
										<th>공지번호</th>
										<th>내용</th>
										<th>날짜</th>										
									</tr>
									<%
										for(Notice n : noticeList){
									%>
											<tr>
												<td><%=n.getNoticeNo()%></td>
												<td class="text-left" id="td_width"><%=n.getNoticeMemo()%></td>
												<td><%=n.getCreatedate()%></td>												
											</tr>
									<%
										}
									%>
								</table>								
								<!-- paging -->
								<div>
									<ul class="pagination justify-content-center">				
										<li class="page-item">
											<a href="<%=request.getContextPath()%>/memberNoticeList.jsp?currentPage=1" class="page-link">처음</a>
										</li>
										<%
											if(currentPage > 1){
										%>
												<li class="page-item">
													<a href="<%=request.getContextPath()%>/memberNoticeList.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
												</li>
										<%
											}
											for(int i=beginPage; i<=endPage; i++){
												if(currentPage == i){
												%>
													<li class="page-item active">
														<a href="<%=request.getContextPath()%>/memberNoticeList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%		
												}else{
												%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/memberNoticeList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%	
												}
											}
											if(currentPage < lastPage){
										%>
												<li class="page-item">
													<a href="<%=request.getContextPath()%>/memberNoticeList.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
												</li>
										<%
											}
										%>
										<li class="page-item">
											<a href="<%=request.getContextPath()%>/memberNoticeList.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
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