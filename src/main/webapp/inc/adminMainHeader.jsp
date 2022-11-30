<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--Nav header start-->
<div class="nav-header" style="background-color: #9097c4;">
     <div class="brand-logo">
         <a href="<%=request.getContextPath()%>/cash/cashList.jsp" style="color: white; font-size:25px;">
         	<b class="logo-abbr">G</b>
             
             <span class="brand-title" style="color: white; font-size:25px;">Goodee</span>
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
                         <img src="./Resources/images/user/1.png" height="40" width="40" alt="">
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
                     <i class="icon-notebook menu-icon"></i><span class="nav-text">사용자 페이지</span>
                 </a>
             </li>
             
             <li>
                 <a href="<%=request.getContextPath()%>/logout.jsp" aria-expanded="false">
                     <i class="icon-menu menu-icon"></i><span class="nav-text">로그아웃</span>
                 </a>
             </li>
             
         </ul>
     </div>
</div>
<!--Sidebar end-->