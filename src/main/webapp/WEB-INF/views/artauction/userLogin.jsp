<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<title>로그인</title>
<style>

.all {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
       /* margin: 20px 0;  Adjust the margin as needed */
           
    }
    
form{ border: 1px solid  rgb(86, 101, 115);  background-color: white; padding: 40px; }

.idpw { margin-top: 20px; text-align: center;  }
.idpw .btn { background-color: rgb(86, 101, 115); margin-left: 20px;}

.loginBtn { margin-top: 20px; text-align: center; }
.loginBtn .btn {padding: 10px 200px;}
.main { height: 70vh; background:rgb(251, 252, 252);  }

</style>

<section class="module bg-dark-30 parallax-bg restaurant-menu-bg" style="background-image: url(&quot;/resources/img/title/a.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
				<h5 class="font-serif">Login</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0" >로그인</h2>
              </div>
            </div>
          </div>
        </section>

   <section class="module main" style="padding-top: 70px;">
    
          <div class="container">
            <div class="row">
              <div class="all">
                <h4 class="font-alt">Login</h4>
                <hr class="divider-w mb-10">
     			 <form role="form" action="/login" method="post" class="loginFrm">
     			 <!-- 에러 메시지 표시 -->
     			 <c:if test="${not empty error}">
      			 	 <div class="alert alert-danger" role="alert" style="text-align: center;">
           				 ${error}
        			 </div>
   				 </c:if>
         	<div class="form-group">
                    <input class="form-control" id="username" type="text" name="username"  required autofocus placeholder="아이디"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="password" type="password" name="password" required autofocus placeholder="비밀번호"/>
                  </div>
                  <div class="form-group">
                  <div class="loginBtn">
                    <button class="btn btn-round btn-b ">Login</button>          
                  </div>
                    <div class="idpw">
                   	 <button type="button" class="btn btn-round btn-b idsBtn">아이디 찾기</button>
                   	 <button type="button" class="btn btn-round btn-b pwsBtn">비밀번호 찾기</button>
                    </div>
                  </div>
         <input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
          <!-- <div class="checkbox">
                 <label>
                     <input name="remember-me" type="checkbox" >Remember Me
                 </label>
              </div> -->
      </form>
    </div>
   </div>
   </div>
   </section> 
    
    <script>
          
        $(function(){    //  이거 지금 헤더 안넣으니까 제이쿼리 안먹어서 에러나는 거임 나중에 합칠때 수정하기
        	
        	// 아이디 찾기 버튼 처리 -----
        	$('.idsBtn').on('click',function(e){
        		 e.preventDefault();
        		location.href='/artauction/idSearch';
	
        	});
        	// 아이디 찾기 버튼 처리 end -----
        	
        	// 비밀번호 찾기 버튼 처리 -----
        	$('.pwsBtn').on('click',function(e){
        		 e.preventDefault();
        		location.href='/artauction/pwSearch';
	
        	});
        	// 비밀번호 찾기 버튼 처리 end -----
        	
        	
        	// 비밀번호 변경시 로그인으로 돌아와서 알림창.?
        	var result = '${result }';
        	
        	userOut(result);
        	 
        	history.replaceState({},null,null); // history 초기화
        	
        	function userOut(result){
          	  // result 값이 있는경우에 알림창 표시
          	  
          	  if(result === '' || history.state) {
          		  return; 
          		  }
	
          	  if(result == 'change success') {    // 비밀번호 변경 성공시
          		Swal.fire(
        		        '비밀번호 변경이 \n 완료되었습니다.',
        		        '',
        		        'success'
	        		      )			
          	} 
          	  
           	 
           }   //  메인에서 뜨는 알림창 처리
  
        });//END $
        

</script>
<%@ include file="../includes/footer.jsp" %>
