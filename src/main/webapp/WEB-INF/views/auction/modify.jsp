<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-30 about-page-header"
		data-background="/resources/img/title/auc.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h1 class="module-title font-alt mb-0">Modifying Posts</h1>
				</div>
			</div>
		</div>
	</section>
	<section class="module">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<h4 class="font-alt mb-0">경매 수정</h4>
					<hr class="divider-w mt-10 mb-20">
					<form action="/auction/modify" method="post" role="form">
						<div class="form-group">
							<label>작가</label> <input class="form-control" type="text"
								name="artist" readonly="readonly" value="${avo.artist }">
						</div>

						<div class="form-group">
							<label>추정가</label> <input class="form-control" type="number"
								name="priceE" value="${avo.priceE }">
						</div>

						<div class="form-group">
							<label>현재가</label> <input class="form-control" type="number"
								name="priceC" value="${avo.priceC }">
						</div>

						<div class="form-group">
							<label>입찰예정가</label> <input class="form-control" type="number"
								name="priceS" readonly="readonly">
						</div>

						<div class="form-group">
							<label>경매 시작일</label> <input class="form-control" type="date"
								name="startDate" value="${avo.startDate }">
						</div>

						<div class="form-group">
							<label>경매 마감일</label> <input class="form-control" type="date"
								name="endDate" value="${avo.endDate }">
						</div>

						<div>
							<input type="hidden" name="artImg">
						</div>

						<div>
							<input type="hidden" name="ano" value="${avo.ano }">
						</div>

						<div>
							<input type="hidden" name="mid">
						</div>

						<div class="form-group">
							<label>작품 정보</label>
							<textarea class="form-control" rows="7" name="intro">${avo.intro }</textarea>
						</div>
						<button data-oper="remove" class="btn btn-danger"
							formaction="/auction/remove">Remove</button>
						<button data-oper="modify" class="btn btn-warning">Modify</button>
						<button type="button" class="btn btn-primary"
							onclick="history.back()">Cancel</button>
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }"> <input type="hidden" name="type"
							value="${cri.type}"> <input type="hidden" name="keyword"
							value="${cri.keyword}"> <input type="hidden"
							name="pageNum" value="${cri.pageNum}"> <input
							type="hidden" name="amount" value="${cri.amount}"> <input
							type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }">
					</form>
				</div>
			</div>
		</div>
	</section>

	<script>
		window.onload = function() {
			var priceCInput = document.querySelector('input[name="priceC"]');
			var priceSInput = document.querySelector('input[name="priceS"]');

			priceCInput.addEventListener('input', function() {
				priceSInput.value = this.value;
			});
		};
		
		$('.btn-warning').on('click', function(e) {
	    	e.preventDefault();
	    	Swal.fire({
	    		   title: '게시물을 수정하시겠습니까?',
	    		   text: '',
	    		   icon: 'warning',
	    		   
	    		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
	    		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
	    		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
	    		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
	    		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
	    		   
	    		   reverseButtons: true, // 버튼 순서 거꾸로
	    		   
	    		}).then(result => {
	    		   // 만약 Promise리턴을 받으면,
	    		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
	    		      Swal.fire('수정이 완료되었습니다.','','success').then(() => {
	    	                $('form').submit();
	    	            });
	    		   }
	    		});
	    });
		
		$('.btn-danger').on('click', function(e) {
	    	e.preventDefault();
	    	Swal.fire({
	    		   title: '게시물을 삭제하시겠습니까?',
	    		   text: '',
	    		   icon: 'warning',
	    		   
	    		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
	    		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
	    		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
	    		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
	    		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
	    		   
	    		   reverseButtons: true, // 버튼 순서 거꾸로
	    		   
	    		}).then(result => {
	    		   // 만약 Promise리턴을 받으면,
	    		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
	    		      Swal.fire('삭제가 완료되었습니다.','','success').then(() => {
	    		    	  $('form').attr('action', '/auction/remove'); 
	    	                $('form').submit();
	    	            });
	    		   }
	    		});
	    });

	</script>

	<%@ include file="../includes/footer.jsp"%>