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
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>test</title>
    <!-- Custom Stylesheet -->
    <link href="./Resources/css/style.css" rel="stylesheet">
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
		<jsp:include page="./inc/adminMainHeader.jsp"></jsp:include>

        <!--Content body start-->
        <div class="content-body">
            <!-- row -->

            <div class="container-fluid">
                <div class="row">
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
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
                            </div>
                        </div>
                    </div>
                    
                    <div class="col">
                        <div class="card">
                            <div class="card-body">
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
                    </div>
                </div>
                
                <div class="row">
               	  <div class="col">
                       <div class="card">
                           <div class="card-body">
                               <div>
								<h3><strong>최근 생성된 문의</strong></h3>
								<table border="1">
									<tr>
										<th>문의내용</th>
										<th>작성자</th>
										<th>작성일</th>
									</tr>
									<%
										for(HashMap<String, Object> h : helpList){
									%>
											<tr>
												<td><%=h.get("helpMemo")%></td>
												<td><%=h.get("memberId")%></td>
												<td><%=h.get("helpCreatedate")%></td>
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
    <script src="./Resources/plugins/common/common.min.js"></script>
    <script src="./Resources/js/custom.min.js"></script>
    <script src="./Resources/js/settings.js"></script>
    <script src="./Resources/js/gleek.js"></script>
    <script src="./Resources/js/styleSwitcher.js"></script>
</body>
</html>