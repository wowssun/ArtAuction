<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%@ include file="../includes/header.jsp"%>

<header class="py-5 bg-image-full"
	style="background-image: url('https://source.unsplash.com/wfh8dDlNFOk/1600x900')">
	<div class="text-center my-5">
		<img class="img-fluid rounded-circle mb-4"
			src="https://dummyimage.com/150x150/6c757d/dee2e6.jpg" alt="..." />
		<h1 class="text-white fs-3 fw-bolder">Full Width Pics</h1>
		<p class="text-white-50 mb-0">Landing Page Template</p>
	</div>
</header>

<style>
.cregi {
	width: 200px;
}
</style>
<div>
	<br>
	<form action="/review/reviewRegi" method="post" role="form">
		
		<div> <!-- name도....맞춰줘야..함 -->
			<textarea name="classinfo" class="content cregi" rows="4"></textarea>
		</div>
		<br>
		
		<div class="regDate">
			<input type="text" name="regDate" id="regDate" class="" readonly>
		</div>
		<br>

		<div class="date">
			<input type="text" name="reviewer" id="reviewer" class=""  readonly>
		</div>
		<br>

		<button type="submit" class="submitBtn">등록 완료</button>
		<button type="button" class="cancleBtn" onclick="history.back()">취소</button>

		<input type="hidden" name="cno" value="${view.cno }"/>">
		
		<input type="hidden" name="${_csrf.parameterName }"
			value="${_csrf.token }">

	</form>
</div>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> jQuery 스크립트 추가 -->
<script>
var form = $('form[role="form"]');
	
	//submit(등록) 버튼 이벤트 처리-------------
	$('.submitBtn').on('click', function(e){
		event.preventDefault();
		console.log("게시글 등록");
		
		var formData = $('form[role="form"]').serialize(); //이게 뭘까?
		console.log('Form Data:', formData);

		var hiddenTag = '';
	
		$('.uploadResult ul li').each(function(i, obj){
			var uuid =  $(obj).data("uuid");
			var filename =  $(obj).data("filename");
		
			hiddenTag += '<input type="hidden" name="classimg" value="' + filename + '">';
		
		});
// 		alert("여긴되냐 x");
		form.append(hiddenTag);
		console.log(hiddenTag);
		form.submit();
	});
	//END submit 버튼 이벤트 처리-------------
	
	var csrfHeaderName = '${_csrf.headerName}';
	var csrfTokenValue = '${_csrf.token}';
	

</script>

<%@ include file="../includes/footer.jsp"%>