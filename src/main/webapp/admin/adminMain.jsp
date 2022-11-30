<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="vo.Notice"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="dao.MemberDao"%>
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
	int beginRow = 0;
	int rowPerPage = 5;
	ArrayList<Notice> noticeList = noticeDao.selectNoticeListByPage(beginRow, rowPerPage); // 최근 공지 5개
	ArrayList<Member> memberList = memberDao.selectMemberListByPage(beginRow, rowPerPage); // 최근 추가 멤버 5개씩
	
	// V
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>adminMain</title>
	<!-- Custom Stylesheet -->
	<link href="../Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
	<link href="../Resources/css/style.css" rel="stylesheet">
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
    
		<!-- header -->
		<jsp:include page="../inc/adminMainHeader.jsp"></jsp:include>
		<!-- 본문 시작 -->
		<div>
			<div>
				<h3><strong>공지사항</strong></h3>
				<table border="1">
					<tr>
						<th>내용</th>
						<th>날짜</th>
					</tr>
					<%
						for(Notice n : noticeList){
					%>
							<tr>
								<td><%=n.getNoticeMemo()%></td>
								<td><%=n.getCreatedate()%></td>
							</tr>
					<%
						}
					%>
				</table>
			</div>
			<!-- 최근 추가 멤버 5개 -->
			<div>
				<h3><strong>최근 생성된 회원</strong></h3>
				<table border="1">
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
							<tr>
								<td><%=m.getMemberNo()%></td>
								<td><%=m.getMemberId()%></td>
								<td><%=m.getMemberLevel()%></td>
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
	
	<!--Scripts-->
    <script src="../Resources/plugins/common/common.min.js"></script>
    <script src="../Resources/js/custom.min.js"></script>
    <script src="../Resources/js/settings.js"></script>
    <script src="../Resources/js/gleek.js"></script>
    <script src="../Resources/js/styleSwitcher.js"></script>
    
    <script src="../Resources/plugins/jqueryui/js/jquery-ui.min.js"></script>
    <script src="../Resources/plugins/moment/moment.min.js"></script>
    <script src="../Resources/plugins/fullcalendar/js/fullcalendar.min.js"></script>
    <script src="../Resources/js/plugins-init/fullcalendar-init.js"></script>
    
	</body>
</html>