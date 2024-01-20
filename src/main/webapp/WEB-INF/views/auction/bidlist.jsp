<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-60 shop-page-header"
		data-background="/resources/img/title/auc.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">Tender Records</h2>
					<div class="module-subtitle font-serif"></div>
				</div>
			</div>
		</div>
	</section>
	<hr class="divider-w pt-20">
	<div class="row">
		<div class="col-sm-12">
			<table class="table table-striped table-border checkout-table">
				<tbody>
					<tr>
						<th class="hidden-xs">이미지</th>
						<th>작품명</th>
						<th class="hidden-xs">입찰가</th>
						<th>현재가</th>
						<th>입찰날짜</th>
					</tr>
					<c:forEach items="${bidlist }" var="bvo">
						<tr style="text-align: center;">
							<td class="hidden-xs" style="vertical-align: middle;"><img
								src="/artdisplay?fileName=/${bvo.artImg}" alt="${bvo.artName}"
								alt="Accessories Pack" style="width: 50px; height: 50px;" /></td>
							<td style="vertical-align: middle;"><a class="move" href="${bvo.ano }">
									<h5 class="product-title font-alt">${bvo.artName }</h5>
							</a></td style="vertical-align: middle;">
							<td class="hidden-xs" style="vertical-align: middle;">
								<h5 class="product-title font-alt">${bvo.priceB }원</h5>
							</td>
							<td class="hidden-xs" style="vertical-align: middle;">
								<h5 class="product-title font-alt">${bvo.priceC }원</h5>
							</td>
							<td style="vertical-align: middle;">
								<h5 class="product-title font-alt">${bvo.bidDate }</h5>
							</td>
						</tr>
						<input type="hidden" id="mid" value="${bvo.mid}">
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- paging -------------------------------->
	<div class="col-sm-12">
		<div class="pagination font-alt">
			<c:if test="${pageDTO.prev }">
				<a href="${pageDTO.start - 1}"><i class="fa fa-angle-left"></i></a>
			</c:if>
			<c:forEach begin="${pageDTO.start }" end="${pageDTO.end }" var="i">
				<a class="active ${pageDTO.cri.pageNum == i ? 'active' : '' }"
					href="${i}">${i}</a>
			</c:forEach>
			<c:if test="${pageDTO.next }">
				<a href="${pageDTO.end + 1}"><i class="fa fa-angle-right"></i></a>
			</c:if>
		</div>
	</div>

	<form action="/auction/bidlist" id="actionFrm">
		<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
		<input type="hidden" name="mid" value="">
	</form>
	<script>
	var actionFrm = $('#actionFrm');
	var mid = $('#mid').val();

	$('.pagination a').on('click', function(e) {
		e.preventDefault();

		//a 태그의 href 값을 pageNum에 저장
		actionFrm.find("input[name='pageNum']").val($(this).attr('href'));
		actionFrm.find("input[name='mid']").val(mid);

		actionFrm.submit();
	});

	$('.move').on('click', function(e) {
		e.preventDefault();

		var ano = $(this).attr('href'); // 클릭한 링크의 href 값을 가져옴

		// auction/view 경로로 이동
		window.location.href = '/auction/view?ano=' + ano;
	});
	

</script>
	<%@ include file="../includes/footer.jsp"%>