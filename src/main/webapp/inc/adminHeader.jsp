<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--Nav header start-->
<div class="nav-header" style="background-color: #9097c4;">
     <div class="brand-logo">
         <a href="<%=request.getContextPath()%>/cash/cashList.jsp" style="color: white; font-size:25px;">
         	<b class="logo-abbr">G</b>
             
             <span class="brand-title" style="color: white; font-size:25px; font-weight:bold;">GOODEE</span>
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
                    <div class="user-img c-pointer position-relative"   data-toggle="dropdown">
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
                                     <a href="app-profile.html"><i class="icon-user"></i> <span>My page</span></a>
                                 </li>
                                 <hr class="my-2">                                        
                                 <li><a href="page-login.html"><i class="icon-key"></i> <span>Logout</span></a></li>
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
             <li class="nav-label">Home</li>
             <li>
                 <a href="<%=request.getContextPath()%>/cash/cashList.jsp" aria-expanded="false">
                     <i class="icon-notebook menu-icon"></i><span class="nav-text">가계부</span>
                 </a>
             </li>
             <li>
                 <a href="<%=request.getContextPath()%>/help/helpList.jsp" aria-expanded="false">
                     <i class="icon-screen-tablet menu-icon"></i><span class="nav-text">고객센터</span>
                 </a>
             </li>
             <li>
                 <a href="<%=request.getContextPath()%>/admin/adminMain.jsp" aria-expanded="false">
                     <i class="icon-note menu-icon"></i><span class="nav-text">관리자</span>
                 </a>
             </li>
             
             <li class="nav-label">Member</li>
             <li>
                 <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                     <i class="icon-grid menu-icon"></i><span class="nav-text">My Page</span>
                 </a>
                 <ul aria-expanded="false">
                     <li><a href="<%=request.getContextPath()%>/member/memberOne.jsp">내 정보</a></li>
                     <li><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
                 </ul>
             </li>
         </ul>
     </div>
</div>
<!--Sidebar end-->