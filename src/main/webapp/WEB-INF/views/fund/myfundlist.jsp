<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<div class="main">
	<section class="module bg-dark-30 about-page-header" data-background="/resources/live/assets/images/fund.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">MY FUND LIST</h2>
				</div>
			</div>
		</div>
	</section>



	<!-- Section-->
	<section class="module">
		<div class="container">
						<c:if test="${empty myfundlist }">
						<div class="row text-center">
									등록된 펀딩이 없습니다.</div>
				</c:if>
			<div class="row text-right justify-content-end">

			
		<div class="row multi-columns-row post-columns" id="fundList">
			<c:forEach items="${myfundlist}" var="fvo">
					<div class="col-sm-6 col-md-3 col-lg-3">
						<div class="post">
							<div class="post-thumbnail">
								<%-- <a class="move" href="${fvo.fno }">  --%><img
									src="/display?fileName=/${fvo.atvo.photo }"
									alt="${fvo.mvo.name }" />
								<!-- </a> -->
							</div>
							<div class="post-header font-alt">
								<h2 class="post-title">
									${fvo.fundName}
								</h2>
								<div class="post-meta">${fvo.totalPrice}원펀딩중</div>
							</div>
							<div class="post-entry">
								<p>
									<fmt:formatDate value="${fvo.endDate }" type="date"
										pattern="yyyy-MM-dd (E)" />
									까지
								</p>
								<div id="remainingDays"></div>
							</div>
							<div class="post-more">
								<a class="move" href="${fvo.fno }">Read more</a>
							</div>
						</div>
					</div>
			</c:forEach>
			</div>

			<div class="text-right">
				<a class="btn btn-secondary backBtn" onclick="history.back()"
					style="background-color: lightgray; color: #fff;">뒤로가기</a>
			</div>

			<!-- Paging-->
			<div class="pagination-container text-center">
				<ul class="pagination">
					<%-- 이전 버튼 --%>
					<c:if test="${fpageDTO.prev }">
						<li class="page-item"><a href="${fpageDTO.start - 1}"
							class="page-link">&laquo; Pre</a>
					</c:if>

					<%-- 페이지 번호 버튼 --%>
					<c:forEach begin="${fpageDTO.start }" end="${fpageDTO.end }" var="i">
						<%-- <c:url var="link" value=""/> --%>
						<li class="page-item ${fpageDTO.cri.pageNum == i ? 'active' : '' }">
							<a href="${i }" class="page-link">${i }</a>
					</c:forEach>

					<%-- 다음 버튼 --%>
					<c:if test="${fpageDTO.next }">
						<li class="page-item"><a href="${fpageDTO.end + 1}"
							class="page-link">Next &raquo;</a>
					</c:if>
				</ul>
			</div>
			</div>
		</div>
	</section>



<!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
<form action="/fund/myfundlist" id="actionFrm">
<input type="hidden" name="mid" value="${mid }">
	<input type="hidden" name="type" value="${fpageDTO.cri.type}"> <input
		type="hidden" name="keyword" value="${fpageDTO.cri.keyword}"> <input
		type="hidden" name="pageNum" value="${fpageDTO.cri.pageNum}"> <input
		type="hidden" name="amount" value="${fpageDTO.cri.amount}">
</form>




<script>
$(function(){

	// 페이징 이벤트 처리 ------------------------------
	var actionFrm = $('#actionFrm');

	$('.page-item a').on('click', function(e){
		e.preventDefault();
		
		console.log('#mid');
		// a 태그의 href 값을 pageNum에 저장
		actionFrm.find("input[name='pageNum']").val($(this).attr('href'));
		
		
		// 로그 남기기
	    /* console.log('페이지 이동: ' + pageNum); */

		actionFrm.submit();
	});


	
	$('.move').on('click', function(e) {
		e.preventDefault();

		var fno = $(this).attr('href'); // 클릭한 링크의 href 값을 가져옴

		// auction/view 경로로 이동
		window.location.href = '/fund/view?fno=' + fno;
	});
	
	
});//END
</script>

<%@ include file="../includes/footer.jsp"%>

