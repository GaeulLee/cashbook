<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%

%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>deleteMemberForm</title>
    <!-- Custom Stylesheet -->
    <link href="../Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="../Resources/css/style.css" rel="stylesheet">
    <style>
    	th{
    		
    		background-color: #ededf8;
    	}
    	
    	td{
    	
    	}
    	
    	td_cell{
    		
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
		
		

        <!-- 본문시작 -->
		
			<form action="<%=request.getContextPath()%>/member/deleteMemberAction.jsp" method="post">
				<input type="hidden" name="memberId" value="">
				<table class="table table-borderless w-50 mx-auto align-middle shadow-sm mt-3">
					<tr>
						<th colspan="2">
							<h4 class="mt-3"><strong>회원탈퇴</strong></h4>
						</th>
					</tr>
					<tr>
						<th colspan="2">
						<%
						String msg = request.getParameter("msg");
							if(msg != null){
						%>
								<span class="text-info">&#10069;<%=msg%></span>						
						<%
							}else{
						%>
								<span>회원 탈퇴를 위한 비밀번호를 입력해주세요.</span>
						<%
							}
						%>
						</th>
					</tr>
					<tr>
						<th class="w-50">비밀번호 입력</th>
						<td>
							<input type="password" name="memberPw" class="form-control w-75">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<a href="<%=request.getContextPath()%>/member/memberOne.jsp" class="btn btn-outline-primary float-start">back</a>
							<button type="submit" class="btn btn-outline-primary float-end">탈퇴</button>
						</td>
					</tr>
				</table>
			</form>
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