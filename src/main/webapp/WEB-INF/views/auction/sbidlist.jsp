<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-60 shop-page-header"
		data-background="/resources/img/title/auc.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">Winning Record</h2>
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
						<th>경매 마감일</th>
						<th>결제 기한</th>
						<th>결제 상태</th>
					</tr>
					<c:forEach items="${sbidlist }" var="avo">
						
						
						<input type="hidden" id="mid" name="mid" value="${avo.buyer }">
						<tr style="text-align: center;">
							<td class="hidden-xs" style="vertical-align: middle;"><img
								src="/artdisplay?fileName=/${avo.artImg}" alt="${avo.artName}"
								alt="Accessories Pack" style="width: 50px; height: 50px;"/></td>
							<td style="vertical-align: middle;">
								<h5 class="product-title font-alt">${avo.artName}</h5>
							</td>
							<td class="hidden-xs" style="vertical-align: middle;">
								<h5 class="product-title font-alt">${avo.priceC}원</h5>
							</td>
							<td style="vertical-align: middle;">
								<h5 class="product-title font-alt">${avo.endDate}</h5>
							</td>
							<td style="vertical-align: middle;">
								<h5 class="product-title font-alt">${avo.payDate}</h5>
							</td>
							<td style="vertical-align: middle;"><c:if
									test="${avo.paystatement == '결제중'}">
									<button data-oper="order" data-ano="${avo.ano}"
										data-priceC="${avo.priceC}" data-buyer="${avo.buyer}"
										data-artName="${avo.artName}"
										class="btn btn-success btn-circle btn-block">결제하기</button>
								</c:if> <c:if test="${avo.paystatement == '결제완료'}">
									<button data-oper="buy" data-ano="${avo.ano}"
										data-priceC="${avo.priceC}" data-buyer="${avo.buyer}"
										data-artName="${avo.artName}" data-artImg="${avo.artImg}"
										class="btn btn-info btn-circle btn-block">결제완료</button>
								</c:if></td>
						</tr>


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

	<form action="/auction/sbidlist" id="actionFrm">
		<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
		<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
		<input type="hidden" name="buyer" value="">
	</form>
</div>

<script>
	var csrfHeaderName = '${_csrf.headerName}'; // csrf 토근 관련 변수
	var csrfTokenValue = '${_csrf.token}'; // csrf 토근 관련 변수
	$(document).ajaxSend(function(e, xhr, option) {
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});

	var IMP = window.IMP; // 생략 가능
	IMP.init("imp40560112"); // 예: imp00000000a  , 자신의 "가맹점 식별코드"를 사용
	// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드

	function Payment(ano, priceC, buyer, artName) {
		IMP.request_pay({
			pg : "html5_inicis", // 하나의 아임포트계정으로 여러 PG를 사용할 때 구분자로 사용할 PG사의 코드값을 입력한다.
			pay_method : "card", // 결제수단 (옵션값 참고), 신용카드로 결제한다는 뜻
			merchant_uid : ano + "_" + new Date().getTime(), //가맹점에서 생성/관리하는 고유 주문번호(이건 내가 만들어야 함)
			name : artName, // 주문명(예약명 : 숙소명으로 해야 되나?) //결제창에서 보여질 이름
			amount : priceC, // 결제 금액
			buyer_name : buyer
		// 예약자 이름

		}, function(rsp) { // callback   // 결과값 날라오는거
			if (rsp.success) {
				console.log(rsp);
				$.ajax({
					url : "/auction/pay",
					type : 'POST',
					data : {
						ano : ano,
						price : priceC,
					},
					success : function(response) {
						Swal.fire('결제가 \n 완료되었습니다.', '', 'success')
					},
					error : function(xhr, status, error) {
						Swal.fire('결제가 \n 실패했습니다.', '', 'warning')
					}
				});
			} else {
			}
		});
	}

	$('.btn[data-oper=order]').on('click', function(e) {
		e.preventDefault();

		var ano = $(this).data('ano');
		var priceC = $(this).data('pricec');
		var buyer = $(this).data('buyer');
		var artName = $(this).data('artname');
		
		e.preventDefault();
		Payment(ano, priceC, buyer, artName);
	});

	var actionFrm = $('#actionFrm');
	var mid = $('#mid').val();

	$('.pagination a').on('click', function(e) {
		e.preventDefault();

		//a 태그의 href 값을 pageNum에 저장
		actionFrm.find("input[name='pageNum']").val($(this).attr('href'));
		actionFrm.find("input[name='buyer']").val(mid);

		actionFrm.submit();
	});
	
	$('.btn[data-oper=buy]').on('click', function(e) {
		  e.preventDefault();

		  var artImg = $(this).data('artimg');
		  var priceC = $(this).data('pricec');
		  var buyer = $(this).data('buyer');
		  var artName = $(this).data('artname');

		  console.log(artImg);	
		  
		  Swal.fire({
		    imageUrl: '/artdisplay?fileName=/' + artImg,
		    imageAlt: '이미지',
		    html: '<div style="font-size: 26px;"><br>작품 : ' + artName + '</div><br><br><div style="font-size: 18px;">가격 : ' + priceC + '원</div>',
		    icon: ''
		  });
		});

</script>
<%@ include file="../includes/footer.jsp"%>