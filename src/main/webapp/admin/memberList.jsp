<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사(회원 레벨 확인)
		2. 페이징(페이지 값 있다면 바꿔주기)
		3. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	MemberDao memberDao = new MemberDao();
	int cnt = memberDao.selectMemberCount();
	final int ROW_PER_PAGE = 15;
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
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, ROW_PER_PAGE);
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width,initial-scale=1">
	<title>memberList</title>
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		th{
			background-color: #ededf8;
			
			height: 10px;
		}
		
		table{
			height: 300px;
			text-align: center;
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
		<!-- header -->
		<jsp:include page="../inc/adminMainHeader.jsp">
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
									<strong>회원 목록</strong>
								</div>
								<table class="table">
									<tr>
										<th>회원번호</th>
										<th>아이디</th>
										<th>회원레벨</th>
										<th>이름</th>
										<th>수정일</th>
										<th>회원 생성일</th>
										<th>편집</th>
									</tr>
									<%
										for(Member m : memberList){
									%>
											<tr>
												<td><%=m.getMemberNo()%></td>
												<td><%=m.getMemberId()%></td>
												<%
													if(m.getMemberLevel() > 0){
												%>
														<td>관리자</td>
												<%
													} else {														
												%>
														<td>회원</td>
												<%
													}
												%>												
												<td><%=m.getMemberName()%></td>
												<td><%=m.getUpdatedate()%></td>
												<td><%=m.getCreatedate()%></td>
												<td>
													<a href="<%=request.getContextPath()%>/admin/member/updateMemberLevelForm.jsp?memberNo=<%=m.getMemberNo()%>" class="btn btn-light btn-sm">레벨수정</a>
													<a href="<%=request.getContextPath()%>/admin/member/deleteMemberAction.jsp?memberNo=<%=m.getMemberNo()%>" class="btn btn-light btn-sm">삭제</a>
												</td>
											</tr>
									<%
										}
									%>
								</table>
								<!-- paging -->
								<div>
									<ul class="pagination justify-content-center">				
										<li class="page-item">
											<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=1" class="page-link">처음</a>
										</li>
										<%
											if(currentPage > 1){
										%>
												<li class="page-item">
													<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
												</li>
										<%
											}
											for(int i=beginPage; i<=endPage; i++){
												if(currentPage == i){
												%>
													<li class="page-item active">
														<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%		
												}else{
												%>
													<li class="page-item">
														<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
													</li>
												<%	
												}
											}
											if(currentPage < lastPage){
										%>
												<li class="page-item">
													<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
												</li>
										<%
											}
										%>
										<li class="page-item">
											<a href="<%=request.getContextPath()%>/admin/memberList.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
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