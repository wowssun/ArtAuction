<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<title>작가 신청 정보 조회</title>
<style>

.centered-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 80vh; /* 화면 높이에 맞게 설정 */
}

.title { font-weight: bold; padding: 0px;}
.layout { width: 1000px;}
button { margin: 20px 0px;}
.out { text-align: right;  }
.out button {background: rgb(236, 112, 99); border: 1px solid rgb(236, 112, 99); color: white; }
.back { text-align: left;}

.back button {background: rgb(162, 217, 206); border: 1px solid rgb(162, 217, 206); color : white;}
.info button {background: rgb(93, 173, 226); border: 1px solid rgb(93, 173, 226); color: white;}
.pw button { background: rgb(93, 173, 226); border: 1px solid rgb(93, 173, 226); color: white;}

.ok button {background: rgb(93, 173, 226); color: white; border: 1px solid rgb(93, 173, 226); }
.no button {background: rgb(236, 112, 99); color: white; border: qpx solid rgb(236, 112, 99); }

.allBtn { margin-top : 80px; }
.col-md-6 p { margin : 20px 0px;}

.product-title {font-weight: bold;}
.open-tab { font-size: 15px;}


.hyphen
{
  margin:0;
  padding:0;
  list-style: none
}


.hyphen li
{
  position: relative;
  margin: 2px 0 0 0;
  padding: 0 0 4px 16px;
}

.hyphen li:before{
  content: "";
  position: absolute;
  top: 10px;
  left: 6px;  
  width: 4px;
  height: 1px;
  background: #262626;
}

.imgTag { text-align: center;}
.imgTag img { width: 212px; height: 219px; }

.find-btn{
	text-align: center;
	 width: 100%;
	 margin-bottom: 50px;
}
.find-btn1{
	display :inline-block;
	margin-right: 20px;
	
}



</style>

<%@ include file="../includes/header.jsp" %>

<section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/j.jpg&quot;);">
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
                <h2 class="module-title font-alt mb-0">작가 신청 정보 조회</h2>
              </div>
            </div>
          </div>
        </section>

			<div class="main">
			
			<section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 mb-sm-40 imgTag"><img src="/display?fileName=${avo.photo }" alt="작가 사진"></div>
              <div class="col-sm-6">
                <div class="row">
                  <div class="col-sm-12">
                    <h5 class="product-title font-alt">아이디</h5>
                  </div>
                </div>
                <div class="row mb-20">
                  <div class="col-sm-12"><span class="open-tab section-scroll">${avo.mid }</span></div>
                </div>
                <hr>
                <div class="row">
                  <div class="col-sm-12">
                    <h5 class="product-title font-alt">이름</h5>
                  </div>
                </div>
                <div class="row mb-20">
                  <div class="col-sm-12"><span class="open-tab section-scroll">${avo.name }</span></div>
                </div>
                <hr>
                <div class="row">
                  <div class="col-sm-12">
                    <h5 class="product-title font-alt">분야정보</h5>
                  </div>
                </div>
                <div class="row mb-20">
                  <div class="col-sm-12"><span class="open-tab section-scroll">${avo.major }</span></div>
                </div>
         	 </div>
            </div>
           
            <div class="row mt-70">
              <div class="col-sm-12">
                <ul class="nav nav-tabs font-alt" role="tablist">
                  <li class="active"><a href="#description" data-toggle="tab" aria-expanded="true"><span class="icon-tools"></span>작가 소개</a></li>
                  <li class=""><a href="#data-sheet" data-toggle="tab" aria-expanded="false"><span class="icon-trophy"></span>이력</a></li>
                </ul>
                <div class="tab-content">
                  <div class="tab-pane active" id="description">
                    <p>${avo.introduce }</p>
                  </div>
                  <div class="tab-pane" id="data-sheet">
                  <ul  class="hyphen"> 
                    <c:forEach items="${career }" var="cr">
                   	 <li>${cr.career }</li>
                    </c:forEach>
                 </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
		
					
     
          
           <sec:authorize access="isAuthenticated()">	
				<c:if test="${auth eq 'ROLE_ADMIN' }">
					<form action="/admin/rqList"  id="rqFrm">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
         				<input type="hidden" name="mid" value="${avo.mid }">
					
					<div class="allBtn">
						<div class="row">	   
						<div class="col-md-2 back pull-right" >
							<button class="btn btn-success backBtn">
								뒤로가기
							</button>
						</div>
						</div>
					<div class="find-btn">
						<div class="ok find-btn1">	 							
							<button class=" btn okBtn " data-mid="${avo.mid}" data-state="승인">승인</button>
					   </div>
					   <div class="no find-btn1">
							<button class=" btn noBtn " data-mid="${avo.mid}" data-state="거절">거절</button>
						</div>
					 </div>
					</div>
				</form>
				</c:if>
				</sec:authorize>

		</div>
	
	
	<script>
	
	var rqFrm = $('#rqFrm');
	
	// beforeSend 대신 CSFR 토큰 헤더 추가-----------------
    var csrfHeaderName = '${_csrf.headerName }';   // CSRF 토큰 관련 변수
	   var csrfTokenValue = '${_csrf.token }';		  // 토큰
	   $(document).ajaxSend(function(e,xhr, options){
		   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	   });
 
	   // beforeSend 대신 CSFR 토큰 헤더 추가 END -----------------------------
	
//  승인 버튼 처리 -------------------
	 
	$('.okBtn').on('click', function(e) {
		e.preventDefault(); 
		
	  var mid = $(this).data('mid');
	  var stateval = $(this).data('state');
	  console.log(mid);
	  console.log(stateval);
	  
	  Swal.fire({
		   title:'신청을 승인하시겠습니까?',
		   text: '다시 되돌릴 수 없습니다. 신중하세요.',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: 'rgb(93, 173, 226)', // confrim 버튼 색깔 지정
		   cancelButtonColor: 'rgb(236, 112, 99)', // cancel 버튼 색깔 지정
		   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		   reverseButtons: true, // 버튼 순서 거꾸로
		   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   $.ajax({
				    type: 'POST',
				    url: '/admin/state',
				    data: { mid: mid, state : stateval},
				    dataType: 'text', // 반환 값의 데이터 타입을 'text'로 설정
				    success: function(result) {
				        // result는 boolean 값을 문자열로 받게 됩니다.
				        if (result === 'true') {
				            console.log('승인 성공');
				            Swal.fire({
				                title: '작가 신청이 승인 되었습니다.',
				                icon: 'success',
				                showConfirmButton: true, // 확인 버튼 보이기
				                confirmButtonText: '확인', // 확인 버튼의 텍스트 설정
				            }).then((result) => {
				                if (result.isConfirmed) {
				                    // 확인 버튼을 눌렀을 때 실행할 작업을 여기에 추가
				                	location.href = "/admin/rqList";
				                }
				            });
				        } else {
				            console.log('승인 실패');
				        }
				    },
				    error: function(error) {
				        console.log('요청이 실패했습니다.');
				        console.log(error)
				    }
				});  // ajax end
		   
		      
		  }
		});
 
	});


	// 승인 버튼 처리 end--------------
	
	//  거절 버튼 처리 -------------------
	 
	$('.noBtn').on('click', function(e) {
		e.preventDefault(); 
		
	  var mid = $(this).data('mid');
	  var stateval = $(this).data('state');
	  console.log(mid);
	  console.log(stateval);
	  
	  Swal.fire({
		   title:'신청을 거절하시겠습니까?',
		   text: '다시 되돌릴 수 없습니다. 신중하세요.',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: 'rgb(93, 173, 226)', // confrim 버튼 색깔 지정
		   cancelButtonColor: 'rgb(236, 112, 99)', // cancel 버튼 색깔 지정
		   confirmButtonText: '승인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		   reverseButtons: true, // 버튼 순서 거꾸로
		   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
			   $.ajax({
				    type: 'POST',
				    url: '/admin/state',
				    data: { mid: mid, state : stateval},
				    dataType: 'text', // 반환 값의 데이터 타입을 'text'로 설정
				    success: function(result) {
				        // result는 boolean 값을 문자열로 받게 됩니다.
				        if (result === 'true') {
				            console.log('거절 성공');
				            Swal.fire({
				                title: '작가 신청이 거절 되었습니다.',
				                icon: 'success',
				                showConfirmButton: true, // 확인 버튼 보이기
				                confirmButtonText: '확인', // 확인 버튼의 텍스트 설정
				            }).then((result) => {
				                if (result.isConfirmed) {
				                    // 확인 버튼을 눌렀을 때 실행할 작업을 여기에 추가
				                    // 신청 목록으로 이동하기
				                    
				                    location.href = "/admin/rqList";

				                }
				            });
				        } else {
				            console.log('거절 실패');
				        }
				    },
				    error: function(error) {
				        console.log('요청이 실패했습니다.');
				        console.log(error)
				    }
				});  // ajax end
		   
		      
		  }
		});
 
	});


	// 거절 버튼 처리 end--------------

	
	</script>




<%@ include file="../includes/footer.jsp" %>