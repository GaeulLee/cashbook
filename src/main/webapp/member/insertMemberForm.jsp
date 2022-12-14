<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%
	// 로그인 유효성 검사(로그인이 되어있으면 회원가입을 할 수 없게)
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	Member loginMember = (Member)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html class="h-100" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>insertMemberForm</title>    
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
    <style>
    	#font_color{
    		color: #9097c4;
    	}
    	
    	#insertBtn{
    		background-color: #9097c4;
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

<body class="h-100">  
    <!--Preloader star*-->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!--Preloader end-->
    
    
    
    <!-- 회원가입 폼 -->
    <div class="login-form-bg h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="form-input-content">
                    	<!-- 타이틀 -->
					    <div class="h1 text-center mb-3">
					    	<span id="font_color"><strong>CashBook</strong></span>
					    </div>
                        <div class="card login-form mb-0">                        	
                            <div class="card-body pt-5">
                                <a class="text-center" href="#"> <h4>SignUp</h4></a>
								<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post" id="insertForm" class="mt-5 mb-5 login-input">
									<%
										String msg = request.getParameter("msg");
										if(msg != null){
									%>
											<p class="text-primary">&#10069;<%=msg%></p>
									<%
										}
									%>
								    <div class="form-group">
										<input type="text" name="memberName" id="memberName" class="form-control input-default" placeholder="Enter Name" required>
								    </div>
								    <div class="form-group">
								        <input type="text" name="memberId" id="memberId" class="form-control input-default" placeholder="Enter ID" required>
								    </div>
								    <div class="form-group">
								        <input type="password" name="memberPw" id="memberPw" class="form-control input-default" placeholder="Enter Password" required>                                       
								    </div>
								    <button type="submit" class="btn login-form__btn submit w-100" id="insertBtn">회원가입</button>
								</form>
	            				<p class="mt-5 login-form__footer">이미 회원이라면 <a href="<%=request.getContextPath()%>/loginForm.jsp" class="text-primary">로그인 </a></p>
	                        </div>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
    <!--Scripts-->
    <script>
    	let insertBtn = document.querySelector('#insertBtn');
    	
    	insertBtn.addEventListener('click', function(){
    		// debug
    		console.log('insertBtn clicked');
    		
    		// form check
    		
    		// memberName
    		let memberName = document.querySelector('#memberName');
    		if(memberName.value == ''){
    			alert('이름을 입력하세요.');
    			memberName.focus();
				return;
    		}
    		
    		// memberId
    		let memberId = document.querySelector('#memberId');
    		if(memberId.value == ''){
    			alert('아이디를 입력하세요.');
    			memberId.focus();
				return;
    		}    		    	
    		
    		// memberPw
    		let memberPw = document.querySelector('#memberPw');
    		if(memberPw.value == ''){
    			alert('비밀번호를 입력하세요.');
    			memberPw.focus();
				return;
    		}
    		    		
    		let insertForm = document.querySelector('#insertForm');
    		insertForm.submit();
    	});    	
    </script>
    
    <script src="<%=request.getContextPath()%>/Resources/plugins/common/common.min.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/custom.min.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/settings.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/gleek.js"></script>
    <script src="<%=request.getContextPath()%>/Resources/js/styleSwitcher.js"></script>
</body>
</html>