<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>

ul.list03 {
    list-style-type: none; /* 목록 마커(점) 감추기 */
    padding: 0; /* 목록의 패딩 제거 */
    margin: 0; /* 목록의 마진 제거 */
}


.exh-list {
	display: flex;
	flex-wrap: wrap;
	list-style: none;
	padding: 0;
	margin: 0;
}

.exh-item {
	flex: 0 0 calc(33.33% - 20px); /* Adjust the width as needed */
	margin: 10px;
	border: 1px solid #ccc;
	padding: 10px;
	box-sizing: border-box;
}

.title {
	display: block;
	color: #333333;
	white-space: nowrap;
	text-overflow: ellipsis;
	overflow: hidden;
}

html, body, div, span, applet, object, iframe, h1, h2, h3, h4, h5, h6, p,
	blockquote, pre, a, abbr, acronym, address, big, cite, code, del, dfn,
	em, font, img, ins, kbd, q, s, samp, small, strike, strong, sub, sup,
	tt, var, dl, dt, dd, ol, ul, li, fieldset, form, label, legend, table,
	caption, tbody, tfoot, thead, tr, th, td {
	font-family: 'Noto Sans KR', 'CJONLYONENEW', '맑은 고딕', '돋움', Dotum,
		sans-serif;
	font-size: 100%;
	margin: 0;
	padding: 0;
	border: 0;
	vertical-align: baseline;
	word-break: break-all;
}

[class|="sect"][class*="chart"] .score .egg-gage, [class|="sect"][class*="chart"] .score .percent
	{
	vertical-align: middle;
}

.sedate {
	display: flex; /* 부모 요소를 플렉스 컨테이너로 설정 */
	font-size: 11px; /* 원하는 폰트 크기로 조절 */
	text-align: center !important;
}

.dday {
	display: inline-block;
	margin-left: 5px;
	color: #fb4357;
	font-size: 12px;
	font-family: Verdana, Geneva, sans-serif;
	font-weight: bold;
}

.detailexh {
	display: none;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background: #fff;
	z-index: 999;
	padding: 20px;
	max-width: 80%;
	max-height: 80%;
	overflow: auto;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
}

/* .box-contents{
	display: flex;
    flex-direction: column; /* 자식 요소를 세로로 배열 
    text-align: center;
}

.sedate{
	text-align: center;
} */
.dbox-image {
	float: left;
	margin-right: 20px; /* 원하는 간격으로 조절 가능 */
}

.dbox-contents {
	float: right;
	margin-right: 5px; /* 원하는 간격으로 조절 가능 */
}

p {
	display: block;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
}

dl {
	display: block;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
}

.exh-item:hover {
	/* 마우스 오버 시 적용할 스타일 설정 */
	background-color: #f0f0f0; /* 배경색 변경 예시 */
	color: #333; /* 텍스트 색상 변경 예시 */
}

.thumb-image img {
	max-width: 600px; /* 최대 너비를 200px로 설정 */
	max-height: 800px; /* 최대 높이를 200px로 설정 */
}

#loadMoreBtn{
 display: block; /* block 요소로 설정하여 너비와 높이 설정이 가능하도록 함 */
    width: 150px; /* 버튼의 너비를 원하는 크기로 설정 */
    margin: 0 auto; /* 수평 가운데 정렬을 위해 margin 속성을 사용 */

margin-bottom:20px;}
</style>
<%@ include file="../includes/header.jsp"%>

<div class="main">
    <section class="module bg-dark-30 about-page-header" data-background="/resources/live/assets/images/visitors.jpg">
        <div class="container">
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3">
                    <h2 class="module-title font-alt">전국 전시회 현황</h2>
                    <div class="module-subtitle font-serif">Stay informed about art exhibitions nationwide! Whether you're an art enthusiast, collector, or simply curious, find detailed event information and plan your cultural experiences.</div>
                </div>
            </div>
        </div>
    </section>

<div>
    <ul class="exh-list">
        <c:forEach items="${list}" var="hongbo" varStatus="loop">
            <li class="exh-item">
                <div class="img text-center" data-brl-use="${hongbo.exhImg}">
                    <img src="${hongbo.exhImg}" alt="${hongbo.exhName}" width="200px" height="250px">
                </div>
                <div class="text text-center">
                    <p class="title">${hongbo.exhName}</p>
                    <ul class="list03">
                        <li><em>기간</em>: ${hongbo.exhDate}</li>
                        <li><em>장소</em>: ${hongbo.place}</li>
                        <li><em>문의</em>: ${hongbo.contact}</li>
                    </ul>
                </div>
                <!-- 이미지 클릭시 불러오는 div -->
                <div class="detailexh">
                    <div class="dbox-image">
                        <span class="img"> <img src="${hongbo.exhImg}" alt="${hongbo.exhName}" width="300px" height="400px"></span>
                    </div>
                    <div class="dbox-contents">
                        <div class="title form-control">
                            <span>${hongbo.exhName}</span>
                        </div>
                        <!-- 떨어지는 얘 이전 요소에 class=on을 넣는다 -->
                        <div class="spec">
                            <dl>
                                <dt><em>기간</em>: ${hongbo.exhDate}</dt>
                                <dd></dd>
                                <dt><em>장소</em>: ${hongbo.place}</dt>
                                <dd></dd>
                                <dt><em>요금</em>: ${hongbo.charge}</dt>
                                <dt><em>대표번호</em>: ${hongbo.contact}</dt>
                                <dt><em>홈페이지</em>: <a href="${hongbo.homeurl}" target="_blank">${hongbo.homeurl}</a></dt>
                                <dt><em>전시소개</em>: <br>${hongbo.exhIntro}</dt>
                            </dl>
                        </div>
                    </div>
                </div>
            </li>
            <c:if test="${loop.index % 3 == 2}">
            </c:if>
        </c:forEach>
    </ul>
   
</div>
<div style="padding:20px;">
 <button id="loadMoreBtn">더보기</button></div>

<link href="/resources/live/assets/css/hongbo.css" rel="stylesheet">
<script>
    $('.exh-item').hide();
    $('.exh-item').slice(0, 6).show();

    $("#loadMoreBtn").click(function(e){ // Load More를 위한 클릭 이벤트
        e.preventDefault();
        $(".exh-item:hidden").slice(0, 6).show(); // 숨김 설정된 다음 n개 표시
        if($(".exh-item:hidden").length == 0){ // 숨겨진 DIV가 있는지 체크해서 없으면 more 버튼 숨기기
            $('#loadMoreBtn').hide();
        }
    });

    $(document).ready(function() {
        $(".img").click(function() {
            // 클릭된 이미지의 부모 요소를 찾아 "detailmovie"를 표시합니다.
            var detailExh = $(this).closest(".exh-item").find(".detailexh");

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
