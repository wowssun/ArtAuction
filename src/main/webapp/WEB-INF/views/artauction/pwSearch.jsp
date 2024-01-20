<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>비밀번호 찾기</title>
<style>

.centered-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 60vh; /* 화면 높이에 맞게 설정 */
}

.line {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
         /*margin: px 0; Adjust the margin as needed */
        
    
    }

#name {width: 555px;}
#mid {width: 555px;}
form .btn {text-align: center; background:rgb(213, 245, 227); color:rgb(11, 83, 69); margin-top:40px;}



.phoneInput { width: 160px; display: inline-block; }

#phone-divider {
  margin: 0 12px; /* 원하는 간격 설정 */
  line-height: 30px; /* 수직 가운데 정렬을 위한 높이 설정 */
  display: inline-block;
  width: 7px;

}

.phonelb { margin-right: 150px;}

 form{ border:1px solid lightgray; padding: 50px; }
 .btn{margin: 20px;}

form .backBtn { background: rgb(213, 216, 220);}
</style>

	<%@ include file="../includes/header.jsp" %>
	
	<section class="module bg-dark-30 parallax-bg restaurant-menu-bg" style="background-image: url(&quot;/resources/img/title/b.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
				<h5 class="font-serif">Find Password</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">비밀번호 찾기</h2>
              </div>
            </div>
          </div>
        </section>
	
<div class="main">
		<div class="container centered-content">
			<form action="/artauction/pwChange" class="form-horizontal" id="pwSearchFrm">
		
			 <div class="line">
			<div class="form-group">
						<label><b>아이디</b></label>
						<div class="input">
						<input type="text" name="mid" id="mid" class="form-control" required>		
					</div>
				</div>
					
			<div class="form-group">
					<label><b>이름</b></label>
					<div class="input">
						<input type="text" name="name" id="name" class="form-control" required>		
					</div>
				</div>
					
	 <div class="form-group">
			     <label><b>전화번호</b></label>
			     <div class="input">
						<div class="phoneInput">
			        <select class="form-control" name="phone1" id="phone1">
			            <option value="010" selected>010</option>
			            <option value="011">011</option>
			            <option value="017">017</option>
			            <option value="019">019</option>
			        </select>
			    </div>
			   <div id="phone-divider">-</div>
			    <div class="input phoneInput">
			        <input type="text" name="phone2" id="phone2" class="form-control" required maxlength="4">
			    </div>
			 <div id="phone-divider">-</div>	
			    <div class="input phoneInput">
			        <input type="text" name="phone3" id="phone3" class="form-control" required maxlength="4">
			    </div>
			</div>
		</div>
            <div class="button-container">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                 <input type="hidden" name="mid" value="${_csrf.token}">
                 <input type="button" class="btn backBtn find-btn1" value="뒤로가기">
                <input type="submit" class="btn pwSearchBtn" value="확인">
            </div>
			</div>
			</form>
		</div>
	</div>
	
	
	<script>
	
	 // beforeSend 대신 CSFR 토큰 헤더 추가-----------------
       var csrfHeaderName = '${_csrf.headerName }';   // CSRF 토큰 관련 변수
	   var csrfTokenValue = '${_csrf.token }';		  // 토큰
	   $(document).ajaxSend(function(e,xhr, options){
		   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	   });
    
	   // beforeSend 대신 CSFR 토큰 헤더 추가 END -----------------------------
	
	$('.pwSearchBtn').on('click', function(e) {
		 e.preventDefault();
		 
	    var midval = $('#mid').val();
	    var nameval = $('#name').val();
		var phoneval = $('#phone1').val() + '-' + $('#phone2').val() + '-' + $('#phone3').val();
		var pwSearchFrm = $('#pwSearchFrm');
		
		console.log(midval);
		console.log(nameval);
		console.log(phoneval);
			
		// 이름과 전화번호 칸이 모두 null값이면 안된다. 길이가 1이하면 안된다.
		// 그때 길이 체크해서 알림창을 뿌려준다.
		// 어차피 본인인증을 해서 넘어가기 때문에 중복되는 값은 없을것.
		
		if (midval.length < 1) {
				Swal.fire({
					  icon: 'warning',  // 여기다가 아이콘 종류를 쓰면 됩니다.                     
					  title: '아이디를 입력해주세요.',    
					  text: '', 
					});
					  return;
					 }
		
		
			if (nameval.length < 1) {
				Swal.fire({
					  icon: 'warning',  // 여기다가 아이콘 종류를 쓰면 됩니다.                     
					  title: '이름을 입력해주세요.',    
					  text: '', 
					});
					  return;
					 }

			 if (phoneval.length != 13) {
				 Swal.fire({
					  icon: 'warning',  // 여기다가 아이콘 종류를 쓰면 됩니다.                     
					  title: '전화번호를 \n 정확하게 입력해주세요.',    
					  text: '', 
					});
				  return;
			 }
				  
		 $.ajax({
			    type: 'POST',
			    url: '/artauction/pwSearch',
			    data: { mid : midval , name: nameval, phone: phoneval },
			   // contentType : 'application/json',
			    dataType: 'text',
			    success: function(result) {
			        console.log(result);
			        
			        if (result === 'no' ) {
			        	Swal.fire(
			        			  '일치하는 회원 정보가 \n 없습니다!',
			        			  '',
			        			  'question'
			        			)
			        		return;
			        }else {
			        	// 여기서 폼 제출하기
			        	 Swal.fire({
			                title: '비밀번호 변경페이지로 \n 이동합니다!',
			                icon: 'success',
			                showConfirmButton: true, // 확인 버튼 보이기
			                confirmButtonText: '확인', // 확인 버튼의 텍스트 설정
			            }).then((result) => {
			                if (result.isConfirmed) {
			                   
			                    pwSearchFrm.submit();
			                }
			        	
			            });
			        }
			    },
			    error: function(xhr, status, er) {
			        // 오류 처리
			        console.error(er);
			    }
			});
		 
	});  // end
	   
	// 뒤로가기    
	$('.backBtn').on('click',function(e){
		   e.preventDefault();
		   
		   location.href='/artauction/userLogin';
		   
		   
	   });  // 뒤로가기 end
	   
	   	
	</script>

	<%@ include file="../includes/footer.jsp" %>