<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사 + 레벨 확인
		2. 페이징
		3. 모델 출력(모든 문의 글)
	*/
	// 세션값 받고 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"loginForm.jsp");
		return;
	}

	// 페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	HelpDao helpDao = new HelpDao();
	int cnt = helpDao.selectHelpCount();
	final int ROW_PER_PAGE = 15;
	int beginRow = (currentPage-1)*ROW_PER_PAGE;
	final int PAGE_COUNT = 10;
	int beginPage = (currentPage-1)/PAGE_COUNT*PAGE_COUNT+1;
	int endPage = beginPage*PAGE_COUNT;
	int lastPage = cnt/ROW_PER_PAGE;
	
	if(cnt%ROW_PER_PAGE != 0){
		lastPage++;
	}
	if(endPage > lastPage){
		endPage = lastPage;
	}
	

	// M
	ArrayList<HashMap<String, Object>> helpList = helpDao.selectHelpList(beginRow, ROW_PER_PAGE);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>helpList</title>
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
			
			details {
				background: #f0f0f0;
				padding: 20px;
				border-radius: 8px;
			 
			}
			
			summary {
				cursor: pointer; 
			}
			
			#question{
				font-weight: bold;
			  	font-size: 1.1em;
			}
			
		</style>
	</head>
	<body>
	<!-- header -->
	<jsp:include page="../inc/adminMainHeader.jsp"></jsp:include>
	<!-- 본문 시작 -->
	<div class="container">
		<!-- 문의글 출력 -->
		<div class="w-75 mx-auto">
		<%			
			for(HashMap<String, Object> m : helpList){ // helpList를 반복해서 출력
				// 받아온 날짜를 년, 월, 일, 시, 분 까지만 나오게 문자열 자르기
				String helpCreatedate = (String)m.get("helpCreatedate");
				helpCreatedate = helpCreatedate.substring(0,16);
				String commentCreatedate = (String)m.get("commentCreatedate"); // commentCreatedate에 값이 없으면 null로 들어옴
				if(m.get("commentCreatedate") != null){ // commentCreatedate이 null이 아닐 경우에만 문자열 자르기 
					commentCreatedate = commentCreatedate.substring(0,16);
				}	
		%>
				<!-- 조건에 맞게 문의글 출력 -->
				<details class="mb-2">
					<!-- 질문 -->
					<summary>
						<span id="question"><%=m.get("helpMemo")%></span>
						<span class="float-end"><strong><%=helpCreatedate%></strong></span>
						<span class="float-end">작성자ID: <%=m.get("memberId")%>&nbsp;</span>
					</summary> 
					<!-- 답변 -->
					<%
						if(m.get("commentMemo") == null){
					%>
							<div class="mt-4">
								<span>답변 전입니다.</span>
								<span class="float-end">
									<a href="<%=request.getContextPath()%>/help/insertComment.jsp?helpNo=<%=m.get("helpNo")%>">답변하기</a>
									
								</span>
							</div>
					<%
						}else{	
					%>
							<div class="mt-4">
								<span><%=m.get("commentMemo")%></span>
								<span class="float-end">
									<a href="<%=request.getContextPath()%>/help/updateCommentForm.jsp?commentNo=<%=m.get("commentNo")%>">수정</a>
									<a href="<%=request.getContextPath()%>/help/deleteCommentAction.jsp?commentNo=<%=m.get("commentNo")%>">삭제</a>
								</span>
							</div>
					<%
						}
					%>
				</details>
		<%
			}
		%>
		</div>
		<!-- paging -->
		<div>
			<ul class="pagination justify-content-center">				
				<li class="page-item">
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=1" class="page-link">처음</a>
				</li>
				<%
					if(currentPage > 1){
				%>
						<li class="page-item">
							<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage-1%>" class="page-link">이전</a>
						</li>
				<%
					}
					for(int i=beginPage; i<=endPage; i++){
						if(currentPage == i){
						%>
							<li class="page-item active">
								<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
							</li>
						<%		
						}else{
						%>
							<li class="page-item">
								<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=i%>" class="page-link"><%=i%></a>
							</li>
						<%	
						}
					}
					if(currentPage < lastPage){
				%>
						<li class="page-item">
							<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=currentPage+1%>" class="page-link">다음</a>
						</li>
				<%
					}
				%>
				<li class="page-item">
					<a href="<%=request.getContextPath()%>/admin/helpListAll.jsp?currentPage=<%=lastPage%>" class="page-link">마지막</a>	
				</li>
			</ul>
		</div>
	</div>
	</body>
</html>