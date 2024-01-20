<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-30 about-page-header"
		data-background="/resources/img/title/qna.jpg">
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
					<h4 class="font-alt mb-0">게시물 수정</h4>
					<hr class="divider-w mt-10 mb-20">
					
					<sec:authorize access="hasRole('USER') || hasRole('ARTIST')">
					<form class="form" action="/inquiry/modify" method="post"
						role="form">
						<div class="form-group">
							<label>제목</label> <input class="form-control" type="text"
								name="title" value="${ivo.title}">
						</div>

						<div class="form-group">
							<label>질문</label>
							<textarea class="form-control" rows="7" name="detail">${ivo.detail}</textarea>
						</div>
						
						<div>
							<input type="hidden" name="mid" value="${ivo.mid}"> <input
								type="hidden" name="rno" value="${ivo.rno}">
						
						</div>
						<button data-oper="remove" class="btn btn-danger"
							formaction="/inquiry/remove">Remove</button>
						<button type="button" class="btn btn-warning"
							onclick="history.back()">Cancel</button>
						<button type="submit" class="btn btn-primary">Submit</button>
						<input type="hidden" name="${_csrf.parameterName }"
							value="${_csrf.token }">
		
					</form>
					</sec:authorize>

					<sec:authorize access="hasRole('ADMIN')">
						<form class="form" action="/inquiry/modifyAdmin" method="post"
							role="form">
							<div class="form-group">
								<label>답변</label>
								<textarea class="form-control" rows="7" name="answer"></textarea>
							</div>
							
							<div>
								<input type="hidden" name="mid" value="${ivo.mid}"> <input
									type="hidden" name="rno" value="${ivo.rno}">
							</div>
							
							<button data-oper="remove" class="btn btn-danger"
								formaction="/inquiry/remove">Remove</button>
							<button type="button" class="btn btn-warning"
								onclick="history.back()">Cancel</button>
							<button type="submit" class="btn btn-primary">Submit</button>
							<input type="hidden" name="${_csrf.parameterName }"
								value="${_csrf.token }">
						
						</form>
					</sec:authorize>

				</div>
			</div>
		</div>
	</section>
	<script>
$('.btn-primary').on('click', function(e) {
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