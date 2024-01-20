<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>작가 신청 현황 조회</title>
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
    
#form{ border:1px solid lightgray; padding: 30px; }

form .btn {text-align: center; margin: 20px 300px; background:rgb(213, 245, 227); color:rgb(11, 83, 69); }

.form-group {margin: 20px 0px;}

#name {width: 540px;}


.find-btn{
	text-align: center;
	 width: 100%;
}
.find-btn1{
	display :inline-block;
	
}

form .backBtn {background:rgb(128, 139, 150); color:white;}

</style>

<%@ include file="../includes/header.jsp" %>

<section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/e.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">Check Artist</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">작가 신청 현황 조회</h2>
              </div>
            </div>
          </div>
        </section>

	<div role="main">
    <div class="container centered-content">
    
        <form action="/artauction/idSearch" method="post" class="form-horizontal" id="form">
          <div class="line">  
            <div class="form-group" style="width: 300px;">
                <label><b>아이디</b></label>
                <div class="input">
                    <input type="text" name="mid" id="mid" class="form-control" required>
                </div>
            </div>
     
 		</div>
          
            <div class="find-btn">
	                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	                <input type="button" class="btn backBtn find-btn1" 
	                style="margin-right: 10px; margin-left: 0px;" value="뒤로가기">
	                <input type="submit" class="btn rqBtn find-btn1 " 
	                style="margin-right: 0px; margin-left: 0px;" value="조회하기">
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
	
	$('.rqBtn').on('click', function(e) {
		 e.preventDefault();
	    var midval = $('#mid').val();
		
		 console.log(midval);
		
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
				  
		 $.ajax({
			    type: 'POST',
			    url: '/user/rqcheck',
			    data: { mid: midval },
			   // contentType : 'application/json',
			    dataType: 'text',
			    success: function(result) {
			        console.log(result);
			        
			        if (result == null || result =='') {
			        	Swal.fire(
			        			  '일치하는 회원 정보가 \n 없습니다!',
			        			  '',
			        			  'question'
			        			)
			        //	Swal.fire('일치하는 회원 정보가 \n 없습니다!')
			        
			        }else {
			        	Swal.fire(
		        		        '회원님의 작가신청은 \n <b style="color:cornflowerblue;">' + result + '</b> 상태입니다!',
		        		        '',
		        		        'info'
			        		      )
			           // alert('회원님의 아이디는 ' + result + '입니다.');
			        }
			    },
			    error: function(xhr, status, er) {
			        // 오류 처리
			        console.error(er);
			    }
			});
	
		 
	});
	   
	   $('.backBtn').on('click',function(){
		
		   location.href='/user/mypage';
		   
	   });
	   
	   
	
	</script>
	
	<%@ include file="../includes/footer.jsp" %>