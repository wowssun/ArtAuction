<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>
.pagination-container {
    text-align: center;
/*     margin-top: 20px; /* Pagination과 다른 요소 사이의 간격 조절 (선택적) */ */
    position: fixed;
    bottom: 0;
    width: 100%;
/*     background-color: #f8f9fa; /* 배경색 설정 (선택적) */
    padding: 10px 0; /* Pagination 내부 여백 설정 (선택적) */
    z-index: 999; /* 다른 요소 위에 표시되도록 설정 (선택적) */ */
}
</style>

<!--  -->
<div class="main">
	<section class="module bg-dark-60 portfolio-page-header"
		data-background="">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">Art Gallery</h2>
					<div class="module-subtitle font-serif">A wonderful serenity
						has taken possession of my entire soul, like these sweet mornings
						of spring which I enjoy with my whole heart.</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 검색 -->
	<section class="module-small text-center">
		<div class="container">
			<form class="row" action="/auction/auclist" id="searchFrm">
			
						<!-- 게시물이 없는 경우 -->
			<c:if test="${empty list }">
				<div class="row">등록된 게시물이 없습니다.</div>
			</c:if>
			
				<div class="col-sm-2 mb-sm-20">
					<select class="form-control" name="type">
						<c:set var="type" value="${pageDTO.cri.type}" />
					<option value="N" ${type == 'N' ? 'selected' : '' }>작품명</option>
					<option value="T" ${type == 'T' ? 'selected' : '' }>작가명</option>
					</select>
				</div>
				<div class="col-sm-2 mb-sm-20">
					<input type="text" class="form-control" name="keyword" value="${pageDTO.cri.keyword}">
				</div>
				<div class="col-sm-2">
					<input type="submit" id="search"
					class="btn btn-outline-dark searchBtn" value="검색">
				</div>
				<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
			</form>
		</div>
	</section>


<section class="module" style="padding:50px 0 50px 0;">
		<div class="container">
			<div class="row multi-columns-row">
				<c:forEach items="${list}" var="avo">
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
	<div class="pagination-container text-center" style="padding-bottom:30px;">
		<ul class="pagination">
			<%-- 이전 버튼 --%>
			<c:if test="${pageDTO.prev }">
				<li class="page-item"><a href="${pageDTO.start - 1}"
					class="page-link">&laquo; Pre</a>
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
	

	

	<!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
	<form action="/art/list" id="actionFrm">
		<input type="hidden" name="type" value="${pageDTO.cri.type}">
		<input type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
		<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
	</form>



	<script>
		$(function() {
			//검색 버튼 이벤트 처리 ---------------------------
			var searchFrm = $('#searchFrm')

			$('.searchBtn').on('click', function(e) {
				e.preventDefault();
				//검색 키워드를 입력하지 않은 경우
				if (searchFrm.find("input[name='keyword']").val() == '') {
					alert('검색 키워드를 입력해 주세요.');
					return false;
				}

				//검색 시 페이지 번호를 1이 되도록 설정
				searchFrm.find("input[name='pageNum']").val('1');
				searchFrm.submit();
			});

			// 페이징 이벤트 처리 ------------------------------
			var actionFrm = $('#actionFrm');

			$('.page-item a').on(
					'click',
					function(e) {
						e.preventDefault();

						// a 태그의 href 값을 pageNum에 저장
						actionFrm.find("input[name='pageNum']").val(
								$(this).attr('href'));

						// 로그 남기기
						/* console.log('페이지 이동: ' + pageNum); */

						actionFrm.submit();
					});

			//게시물 제목 클릭 이벤트 처리 -----------------------
			$('.move')
					.on(
							'click',
							function(e) {
								e.preventDefault();
								console.log("폼 제출됨!");
								//hidden 태그를 생성하여 이름을 bno로 지정하고
								//a 태그의 href 값을 bno에 저장한 후 actionFrm에 추가
								actionFrm
										.append("<input type='hidden' name='ano' value='"
												+ $(this).attr('href') + "'>");

								actionFrm.attr('action', '/art/view');

								actionFrm.submit();
							});

			//게시물 등록 버튼 클릭 이벤트 처리 -------------------
			$('#regBtn').on('click', function() {
				self.location = "/art/register";
			});


			var result = '${result }';
			userOut(result);

			history.replaceState({}, null, null); // history 초기화

			function userOut(result) {
				// result 값이 있는경우에 알림창 표시

				if (result === '' || history.state) {
					return;
				}

				if (result == 'artsuccess') {
					Swal.fire('작품이 등록되었습니다.', '', 'success')
				}

			}

		});//END
	</script>

	<%@ include file="../includes/footer.jsp"%>
