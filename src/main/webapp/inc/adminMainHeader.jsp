<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#id_font{
		color: white;
	    font-size: 20px;
	}
	
	#position{
		padding-top: 10px;
	}
	
	#logo{
		color: white;
		font-size:25px;
		font-weight:bold;
	}
</style>
<!--Nav header start-->
<div class="nav-header" style="background-color: #9097c4;">
     <div class="brand-logo">
         <a href="<%=request.getContextPath()%>/cash/cashList.jsp" style="color: white; font-size:25px;">
         	<b class="logo-abbr">G</b>
             
             <span class="brand-title" id="logo">GOODEE</span>
         </a>
     </div>
</div>
<!--Nav header end-->

<!--Header start-->
<div class="header" style="background-color: #9097c4;">    
     <div class="header-content clearfix">
         <!-- 헤더 아이콘 -->
         <div class="nav-control">
             <div class="hamburger">
                 <span class="toggle-icon"><i class="icon-menu"></i></span>
             </div>
         </div>
		 <!-- 헤더 내용 -->
         <div class="header-right">
             <ul class="clearfix">
             	<li class="icons dropdown">
             		<span id="id_font"><strong><%=request.getParameter("memberId")%></strong> 님</span>
             	</li>
                 <li class="icons dropdown">
                     <div class="user-img c-pointer position-relative" id="position"   data-toggle="dropdown">
                         <!-- 회원 이미지 -->
                         <svg xmlns="http://www.w3.org/2000/svg" height="40" width="40" fill="white" class="bi bi-person-circle" viewBox="0 0 16 16">
							<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
							<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
						</svg>
                     </div>
                     <!-- 드롭 다운 -->
                     <div class="drop-down dropdown-profile   dropdown-menu">
                         <div class="dropdown-content-body">
                             <ul>
                                 <li>
                                     <a href="<%=request.getContextPath()%>/member/memberOne.jsp"><i class="icon-user"></i> <span>내 정보</span></a>
                                 </li>
                                 <hr class="my-2">                                        
                                 <li><a href="<%=request.getContextPath()%>/logout.jsp"><i class="icon-key"></i> <span>로그아웃</span></a></li>
                             </ul>
                         </div>
                     </div>
                 </li>
             </ul>
         </div>
         <!-- 헤더 내용 끝 -->
     </div>
</div>
<!--Header end ti-comment-alt-->

<!--Sidebar start-->
<div class="nk-sidebar">           
     <div class="nk-nav-scroll">
         <ul class="metismenu" id="menu">
             <li>
                 <a href="<%=request.getContextPath()%>/admin/adminMain.jsp" aria-expanded="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
					 	<path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
					</svg>
					<span class="nav-text">Home</span>
                 </a>
             </li>
             
             <li>
                 <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                     <i class="icon-note menu-icon"></i><span class="nav-text">Manage</span>
                 </a>
                 <ul aria-expanded="false">
                     <li><a href="<%=request.getContextPath()%>/admin/noticeList.jsp">공지</a></li>
                     <li><a href="<%=request.getContextPath()%>/admin/categoryList.jsp">카테고리</a></li>
                     <li><a href="<%=request.getContextPath()%>/admin/memberList.jsp">회원</a></li>
                     <li><a href="<%=request.getContextPath()%>/admin/helpListAll.jsp">문의</a></li>
                 </ul>
             </li>
             
             <li class="nav-label">Member</li>
             <li>
                 <a href="<%=request.getContextPath()%>/cash/cashList.jsp" aria-expanded="false">
                     <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-lines-fill" viewBox="0 0 16 16">
					 	<path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z"/>
					 </svg>
					 <span class="nav-text">사용자 페이지</span>
                 </a>
             </li>
             
             <li>
                 <a href="<%=request.getContextPath()%>/logout.jsp" aria-expanded="false">
                     <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-power" viewBox="0 0 16 16">
					 	<path d="M7.5 1v7h1V1h-1z"/>
					 	<path d="M3 8.812a4.999 4.999 0 0 1 2.578-4.375l-.485-.874A6 6 0 1 0 11 3.616l-.501.865A5 5 0 1 1 3 8.812z"/>
					 </svg>
					 <span class="nav-text">로그아웃</span>
                 </a>
             </li>
             
         </ul>
     </div>
</div>
<!--Sidebar end-->