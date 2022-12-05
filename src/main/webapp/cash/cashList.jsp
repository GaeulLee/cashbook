<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CashDao"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	// Controller : session, request
	// request : 년, 월
	
	// 로그인 유효성 검사
	String msg = null;
	if(session.getAttribute("loginMember") == null){
		msg = URLEncoder.encode("로그인이 필요합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember"); // session에 저장된 사용자 정보(현재 로그인 사용자)를 Member 타입에 저장
		System.out.println("cashList : memberID-> "+loginMember.getMemberId()+", memberLevel-> "+loginMember.getMemberLevel());
	
	// 달력 만드는 알고리즘
	int year = 0;
	int month = 0;
	// 년, 월 구하기
	if(request.getParameter("year") == null || request.getParameter("month") == null){ // 넘어온 값이 없으면 오늘 날짜 출력
		Calendar today = Calendar.getInstance(); // 오늘 날짜
		year = today.get(Calendar.YEAR);
		month = today.get(Calendar.MONTH);
	} else {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		// month -> -1일 경우, 또는 12일 경우 바꿔줘야함 ==> 왜? month는 값을 가져올 때 0부터 가져옴(0~11 -> 1~12) ex) 값이 0이면 1월 
		// month 출력 시 +1 을 해주어야 함
		if(month == -1){
			month = 11;
			year = year - 1;
		} 
		if(month == 12){
			month = 0;
			year = year + 1;
		}
	}
	// 출력하고자 하는 년, 월, 첫째날(1일) 요일 구하기
	Calendar targetDate = Calendar.getInstance();
	targetDate.set(Calendar.YEAR, year);
	targetDate.set(Calendar.MONTH, month);
	targetDate.set(Calendar.DATE, 1);
	int firstDay = targetDate.get(Calendar.DAY_OF_WEEK); // 해당 월 1일의 요일
	int lastDate = targetDate.getActualMaximum(Calendar.DATE); // 해당 월의 마지막 날짜 구하기
	// 달력 출력 테이블의 시작 공백셀(td)과 마지막 공백셀의 갯수
	/*
		일 월 화 수 목 금 토
		1  2 3 4 5 6 7
	*/
	int beginBlank = firstDay-1; // 첫째날의 요일이 수요일이라면 요일의 수는 4 공백 갯수는 3개
	int endBlank = 0; // beginBlank + lastDate + ?(endBlank) = 7로 나누어 떨어져야 함 --> totalTd
	if((beginBlank + lastDate) % 7 != 0){
		endBlank = 7 - ((beginBlank + lastDate) % 7);
	}
	int totalTd = beginBlank + lastDate + endBlank; // 전체 td의 갯수 7로 나누어 떨어져야 함
	
	// Model 호출 : 일별 cash 목록
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> list = cashDao.selectCashListByMonth(loginMember.getMemberId(), year, month+1); // month에 +1을 해주어야 함

	// View : 달력 출력 + 일별 cash 목록
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>cashList</title>
    <!-- Custom Stylesheet -->
    <link href="<%=request.getContextPath()%>/Resources/plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/Resources/css/style.css" rel="stylesheet">
    <style>
    	th{
    		height: 10px;
    		text-align: center;
    		background-color: #ededf8;
    	}
    	
    	td{
    		width: 60px;
    		height: 8rem;
    		word-break: break-all;
    	}
    	
    	td_cell{
    		min-height:50px;
    	}
    	
    	#font_color{
			color: #76838f;
		}
		
		#income{
			background-color: skyblue;
		}
		
		#outcome{
			background-color: pink;
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

        <!-- 본문시작 -->
         <!--Content body start-->
        <div class="content-body">
            <div class="container-fluid">
                <div class="row">
                    <div class="col">

                        <div class="card">
                            <div class="card-body">
                                <!-- 달력 출력 -->
								<div>
									<!-- 달력 날짜 -->
									<div class="mt-2 mb-4 text-center">
										<span>
											<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" class="btn btn-outline-secondary">Prev</a>
										</span>
										<span class="h3 align-middle" id="font_color"><strong><%=year%>년 <%=month+1%>월</strong></span>
										<span>
											<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" class="btn btn-outline-secondary">Next</a>
										</span>
									</div>
									<!-- 달력 본문 -->
									<table class="table mt-3 w-75 mx-auto">
										<tr>
											<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
										</tr>
										<tr>
											<%
												for(int i=1; i<=totalTd; i++){													
											%>
													<td class="align-top">
														<div id="td_cell">
											<%
															int date = i - beginBlank; // i를 출력하면 안됨 i는 td의 갯수
															if(date > 0 && date <= lastDate){
											%>
															<div>
																<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
																	<%=date%>
																</a>
															</div>
															<div onclick="location.href='<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>'" style="cursor:pointer;">
															<%
																for(HashMap<String, Object> m : list) {
																	String cashDate = (String)(m.get("cashDate"));
																	String cateKind = (String)(m.get("categoryKind"));
																	if(Integer.parseInt(cashDate.substring(8)) == date){ 
																	// 일별 수입지출 목록을 보기 위해서 -> String 타입의 cashdate 변수를 만들고, 정수타입으로 형변환, 일 숫자 추출 
																	// int를 적으면 안됨 -> int타입의 참조타입형태인 integer로 형변환 왜? hashmap에서 object 타입으로 받아왔기때문
																		if(cateKind.equals("수입")){
																	%>
																			<span class="badge badge-light align-middle mb-1" id="income"><%=(String)(m.get("categoryKind"))%></span>
																	<%
																		} else {
																	%>
																			<span class="badge badge-light align-middle mb-1" id="outcome"><%=(String)(m.get("categoryKind"))%></span>																			
																	<%
																		}
																	%>	
																		<span><%=(String)(m.get("categoryName"))%>&nbsp;<%=(Long)(m.get("cashPrice"))%>원</span>
																		<br>												
																	<%
																	}
																}
															%>		
															</div>
											<%			
														}
											%>
														</div>
													</td>										
											<%
													if(i%7 == 0 && i != totalTd){ // 7로 나누어 떨어지고 i가 totalTd가 아닐때만 출력
											%>
														</tr><tr><!-- td 7개 만들고 테이블 줄바꿈 -->
											<%
													}
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