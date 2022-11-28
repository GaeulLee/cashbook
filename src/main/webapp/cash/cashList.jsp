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
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashList</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/combine/npm/bootswatch@5.2.2/dist/sandstone/bootstrap.min.css,npm/bootswatch@5.2.2/dist/sandstone/bootstrap.min.css">
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <style>
			th{
				text-align: center;
				height: 20px;
			}
			
			td{
				width: 60px;			
			}
			#align_center{
				text-align: center;
			}
			
			table{
				border-radius: 10px;
				background-color: rgba(248,245,240,0.5);
				height: 600px;
				table-layout: fixed;
				word-break: break-all;
			}
			
			#font_size{
				font-size: 20px;
				font-weight: bold;
			}
		</style>
	</head>	
	<!-- 다이어리 형식으로 수입 지출을 확인할 수 있도록 -->
	<body>
	<!-- header -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<div class="container-fluid">
				<div class="collapse navbar-collapse" id="navbarColor01">
					<ul class="navbar-nav me-auto">
						<li class="nav-item">
							<a class="nav-link active" href="<%=request.getContextPath()%>/cash/cashList.jsp">Home
								<span class="visually-hidden">(current)</span>
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="#">Help</a>
						</li>
						<%
							if(loginMember.getMemberLevel() > 0){
						%>
								<li class="nav-item">
									<a class="nav-link" href="<%=request.getContextPath()%>/admin/adminMain.jsp">Admin</a>
								</li>
						<%
							}
						%>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">My page</a>
							<ul class="dropdown-menu">
								<li>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/member/memberOne.jsp">내 정보</a>
								</li>
								<li>
									<div class="dropdown-divider"></div>
								</li>
								<li>
									<a class="dropdown-item" href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</nav>
	<div class="container">		
		<!-- 로그인 정보(세션에 loginMember 변수) 출력 -->
		<div class="alert alert-dismissible alert-secondary shadow-sm mt-2 w-25">
			<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
			<strong><%=loginMember.getMemberName()%></strong>님 반갑습니다.
		</div>
		<!-- 달력 출력 -->
		<div>
			<div id="align_center" class="mt-3">
				<span>
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>" class="btn btn-outline-secondary me-1">Prev</a>
				</span>
				<span id="font_size">
					<%=year%>년 <%=month+1%>월
				</span>
				<span>
					<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month+1%>" class="btn btn-outline-secondary ms-1">Next</a>
				</span>
			</div>
			<table class="table shadow-sm mt-3">
				<tr class="" id="">
					<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>
				</tr>
				<tr>
					<%
						for(int i=1; i<=totalTd; i++){
					%>
							<td>
					<%
								int date = i - beginBlank; // i를 출력하면 안됨 i는 td의 갯수
								if(date > 0 && date <= lastDate){
					%>
									<div>
										<a href="<%=request.getContextPath()%>/cash/cashDateList.jsp?year=<%=year%>&month=<%=month+1%>&date=<%=date%>">
											<%=date%>
										</a>
									</div>
									<div>
									<%
										for(HashMap<String, Object> m : list) {
											String cashDate = (String)(m.get("cashDate"));
											String cateKind = (String)(m.get("categoryKind"));
											if(Integer.parseInt(cashDate.substring(8)) == date){ 
											// 일별 수입지출 목록을 보기 위해서 -> String 타입의 cashdate 변수를 만들고, 정수타입으로 형변환, 일 숫자 추출 
											// int를 적으면 안됨 -> int타입의 참조타입형태인 integer로 형변환 왜? hashmap에서 object 타입으로 받아왔기때문
												if(cateKind.equals("수입")){
											%>
													<span style="color: skyblue;">[<%=(String)(m.get("categoryKind"))%>]</span>
											<%
												} else {
											%>
													<span style="color: pink;">[<%=(String)(m.get("categoryKind"))%>]</span>
											<%
												}
											%>	
												<%=(String)(m.get("categoryName"))%>
												&nbsp;
												<%=(Long)(m.get("cashPrice"))%>원
												<br>												
											<%
											}
										}
									%>		
									</div>
					<%			
								}
					%>
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
	</body>
</html>