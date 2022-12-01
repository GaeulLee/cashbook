<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 세션에서 회원 아이디 받기
		3. 데이터 묶기
		4. 모델 출력(회원이 작성한 모든 글)
	*/
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// 데이터 묶기
	Member paramMember = new Member();
	paramMember.setMemberId(memberId);

	// M
	HelpDao helpDao = new HelpDao();
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(paramMember);
	
	// V
%>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>helpList</title>
    <!-- Custom Stylesheet -->
    <link href="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		th{
			text-align: center;
		}
		
		#align_center{
			text-align: center;
		}
		
		details {
			background: #f0f0f0;
			padding: 20px;
			border-radius: 8px;
		 
		}
		
		summary {
			cursor: pointer;
			font-weight: bold;
			font-size: 1.1em;
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
		<jsp:include page="<%=targetPage%>"></jsp:include>    	

        <!--Content body start-->
        <div class="content-body">
            <div class="container-fluid">
            
                <div class="row">
                    <div class="col">
                        <div class="card">
                        	<!-- 본문시작 -->
                            <div class="card-body">
								<div class="w-75 mt-4 mb-4 mx-auto h3 text-center" >
									<strong>내 문의 내역</strong>
									<span>
										<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp" class="btn btn-outline-secondary float-end">문의하기</a>
									</span>
								</div>
								<!-- 문의 출력 -->
								<div class="w-75 mx-auto">
								<%			
									for(HashMap<String, Object> m : helpList){
										String helpCreatedate = (String)m.get("helpCreatedate");
										helpCreatedate = helpCreatedate.substring(0,16);
										
										String commentCreatedate = (String)m.get("commentCreatedate");
										if(m.get("commentCreatedate") != null){
											commentCreatedate = commentCreatedate.substring(0,16);
										}	
								%>
										<details class="mb-2">
											<summary>
												<span><%=m.get("helpMemo")%></span>
												<span class="float-end"><%=helpCreatedate%></span>
											 </summary>
											 
											<%
												if(m.get("commentMemo") == null || commentCreatedate == null){
											%>
													<div class="mt-4">
														<span>답변 전</span>
														<span class="float-end">
															<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-light">문의 수정</a>
															<a href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-light">문의 삭제</a>
														</span>
													</div>
											<%
												}else{
													
											%>
													<div class="mt-4">
														<span><%=m.get("commentMemo")%></span>
														<span class="float-end"><%=commentCreatedate%></span>
													</div>
											<%
												}
											%>
										</details>
								<%
									}
								%>
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