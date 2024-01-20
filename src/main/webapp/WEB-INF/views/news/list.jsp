<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<style>


.thumb {
    float: left; /* 이미지를 왼쪽으로 띄움 */
    margin-right: 10px; /* 이미지와 텍스트 사이의 간격 조정 (원하는 간격으로 조절) */
}

.news-item {
    border-bottom: 1px solid #ccc; /* 밑줄 스타일과 색상을 설정할 수 있습니다. */
    padding-bottom: 10px; /* 선택적으로 밑줄과 뉴스 항목 사이의 간격을 조정할 수 있습니다. */
    margin-bottom: 20px; /* 선택적으로 각 뉴스 항목 사이의 간격을 조정할 수 있습니다. */
}
img{
width:150px;
height:160px;
}

#loadMoreBtn{
 display: block; /* block 요소로 설정하여 너비와 높이 설정이 가능하도록 함 */
    width: 150px; /* 버튼의 너비를 원하는 크기로 설정 */
    margin: 0 auto; /* 수평 가운데 정렬을 위해 margin 속성을 사용 */

margin-bottom:20px;}

.newslist{
margin-top:25px;}

.type2 li{
list-style-type: none;}

</style>
<div class="main">
	<section class="module bg-dark-30 about-page-header" data-background="/resources/live/assets/images/paper.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">문화/예술 뉴스</h2>
					<div class="module-subtitle font-serif">Explore the latest in arts and culture! Stay tuned for in-depth articles, artist spotlights, and event coverage, bringing you the vibrant world of cultural and artistic expression.</div>
				</div>
			</div>
		</div>
	</section>

<div class="newslist">
	<section id="section-list">
		<ul class="type2">
			<c:forEach items="${list}" var="nvo" varStatus="loop">
				<li class="news-item"><a href="${nvo.newsUrl}" target="_top"
					class="thumb"> 
					<img src="${nvo.newsImg}" alt="${nvo.title}">
				</a>
					<div class="view-cont">
						<h4 class="titles">
							<a href="${nvo.newsUrl}" target="_top">${nvo.title}</a>
						</h4>
						<p class="lead line-6x2">
							<a href="${nvo.newsUrl}" target="_top"> ${nvo.script} </a>
						</p>
						<span class="byline"> <em>${nvo.genre}</em> <em>${nvo.writer}</em>
							<em>${nvo.updateDate}</em>
						</span>
					</div></li>
				<%--             <c:if test="${loop.index % 3 == 2}">
            </c:if> --%>
			</c:forEach>
		</ul>
	</section>
</div>

<div style="padding:20px;">
 <button id="loadMoreBtn">더보기</button></div>


<!-- <link href="/resources/live/assets/css/news.css" rel="stylesheet"> -->
	<script>
		$('.news-item').hide();
		$('.news-item').slice(0, 10).show();

		$("#loadMoreBtn").click(function(e) { // Load More를 위한 클릭 이벤트
			e.preventDefault();
			$(".news-item:hidden").slice(0, 10).show(); // 숨김 설정된 다음 n개 표시
			if ($(".news-item:hidden").length == 0) { // 숨겨진 DIV가 있는지 체크해서 없으면 more 버튼 숨기기
				$('#loadMoreBtn').hide();
			}
		});

/* 		$(document).ready(
				function() {
					$(".img").click(
							function() {
								// 클릭된 이미지의 부모 요소를 찾아 "detailmovie"를 표시합니다.
								var detailExh = $(this).closest(".exh-item")
										.find(".detailexh");

								if (detailExh.is(":visible")) {
									// 이미 세부 정보가 표시된 경우, 다시 숨깁니다.
									detailExh.hide();
								} else {
									// 세부 정보가 표시되지 않은 경우, 표시합니다.
									detailExh.show();
								}
							});
				}); */
	</script>

	<%@ include file="../includes/footer.jsp"%>