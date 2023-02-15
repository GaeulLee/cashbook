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
                 <a href="<%=request.getContextPath()%>/cash/cashList.jsp" aria-expanded="false">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-house-door" viewBox="0 0 16 16">
					 	<path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"/>
					</svg>
					<span class="nav-text">Home</span>
                 </a>
             </li>
             
             <li>
                 <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                     <i class="icon-graph menu-icon"></i>
					 <span class="nav-text">통계</span>
                 </a>
                 <ul aria-expanded="false">
                     <li><a href="<%=request.getContextPath()%>/stats/statsListByYear.jsp">년도별</a></li>
                     <li><a href="<%=request.getContextPath()%>/stats/statsListByMonth.jsp">월별</a></li>
                 </ul>
             </li>
             
             <li>
                 <a href="<%=request.getContextPath()%>/memberNoticeList.jsp" aria-expanded="false">
                    <i class="icon-notebook menu-icon"></i>
					<span class="nav-text">공지</span>					
                 </a>
             </li>
             
             <li>
                 <a href="<%=request.getContextPath()%>/help/helpList.jsp" aria-expanded="false">
                     <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-question-circle" viewBox="0 0 16 16">
					  	<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
					  	<path d="M5.255 5.786a.237.237 0 0 0 .241.247h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286zm1.557 5.763c0 .533.425.927 1.01.927.609 0 1.028-.394 1.028-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94z"/>
					 </svg>                     
					 <span class="nav-text"> 고객센터</span>
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
                     <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-lines-fill" viewBox="0 0 16 16">
					 	<path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm-5 6s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zM11 3.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm.5 2.5a.5.5 0 0 0 0 1h4a.5.5 0 0 0 0-1h-4zm2 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2zm0 3a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1h-2z"/>
					 </svg>
					 <span class="nav-text">My Page</span>
                 </a>
                 <ul aria-expanded="false">
                     <li><a href="<%=request.getContextPath()%>/member/memberOne.jsp">내 정보</a></li>
                     <li><a href="<%=request.getContextPath()%>/member/updateMemberForm.jsp">회원정보 수정</a></li>
                     <li><a href="<%=request.getContextPath()%>/member/updatePwForm.jsp">비밀번호 수정</a></li>
                     <li><a href="<%=request.getContextPath()%>/member/deleteMemberForm.jsp">회원탈퇴</a></li>
                     <li><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
                 </ul>
             </li>
         </ul>
     </div>
</div>
<!--Sidebar end-->