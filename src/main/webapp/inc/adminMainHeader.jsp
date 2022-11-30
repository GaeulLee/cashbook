<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container">
		<div class="container-fluid">
			<div class="collapse navbar-collapse" id="navbarColor01">
				<ul class="navbar-nav me-auto">
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/cash/cashList.jsp">Home</a>
						<span class="visually-hidden">(current)</span>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/noticeList.jsp">Notice</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/categoryList.jsp">Category</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/memberList.jsp">Member</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" href="<%=request.getContextPath()%>/admin/helpListAll.jsp">Help</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle active" data-toggle="dropdown" href="#">My page</a>
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