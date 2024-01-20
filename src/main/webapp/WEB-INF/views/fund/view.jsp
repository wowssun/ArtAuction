<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-30 about-page-header"
		data-background="/resources/live/assets/images/fund.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h1 class="module-title font-alt mb-0">Fund View</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="module">
		<div class="container">

			<div class="row" style="padding-bottom: 30px;">

				<%-- <div class="col-sm-6 mb-sm-40"
					style=" background-image : url('/display?fileName=/${fvo.atvo.photo }'); background-size : contain"> --%>
				<div class="col-sm-6 mb-sm-40">
					<a class="gallery" href=""> <img
						src="/display?fileName=/${fvo.atvo.photo }" alt="${fvo.mvo.name }"
						style="background-size: contain; width: 400px; height: 400px;" />
					</a>
				</div>

				<div class="col-sm-6 mb-sm-40">
					<div class="row">
						<div class="col-sm-12">
							<h1 class="product-title font-alt">${fvo.fundName }</h1>
						</div>
						<div class="col-sm-12">
							<div class="product_meta">
								<p style="color: #212121;">작가명 : ${fvo.mvo.name}</p>
								<!-- <strong id="rate"></strong> -->
								<p style="font-weight: bold; font-size: 1.8em; color: #546E7A;">${fvo.partcpntCnt}명
									<span id="remainingDays"></span>
								</p>
								<p style="font-weight: bold; font-size: 2.0em; color: #546E7A;">${fvo.totalPrice}원
									<span style="font-size: 0.5em;">${fvo.targetPrice }원</span> <strong
										id="rate"></strong>
								</p>
								<%-- <p>${fvo.totalPrice }원</p> --%>
								<%-- <p>${fvo.targetPrice }원</p> --%>
								<p style="margin-bottom: 10px; color: #212121;">시작/종료일 :
									${startDate }~${endDate }</p>
								<p
									style="border-top: 1px solid #ccc; padding-top: 10px; color: #212121;">${fvo.mvo.name}
									작가를 후원해 주세요. 작가에게 아주 큰 힘이 됩니다!</p>
							</div>
						</div>
					</div>


					<sec:authorize access="isAuthenticated()">
						<sec:authentication property="principal.username" var="loginId" />
						<c:choose>
							<c:when test="${loginId != fvo.mid and loginId != 'admin'}">
								<div class="row mb-10" id="funding">
									<div class="col-sm-4">
										<select class="form-control" name="price">
											<option>1000</option>
											<option>2000</option>
											<option>3000</option>
											<option>4000</option>
											<option>5000</option>
											<option>6000</option>
											<option>7000</option>
											<option>8000</option>
											<option>9000</option>
											<option>10000</option>
										</select>
									</div>
									<div class="col-sm-4">
										<button data-oper="fundingpay" id="fundBtn"
											class="btn btn-primary"
											style="background-color: #455A64; font-size: 1.2em; font-weight: bold;">펀딩하기</button>
									</div>
								</div>
							</c:when>
							<c:when test="${loginId == fvo.mid or loginId == 'admin'}">

								<div style="margin-top: 30px;">
									<form action="/fund/modify">
										<button data-oper="modify" class="btn btn-warning">Modify</button>
										<input type="hidden" name="fno" value="${fvo.fno }"> <input
											type="hidden" name="sort" value="${cri.sort}"> <input
											type="hidden" name="pageNum" value="${cri.pageNum}">
										<input type="hidden" name="amount" value="${cri.amount}">
									</form>
								</div>
							</c:when>
						</c:choose>
					</sec:authorize>
				</div>
			</div>



			<div class="row">
				<h2 style="color: #212121; font-weight: bold;">펀딩소개</h2>

				<div class="row mb-20"
					style="border-top: 1px solid #ccc; padding-top: 30px; color: #212121;">
					<div class="col-sm-12">
						<div class="description">
							<p style="font-size: 1.3em;">${fvo.pr }</p>
						</div>
					</div>
				</div>
				
				
				
				<div class="container">
						<div class="row">
						<h2 style="color: #212121; font-weight: bold; font-size:20px;">이력사항</h2>
							<div class="row mb-20"
								style="border-top: 1px solid #ccc; padding-top: 30px; color: #212121;">
							</div>
						</div>
						<div class="row multi-columns-row">
						<ul  class="hyphen"  style="margin:0; padding:0; list-style: none"> 
							<c:forEach items="${careerlist}" var="car" varStatus="status">
								<li style="position: relative; margin: 2px 0 0 0; padding: 0 0 4px 16px;">- ${car.career }</li>
							</c:forEach>
							</ul>
						</div>
					</div>
				
				

				<section class="module-small">
					<div class="container">
						<div class="row">
						<h2 style="color: #212121; font-weight: bold; font-size:20px;">${fvo.mvo.name}작가의
									작품</h2>
							<div class="row mb-20"
								style="border-top: 1px solid #ccc; padding-top: 30px; color: #212121;">
							</div>
						</div>
						<div class="row multi-columns-row">
							<c:forEach items="${artlist}" var="artvo" varStatus="status">
								<c:if test="${status.index < 4}">
									<div class="col-sm-6 col-md-3 col-lg-3">
										<div class="shop-item">
											<div class="shop-item-image">
												<img src="/artdisplay?fileName=/${artvo.artImg}"
													alt="${artvo.artName}" style="width: 300px; height: 300px;" />
												<div class="shop-item-detail">
													<a class="artmove btn btn-round btn-b" href="${artvo.ano }">VIEW</a>
												</div>
											</div>
											<h4 class="shop-item-title font-alt">
												<a href="#">작품명 : ${artvo.artName}</a>
											</h4>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
					</div>







				</section>
			</div>

			<div class="text-right">
				<a class="btn btn-secondary backBtn" onclick="history.back()"
					style="background-color: lightgray; color: #fff; margin-right: 10px;">뒤로가기</a>
			</div>

		</div>
	</section>

	<%-- 	<form action="/fund/modify">
		<input type="hidden" name="fno" value="${fvo.fno }"> <input
			type="hidden" name="sort" value="${cri.sort}"> <input
			type="hidden" name="pageNum" value="${cri.pageNum}"> <input
			type="hidden" name="amount" value="${cri.amount}">
	</form> --%>

	<script>
<!-- 남은 기간 계산 -->
    var startDate = new Date('${startDate}');
    var endDate = new Date('${endDate}');
    var currentDate = new Date();
    var remainingDays = Math.floor((endDate - startDate) / (1000 * 60 * 60 * 24));
    // 1일을 밀리초로 -> (1000 * 60 * 60 * 24)
    
    console.log(startDate);
    console.log(endDate);
    console.log(remainingDays);
    console.log(currentDate);
    
    // 종료일이 현재 날짜보다 이전인지 확인
    if (endDate < currentDate) {
        document.getElementById("remainingDays").textContent = "종료된 펀딩입니다.";
        document.getElementById("fundBtn").style.display = "none";
        $("#funding").hide();
    } else {
        // 종료되지 않은 경우, 남은 날짜 계산
        var remainingDays = Math.floor((endDate - currentDate) / (1000 * 60 * 60 * 24));
        document.getElementById("remainingDays").textContent = "D-" + remainingDays;
    }
    
<!-- 달성률 계산 -->
var rate = Math.floor((${fvo.totalPrice } / ${fvo.targetPrice }) * 100) / 100;
console.log(rate);
document.getElementById("rate").textContent = rate+"% 달성";


var csrfHeaderName = '${_csrf.headerName}'; // csrf 토근 관련 변수
var csrfTokenValue = '${_csrf.token}'; // csrf 토근 관련 변수
$(document).ajaxSend(function(e, xhr, option) {
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
});
    


var IMP = window.IMP;
IMP.init("imp62856446");
var mid = '<sec:authentication property="principal.username" />';
console.log("현재 로그인 중인 사용자의 아이디: " + mid);

function requestPay() {
    var fundName = '${fvo.fundName}';

    var fno = '${fvo.fno}';
    var amount = $('select[name="price"]').val();
    var merchant_uid = 'f_' + new Date().getTime();
    
    
    console.log(fundName);
    console.log(mid);
    console.log(fno);
    console.log(amount);
    console.log(merchant_uid);

    IMP.request_pay(
        {
            pg: "html5_inicis",
            pay_method: "card",
            merchant_uid: merchant_uid,
            fundName: fundName,
            mid: mid,
            fno: fno,
            amount: amount,
        },
        function (rsp) {
            if (rsp.success) {
                console.log("결제 응답:", rsp);
                
                $.ajax({
                    type: 'POST',
                    url: '/fund/fundingpay',
                    data: {
                        mid: mid,
                        fno: fno,
                        amount: amount
                    },
                    success: function(response) {
                    	console.log(mid);
						console.log(fno);
						console.log(amount);
						
						Swal.fire({
	                         title: '결제가 완료되었습니다.',
	                         icon: 'success',
	                         showConfirmButton: true, // 확인 버튼 보이기
	                         confirmButtonText: '확인', // 확인 버튼의 텍스트 설정
	                     }).then((result) => {
	                         if (result.isConfirmed) {
	                             // 확인 버튼을 눌렀을 때 실행할 작업을 여기에 추가
	                        	 window.location.href = '/fund/mypaylist?mid='+mid
	                         }
	                     });
                     
                    },
                    error: function(xhr, status, error) {
                    	console.log(status);
						console.log(error);
                        alert("결제 실패");
                    }
                });
            }
        }
    );
}

$('.btn[data-oper=fundingpay]').on('click', function(e) {
    e.preventDefault();
    requestPay();
});

/* //게시물 알림창
$(document).ready(function(){
    var modifyfund = "${modifyfund}"; // 작품 수정 성공
    
    if(modifyfund === "success") {
        alert("펀딩이 수정되었습니다.");
    }
}); */

$(function() {
	
    $('.artmove').on('click', function(e) {
        e.preventDefault();

        var ano = $(this).attr('href'); // 클릭한 링크의 href 값을 가져옴

        // auction/view 경로로 이동
        window.location.href = '/art/view?ano=' + ano;
     });
    
    
	var result = '${result }';
	userOut(result);

	history.replaceState({}, null, null); // history 초기화

	function userOut(result) {
		// result 값이 있는경우에 알림창 표시

		if (result === '' || history.state) {
			return;
		}

		if (result == 'modifyfund') {
			Swal.fire('펀딩이 수정되었습니다.', '', 'success')
		}

	}
	});


</script>




	<%@ include file="../includes/footer.jsp"%>