<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>

<div class="main">
	<section class="module bg-dark-30 about-page-header" data-background="/resources/live/assets/images/fund.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h1 class="module-title font-alt mb-0">Fund Modify</h1>
				</div>
			</div>
		</div>
	</section>
	
	
	<section class="module" style="padding: 50px;">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<h4 class="font-alt mb-0">Modify Form</h4>
					<hr class="divider-w mt-10 mb-20">
					
					<div class="row">
						<div class="col-sm-8">
    <form action="/fund/modify" method="post" role="form">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      	<input type="hidden" name="fno" value="${fvo.fno }">
       
        <div class="form-group">
            <label>아이디</label>
            <input type="text" name="mid" id="mid" class="form-control"
                   value="${fvo.mid }" readonly class="form-control">
        </div>

        <div class="form-group">
            <label>펀딩명</label>
            <input type="text" name="fundName" id="fundName" 
            value="${fvo.fundName }" class="form-control">
        </div>
        
         <div class="form-group">
            <label>PR</label>
            <textarea name="pr" id="pr" class="form-control" rows="3" required>${fvo.pr }</textarea>
            <p>Bytes: <span id="byteCount">0</span></p>
        </div>
        
        <div class="form-group">
            <label>목표금액</label>
            <input type="number" name="targetPrice" id="targetPrice" 
            value="${fvo.targetPrice }" required>
        </div>
        
        

        <div class="form-group">
            &nbsp;시작/종료일
            <input type="date" name="startDate" id="startDate" 
            value="${startDate }" required style="margin-left: 10px; margin-top: 10px;">
            <input type="date" name="endDate" id="endDate" 
            value="${endDate }" required style="margin-top: 10px;">
        </div>
        <!-- 등록 안된 이유 -> date때문! vo에 @DateTimeFormat(pattern="yyyy-MM-dd") 넣어줬더니 됨-->

<!-- 로그인한 사용자가 작성한 글 -> 수정/삭제버튼 표시 -->
<sec:authorize access="isAuthenticated()">
<sec:authentication property='principal.username' var="loginId"/>
<c:if test="${loginId == fvo.mid or loginId == 'admin'}">

<button data-oper="remove" class="btn btn-danger"
		formaction="/fund/remove">
		Remove</button>
<button data-oper="modify" id="modBtn" class="btn btn-warning">
		Modify</button>

</c:if>
</sec:authorize>

<button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>

<!-- 페이지 번호와 페이지에 표시할 게시물의 수, 검색 타입, 키워드 -->
<input type="hidden" name="sort" 	value="${cri.sort}">
<%-- <input type="hidden" name="type" 	value="${cri.type}">
<input type="hidden" name="keyword" value="${cri.keyword}"> --%>
<input type="hidden" name="pageNum" value="${cri.pageNum}">
<input type="hidden" name="amount"  value="${cri.amount}">

							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Section -->


<script>
    //submit 버튼 이벤트 처리-------------------------
    var frm = $('form[role="form"]');
    
    function updateByteCount() {
        var pr = $('#pr');
        var byteCount = $('#byteCount');

        // UTF-8로 인코딩하고 바이트 수 계산
        var text = pr.val();
        var encodedText = unescape(encodeURIComponent(text)); // UTF-8 인코딩
        var length = encodedText.length;

        $("#byteCount").text(length + " bytes");


  }


    $('#pr').on('input',function(){
       updateByteCount();
       
    });

/*     $('#modBtn').on('click', function (event) {
        event.preventDefault();
        
        var fno = $('#fno').val();
        var mid = $('#mid').val();
        var fundName = $('#fundName').val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();
        var pr = $('#pr').val();
        var targetPrice = $('#targetPrice').val();
       
       console.log(fno);
       console.log(mid);
       console.log(fundName);
       console.log(startDate);
       console.log(endDate);
       console.log(pr);
       console.log(targetPrice);
       
        console.log('modBtn 눌림!');
        console.log(hidden);
       //frm.submit();
    }); */

  //작품 삭제
/*     $('button[data-oper="remove"]').on('click', function(event) {
        var result = confirm('정말로 삭제하시겠습니까?');
        if (!result) {
            // 취소 버튼을 누른 경우 폼 전송을 막음
            event.preventDefault();
            alert("펀딩 삭제를 취소하였습니다.");
        }
    }); */
 
	
    
  //게시물 알림창
/*     $(document).ready(function(){
        var modifyfunderror = "${modifyfunderror}"; // 펀딩 수정 실패
        var funddeletererror = "${funddeletererror}"; // 펀딩 삭제 실패
        
        if(modifyfunderror === "error") {
            alert("펀딩 수정에 실패했습니다. 다시 시도해주세요.");
        }else if(funddeletererror === "error") {
            alert("펀딩 삭제에 실패했습니다. 다시 시도해주세요.");
        }
    }); */
  
    var result = '${result }';
    userOut(result);

    history.replaceState({}, null, null); // history 초기화

    function userOut(result) {
    	// result 값이 있는경우에 알림창 표시

    	if (result === '' || history.state) {
    		return;
    	}

    	if (result == 'modifyfunderror') {
    		Swal.fire('펀딩 수정에 실패했습니다. 다시 시도해주세요.', '', 'success')
    	}

    }

   $('button[data-oper="remove"]').on('click', function(e) {
   	e.preventDefault();
   	Swal.fire({
   		   title: '이 펀딩을 삭제하시겠습니까?',
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
   		      Swal.fire('삭제가 완료되었습니다.','','funddelete').then(() => {
   		    	  $('form').attr('action', '/fund/remove'); 
   	                $('form').submit();
   	            });
   		   }
   		});
   });

  
</script>

<%@ include file="../includes/footer.jsp" %>
