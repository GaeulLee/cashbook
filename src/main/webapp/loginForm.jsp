<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.NoticeDao"%>
<%@ page import="java.util.*"%>
<%@ page import="vo.Notice"%>
<%
	/*
	1. 로그인 유효성 검사 -> 로그인이 되어있으면 가계부로 가게
	2. 페이징(cnt는 메서드로)
	3. 공지 출력
	*/

	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}

	// paging
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	final int ROW_PER_PAGE = 5; // 한 페이지 당 보여줄 게시글(행) 수
	int beginRow = (currentPage-1)*ROW_PER_PAGE; // 쿼리에 작성할 게시글(행) 시작 값
	final int PAGE_COUNT = 10; // 한 페이지 당 보여줄 페이징 목록 수
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1; // 페이징 목록 시작 값
	int endPage = beginPage+PAGE_COUNT-1; // 페이징 목록 끝 값
	
	NoticeDao noticeDao = new NoticeDao();
	int cnt = noticeDao.selectNoticeCount(); // 전체 행 구하기
	int lastPage = cnt/ROW_PER_PAGE; // 마지막 페이지
	if(lastPage%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){ // 페이지 목록이 lastPage까지만 보이도록
		endPage = lastPage;
	}
	
	ArrayList<Notice> list = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE); // 공지 출력

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>loginForm</title>
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
			}
		</style>
	</head>
	<body>
	<div class="container">
		<!-- 공지(5개)목록 페이징 (상세보기 없음 타이틀만 보이게, 댓글 기능) -->
		<div class="mt-2">
			<table class="table">
				<tr class="table-light">
					<th>공지내용</th>
					<th>날짜</th>
				</tr>
				<%
					for(Notice n : list){
				%>
						<tr>
							<td class="w-75"><%=n.getNoticeMemo()%></td>
							<td id="align_center">
								<%
									String createdate = n.getCreatedate();
									createdate = createdate.substring(0,10);
								%>
								<%=createdate%>
							</td>
						</tr>
				<%
					}
				%>
			</table>
			<!-- paging -->
			<div>
				<ul class="pagination justify-content-center">				
					<li class="page-item">
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=1" class="page-link">처음</a>
					</li>
					<%
						if(currentPage > 1){
					%>
							<li class="page-item">
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
							</li>
					<%
						}
						for(int i=beginPage; i<=endPage; i++){
							if(currentPage == i){
							%>
								<li class="page-item active">
									<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
								</li>
							<%		
							}else{
							%>
								<li class="page-item">
									<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
								</li>
							<%	
							}
						}
						if(currentPage < lastPage){
					%>
							<li class="page-item">
								<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
							</li>
					<%
						}
					%>
					<li class="page-item">
						<a href="<%=request.getContextPath()%>/loginForm.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
					</li>
				</ul>
			</div>
		</div>
		<!-- 회원 로그인 폼 -->
		<form action="<%=request.getContextPath()%>/loginAction.jsp" method="post" class="w-50 mx-auto">
			<table class="table table-borderless w-75 mx-auto align-middle shadow p-4 mb-4 bg-light">
				<tr>
					<th>
						<h4 class="mt-3"><strong>로그인</strong></h4>
					</th>
				</tr>
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
				%>
						<tr>
							<th class="text-info">&#10069;<%=msg%></th>
						</tr>	
				<%
					}
				%>
				<tr>
					<td>
						<div class="form-floating mb-2 mt-2">
							<input type="text" name="memberId" id="memberId" class="form-control" placeholder="Enter ID">
							<label for="memberId">Enter ID</label>
						</div>
					</td>
				</tr>			
				<tr>
					<td>
						<div class="form-floating mb-2 mt-2">
							<input type="password" name="memberPw" id="memberPw" class="form-control" placeholder="Enter Password">
							<label for="memberPw">Enter Password</label>
						</div>
					</td>
				</tr>
				<tr>
					<th>
						<a href="<%=request.getContextPath()%>/member/insertMemberForm.jsp" class="btn btn-outline-primary float-start">회원가입</a>
						<button type="submit" class="btn btn-outline-primary float-end">로그인</button>
					</th>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>