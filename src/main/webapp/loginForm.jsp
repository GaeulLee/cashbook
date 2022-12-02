<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.Notice"%>
<%
	/*
	1. 로그인 유효성 검사 -> 로그인이 되어있으면 가계부로 가게
	2. 페이징(cnt는 메서드로)
	3. 공지 출력
	*/

	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// paging
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 5; // 한 페이지 당 보여줄 게시글(행) 수
	int beginRow = (currentPage-1)*ROW_PER_PAGE; // 쿼리에 작성할 게시글(행) 시작 값
	final int PAGE_COUNT = 10; // 한 페이지 당 보여줄 페이징 목록 수
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1; // 페이징 목록 시작 값
	int endPage = beginPage+PAGE_COUNT-1; // 페이징 목록 끝 값
	
	NoticeDao noticeDao = new NoticeDao();
	int cnt = noticeDao.selectNoticeCount(); // 전체 행 구하기
	int lastPage = cnt/ROW_PER_PAGE; // 마지막 페이지
	if(lastPage%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){ // 페이지 목록이 lastPage까지만 보이도록
		endPage = lastPage;
	}
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE); // 공지 출력

%>
<!DOCTYPE html>
<html class="h-100" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>login</title>
    <!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous"> -->
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
    <style>
    	th{
    		background-color: #ededf8;
    	}
    	
    	#font_color{
    		color: #9097c4;
    	}
    	
    	#button_color{
    		background-color: #9097c4;
    	}
    </style> 
</head>

<body class="h-100">
    <!--Preloader start-->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!--Preloader end-->
    
    <!-- 타이틀 -->
    <div class="h1 text-center mt-3">
    	<span id="font_color"><strong>CashBook</strong></span>
    </div>
    
    <!-- 회원 로그인 폼 -->
    <div class="login-form-bg h-50">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-5">
                                <a class="text-center" href="<%=request.getContextPath()%>/loginForm.jsp"><h4>Login</h4></a>
                                <form action="<%=request.getContextPath()%>/loginAction.jsp" method="post" class="mt-5 mb-5 login-input">
                             		<%
										String msg = request.getParameter("msg");
										if(msg != null){
									%>
											<p class="text-primary">&#10069;<%=msg%></p>												
									<%
										}
									%>
                                    <div class="form-group">
                                        <input type="text" name="memberId" class="form-control input-default" placeholder="Id">
                                    </div>
                                    <div class="form-group">
                                        <input type="password" name="memberPw" class="form-control input-default" placeholder="Password">
                                    </div>
                                    <button type="submit" class="btn login-form__btn submit w-100" id="button_color">Sign In</button>
                                </form>
                                <p class="mt-5 login-form__footer">회원이 아니신가요? <a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="text-primary">화원가입</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
     <!-- 공지(5개)목록 페이징 (상세보기 없음 타이틀만 보이게, 댓글 기능) -->
     <div class="col mx-auto mt-2 w-50 h-50">     
	     <div class="card">
	     	<div class="card-body">	     
	     		<table class="table">
						<tr class="text-center">
							<th>공지내용</th>
							<th>날짜</th>
						</tr>
						<%
							for(Notice n : list){
						%>
								<tr>
									<td class="w-75"><%=n.getNoticeMemo()%></td>
									<td class="text-center">
										<%
											String createdate = n.getCreatedate();
											createdate = createdate.substring(0,10);
										%>
										<%=createdate%>
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
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1" class="page-link">처음</a>
							</li>
							<%
								if(currentPage > 1){
							%>
									<li class="page-item">
										<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
									</li>
							<%
								}
								for(int i=beginPage; i<=endPage; i++){
									if(currentPage == i){
									%>
										<li class="page-item active">
											<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
										</li>
									<%		
									}else{
									%>
										<li class="page-item">
											<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
										</li>
									<%	
									}
								}
								if(currentPage < lastPage){
							%>
									<li class="page-item">
										<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
									</li>
							<%
								}
							%>
							<li class="page-item">
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
							</li>
						</ul>
					</div>
				</div>	     		
	     	</div>
	     </div>     
     </div>         
	<div>

    <!--Scripts-->
    <script src="<%=request.getContextPath()%>/Resources/plugins/common/common.min.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/custom.min.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/settings.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/gleek.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/styleSwitcher.js"></script>
</body>
</html>