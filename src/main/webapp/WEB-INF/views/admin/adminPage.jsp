<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>관리자 페이지</title>
<style>
/* The side navigation menu */
.sidenav {
  height: 950px; /* 100% Full-height */
  width:200px; /* 0 width - change this with JavaScript */
  position: relative; /* Stay in place */
  z-index: 1; /* Stay on top */
  top: 0; /* Stay at the top */
  left: 0;
  background-color: #111; /* Black*/
  overflow-x: hidden; /* Disable horizontal scroll */
  padding-top: 60px; /* Place content 60px from the top */
  transition: 0.5s; /* 0.5 second transition effect to slide in the sidenav */
  text-align: center;
}

/* The navigation menu links */
.sidenav a {
  
  padding: 8px 8px 8px 32px;
  text-decoration: none;
  font-size: 18px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

/* When you mouse over the navigation links, change their color */
.sidenav a:hover {
  color: #f1f1f1;
}

/* Style page content - use this if you want to push the page content to the right when you open the side navigation */
/* Style page content */
#main {
  position: absolute;
  left: 500px; /* Width of the sidenav */
  top: 40%;
  transform: translate(0, -50%);
  padding: 10px;
  transition: 0.5s;
}

/* Extend sidenav to footer */
.sidenav.extended {
  height: 100%;
  overflow-y: auto;
}

img { width: 100px;  }

.a-here { position : absolute; top: 800px;}

.admin-name { color: white; font-size: 20px; font-weight: bold;}			

.title { font-size: 25px; font-weight: bold;  padding: 20px 0px;}

.price-table { height: 500px;}



.price-details a { display: block; color: black; text-decoration: none; padding:20px 0px; font-size: 17px; }

.price-details a:hover { background: rgb(242, 243, 244); color: black; }

.num1 { position: absolute; left: 700px; margin-right: 10px;}

</style>

	<%@ include file="../includes/header.jsp" %>
	

<div id="mySidenav" class="sidenav">
	<img class="img-fluid rounded-circle mb-4" src="/resources/img/myicon/admin1.png" alt="..." />
	<div class="admin-name">
		관리자
	</div>
	<div class="a-here">
	<form action="/artauction/pwChange" id="pwch" >
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
        <input type="hidden" name="mid" value="<sec:authentication property='principal.mvo.mid'/>">
	</form>
	<a href="#" onclick="document.getElementById('pwch').submit();">비밀번호 변경</a>
	   
   <form action="/userLogout" method='post' id="logoutform">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }" />
	 </form>			
	 <a href="#" onclick="document.getElementById('logoutform').submit();">로그아웃</a>
  </div>
</div>



<!-- Add all page content inside this div if you want the side nav to push page content to the right (not used if you only want the sidenav to sit on top of the page -->
	<div id="main">
	
	
	
	
	<section class="module" style="padding-top: 300px; padding-bottom: 20px;">      
          <div class="container">
          
          <div class="col-sm-8 col-sm-offset-2" style="margin-left: 10px; margin-bottom: 50px;">
                <h4 class="font-alt mb-0">회원 현황</h4>
                <hr class="divider-w mt-10 mb-20">
                <h6 class="font-alt"><span class="icon-tools-2"></span> 일반
                </h6>
                <div class="progress">
                  <div class="progress-bar pb-dark" aria-valuenow="${ucount }" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${ucount }%;"><span class="font-alt num1" style="opacity: 1; width: 39px;">${ucount }</span></div>
                </div>
                <h6 class="font-alt"><span class="icon-strategy"></span> 작가
                </h6>
                <div class="progress">
                  <div class="progress-bar pb-dark" aria-valuenow="${acount }" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${acount }%;"><span class="font-alt num1" style="opacity: 1; width: 39px;">${acount }</span></div>
                </div>
                <h6 class="font-alt"><span class="icon-target"></span> 계정중지
                </h6>
                <div class="progress">
                  <div class="progress-bar pb-dark" aria-valuenow="${lcount }" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${lcount }%;"><span class="font-alt num1" style="opacity: 1; width: 39px;">${lcount }</span></div>
                </div>
                <h6 class="font-alt"><span class="icon-camera"></span> 작가신청
                </h6>
                <div class="progress">
                  <div class="progress-bar pb-dark" aria-valuenow="${rcount }" role="progressbar" aria-valuemin="0" aria-valuemax="100" style="width: ${rcount }%;"><span class="font-alt num1" style="opacity: 1; width: 39px;">${rcount }</span></div>
                </div>
              </div>
          
          <hr>
          
            <div class="row multi-columns-row" style="margin-top: 100px;">
              <div class="col-sm-6 col-md-4 col-lg-4">
                <div class="price-table font-alt" style="margin-top: 0px;"> 
                  <h4 class="title">일반 회원 관리</h4>
                  <div class="borderline"></div>
                  <ul class="price-details">
                    <li><a href="/admin/userList">일반 회원 목록</a></li>
                    <li><a href="/admin/userLockList">계정 중지 회원 목록</a></li>
                    <li></li>
                  </ul>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4">
                <div class="price-table font-alt best">
                  <h4 class="title">작가 회원 관리</h4>
                  <div class="borderline"></div>
                  <ul class="price-details">
                    <li><a href="/admin/artistList">작가 회원 목록</a></li>
                    <li><a href="/admin/rqList">작가 신청 목록</a></li>
                    <li><a href="/admin/checkList">작가 회원 승인 / 거절 목록</a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>
		
	</div>

<%@ include file="../includes/footer.jsp" %>