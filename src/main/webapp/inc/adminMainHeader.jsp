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
                     <i class="icon-menu menu-icon"></i><span class="nav-text">Home</span>
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