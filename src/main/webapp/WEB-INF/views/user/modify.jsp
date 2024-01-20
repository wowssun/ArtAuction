<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>정보 수정</title>
<style>

.all {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
         /*margin: px 0; Adjust the margin as needed */
        height: 60vh;
        
      
    
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

<section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/l.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">Try our confectionery</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">정보 수정</h2>
              </div>
            </div>
          </div>
        </section>
        
        <div class="main">
			 <div class="container">
           		 <div class="row">
             		<div class="all">
				
				<form action="/user/modify" method="post" class="form-horizontal modifyform">
				<div class="line">
					<div class="form-group ">
						<label><b>아이디</b></label>
						<div class="input">
           						 <input type="text" name="mid" id="mid" class="form-control"
           						  readonly value="${mvo.mid }" >
           						 </div>		
						</div>
					<div class="form-group">
						<label><b>이름</b></label>
						<div class="input">
							<input type="text" name="name" id="name" class="form-control" readonly value="${mvo.name }">	
						</div>
					</div>

					<div class="form-group">
						<label><b>전화번호</b></label>
						<div class="input">
						<div class="phoneInput">
							<select class="form-control" name="phone1" id="phone1">
								<option value="010"  ${phone1 eq '010' ? 'selected' :'' }>010</option>
								<option value="011" ${phone1 eq '011' ? 'selected' :'' }>011</option>
								<option value="017" ${phone1 eq '017' ? 'selected' :'' }>017</option>
								<option value="019" ${phone1 eq '019' ? 'selected' :'' }>019</option>
							</select>
						</div>
						<div id="phone-divider">-</div>
						<div class="input phoneInput">
							<input type="text" name="phone2" id="phone2" class="form-control"
								 maxlength="4" value="${phone2 }">
						</div>
						<div id="phone-divider">-</div>
						<div class="input phoneInput">
							<input type="text" name="phone3" id="phone3" class="form-control"
								  maxlength="4" value="${phone3 }">
						</div>
					</div>
					</div>
					
					<div class="form-group">
						<label><b>이메일</b></label>
						<div class="input">
						<div class="emailInput">
							<input type="text" name="email1" id="email1" class="form-control"  value="${email1 }">	
						</div>
						<div id="email-divider">@</div>
						<div class="input emailInput">
							<input type="text" name="email2" id="email2" class="form-control" value="${email2 }"> 
						</div>
	
						<div class="input emailInput">
							<select class="form-control" name="email3" id="email3"
								    onchange="javascript:setEmail(this)">
								<option ${email2 eq '${email2 }' ? 'selected' :'' }>직접 입력</option>
								<option value="gmail.com" ${email2 eq 'gmail.com' ? 'selected' :'' }>gmail.com</option>
								<option value="naver.com"${email2 eq 'naver.com' ? 'selected' :'' }>naver.com</option>
								<option value="daum.com"${email2 eq 'daum.com' ? 'selected' :'' }>daum.com</option>
							</select>
						</div>
					</div>
					</div>
					</div>
					<div class="form-group"> 
						<div class="allBtn" >
							<input type="submit" class="cancelBtn btn"
								   value="뒤로가기" formaction="/user/myinfo" formmethod="get">
							<input type="submit" class="okBtn btn"
								   value="수정하기">
						</div>
					</div>
				<input type="hidden" name="email" id="email">
				<input type="hidden" name="phone" id="phone">	
				 <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
			</form>
		</div>
	</div>
</div></div>
<script>
		
	$('.okBtn').on('click', function(e) {
	    e.preventDefault(); // onclick 말고 이렇게도 가능함. 
	    
	    var mid = $('#mid');
	    var name = $('#name');
	    var email = $('#email');
	    var email1 = $('#email1');
	    var email2 = $('#email2');
	    var phone = $('#phone');
	    var phone1 = $('#phone1');
	    var phone2 = $('#phone2');
	    var phone3 = $('#phone3');
	    var modifyform = $('.modifyform');
	        
	 // 빈칸 안돼
	    if (mid.val()=== '' || name.val() === '' || email1.val() === '' || email2.val() === '' || phone1.val() === '' || phone2.val() === '' || phone3.val() === '') {
	    	Swal.fire({
	    	      icon: 'warning',
	    	      title: '모두 입력해주세요.',
	    	      text: '',
	    	    });
	        return;
	    }	

	    // 이메일 합치기
	    
	    email.val(email1.val() + '@' + email2.val());

	    // 전화번호 합치기
	   
	    phone.val(phone1.val() + '-' + phone2.val() + '-' + phone3.val());

	    console.log(email.val())
	    console.log(phone.val())
	    console.log(mid.val())
	    console.log(name.val())
	    
	   modifyform.submit();
	});
	
// 이메일 선택하면 value값 -----------------------
    
	function setEmail(obj){
			
		var email2 = document.getElementById('email2');
		var email3 = document.getElementById('email3');
				
			if(email3.value == '직접 입력'){ 
				email2.readOnly = false;  		
				email2.value = '';					 
			}else{
				email2.value = email3.value;
				email2.readOnly = true;
			}					
				
		}
	// 이메일 선택하면 value값 end -----------------------

	</script>
<%@ include file="../includes/footer.jsp" %>