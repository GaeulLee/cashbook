<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	String memberName = loginMember.getMemberName();

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>MemberOne</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>helpList</title>
    <!-- Custom Stylesheet -->
    <link href="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		th{
			text-align: center;
		}
		
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
								<table class="table table-borderless w-75 mx-auto align-middle">
									<tr>
										<th colspan="2" class="h3" id="font_color"><strong>내 정보</strong></th>
									</tr>
									<tr>
										<th class="align-middle">회원 ID</th>
										<td><%=memberId%></td>
									</tr>
									<tr>
										<th class="align-middle">회원 PW</th>
										<td>
											<a href="<%=request.getContextPath()%>/member/updatePwForm.jsp" class="btn btn-outline-secondary btn-sm">비밀번호 변경</a>
										</td>
									</tr>
									<tr>
										<th class="align-middle">회원 이름</th>
										<td><%=memberName%></td>
									</tr>
								</table>
								
								<div class="text-center">
									<span>
										<a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp" class="btn btn-outline-secondary">회원정보 수정</a>
									</span>
									<span>
										<a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp" class="btn btn-outline-secondary">회원 탈퇴</a>
									</span>
								</div>
								
                            </div><!-- card-body -->
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