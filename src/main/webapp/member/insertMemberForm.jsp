<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 로그인 유효성 검사(로그인이 되어있으면 회원가입을 할 수 없게)
	if(session.getAttribute("loginMember") != null){
		response.sendRedirect(request.getContextPath()+"/cash/cashList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>insertMemberForm</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/combine/npm/bootswatch@5.2.2/dist/sandstone/bootstrap.min.css,npm/bootswatch@5.2.2/dist/sandstone/bootstrap.min.css">
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
			
			#verticalMiddle{
			    position: absolute;
			    top: 45%;
			    left: 50%;
			    transform: translate(-50%, -50%);
			}
		</style>
	</head>
	<body>
	<div class="container">
		<form action="<%=request.getContextPath()%>/member/insertMemberAction.jsp" method="post" class="w-50 mx-auto" id="verticalMiddle">
			<table class="table table-borderless w-50 mx-auto align-middle shadow p-4 mb-4 bg-light">
				<tr>
					<th>
						<h4 class="mt-3"><strong>회원가입</strong></h4>
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
						<div class="form-floating mb-1 mt-2">
							<input type="text" name="memberId" id="memberId" class="form-control" placeholder="Enter ID">
							<label for="memberId">Enter ID</label>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-floating mb-1 mt-1">
							<input type="password" name="memberPw" id="memberPw" class="form-control" placeholder="Enter Password">
							<label for="memberPw">Enter Password</label>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="form-floating mb-2 mt-1">
							<input type="text" name="memberName" id="memberName" class="form-control" placeholder="Enter Name">
							<label for="memberName">Enter Name</label>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<a href="<%=request.getContextPath()%>/loginForm.jsp" class="btn btn-outline-primary float-start">back</a>
						<button type="submit" class="btn btn-outline-primary float-end">가입</button>
					</td>
				</tr>
			</table>
		</form>	
	</div>
	</body>
</html>