<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기 -> deleteAction으로 세션에 저장된 아이디 값을 넘겨주기 위함
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>deleteMemberForm</title>
    <!-- Custom Stylesheet -->
    <link href="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
    <style>
    	table{
			height:400px;
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
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
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
                            	<a href="<%=request.getContextPath()%>/member/memberOne.jsp">back</a>
                                <form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
									<input type="hidden" name="memberId" value="<%=memberId%>">
									<table class="table table-borderless w-50 mx-auto align-middle">
										<tr>
											<th colspan="2">
												<h3 class="mt-3 text-center" id="font_color"><strong>회원 탈퇴</strong></h3>
											</th>
										</tr>
										<tr>
											<th colspan="2">
											<%
											String msg = request.getParameter("msg");
												if(msg != null){
											%>
													<div class="text-info text-center">&#10069;<%=msg%></div>						
											<%
												}else{
											%>
													<div class="text-center">회원 탈퇴를 위한 비밀번호를 입력해주세요.</div>
											<%
												}
											%>
											</th>
										</tr>
										<tr>
											<th class="w-50 text-center align-middle">비밀번호 입력</th>
											<td>
												<input type="password" name="memberPw" class="form-control input-default w-75">
											</td>
										</tr>
										<tr>
											<td colspan="2" class="text-right">
												<button type="submit" class="btn mb-1 btn-outline-secondary">탈퇴</button>
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