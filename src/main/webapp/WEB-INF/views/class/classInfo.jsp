<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="../includes/header.jsp"%>


<style>

#closeReqBtn{visibility: hidden;}
#finBtn{visibility: hidden;}


</style>

 <section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/d.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                <h5 class="font-serif">OneDay Class</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">원데이 클래스 상세</h2>
              </div>
            </div>
          </div>
        </section>

<br>
<div class="container">
	<div class="row">
	<div>
<!-- 		<button type="button" id="backBtn" class="backBtn">◀ 목록으로 돌아가기</button> -->
		<button type="button" id="backBtn" class="backBtn" onclick="history.back()">◀ 목록으로 돌아가기</button>
		

		<sec:authorize access="hasRole('ADMIN') or hasRole('ARTIST')">
			<sec:authentication property="principal" var="p" />
			<button data-oper="classReqList" type="button" id="reqList">클래스 신청자 목록 ▶</button>
		</sec:authorize>
	</div>
	<br>		
		<div>
			<div class="col-sm-4 mb-sm-20">
				<img class="image" src="/cDisplay?filename=/${view.classimg}"
					 alt="${view.classimg}" style="width:300px">
			</div>
			<div class="col-sm-5">
				<div class="row" style="align-content: ">
					<div class="col-sm-12">
						<h1 class="product-title font-alt">${view.classname }</h1>
					</div>
				</div>
				<div class="writer">${view.mid } 작가</div>
				<div class="runtime">러닝 타임: ${view.runningtime} 분</div>
				<div class="people">모집 인원: ${view.peoplenum } 명</div>
				<div class="classDate">진행 날짜: ${view.classdate }</div>
				<div class="classDate">시작 시간: ${view.classtime }</div>
				<br>
				<div class="peopleNum">현재 신청 인원 수: ${view.reqcnt }</div>


				<!-- 	<button type="button" id="backBtn">클래스 마감</button> -->
				<!-- 버튼 말고 안눌리는걸로 바꾸기 -->
				<form action="/class/classMod" id="classFrm">

					<sec:authorize access="!isAuthenticated()">
						<div style="color: red;">클래스 신청을 위해 로그인을 해주세요.</div>
					</sec:authorize>

					<sec:authorize access="hasRole('USER')">
						<sec:authentication property="principal" var="p" />
						<c:set var="loggedInUsername" value="${p.mvo.mid}" />
						<c:if test="${p.username == loggedInUsername}">
							<div id="closeReqBtn">
								<c:if test="${view.reqcnt >= view.peoplenum}">
									<button id="closeBtn" style="background: lightgray; color: red"
										disabled>클래스가 마감되었습니다.</button>
								</c:if>
								<c:if test="${view.reqcnt < view.peoplenum}">
									<button data-oper="classReq" id="reqBtn"
										formaction="/class/classReq">클래스 신청하기</button>
								</c:if>
							</div>
							<button id="finBtn" style="background: lightgray;" disabled>해당 클래스 신청을 완료하였습니다.</button>
						</c:if>
					</sec:authorize>

					<%-- 					${p.username } --%>
					<input type="hidden" name="mid" value="${p.username}" />
					
<%-- 				<input type="hidden" name="mid" value="<sec:authentication property='principal.mvo.mid'/>"> --%>
					<input type="hidden" name="cno" value="${view.cno }">
					<div>
						<sec:authorize access="hasRole('ADMIN') or hasRole('ARTIST')">
							<sec:authentication property="principal" var="p" />
							<c:if test="${p.username == view.mid }">
								<button data-oper="classMod" id="modBtn" class="modBtn">클래스 수정</button>
								<button data-oper="classRem" class="classRem" style="color: red"
										formaction="/class/classRem">클래스 삭제</button>
							</c:if>
						</sec:authorize>

					</div>
					<input type="hidden" name="${_csrf.parameterName }"
						value="${_csrf.token }">
				</form>

			</div>
			
		</div>
		
	</div>
<hr>
	<div class="row">
		<label>클래스 소개</label>
		<div>${view.classinfo }</div>
		<div>
			<img class="image2" src="/cDisplay?filename=/${view.classimg}"
				alt="${view.classimg}">
		</div>
	</div>

</div>
<hr>

<!-- 리뷰 ------------------>
<!-- <div> -->
<!-- 	<div class="review"> -->
<!-- 		리뷰 -->
<%-- 		<sec:authorize access="isAuthenticated()"> --%>
			<!-- 버튼을 로그인시에만 보이게함 -->
<!-- 			<button id="modiBtn" class="btn btn-primary btn-xs pull-right">리뷰 작성</button> -->
<%-- 		</sec:authorize> --%>
<!-- 	</div> -->
	<!-- review list -->
<!-- 	<div class=""> -->
<!-- 		<ul class="review"> -->

<!-- 		</ul> -->
<!-- 	</div> -->
	<!-- review list End -->
<!-- </div> -->
<!-- End 리뷰 ------------------------->
<script>
	var cnoVal = '${view.cno}'; //el구문
	var reviewUL = $('.review'); //jquery로 객체 찾아오는 것

// //리뷰 목록------------------------------------
// // 	makeList(1); //댓글 목록을 무조건 1로 호출

// 	//리뷰 목록 출력 ----------------------------------
// 	function makeList(pageNum) {
// 		rvService.list({cno : cnoVal}, function(/* reviewCnt, */ result) {

// 			//댓글이 없는 경우 ul 비우기
// 			if (result == null || result.length == 0) {
// 					reviewUL.html('');
// 					return;
// 			}

// 			//댓글 목록 li 작성
// 			var liTag = '';
// 			for (var i = 0; i < result.length; i++) {
// 			liTag += '<li class="left clearfix" data-rno="' + result[i].rno + '">'
// 					 + '<div>'
// 					 + '<div class="header">'
// 					 + '<strong class="primary-font">'
// 				     + result[i].mid
// 			         + '</strong>'
// 					 + '<small class="pull-right text-muted">'
// 					 + rvService.display(result[i].uploaddate)
// 					 + '</small></div>'
// 					 + '<p>'
// 				     + result[i].reviewscript
// 					 + '</p>'
// 				     + '</div>' + '</li>';
// 			}
// 			reviewUL.html(liTag);//ul에 li 붙이기
// 		});
// 	}
// 	//END 리뷰 목록 출력 -----------------------------

	//버튼 전환-----------------------

	(function(){
		
//	var midval = "${p.username}"; //이걸로 못받아서 아래에서 주소로 바로 넘김
	$.ajax({
			type : 'get', //get | post
			url : '/class/reqChk/'+ cnoVal + "/${p.username}", // + midVal, //전송할 곳 - replyContoller로 넘어감
			success : function(result, status, xhr) {
					 $('#finBtn').css('visibility', 'visible');
				
			}, //성공시
			error : function(xhr, status, er) {
				 $('#closeReqBtn').css('visibility', 'visible');
			} //에러시
		}); //END ajax;

	})();

	//END 버튼 전환-----------------------

	//beforeSend 대신 csrf 토큰 헤더 추가
	var csrfHeaderName = '${_csrf.headerName }';
	var csrfTokenValue = '${_csrf.token }';

	//ajax를 할때마다 모든 csrf 헤더를 보내줌
	$(document).ajaxSend(function(e, xhr, options) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

	});

	//END beforeSend 대신 csrf 토큰 헤더 추가

	//클래스 신청--------------------x
	$('button[data-oper="classReq"]').on('click', function(event) {
		var classFrm = $('#classFrm');

		event.preventDefault(); // 일단 기존버튼 막기()
		if (confirm('해당 클래스를 신청하시겠습니까?')) {
			classFrm.attr('action', '/class/classReq'); // 해당 form의 action 속성 설정
			classFrm.attr('method', 'post'); // 해당 form의 method 속성 설정
			classFrm.submit();
		}

	});

	//END 클래스 신청--------------------

	//클래스 삭제--------------------
	$('button[data-oper="classRem"]').on('click', function(event) {
		var classFrm = $('#classFrm');

		event.preventDefault(); // 일단 기존버튼 막기()
		if (confirm('정말로 삭제하시겠습니까?')) {
			classFrm.attr('action', '/class/classRem'); // 해당 form의 action 속성 설정
			classFrm.attr('method', 'post'); // 해당 for                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               m의 method 속성 설정
			classFrm.submit();
		}

	});

	//END 클래스 삭제--------------------

	//로그인으로 이동--------------x
	function moveToLogin() {
		alert("로그인 후 이용가능합니다.");
		window.location.href = "/userLogin"; // 로그인 페이지 URL로 리디렉션
	}

	//END 로그인으로 이동--------------

	//클래스 신청자 리스트 클릭 이벤트--------x
	$('#reqList').on('click', function(event) {
		event.preventDefault(); // 일단 기존버튼 막기()
		var classFrm = $('#classFrm');
		var cno = $(this).closest('form').find('input[name="cno"]').val();

		classFrm.attr('action', '/class/classReqList');
		// cno 값을 hidden input으로 추가하여 전달
		// 		classFrm.append('<input type="hidden" name="cno" value="' + cno + '">');

		classFrm.submit();
	});
	//END 클래스 신청자 리스트 클릭 이벤트--------

	//클래스 수정 클릭 이벤트--------x
	$('.modBtn').on('click', function(event) {
		event.preventDefault(); // 일단 기존버튼 막기()
		var classFrm = $('#classFrm');
		var cno = $(this).closest('form').find('input[name="cno"]').val();

		// cno 값을 hidden input으로 추가하여 전달
		// 		classFrm.append('<input type="hidden" name="cno" value="' + cno + '">'); //안되면 이거 풀고 넘겨보기

		classFrm.submit();
	});
	//END 클래스 수정 클릭 이벤트--------

	// 목록으로 돌아가기 버튼 클릭 이벤트 처리
	// 		$('#backBtn').on('click', function() {
	// 			self.location = "/class/classList";
	// 		});

	//END 목록으로 돌아가기  버튼 클릭 이벤트 처리
</script>

<%@ include file="../includes/footer.jsp"%>