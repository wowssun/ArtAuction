<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.detailexh {
    display: none;
    /* 기타 스타일링 설정 */
}

</style>
<div class="main">
	<section class="module bg-dark-30 about-page-header" data-background="">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">전국 전시회 현황</h2>
					<div class="module-subtitle font-serif">A wonderful serenity
						has taken possession of my entire soul, like these sweet mornings
						of spring which I enjoy with my whole heart.</div>
				</div>
			</div>
		</div>
	</section>

<ul>

	<c:forEach items="${list}" var="hongbo">
		<li class="exh-item">

			<div class="img" data-brl-use="${hongbo.exhImg}">
				<img src="${hongbo.exhImg}" alt="${hongbo.exhName}" width="200px"
					height="250px">
			</div>

			<div class="text">
				<p class="title">${hongbo.exhName}</p>
				<ul class="list03">
					<li><strong>기간</strong>${hongbo.exhDate}</li>
					<li><strong>장소</strong>${hongbo.place}</li>
					<li><strong>문의</strong>${hongbo.contact}</li>
				</ul>
			</div> <!-- 이미지 클릭시 불러오는 div -->
			<div class="detailexh">
				<div class="dbox-image">
					<span class="thumb-image"> <img src="${hongbo.exhImg}"
						alt="${hongbo.exhName}" width="300px" height="400px">
					</span>
				</div>
				<div class="dbox-contents">
					<div class="title form-control">
						<strong>${hongbo.exhName}</strong>
					</div>

					<!-- 떨어지는 얘 이전 요소에 class=on을 넣는다 -->
					<div class="spec">
						<dl>
							<dt>기간 :&nbsp; ${hongbo.exhDate}</dt>
							<dd></dd>
							<dt>장소 :&nbsp; ${hongbo.place}</dt>
							<dd></dd>
							<dt>요금 :&nbsp;${hongbo.charge}</dt>
							<dt>대표번호 :&nbsp;${hongbo.contact}</dt>
							<dt>
								홈페이지: <a href="${hongbo.homeurl}" target="_blank">${hongbo.homeurl}</a>
							</dt>
							<dt>
								전시소개: &nbsp;<br>${hongbo.exhIntro}</dt>
						</dl>
					</div>
				</div>
			</div>

		</li>
			<c:if test="${loop.index % 3 == 2 or loop.last}">
				<div style="clear: both;"></div>
			</c:if>
	</c:forEach>
	
</ul>
<button id="loadMoreBtn" class="text-center">더보기</button>
</div>
<script>


$('.exh-item').hide();
$('.exh-item').slice(0, 6).show();

$("#loadMoreBtn").click(function(e){ // Load More를 위한 클릭 이벤트e
	e.preventDefault();
	$(".exh-item:hidden").slice(0, 6).show(); // 숨김 설정된 다음 n개 표시
		if($(".exh-item:hidden").length == 0){ // 숨겨진 DIV가 있는지 체크해서 없으면 more 버튼 숨기기
		$('#loadMoreBtn').hide();
	}
});

 $(document).ready(
			function() {
				$(".thumb-image").click(
						function() {
							// 클릭된 이미지의 부모 요소를 찾아 "detailmovie"를 표시합니다.
							var detailExh = $(this)
									.closest(".exh-item").find(
											".detailexh");

							if (detailExh.is(":visible")) {
								// 이미 세부 정보가 표시된 경우, 다시 숨깁니다.
								detailExh.hide();
							} else {
								// 세부 정보가 표시되지 않은 경우, 표시합니다.
								detailExh.show();
							}
						});
				
		

			});


	</script>
<%@ include file="../includes/footer.jsp"%>