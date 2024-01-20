<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>mypage</title>
<style>

.my {
 display: flex;
  flex-direction: column;
   align-items: center;
   justify-content: center;
   margin: 30px 0; 
        
        } 
        

.item { width: 300px;
		margin: 10px 10px; padding-left: 50px;}

.item img {
    width: 60px; /* 이미지의 너비 조절 */
    height: auto; /* 이미지의 높이를 자동으로 조절 */
}

.item span {
    margin-left: 10px; /* 이미지와 텍스트 사이 간격 조절 */
    font-weight: bold;
}
.item a { text-decoration: none;
		   color : black;}

.main button { background: white; border: none; width: 300px;  text-align: left; color:black;}

.main button:hover { color: lightgray;}


 </style>
 

<%@ include file="../includes/header.jsp" %>


<section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/k.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">My Page</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">마이 페이지</h2>
              </div>
            </div>
          </div>
        </section>

<div class="main">
    <div class="container">
    	<div class="my">
         <form action="/user/myinfo" class="artFrm">
         	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
         	<input type="hidden" name="mid" value="<sec:authentication property='principal.mvo.mid'/>">
	        <%-- <input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
			<input type="hidden" name="amount" value=${pageDTO.cri.amount }>
 --%>
	        
	        <div class="row">
				<div class="col-md-6">
	                <div class="item">
	                <button><img alt="" src="/resources/img/myicon/user.png">
	                    <span>내 정보 보기</span></button>
	                </div>
	            </div>
	           <div class="col-md-6">
	                <div class="item">
	                    <a href="/inquiry/mylist?mid=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/faq.png">
	                    <span>1 : 1 문의 내역</span></a>
	                </div>
	             </div>
	          </div>
           <div class="row">
			<div class="col-md-6">
                <div class="item">
                    <a href="/class/classMyReq?mid=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/brush.png">
                    <span>원데이 클래스 신청 내역</span></a>
                </div>
            </div>
           <div class="col-md-6">
                <div class="item">
                <button class="requestBtn" formaction="/user/request"><img alt="" src="/resources/img/myicon/light.png">
	                    <span>작가 신청</span></button>
	                </div> 
            </div>
            </div>
            <div class="row">
				<div class="col-md-6">
                <div class="item">
                    <a href="/user/rqcheck"><img alt="" src="/resources/img/myicon/search.png">
                    <span>작가 신청 현황 조회</span></a>
                </div>
            </div>
            <div class="col-md-6">
                <div class="item">
                    <a href="/auction/sbidlist?buyer=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/picture.png">
                    <span>내가 낙찰한 작품</span></a>
                </div>
            </div>
            </div>
          		<div class="row">
					<div class="col-md-6">
		                <div class="item">
		                    <a href="/fund/mypaylist?mid=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/wish.png">
		                    <span>나의 펀딩 결제 내역</span></a>
		                </div>
           			</div>
            <div class="col-md-6">
                <div class="item">
                <button class="freeBtn" formaction="/free/mylist"><img alt="" src="/resources/img/myicon/light.png">
                    <span>내가 작성한 게시글</span></button>
                </div>
            </div>
            </div>
            <div class="row">
					<div class="col-md-6">
               			 <div class="item">
               			 <button class="replyBtn" formaction="/free/remylist"><img alt="" src="/resources/img/myicon/chat.png">
                    <span>내가 작성한 댓글</span></button> 
            			</div>
           		 </div>
            <div class="col-md-6">
                <div class="item">
                    <a href="/auction/bidlist?mid=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/star.png">
                    <span>내가 입찰한 작품</span></a>
                </div>
            </div>
            </div>
            </form>
            </div>
        </div>
        
        <sec:authorize access="isAuthenticated()">
         <sec:authentication property="principal.mvo.auth.auth" var ="auth"/>              
 		 <c:if test="${auth eq 'ROLE_ARTIST' || auth eq 'ROLE_ADMIN'}">
       	<!-- 작가 마이페이지 로그인해서 작가랑 관리자만 보임  -->
       	 <%@ include file="artistMypage.jsp" %>
        </c:if>
        </sec:authorize>

</div>
	<script>
	
	 // beforeSend 대신 CSFR 토큰 헤더 추가-----------------
       var csrfHeaderName = '${_csrf.headerName }';   // CSRF 토큰 관련 변수
	   var csrfTokenValue = '${_csrf.token }';		  // 토큰
	   $(document).ajaxSend(function(e,xhr, options){
		   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	   });
 
	   // beforeSend 대신 CSFR 토큰 헤더 추가 END -----------------------------
	
	var artFrm = $('.artFrm');
	
	$('.requestBtn').on('click',function(e){
		e.preventDefault();
		 var midval = "<sec:authentication property='principal.mvo.mid'/>";
		 console.log(midval);
		 
		 $.ajax({
			    type: 'POST',
			    url: '/user/rqcheck',
			    data: { mid: midval },
			   // contentType : 'application/json',
			    dataType: 'text',
			    success: function(result) {
			        console.log(result);
			        
			        if (result == null || result =='' || result == '거절') {
			        	// 신청상태가 아니거나 또는 거절이거나
			        	artFrm.attr('action','/user/request');
			        	artFrm.submit();
			      
			        
			        }else {
			        	Swal.fire(
		        		        '이미 신청상태 입니다!',
		        		        '',
		        		        'info'
			        		      )
			           return;
			        }
			    },
			    error: function(xhr, status, er) {
			        // 오류 처리
			        console.error(er);
			    }
			});
		 
		
	});
	
	// 회원정보 수정하고 메시지 가지고
	var result = '${result }';
        	
        	 userOut(result);
        	 
        	history.replaceState({},null,null); // history 초기화
        	
        	function userOut(result){
          	  // result 값이 있는경우에 알림창 표시
          	  
          	  if(result === '' || history.state) {
          		  return; 
          		  }
	
          	  if(result == 'modify success') {    // 회원 수정 성공시
          		Swal.fire(
        		        '정보수정이 완료되었습니다.',
        		        '',
        		        'success'
	        		      )			
          	} 
          	  
          	if(result == 'request success') {    // 작가 신청 성공시
          		Swal.fire(
        		        '작가신청이 완료되었습니다.',
        		        '',
        		        'success'
	        		      )			
          	} 
          	
          	if(result == 'artmodify success') {    // 작가 신청 성공시
          		Swal.fire(
        		        '작가정보가 수정되었습니다.',
        		        '',
        		        'success'
	        		      )			
          	} 
          	  
          	
           	 
           }
	
	
	
	
	</script>

<%@ include file="../includes/footer.jsp" %>