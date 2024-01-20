<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="main">

	<section class="module bg-dark-30 about-page-header" data-background="/resources/live/assets/images/fund.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h1 class="module-title font-alt mb-0">Fund Register</h1>
				</div>
			</div>
		</div>
	</section>

	<section class="module">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<h4 class="font-alt mb-0">Register Form</h4>
					<hr class="divider-w mt-10 mb-20">

					<div class="row">
						<div class="col-sm-8">
						
							<form action="/fund/register" method="post" role="form">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}"> <input type="hidden" name="mid"
									value="<sec:authentication property='principal.username'/>">

								<div class="form-group">
									<label>작가명</label> <input type="text" name="artist" id="artist"
										value="<sec:authentication property='principal.mvo.name'/>"
										readonly class="form-control">
								</div>

								<div class="form-group">
									<label>펀딩명</label> <input type="text" name="fundName"
										id="fundName" class="form-control">
								</div>

								<div class="form-group">
									<label>PR</label>
									<textarea name="pr" id="pr" class="form-control" rows="3"
										placeholder="최대 2000자" required></textarea>
									<p>Bytes: <span id="byteCount">0</span></p>
								</div>

								<div class="form-group">
									<label>목표금액</label> <input type="number" name="targetPrice"
										id="targetPrice" required>
								</div>



								<div class="form-group">
									<label>시작/종료일</label>
									<input type="date" name="startDate" id="startDate"
										required style="margin-left: 10px; margin-top: 10px;">
									~<input type="date" name="endDate" id="endDate" required
										style="margin-left: 10px; margin-top: 10px;">
								</div>
								<!-- 등록 안된 이유 -> date때문! vo에 @DateTimeFormat(pattern="yyyy-MM-dd") 넣어줬더니 됨-->


								<div class="form-group">
									<button type="reset" class="btn btn-default">Reset</button>
									<button type="button" class="btn btn-warning"
										onclick="history.back()">Cancel</button>
									<button type="submit" id="submitBtn" class="btn btn-primary">Submit</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Section -->
</div>
<!-- End Main -->


<script>
//소개 부분에서 4000바이트 크기 제한하기.------------

//textarea의 내용이 변경될 때 호출되는 함수
  function updateByteCount() {
      var pr = $('#pr');
      var byteCount = $('#byteCount');

      // UTF-8로 인코딩하고 바이트 수 계산
      var text = pr.val();
      var encodedText = unescape(encodeURIComponent(text)); // UTF-8 인코딩
      var length = encodedText.length;

      $("#byteCount").text(length + " bytes");

      // 4000바이트 이상이면 버튼 비활성화, 미만이면 활성화
//       if (length > 4000) {
//           submitButton.disabled = true;
//       } else {
//           submitButton.disabled = false;
//       }

}


  $('#pr').on('input',function(){
     updateByteCount();
     
  });


//소개 부분에서 4000바이트 크기 제한하기 end-----------

    //submit 버튼 이벤트 처리-------------------------
    var frm = $('form[role="form"]');

    $('#submitBtn').on('click', function (event) {
        event.preventDefault();
        
        var mid = $('#mid').val();
        var fundName = $('#fundName').val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();
        var pr = $('#pr').val();
        var targetPrice = $('#targetPrice').val();
        
       console.log(mid);
       console.log(fundName);
       console.log(startDate);
       console.log(endDate);
       console.log(pr);
       console.log(targetPrice);
       
    // 입력값이 비어있는지 확인
		if (fundName === '' || startDate === '' || endDate === ''
				|| pr === '' || targetPrice === '') {
			// 입력값이 비어있는 경우 알림창을 띄움
			/* alert('입력값을 모두 작성해주세요.'); */
			Swal.fire('입력값을 모두 작성해주세요.', '', '');
			return;
		}
       
        console.log('submitBtn 눌림!');
       frm.submit();
    });
    
	//게시물 알림창
	$(document).ready(function(){
		
	    var funderror = "${funderror}"; // 작품 삭제 실패
	    
	    if(funderror === "error") {
	        alert(funderror);
	    }
	});
</script>

<%@ include file="../includes/footer.jsp"%>
