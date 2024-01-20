<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/resources/live/assets/lib/jquery/dist/jquery.js"></script>
<script
	src="/resources/live/assets/lib/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="/resources/live/assets/lib/wow/dist/wow.js"></script>
<script
	src="/resources/live/assets/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
<script src="/resources/live/assets/lib/isotope/dist/isotope.pkgd.js"></script>
<script
	src="/resources/live/assets/lib/imagesloaded/imagesloaded.pkgd.js"></script>
<script src="/resources/live/assets/lib/flexslider/jquery.flexslider.js"></script>
<script
	src="/resources/live/assets/lib/owl.carousel/dist/owl.carousel.min.js"></script>
<script
	src="/resources/live/assets/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
<script
	src="/resources/live/assets/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
<script src="/resources/live/assets/js/plugins.js"></script>
<script src="/resources/live/assets/js/main.js"></script>

<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>


<!-- SweetAlert2 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<!--  
    Document Title
    =============================================
    -->
<title>Art Auction</title>
<style>
.footer {
	position: fixed;
	left: 0;
	bottom: 0;
	width: 100%;
	bottom: 0;
}
</style>

<!--  
    Favicons
    =============================================
    -->
<link rel="apple-touch-icon" sizes="57x57"
	href="/resources/live/assets/images/favicons/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60"
	href="/resources/live/assets/images/favicons/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72"
	href="/resources/live/assets/images/favicons/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76"
	href="/resources/live/assets/images/favicons/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114"
	href="/resources/live/assets/images/favicons/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120"
	href="/resources/live/assets/images/favicons/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144"
	href="/resources/live/assets/images/favicons/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152"
	href="/resources/live/assets/images/favicons/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180"
	href="/resources/live/assets/images/favicons/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"
	href="/resources/live/assets/images/favicons/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32"
	href="/resources/live/assets/images/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96"
	href="/resources/live/assets/images/favicons/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/live/assets/images/favicons/favicon-16x16.png">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage"
	content="/resources/live/assets/images/favicons/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">
<!--  
    Stylesheets
    =============================================
    
    -->
<!-- Default stylesheets-->
<link
	href="/resources/live/assets/lib/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Template specific stylesheets-->
<link
	href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Volkhov:400i"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800"
	rel="stylesheet">
<link href="/resources/live/assets/lib/animate.css/animate.css"
	rel="stylesheet">
<link
	href="/resources/live/assets/lib/components-font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link href="/resources/live/assets/lib/et-line-font/et-line-font.css"
	rel="stylesheet">
<link href="/resources/live/assets/lib/flexslider/flexslider.css"
	rel="stylesheet">
<link
	href="/resources/live/assets/lib/magnific-popup/dist/magnific-popup.css"
	rel="stylesheet">
<link
	href="/resources/live/assets/lib/simple-text-rotator/simpletextrotator.css"
	rel="stylesheet">
<!-- Main stylesheet and color file-->
<link href="/resources/live/assets/css/style.css" rel="stylesheet">
<link id="color-scheme"
	href="/resources/live/assets/css/colors/default.css" rel="stylesheet">
</head>
<body data-spy="scroll" data-target=".onpage-navigation"
	data-offset="60">
	<main>
		<div class="page-loader">
			<div class="loader">Loading...</div>
		</div>
		<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button class="navbar-toggle" type="button" data-toggle="collapse"
						data-target="#custom-collapse">
						<span class="sr-only">Toggle navigation</span><span
							class="icon-bar"></span><span class="icon-bar"></span><span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/artauction/main">HOME</a>
				</div>
				<div class="collapse navbar-collapse" id="custom-collapse">
					<ul class="nav navbar-nav navbar-left">
						<li class="dropdown"><a class="dropdown-toggle"
							href="/auction/auclist" data-toggle="dropdown">경매</a>
							<ul class="dropdown-menu">
								<li><a href="/auction/auclist">경매</a></li>
								<sec:authorize access="hasRole('ROLE_ARTIST')">
									<sec:authentication property="principal.username" var="loginId" />
									<li><a href="/auction/register?mid=${loginId}">경매등록</a></li>
								</sec:authorize>
							</ul></li>
						<li class="dropdown"><a class="dropdown-toggle"
							href="/art/list" data-toggle="dropdown">작품</a>
							<ul class="dropdown-menu">
								<li><a href="/art/list">작품</a></li>
								<sec:authorize access="hasRole('ROLE_ARTIST')">
									<sec:authentication property="principal.username" var="loginId" />
									<li><a href="/art/register">작품등록</a></li>
									<li><a href="/art/myartlist?mid=${loginId}">나의작품목록</a></li>
								</sec:authorize>
							</ul></li>
						<li class="dropdown"><a class="dropdown-toggle"
							href="/free/list" data-toggle="dropdown">게시판</a>
							<ul class="dropdown-menu">
								<li><a href="/free/list">자유게시판</a></li>
								<li><a href="/hongbo/list">전국 전시회 홍보 게시판</a></li>
								<li><a href="/news/list">문화 / 예술 뉴스 게시판</a></li>
							</ul></li>
						<li class="dropdown"><a class="dropdown-toggle"
							href="/fund/list" data-toggle="dropdown">작가지원</a>
							<ul class="dropdown-menu">
								<li><a href="/fund/list">신예작가지원</a></li>
								<sec:authorize access="hasAnyRole('ROLE_ARTIST', 'ROLE_USER')">
									<sec:authentication property="principal.username" var="mid" />
									<sec:authorize access="hasRole('ROLE_ARTIST')">
										<li><a href="/fund/register">펀딩등록</a></li>
										<li><a class="nav-link"
											href="/fund/myfundlist?mid=${mid}">나의펀딩목록</a></li>
									</sec:authorize>
									<li><a class="nav-link" href="/fund/mypaylist?mid=${mid}">나의펀딩결제내역</a></li>
								</sec:authorize>
							</ul></li>

						<li class="dropdown"><a class="dropdown-toggle"
							href="/class/classList" data-toggle="dropdown">원데이클래스</a>
							<ul class="dropdown-menu">
								<li><a href="/class/classList">원데이클래스</a></li>
							</ul></li>

						<sec:authorize access="isAuthenticated()">
							<li class="dropdown"><a class="dropdown-toggle" href="#"
								data-toggle="dropdown">고객문의</a>
								<ul class="dropdown-menu">
									<sec:authorize access="hasAnyRole('ROLE_ARTIST', 'ROLE_USER')">
										<li><a href="/inquiry/register">문의글 작성</a></li>
									</sec:authorize>
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<li><a href="/inquiry/inqlist">문의글 전체보기</a></li>
										<li><a href="/inquiry/answerlist">답변하기</a></li>
									</sec:authorize>
								</ul></li>
						</sec:authorize>
					</ul>

					<sec:authorize access="isAnonymous()">
						<ul class="nav navbar-right">
							<li><a href="/artauction/userJoin">회원가입</a></li>
						</ul>
						<ul class="nav navbar-right">
							<li><a href="/artauction/userLogin">로그인</a></li>

						</ul>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.mvo.auth.auth" var="auth" />

						<c:if test="${auth eq 'ROLE_ARTIST' || auth eq 'ROLE_USER'}">
							<form action="/user/mypage" id="mypageform">
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }" />
							</form>

							<ul class="nav navbar-right">
								<li class="dropdown"><a href="" data-toggle="dropdown"
									onclick="document.getElementById('mypageform').submit();">마이페이지</a></li>
							</ul>
						</c:if>

						<c:if test="${auth eq 'ROLE_ADMIN' }">
							<form action="/admin/adminPage" id="adminpageform">
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }" />
							</form>
							<ul class="nav navbar-right">
								<li class="dropdown"><a href="#" data-toggle="dropdown"
									onclick="document.getElementById('adminpageform').submit();">관리자페이지</a></li>
							</ul>
						</c:if>

						<form action="/userLogout" method='post' id="logoutform">
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token }" />
						</form>
						<ul class="nav navbar-right">
							<li class="dropdown"><a href="#" data-toggle="dropdown"
								onclick="document.getElementById('logoutform').submit();">로그아웃</a></li>
						</ul>
					</sec:authorize>

				</div>
			</div>
		</nav>