<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*"%>
<%@ page import="vo.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	// 달력의 특정 일을 클릭하면 그 날의 수입 지출 목록이 보이게 + 수정 삭제 기능
	
	// C
	/*
		1. 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
		2. 파라메터 유효성 검사
		3. 모델 출력
	*/
	
	// 로그인 유효성 검사 -> 있다면 세션 정보를 멤버 타입 변수에 저장
	String msg = null;
	if(session.getAttribute("loginMember") == null){
		msg = URLEncoder.encode("로그인이 필요합니다.", "utf-8");
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	Member loginMember = (Member)session.getAttribute("loginMember");
	String memberId = loginMember.getMemberId();
	
	// 파라메터 유효성 검사
	if(request.getParameter("year") == null || request.getParameter("month") == null || request.getParameter("date") == null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
	int year = Integer.parseInt(request.getParameter("year"));
	int month = Integer.parseInt(request.getParameter("month"));
	int date = Integer.parseInt(request.getParameter("date"));
	
	// M
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	
	CashDao cashDao = new CashDao();
	ArrayList<HashMap<String, Object>> dateList = cashDao.selectCashListByDate(memberId, year, month, date);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>cashDateList</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/combine/npm/bootswatch@5.2.2/dist/sandstone/bootstrap.min.css,npm/bootswatch@5.2.2/dist/sandstone/bootstrap.min.css">
		<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <style>
			th{
				text-align: center;
			}
			
			#align_center{
				text-align: center;
			}
			table{
				border-radius: 8px;
				height: 300px;
				table-layout: fixed;
				word-break: break-all;
			}
		</style>
	</head>
	<body>
	<!-- header -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<div class="container-fluid">
				<div class="collapse navbar-collapse" id="navbarColor01">
					<ul class="navbar-nav me-auto">
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">Home</a>
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
							<a class="nav-link dropdown-toggle active" data-toggle="dropdown" href="#">My page</a>
							<span class="visually-hidden">(current)</span>
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
	<!-- 본문 시작 -->
	<div class="container">
		<a href="<%=request.getContextPath()%>/cash/cashList.jsp?year=<%=year%>&month=<%=month-1%>">back</a>
		<!-- cash 입력 폼 -->
		<form action="<%=request.getContextPath()%>/cash/insertCashAction.jsp" method="post">
			<!-- memberId와 날짜는 hidden 값으로 넘기기 -->
			<input type="hidden" name="memberId" value="<%=memberId%>">
			<input type="hidden" name="year" value="<%=year%>">
			<input type="hidden" name="month" value="<%=month%>">
			<input type="hidden" name="date" value="<%=date%>">
			
			<table class="table table-borderless w-50 mx-auto align-middle shadow-sm mt-3">
				<tr>
					<th colspan="2">
						<h4 class="mt-3"><strong><%=year%>년 <%=month%>월 <%=date%>일 가계부 입력</strong></h4>
					</th>
				</tr>
				<%
					String paramMsg = request.getParameter("msg");
					if(paramMsg != null){
				%>
						<tr>
							<th colspan="2" class="text-info">&#10069;<%=paramMsg%></th>
						</tr>
				<%
					}
				%>
				<tr>
					<th class="w-25">날짜</th>
					<td>
						<input type="text" name="cashDate" value="<%=year%>-<%=month%>-<%=date%>" readonly="readonly" class="form-control">
					</td>
				</tr>
				<!-- categoryName 출력 list로-->
				<tr>
					<th class="w-25">구분</th>
					<td>
						<select name="categoryNo" class="form-control">
						<%
							for(Category c : categoryList){
						%>
								<option value="<%=c.getCategoryNo()%>">
									[<%=c.getCategoryKind()%>]-<%=c.getCategoryName()%>
								</option>
						<%
							}
						%>
						</select>
					</td>
				</tr>
				<tr>
					<th class="w-25">금액</th>
					<td>
						<input type="number" name="cashPrice" class="form-control">
					</td>
				</tr>
				<tr>
					<th class="w-25">메모</th>
					<td>
						<textarea name="cashMemo" rows="3" cols="50" class="form-control"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit" class="btn btn-outline-primary float-end">추가</button>
					</td>
				</tr>
			</table>
		</form>
		<!-- cash 목록 출력 -->
		<table class="table table-borderless w-75 mx-auto align-middle shadow-sm mt-3">
			<tr>
				<th>구분</th>
				<th>항목</th>
				<th>금액</th>
				<th>메모</th>
				<th>수정일</th>
				<th>작성일</th>
				<th>수정</th>
			</tr>
			<%
				for(HashMap<String, Object> m : dateList){				
			%>
				<tr>
				<%
					String cateKind = (String)(m.get("categoryKind"));
					if(cateKind.equals("수입")){
					%>
							<td id="align_center"><span style="color: skyblue;">[<%=(String)(m.get("categoryKind"))%>]</span></td>
					<%
						} else {
					%>
							<td id="align_center"><span style="color: pink;">[<%=(String)(m.get("categoryKind"))%>]</span></td>
					<%
						}
					%>	
					<td id="align_center"><%=(String)m.get("categoryName")%></td>
					<td id="align_center"><%=(Long)m.get("cashPrice")%></td>
					<td><%=(String)m.get("cashMemo")%></td>
					<td id="align_center"><%=(String)m.get("updatedate")%></td>
					<td id="align_center"><%=(String)m.get("createdate")%></td>
					<td id="align_center">
						<a href="<%=request.getContextPath()%>/cash/updateCashForm.jsp?cashNo=<%=(Integer)m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>" class="btn btn-light">수정</a>
						<a href="<%=request.getContextPath()%>/cash/deleteCashAction.jsp?cashNo=<%=(Integer)m.get("cashNo")%>&year=<%=year%>&month=<%=month%>&date=<%=date%>" class="btn btn-light">삭제</a>
					</td>
				</tr>
			<%
				}
			%>
		</table>
	</div>
	</body>
</html>