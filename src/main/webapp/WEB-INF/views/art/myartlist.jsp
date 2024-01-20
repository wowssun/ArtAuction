<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>


<div class="main">
	<section class="module bg-dark-60 shop-page-header" data-background="/resources/live/assets/images/gallery.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">MY ART</h2>
					<div class="module-subtitle font-serif"></div>
				</div>
			</div>
		</div>
	</section>
	<hr class="divider-w">
	<section class="module">
		<div class="container">
			<div class="row multi-columns-row">
				<c:if test="${empty myartlist }">
					<div class="row">등록된 작품이 없습니다.</div>
				</c:if>
				<c:forEach items="${myartlist}" var="avo">
					<div class="col-sm-6 col-md-6 col-lg-6">
						<div class="gallery-item">
							<div class="gallery-image">
								<a class="move" href="${avo.ano}"> <img
									src="/artdisplay?fileName=/${avo.artImg}" alt="${avo.artName}"
									style="width: 940px; height: 567px; object-fit: cover;" />
									<div class="gallery-caption">
										<h2>${avo.artName}</h2>
										<h4>${avo.artist}</h4>
									</div>
								</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
	
	

	
		<div class="text-right">
		<a class="btn btn-secondary backBtn" onclick="history.back()"
			style="background-color: lightgray; color: #fff; margin-right:10px;">뒤로가기</a>
	</div>
	
	

	<!-- Paging-->
	<div class="pagination-container text-center">
		<ul class="pagination">
			<%-- 이전 버튼 --%>
			<c:if test="${pageDTO.prev }">
				<li class="page-item"><a href="${pageDTO.start - 1}"
					class="page-link">&laquo; Previous</a>
			</c:if>

			<%-- 페이지 번호 버튼 --%>
			<c:forEach begin="${pageDTO.start }" end="${pageDTO.end }" var="i">
				<%-- <c:url var="link" value=""/> --%>
				<li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : '' }">
					<a href="${i }" class="page-link">${i }</a>
			</c:forEach>

			<%-- 다음 버튼 --%>
			<c:if test="${pageDTO.next }">
				<li class="page-item"><a href="${pageDTO.end + 1}"
					class="page-link">Next &raquo;</a>
			</c:if>
		</ul>
	</div>
	
</div>




	<!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
	<form action="/art/myartlist" id="actionFrm">
		<input type="hidden" name="mid" value="${mid }"> <input
			type="hidden" name="type" value="${pageDTO.cri.type}"> <input
			type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
		<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
	</form>


<script>
	$(function() {

		// 페이징 이벤트 처리 ------------------------------
		var actionFrm = $('#actionFrm');

		$('.page-item a').on('click', function(e) {
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

    		var ano = $(this).attr('href'); // 클릭한 링크의 href 값을 가져옴

    		// auction/view 경로로 이동
    		window.location.href = '/art/view?ano=' + ano;
    	});

	});//END
</script>
<%@ include file="../includes/footer.jsp"%>