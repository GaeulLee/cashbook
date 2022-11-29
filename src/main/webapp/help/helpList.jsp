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
			  font-weight: bold;
			  font-size: 1.1em;
			}
		</style>
	</head>
	<body>
	<!-- header -->
	<%	
		String targetPage = "../inc/header.jsp";
		if(loginMember.getMemberLevel() > 0){
			targetPage = "../inc/adminHeader.jsp";
		}
	%>
	<jsp:include page="<%=targetPage%>"></jsp:include>
	<!-- 본문 시작 -->
	<div class="container">
		<div class="w-75 mt-4 mb-4 mx-auto h3" id="align_center">
			<strong>내 문의 내역</strong>
			<span>
				<a href="<%=request.getContextPath()%>/help/insertHelpForm.jsp" class="btn btn-outline-primary float-end">문의하기</a>
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
									<a href="<%=request.getContextPath()%>/help/updateHelpForm.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-light">수정</a>
									<a href="<%=request.getContextPath()%>/help/deleteHelpAction.jsp?helpNo=<%=m.get("helpNo")%>" class="btn btn-light">삭제</a>
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
	</body>
</html>