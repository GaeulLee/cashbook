<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.net.*"%>
<%
	// C
	/*
		1. 로그인 유효성 검사
		2. 파라메터 유효성 검사
		3. 데이터 묶기
		4. 모델 출력
	*/
	// 세션값을 받고 아이디 레벨 확인
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) { // 세션 정보가 없거나, 세션에 저장된 멤버 레벨이 1보다 작은 경우
		response.sendRedirect(request.getContextPath()+"/loginForm.jsp");
		return;
	}
	
	// 파라메터 유효성 검사
	if(request.getParameter("commentNo") == null){
		response.sendRedirect(request.getContextPath()+"/admin/helpListAll.jsp");
		return;
	}	
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	
	// 데이터 묶기
	Comment comment = new Comment();
	comment.setCommentNo(commentNo);
	
	// M
	CommentDao commentDao = new CommentDao();
	Comment oldComment = commentDao.selectCommentOne(comment);
	
	// V
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>updateCommentForm</title>
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
	<!-- header -->
	<jsp:include page="../../inc/adminMainHeader.jsp"></jsp:include>
	<!-- 본문 시작 -->
	<div class="container">
		<form action="<%=request.getContextPath()%>/admin/comment/updateCommentAction.jsp" method="post">
			<input type="hidden" name="commentNo" value="<%=oldComment.getCommentNo()%>">
			<table class="table table-borderless w-75 mx-auto align-middle shadow-sm mt-3">
				<tr>
					<th colspan="2">
						<h4 class="mt-3"><strong>답변 수정</strong></h4>
					</th>
				</tr>
				<%
					String msg = request.getParameter("msg");
					if(msg != null){
				%>
						<tr>
							<th class="text-info" colspan="2">&#10069;<%=msg%></th>
						</tr>	
				<%
					}
				%>
				<tr>
					<th>답변 내용</th>
					<td>
						<textarea name="commentMemo" rows="10" cols="50" placeholder="수정할 답변을 입력해주세요." class="form-control"><%=oldComment.getCommentMemo()%></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button type="submit" class="btn btn-outline-primary float-end">수정</button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	</body>
</html>