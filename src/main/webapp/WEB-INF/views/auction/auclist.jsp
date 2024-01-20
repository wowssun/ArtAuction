<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-60 shop-page-header"
		data-background="/resources/img/title/auc.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">AUCTION</h2>
					<div class="module-subtitle font-serif"></div>
				</div>
			</div>
		</div>
	</section>
	<section class="module-small">
		<div class="container">
			<form class="row" action="/auction/auclist" id="searchFrm">
				<div class="col-sm-2 mb-sm-20">
					<select class="form-control" name="type">
						<option value="T" ${type == 'T' ? 'selected' : '' }>ART</option>
						<option value="C" ${type == 'C' ? 'selected' : '' }>ARTIST</option>
						<option value="TC" ${type == 'TC' ? 'selected' : '' }>BOTH</option>
					</select>
				</div>
				<div class="col-sm-2 mb-sm-20">
					<input class="form-control" placeholder="Default input" type="text"
						name="keyword" value="${pageDTO.cri.keyword}">
				</div>
				<div class="col-sm-2">
					<button class="btn btn-block btn-round btn-g" type="submit">Apply</button>
				</div>
				<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
			</form>
		</div>
	</section>
	<hr class="divider-w">
	<section class="module">
		<div class="container">
			<div class="row multi-columns-row">
				<c:forEach items="${list }" var="avo">
				<c:if test="${avo.paystatement != '결제완료'}">
					<div class="col-md-4">
						<div class="shop-item">
							<div class="shop-item-image">
								<img src="/artdisplay?fileName=/${avo.artImg}"
									alt="${avo.artName}" alt="Accessories Pack"
									style="width: 280px; height: 280px;" />
								<div class="shop-item-detail">
									<a class="move btn btn-round btn-b" href="${avo.ano}">VIEW</a>
								</div>
							</div>
							<h4 class="shop-item-title font-alt">
								<a class="move" href="${avo.ano }">${avo.artName}</a>
							</h4>
							${avo.priceC}원<br>
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<c:if test="${avo.endDate < now}">
								<span style="color: red;">[경매 마감]</span>
							</c:if>
						</div>
					</div>
					</c:if>
				</c:forEach>
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

		<form action="/auction/auclist" id="actionFrm">
			<input type="hidden" name="type" value="${pageDTO.cri.type}">
			<input type="hidden" name="keyword" value="${pageDTO.cri.keyword}">
			<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
		</form>
	</section>
	<script>
		var searchFrm = $('#searchFrm')

		$('.searchBtn').on('click', function() {
			searchFrm.find("input[name='pageNum']").val('1');
			searchFrm.submit();
		});
		//END 검색 버튼 이벤트 처리 -----------------------

		//페이징 이벤트 처리 ------------------------------
		var actionFrm = $('#actionFrm');

		$('.pagination a').on('click', function(e) {
			e.preventDefault();

			//a 태그의 href 값을 pageNum에 저장
			actionFrm.find("input[name='pageNum']").val($(this).attr('href'));

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