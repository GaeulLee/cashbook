<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 유효성 검사(로그인이 되어있으면 회원가입을 할 수 없게)
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html class="h-100" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>insertMemberForm</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="../../assets/images/favicon.png">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link href="../Resources/css/style.css" rel="stylesheet">    
</head>

<body class="h-100">  
    <!--*******************
        Preloader start
    ********************-->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!--*******************
        Preloader end
    ********************-->
    
    <!-- 회원가입 폼 -->
    <div class="login-form-bg h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-5">
                                <a class="text-center" href="#"> <h4>SignIn</h4></a>
								<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post" class="mt-5 mb-5 login-input">
									<%
										String msg = request.getParameter("msg");
										if(msg != null){
									%>
											<p class="text-primary">&#10069;<%=msg%></p>
									<%
										}
									%>
								    <div class="form-group">
										<input type="text" name="memberName" class="form-control" placeholder="Enter Name" required>
								    </div>
								    <div class="form-group">
								        <input type="text" name="memberId" class="form-control" placeholder="Enter ID" required>
								    </div>
								    <div class="form-group">
								        <input type="password" name="memberPw" class="form-control" placeholder="Enter Password" required>                                       
								    </div>
								    <button type="submit" class="btn login-form__btn submit w-100">Sign in</button>
								</form>
	            				<p class="mt-5 login-form__footer">이미 회원이라면 <a href="<%=request.getContextPath()%>/loginForm.jsp" class="text-primary">로그인 </a></p>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
    <!--**********************************
        Scripts
    ***********************************-->
    <script src="../Resources/plugins/common/common.min.js"></script>
    <script src="../Resources/js/custom.min.js"></script>
    <script src="../Resources/js/settings.js"></script>
    <script src="../Resources/js/gleek.js"></script>
    <script src="../Resources/js/styleSwitcher.js"></script>
</body>
</html>