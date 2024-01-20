<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<title>회원가입</title>
<style>

 .all {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
         /*margin: px 0; Adjust the margin as needed */
        
        border-top: 1px solid black;
        border-bottom: 1px solid black;
    
    }
.all .allBtn { text-align: center;}   
form{width: 500px;}

.main{padding:90px;}

.input { margin: 20px 0px;}
.line{padding: 50px 0px; } 
.errorpw {
   color: red;
  /*   position: relative;
    right: -320px; 오른쪽으로 이동하는 정도 조정 가능 
    top: -30px;
    font-size: 14px;*/
}
.errorid {
color: red;
  /*   position: relative;
    right: -320px; 오른쪽으로 이동하는 정도 조정 가능 
    top: -30px;
    font-size: 14px;*/

}

.okid { 
color: green;
   /*  position: relative;
    right: -320px; 오른쪽으로 이동하는 정도 조정 가능 
    top: -30px;
    font-size: 14px;
padding-left: 40px;*/
}

.allBtn { margin-top: 20px; text-align: center; }
.btn {text-align: center; padding: 90px; margin: 0px 50px;}
.allBtn .okBtn { background-color: rgb(174, 214, 241);}

.phoneInput { width: 160px; display: inline-block; }

.emailInput { width: 160px; display: inline-block;}
#email1 { width: 170px;}


#phone-divider {
  margin: 0 5px; /* 원하는 간격 설정 */
  line-height: 30px; /* 수직 가운데 정렬을 위한 높이 설정 */
  display: inline-block;
  width: 7px;

}

#email-divider {
  margin: 0 10px; /* 원하는 간격 설정 */
  line-height: 30px; /* 수직 가운데 정렬을 위한 높이 설정 */
  display: inline-block;
 padding-left: 5px;
}

</style>

<%@ include file="../includes/header.jsp" %>
 
 <section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/p.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">Sign Up</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">회원가입</h2>
              </div>
            </div>
          </div>
        </section>


	<section class="module main">
          <div class="container">
            <div class="row">
             <div class="all">
                <h4 class="font-alt">Sign Up</h4>  
				<form action="/artauction/userJoin" method="post" class="form-horizontal joinform">				
				
				<div class="line">
					<div class="form-group">
						<label><b>아이디</b></label>
						<div class="input">
           						 <input type="text" name="mid" id="mid" class="form-control"
           						 placeholder="5~10자, 영문 숫자 조합" required >
           						 </div>		
					</div>
					<div class="form-group">
						<label><b>비밀번호</b></label>
						<div class="input">
							<input type="password" name="pw" id="pw" class="form-control"
								placeholder="5 ~ 20자 ,숫자,영문,특수문자 조합" required>	
						</div>
					</div>
	
					<div class="form-group">
						<label><b>비밀번호 확인</b></label>
						<div class="pwinput" >
							<input type="password" name="pwcheck" id="pwcheck" class="form-control" required>	
						</div>
					</div>
	
					<div class="form-group">
						<label><b>이름</b></label>
						<div class="input">
							<input type="text" name="name" id="name" class="form-control" required >	
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
							<input type="text" name="phone2" id="phone2" class="form-control"
								required maxlength="4">
						</div>
						<div id="phone-divider">-</div>
						<div class="input phoneInput">
							<input type="text" name="phone3" id="phone3" class="form-control"
								 required maxlength="4">
						</div>
					</div>
					
					</div>
					
					<div class="form-group">
						<label><b>이메일</b></label>
						<div class="input">
						<div class="emailInput">
							<input type="text" name="email1" id="email1" class="form-control">	
						</div>
						<div id="email-divider">@</div>
						<div class="input emailInput">
							<input type="text" name="email2" id="email2" class="form-control">
						</div>
						<div class="input emailInput">
							<select class="form-control" name="email3" id="email3" >
								<option selected>직접 입력</option>
								<option>gmail.com</option>
								<option>naver.com</option>
								<option>daum.com</option>
							</select>
						</div>
					</div>
					</div>
					</div>
					<div class="form-group"> 
						<div class="allBtn" >
							<input type="submit" class="mainBtn btn"
								   value="메인으로">
							<input type="submit" class="okBtn btn"
								   value="회원가입">
						</div>
					</div>
				<input type="hidden" name="email" id="email">
				<input type="hidden" name="phone" id="phone">	
				 <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
			
			</form>
		</div>
</div></div>
</section>
	
	
	<script>
	
	// beforeSend 대신 CSFR 토큰 헤더 추가-----------------
    var csrfHeaderName = '${_csrf.headerName }';   // CSRF 토큰 관련 변수
	   var csrfTokenValue = '${_csrf.token }';		  // 토큰
	   $(document).ajaxSend(function(e,xhr, options){
		   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	   });
 
	   // beforeSend 대신 CSFR 토큰 헤더 추가 END -----------------------------
	
	 $(function(){ 
	// 여기 비밀번호 확인 onchange로 하기 둘다 onchange가 되어서 확인이 되어야함.
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
    
	
    /* $('#pwcheck').on('change', function(){
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
       	
    	
    }); */
    // 비밀번호 일치 확인 end----------------------
    
    // 아이디 중복확인 ajax------------------------
    
    
   $('#mid').on('input',function(){// 아이디 입력값 가져오기
	      
	   var mid = $('#mid');
	   var errorid = $('.errorid'); // 에러 메시지 요소
	   var okid = $('.okid');       // 성공시
	   var midval = mid.val();
	   var regex = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{5,10}$/;
	 //  /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-=])[A-Za-z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-=']{5,10}$/;
	 //  /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;  //8~16자 영문, 숫자 조합
	       
	   $.ajax({
	        type: 'POST',
	        url: '/artauction/idcheck', // 중복 확인을 위한 서버 엔드포인트 URL
	        data: { mid: midval }, // 아이디를 POST 요청으로 보냅니다.
	        dataType: 'text',
	        success: function(result) {
	        	console.log(result)
	        	console.log(midval)
	            // 서버에서의 응답 처리
	            if (result === 'no') {
	            	errorid.remove();
	            	okid.remove();	
	            	var errorMessage = $('<div class="errorid">이미 사용 중인 아이디입니다.</div>'); 
	            	mid.after(errorMessage); 
	            } else if (result === 'ok') {
	            	// 사용가능한 아이디이지만 형식이 올바르지 않을때
	            	// 아이디 형식 검증
	            	 if(!regex.test(midval)) {
	            		errorid.remove();
	                 	okid.remove();	
	                 	var errorMessage = $('<div class="errorid">아이디 형식을 확인해주세요.</div>'); 
	                 	mid.after(errorMessage);
	                 	return;
	         	    }
	            	    errorid.remove();
	            		okid.remove();
	            		var errorMessage = $('<div class="okid">사용 가능한 아이디입니다.</div>'); 
	            		mid.after(errorMessage);
	            } else {
	                alert('서버 오류 또는 알 수 없는 응답입니다.');
	            }
	        },
	        error: function(error) {
	            // 오류 처리
	            alert('서버 요청 중 오류가 발생했습니다.');
	            console.log(error)
	        }
	    });  // ajax 끝
	   
   }); 
  
    
    // 아이디 중복확인 ajax end ------------------
	
	
	// 버튼 눌렀을때는 다름 함수 사용하기, 모든 입력값 파악.

	$('.okBtn').on('click', function(e) {
	    e.preventDefault(); // onclick 말고 이렇게도 가능함.
	    
	    var pw = $('#pw');   // .val()을 사용하여 값 가져오기
	    var pwcheck = $('#pwcheck');
	    var errorpw = $('.errorpw'); // 에러 메시지 요소
	    var mid = $('#mid');
	    var name = $('#name');
	    var email1 = $('#email1');
	    var email2 = $('#email2');
	    var phone1 = $('#phone1');
	    var phone2 = $('#phone2');
	    var phone3 = $('#phone3');
	    
	 // 빈칸 안돼
	    if (mid.val()=== '' || pw.val() === '' || pwcheck.val() === '' || name.val() === '' || email1.val() === '' || email2.val() === '' || phone1.val() === '' || phone2.val() === '' || phone3.val() === '') {
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
	 
	 // 아이디 형식 검증
	 if(!/^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{5,10}$/.test(mid.val())){
		 Swal.fire({
   	      icon: 'warning',
   	      title: '아이디를 확인해주세요.',
   	      text: '아이디는 5~10자, 영문 + 숫자 조합이어야 합니다.',
   	    });     
       return;
		 
	 }

	    // 이메일 합치기
	    var email = $('#email');
	    var email1 = $('#email1');
	    var email2 = $('#email2');
	    var joinform = $('.joinform');

	    email.val(email1.val() + '@' + email2.val());

	    // 전화번호 합치기
	    var phone = $('#phone');
	    var phone1 = $('#phone1');
	    var phone2 = $('#phone2');
	    var phone3 = $('#phone3');

	    phone.val(phone1.val() + '-' + phone2.val() + '-' + phone3.val());

	    joinform.submit();
	});
	
    
    // 이메일 선택하면 value값 -----------------------
    
		var email2 = $('#email2');
		var email3 = $('#email3');
		
		$('#email3').on('change',function(){
			
			if(email3.val() == '직접 입력'){ 
				email2.prop('readonly', false);		
				email2.val('');					 
			}else{
				email2.val(email3.val()); 
				email2.prop('readonly', true);
			}	
			
			
		});

	// 이메일 선택하면 value값 end -----------------------
	
	
	// 메인으로 버튼 클릭시 ------
	
	$('.mainBtn').on('click',function(e){
		e.preventDefault();
		
		$('.joinform').attr('action','/artauction/main');
		$('.joinform').attr('method','get');
		
		$('.joinform').submit();
			
	});
	
	// 메인으로 버튼 클릭시 end-----
	
	
	
	 });//END $
	 
	
	 
	</script>
						
	<%@ include file="../includes/footer.jsp" %>