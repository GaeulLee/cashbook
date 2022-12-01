<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// M
	NoticeDao noticeDao = new NoticeDao();
	MemberDao memberDao = new MemberDao();
	HelpDao helpDao = new HelpDao();
	int beginRow = 0;
	int rowPerPage = 5;
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); // 최근 공지 5개
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage); // 최근 추가 멤버 5개씩
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, rowPerPage);
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
	<title>adminMain</title>	
	<!-- Custom Stylesheet -->
	<link href="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		th{
			background-color: #ededf8;
			text-align: center;
			height: 10px;
		}
		
		table{
			height: 300px;
		}
	</style>
</head>
<body>
    <!--Preloader start-->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!--Preloader end-->
    
    <!--Main wrapper start-->
    <div id="main-wrapper">
    
		<!-- header & sidebar -->
		<jsp:include page="../inc/adminMainHeader.jsp"></jsp:include>

        <!--Content body start-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row">
                
                	<!-- 공지사항 -->
                    <div class="col">
                        <div class="card">
                            <div class="card-body h-50">
                                <div class="h-50">
									<h4><strong>공지사항</strong></h4>
									<table class="table">
										<tr>
											<th class="w-75">내용</th>
											<th>날짜</th>
										</tr>
										<%
											for(Notice n : noticeList){
												String createdate = n.getCreatedate();
												createdate = createdate.substring(0,16);
										%>
												<tr>
													<td><%=n.getNoticeMemo()%></td>
													<td class="text-center"><%=createdate%></td>
												</tr>
										<%
											}
										%>
									</table>
								</div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 회원 -->
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
                                <div class="h-50">
									<h4><strong>최근 생성 회원</strong></h4>
									<table class="table">
										<tr>
											<th>회원번호</th>
											<th>아이디</th>
											<th>회원레벨</th>
											<th>이름</th>
											<th>수정일</th>
											<th>회원 생성일</th>
										</tr>
										<%
											for(Member m : memberList){
										%>
												<tr class="text-center">
													<td><%=m.getMemberNo()%></td>
													<td><%=m.getMemberId()%></td>
													<%
														String level = "회원";
														if(m.getMemberLevel() == 1){
															level = "관리자";
														}
													%>
													<td><%=level%></td>
													<td><%=m.getMemberName()%></td>
													<td><%=m.getUpdatedate()%></td>
													<td><%=m.getCreatedate()%></td>
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
                
                <!-- 문의 -->
                <div class="row">
               	  <div class="col">
                       <div class="card">
                           <div class="card-body">
                               <div class="h-50">
								<h4><strong>최근 생성 문의</strong></h4>
								<table class="table">
									<tr>
										<th class="w-75">문의내용</th>
										<th>작성자</th>
										<th>작성일</th>
									</tr>
									<%
										for(HashMap<String, Object> h : helpList){
									%>
											<tr>
												<td><%=h.get("helpMemo")%></td>
												<td class="text-center"><%=h.get("memberId")%></td>
												<td class="text-center"><%=h.get("helpCreatedate")%></td>
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