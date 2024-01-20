<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 mb-sm-40">
					<a class="gallery"
						href="/artdisplay?fileName=/${avo.artImg}"><img
						src="/artdisplay?fileName=/${avo.artImg}"
						alt="Single Product Image" /></a>
				</div>
				<div class="col-sm-6">
					<div class="row">
						<div class="col-sm-12">
							<h1 class="product-title font-alt">${avo.artName }</h1>
						</div>
						<div class="col-sm-12">
							<div class="product_meta">${avo.artist }</div>
						</div>
					</div>
					<br>
					<div class="row mb-20">
						<div class="col-sm-12">
							<div class="price font-alt">
								<span class="product_meta">현재가</span> <span class="product_meta">${avo.priceC }원</span>
							</div>
						</div>
						<div class="col-sm-12">
							<div class="price font-alt"><span class="product_meta">입찰 예정가</span>
								<span class="product_meta">${avo.priceS }원</span>
							</div>
						</div>
						<div class="col-sm-12">
							<div class="price font-alt"><span class="product_meta">마감일</span>
								<span class="product_meta">${avo.endDate }</span>
							</div>
						</div>
					</div>
					<div class="row mb-20">
						<div class="col-sm-12">
							<div class="description">
								<p>${avo.intro }</p>
							</div>
						</div>
					</div>
					<form action="/auction/modify">
						<div class="row mb-20">
							<div class="col-sm-8">
								<button data-oper="bid"
									class="btn btn-success btn-circle btn-block">BID</button>
							</div>
						</div>
						<div class="row mb-20">
							<div class="col-sm-8">
								<sec:authorize access="hasRole('ARTIST') or hasRole('ADMIN')">
									<sec:authentication property="principal.username" var="loginId" />
									<c:if
										test="${empty avo.buyer && loginId == avo.mid or loginId == 'admin'}">
										<button data-oper="modify"
											class="btn btn-warning btn-circle btn-block">MODIFY</button>
									</c:if>
								</sec:authorize>
								<input type="hidden" id="ano" name="ano" value="${avo.ano}">
								<input type="hidden" id="buyer" name="buyer" value="${mid}">
								<input type="hidden" id="sbuyer" name="sbuyer" value="${avo.buyer}">
								<input type="hidden" id="priceC" name="priceC"
									value="${avo.priceS}"> <input type="hidden"
									name="${_csrf.parameterName }" value="${_csrf.token }">
								<input type="hidden" name="type" value="${cri.type}"> <input
									type="hidden" name="keyword" value="${cri.keyword}"> <input
									type="hidden" name="pageNum" value="${cri.pageNum}"> <input
									type="hidden" name="amount" value="${cri.amount}">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	<script>
		var csrfHeaderName = '${_csrf.headerName}'; // csrf 토근 관련 변수
		var csrfTokenValue = '${_csrf.token}'; // csrf 토근 관련 변수
		var endDate = '${avo.endDate}';

		$(document).ajaxSend(function(e, xhr, option) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		});

		// 페이지가 로드되면 실행되는 함수
		$(document).ready(function() {
			// endDate가 현재 날짜를 지났을 때 alert 창을 띄웁니다.
			if (new Date(endDate) < new Date()) {
				Swal.fire('마감된 경매 입니다.', '', 'error')
			}
		});

		$('.btn[data-oper=bid]').on('click', function(e) {
		    e.preventDefault();

		    var ano = $('#ano').val();
		    var buyer = $('#buyer').val();
		    var sbuyer = $('#sbuyer').val();
		    var priceC = $('#priceC').val();
		    var loginId = "${mid}"; // 로그인한 아이디를 가져옴
		    var mid = "${avo.mid}";
		    
		    // endDate가 현재 날짜를 지났을 때 alert 창을 띄웁니다.
		    if (new Date(endDate) < new Date()) {
		        Swal.fire('마감된 경매 입니다.', '', 'error');
		    } else if (mid === loginId) { // mid와 loginId가 같은 경우
		        Swal.fire('판매자는 구매를 누를 수 없습니다.', '', 'error');
		    } else if (sbuyer === loginId) { // buyer와 loginId가 같은 경우
		        Swal.fire('이미 입찰 중입니다.', '', 'error');
		    } else {
		        $.ajax({
		            url: "/auction/updateBid",
		            type: 'POST',
		            data: {
		                ano: ano,
		                buyer: buyer,
		                priceC: priceC
		            },
		            success: function(response) {
		                Swal.fire('입찰이 완료되었습니다.', '', 'success');
		            },
		            error: function(xhr, status, error) {
		                Swal.fire('입찰이 실패하였습니다.', '', 'error');
		            }
		        });
		    }
		});

	</script>

	<%@ include file="../includes/footer.jsp"%>