<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.Member"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%
	// 로그인 유효성 검사(로그인이 안되어있으면 들어오지 못하게)
	if(session.getAttribute("loginMember") == null){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}

	// 세션에 정보가 있다면 정보 가져오기
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();

	// 모델호출
	StatsDao statsDao = new StatsDao();
	ArrayList<HashMap<String, Object>> list = statsDao.selectCashByYear(memberId);
	
	// 숫자 콤마 포맷
	DecimalFormat df = new DecimalFormat("###,###");

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>stats</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <!-- Custom Stylesheet -->
    <link href="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
	<style>
		th{
			background-color: #ededf8;
			text-align: center;
			height: 10px;
		}

		#font_color{
			color: #76838f;
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
                            	<div class="mb-4 h3 text-center" id="font_color">
									<strong>년도별 통계</strong>
								</div>
								<table class="table table-borderless w-75 mx-auto align-middle">									
									<tr class="text-center">
										<th>년도</th>
										<th>지출횟수</th>
										<th>지출총합</th>
										<th>지출평균</th>
										<th>수입횟수</th>
										<th>수입총합</th>
										<th>수입평균</th>
									</tr>
									<%
										for(HashMap<String, Object> m : list){
									%>
											<tr class="text-center">
												<td><%=m.get("year")%></td>
												<td><%=df.format(m.get("outcomeCnt"))%></td>
												<td><%=df.format(m.get("outcomeSum"))%></td>
												<td><%=df.format(m.get("outcomeAvg"))%></td>
												<td><%=df.format(m.get("incomeCnt"))%></td>
												<td><%=df.format(m.get("incomeSum"))%></td>
												<td><%=df.format(m.get("incomeAvg"))%></td>
											</tr>
									<%
										}
									%>																	
								</table>																
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