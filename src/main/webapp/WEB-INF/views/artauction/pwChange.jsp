<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>비밀번호 변경</title>
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

.errorpw {
   color: red;
    font-size: 14px;
}

.form-group input {width: 500px;}


</style>
	
	<%@ include file="../includes/header.jsp" %>
	
	<section class="module bg-dark-30 parallax-bg restaurant-menu-bg" style="background-image: url(&quot;/resources/img/title/b.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
				<h5 class="font-serif">Change Password</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">비밀번호 변경</h2>
              </div>
            </div>
          </div>
        </section>
	
<div class="main">
		<div class="container centered-content">
			<form action="/artauction/pwChange" method="post" class="form-horizontal" id="pwChangeFrm">
			
			<div class="line">
				<div class="form-group">
					<label><b> 새로운 비밀번호</b></label>
					<div class="input">
						<input type="password" name="pw" id="pw" class="form-control"
							placeholder="알파벳,숫자,특수문자 포함 8글자 이상" required>
					</div>	
				</div>
				
				<div class="form-group">
					<label><b>새로운 비밀번호 확인</b></label>
					<div class="pwinput" >
						<input type="password" name="pwcheck" id="pwcheck" class="form-control" required>
					</div>
				</div>

				<input type="hidden" name="mid" value="${param.mid }">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">

				<div class="button-container">
				<button type="submit" class="btn btn-info regBtn"  >비밀번호 변경</button>
		</div>
			</div>
			</form>
		</div>
	</div>
	
	<script>
	
	
	 $(function(){ 
		 
		// 비밀번호 일치 확인 함수----------------------
		    
		    function check(){
				
		    	var pw = $('#pw');   // .val()을 사용하여 값 가져오기
		        var pwcheck = $('#pwcheck');
		        var errorpw = $('.errorpw'); // 에러 메시지 요소
				
		        if (pw.val() !== pwcheck.val()) {
		            // 비밀번호가 일치하지 않을 때 메시지
				        	errorpw.remove();  // 메시지 있으면 먼저 삭제
		            
				            var errorMessage = $('<div class="errorpw">비밀번호가 일치하지 않습니다.</div>'); 
				            pwcheck.after(errorMessage); // 비밀번호 확인란 아래에 메시지 추가
				        	return;
				            
		        } else {
		            // 비밀번호가 일치하면 메시지 삭제
		            errorpw.remove();
		        }
				
				
			}

			// 비밀번호 일치 확인 함수 end--------------------- 
		 
			
			// 비밀번호 확인란에서 
		    $('#pwcheck').on('input', function(){
		    	
		    	check();
		    });
		    
			// 비밀번호란에서
			$('#pw').on('input', function(){
		    	
		    	check();
		    });
	
			// 비밀번호 일치 확인 end----------------------
			
			
		 $('.regBtn').on('click',function(e){
		  e.preventDefault();  // 기존 버튼 막기
		  
				//  데이터 확인하기
				var mid = '${param.mid}';
				console.log(mid);
		
		    var pw = $('#pw');   // .val()을 사용하여 값 가져오기
		    var pwcheck = $('#pwcheck');
		    var errorpw = $('.errorpw'); // 에러 메시지 요소
		    
		 // 빈칸 안돼
		    if (pw.val() === '' || pwcheck.val() === '') {
		    	Swal.fire({
		    	      icon: 'warning',
		    	      title: '모두 입력해주세요.',
		    	      text: '',
		    	    });
		        return;
		    }	
		    
		    // 비밀번호 일치 확인
		    if (pw.val() !== pwcheck.val()) {
		    	Swal.fire({
		    	      icon: 'warning',
		    	      title: '비밀번호가 일치하지\n 않습니다.',
		    	      text: '',
		    	    });  
		        return;
		    }
		
		    
			 // 비밀번호 형식 검증
			    if (!/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@#$%^&+=!])[A-Za-z\d@#$%^&+=!]{5,20}$/.test(pw.val())) {
			    	Swal.fire({
			    	      icon: 'warning',
			    	      title: '비밀번호를 확인해주세요.',
			    	      text: '비밀번호는 5~20자, 숫자 + 영문 + 특수문자 조합이어야 합니다.',
			    	    });     
			        return;
			    }
		
		 $('#pwChangeFrm').submit();
		});
	
			 });//END $
			 
	 
			</script>
	
	

	<%@ include file="../includes/footer.jsp" %>