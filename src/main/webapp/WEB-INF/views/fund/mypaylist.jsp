<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<title>Funding Pay List</title>
<style>
body {
	color: #666;
}

table {
	border-collapse: separate;
	border-spacing: 0;
	margin: -50px auto; /* 가운데 정렬을 위한 스타일 */
	width: 70%; /* 원하는 크기로 조절 (예: 70%) */
}

tr th {
	text-align: center;
	padding: 5px 0;
}

tr td {
	padding: 4px 0px;
}

th, td {
	padding: 6px 15px;
	text-align: center;
}

th {
	background: #42444e;
	color: #fff;
	text-align: center;
}

tr:first-child th:first-child {
	border-top-left-radius: 6px;
}

tr:first-child th:last-child {
	border-top-right-radius: 6px;
}

td {
	border-right: 1px solid #c6c9cc;
	border-bottom: 1px solid #c6c9cc;
}

td:first-child {
	border-left: 1px solid #c6c9cc;
}

tr:nth-child(even) td {
	background: #eaeaed;
}

tr:last-child td:first-child {
	border-bottom-left-radius: 6px;
}

tr:last-child td:last-child {
	border-bottom-right-radius: 6px;
}

tr:hover {
	background: lightyellow;
}

tr:nth-child(even):hover td {
	background: lightyellow;
}

#search {
	background-color: rgb(213, 245, 227);
	border: 1px solid rgb(213, 245, 227);
	color: rgb(11, 83, 69);
}

#searchFrm {
	text-align: center;
	margin-top: 40px;
}

td a {
	text-decoration: none;
	color: black;
}

#tableSec {
	height: 396px;
	margin: 70px auto;
}

button {
	border: 1px solid rgb(213, 245, 227);
	background-color: rgb(213, 245, 227);
	text-decoration: none;
	color: rgb(11, 83, 69);
	margin: 10px 20px;
}

/* #backBtn { position: relative; left :1300px ; top: 80px;} */
#backBtn {
	position: relative;
	left: 1500px;
	border: 1px solid rgb(213, 245, 227);
	background-color: rgb(213, 245, 227);
	color: rgb(11, 83, 69);
	margin: 10px 20px;
}

.badge-wrap .badge {
	color: black;
	text-align: right;
	background: rgb(234, 237, 237);
}

.genReque {
	background: rgb(44, 62, 80);
	color: white;
	border-radius: 10px;
}

.artReque {
	background: rgb(44, 62, 80);
	color: white;
	border-radius: 10px;
}
</style>

<%@ include file="../includes/header.jsp"%>

<div class="main">
	<section class="module bg-dark-30 about-page-header" data-background="/resources/live/assets/images/fund.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">My Funding Pay List</h2>
					<div class="module-subtitle font-serif">Be a part of our success story! Your contribution fuels our passion and helps us achieve milestones. Let's make this project a reality, together!
</div>
				</div>
			</div>
		</div>
	</section>



<section id="tableSec">
	<table>
		<thead>
			<tr>
				<th>NO.</th>
				<th>펀딩명</th>
				<th>결제금액</th>
				<th>결제일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${mypaylist}" var="fpvo">
				<tr>
					<td>${fpvo.fpno}</td>
					<td><a class="move" href="${fpvo.fno}">${fpvo.fvo.fundName}</a></td>
					<td>${fpvo.amount}</td>
					<td><fmt:formatDate value="${fpvo.payDate}"
							pattern="yyyy-MM-dd" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</section>
<div class="row">
	<div class="text-right">
		<a class="btn btn-secondary backBtn" onclick="history.back()"
			style="background-color: lightgray; color: #fff; margin-right: 30px;">뒤로가기</a>
	</div>
</div>

<div>
	<div class="text-center">
		<%-- 페이징 --%>
		<ul class="pagination ">
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
	<!-- end paging -->
</div>



<!-- 현재 페이지 번호 및 출력 게시물 수, 검색 타입, 키워드 전송 폼 -->
<form action="/fund/mypaylist" id="actionFrm" method="get">
	<%--     <input type="hidden" name="mid" value="${mid}"> --%>

	<input type="hidden" name="type" value="${pageDTO.cri.type}"> <input
		type="hidden" name="keyword" value="${pageDTO.cri.keyword}"> <input
		type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}"> <input
		type="hidden" name="amount" value="${pageDTO.cri.amount}">
</form>

<script>
    $(function(){
        // 페이징 이벤트 처리 ------------------------------
        var actionFrm = $('#actionFrm');
        $('.page-item a').on('click', function(e){
            e.preventDefault();
            actionFrm.find("input[name='pageNum']").val($(this).attr('href'));
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