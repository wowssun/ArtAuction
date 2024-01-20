<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>내 정보</title>
<style>

.centered-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 70vh; /* 화면 높이에 맞게 설정 */
}


.title { font-weight: bold; padding-right: 20px;  display: inline-block; }

.out { text-align: right;  }
.out button {background: rgb(236, 112, 99); border: 1px solid rgb(236, 112, 99); color: white; }
.back { text-align: left;}

.back button {background: rgb(162, 217, 206); border: 1px solid rgb(162, 217, 206); color : white;}
.info button { background: rgb(93, 173, 226); border: 1px solid rgb(93, 173, 226); color: white; }
.pw button { background: rgb(93, 173, 226); border: 1px solid rgb(93, 173, 226); color: white;}

.allBtn { margin-top : 80px;    }
.allBtn .btn:hover {background: rgb(234, 237, 237); color: rgb(86, 101, 115);}
/* .col-md-6 p { margin : 20px 0px;} */

</style>

<%@ include file="../includes/header.jsp" %>

	<section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/l.jpg&quot;);">
	          <div class="container">
	            <div class="row">
	              <div class="col-sm-2 col-sm-offset-5">
	                <div class="alt-module-subtitle"><span class="holder-w"></span>
	                  <h5 class="font-serif">My Information</h5><span class="holder-w"></span>
	                </div>
	              </div>
	            </div>
	            <div class="row">
	              <div class="col-sm-8 col-sm-offset-2">
	                <h2 class="module-title font-alt mb-0">내 정보</h2>
	              </div>
	            </div>
	          </div>
	        </section>
        
        <div class="container" style="width: 517px;padding-left: 200px;">
        <div class="row multi-columns-row">
             
              <div class="col-sm-6 col-md-6 col-lg-6">
                <div class="alt-features-item">
                  <div class="alt-features-icon"><span class="icon-happy"></span></div>
                  <h3 class="alt-features-title font-alt">회원 구분</h3>
                  <c:choose>
					    <c:when test="${mvo.auth.auth eq 'ROLE_USER'}">
					        일반 회원
					    </c:when>
					    <c:otherwise>
					        작가 회원
					    </c:otherwise>
				 </c:choose>
                </div>
              </div>
             </div> 
           
             <div class="row multi-columns-row">
              <div class="col-sm-6 col-md-6 col-lg-6">
                <div class="alt-features-item">
                  <div class="alt-features-icon"><span class="icon-key"></span></div>
                  <h3 class="alt-features-title font-alt">아이디</h3>
                  ${mvo.mid }	
                </div>
              </div>
             </div> 
          
             <div class="row multi-columns-row">
              <div class="col-sm-6 col-md-6 col-lg-6">
                <div class="alt-features-item">
                  <div class="alt-features-icon"><span class="icon-lightbulb"></span></div>
                  <h3 class="alt-features-title font-alt">이름</h3>
                  ${mvo.name }
                </div>
              </div>
             </div> 
             
             <div class="row multi-columns-row">
              <div class="col-sm-6 col-md-6 col-lg-6">
                <div class="alt-features-item">
                  <div class="alt-features-icon"><span class="icon-phone"></span></div>
                  <h3 class="alt-features-title font-alt">전화번호</h3>
                  ${mvo.phone }	
                </div>
              </div>
             </div> 
             
             <div class="row multi-columns-row">
              <div class="col-sm-6 col-md-6 col-lg-6">
                <div class="alt-features-item">
                  <div class="alt-features-icon"><span class="icon-envelope"></span></div>
                  <h3 class="alt-features-title font-alt">이메일</h3>
                  ${mvo.email }	
                </div>
              </div>
             </div> 
             
             <div class="row multi-columns-row">
              <div class="col-sm-6 col-md-6 col-lg-6">
                <div class="alt-features-item">
                  <div class="alt-features-icon"><span class="icon-calendar"></span></div>
                  <h3 class="alt-features-title font-alt">가입일자</h3>
                  <fmt:formatDate value="${mvo.joinDate }"  type="date" pattern="yyyy.MM.dd (E)"/>
                </div>
              </div>
             </div>   

          </div>
       
        <div class="container" style="margin-bottom:50px;">
					<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="prin" /> <!-- c태그 사용안하고 이렇게 바로 변수만들기 가능  -->
							<c:if test="${mvo.mid eq prin.username }"> 
					<form action="/user/mypage"  id="mypageFrm">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
         				<input type="hidden" name="mid" value="<sec:authentication property='principal.mvo.mid'/>">
					
					<div class="allBtn">
						<div class="row">	   
						<div class="col-md-4 back">
							<button class="btn btn-success backBtn">
								뒤로가기
							</button>
						</div>
						
						
						<div class="col-md-2 info">	 
							<button class="btn btn-success infoBtn" formaction="/user/modify">
								정보수정
							</button>
						</div>
						
						<div class="col-md-2 pw"> 
							<button  class="btn btn-success pwBtn" formaction="/artauction/pwChange">
								비밀번호 변경
							</button>
						</div>
						
						<div class="col-md-4 out"> 
							<button  class="btn btn-success outBtn" formaction="/user/remove" formmethod="post">
								탈퇴하기
							</button>
						</div>	
					</div>
					</div>
				</form>
						</c:if>
				
				<!-- 관리자만 -->
				<c:if test="${auth eq 'ROLE_ADMIN' }">
					<form action="/admin/userList"  id="amypageFrm">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
         				<input type="hidden" name="mid" value="${mvo.mid }">
					
					<div class="allBtn">
						<div class="row">	   
						<div class="col-md-4 back">
							<c:choose>
								    <c:when test="${mvo.auth.auth eq 'ROLE_USER'}">
										<button class="btn btn-success backBtn">
											뒤로가기
										</button>
								    </c:when>
								    <c:otherwise>
										<button formaction="/admin/artistList" class="btn btn-success backBtn">
											뒤로가기
										</button>
								    </c:otherwise>
							</c:choose>
						</div>
						
						<div class="col-md-2 info">	 
							<button class="btn btn-success infoBtn" formaction="/user/modify">
								정보수정
							</button>
						</div>
						
						<div class="col-md-2 pw"> 
							<button  class="btn btn-success pwBtn" formaction="">
								비밀번호 변경
							</button>
						</div>				
						<div class="col-md-4 out"> 
							<button  class="btn btn-success aoutBtn" formaction="/admin/remove" formmethod="post">
								삭제하기
							</button>
						</div>
					
					</div>
					</div>
				</form>
				</c:if>
				</sec:authorize>
		</div>

<script>

// 탈퇴하기 버튼 클릭시 --------------------

 var mypageFrm = $('#mypageFrm'); // 제출할 form 찾아오기
 
$('.outBtn').on('click', function(e) {
    e.preventDefault();
    console.log('탈퇴하시겠습니까?');

    Swal.fire({
        title: '탈퇴하시겠습니까?',
        text: '다시 되돌릴 수 없습니다. 신중하세요.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: 'rgb(236, 112, 99)',
        cancelButtonColor: 'rgb(93, 173, 226)',
        confirmButtonText: '탈퇴',
        cancelButtonText: '취소',
        reverseButtons: false,
    }).then(result => {
        if (result.isConfirmed) {
            // 탈퇴 버튼이 클릭되었을 때 수행할 동작
            // 성공했을때 버튼 다시 그대로 실행하기
           
            
            mypageFrm.attr('action', '/user/remove');   // 해당 form의 action 속성 설정
            mypageFrm.attr('method', 'post');			// 해당 form의 method 속성 설정
            mypageFrm.submit();						// submit
        }
    });
});

//탈퇴하기 버튼 클릭시 end --------------


// 삭제하기 버튼 클릭시 --------------------

 var amypageFrm = $('#amypageFrm'); // 제출할 form 찾아오기
 
$('.aoutBtn').on('click', function(e) {
    e.preventDefault();
    console.log('삭제하시겠습니까?');

    Swal.fire({
        title: '삭제하시겠습니까?',
        text: '다시 되돌릴 수 없습니다. 신중하세요.',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: 'rgb(236, 112, 99)',
        cancelButtonColor: 'rgb(93, 173, 226)',
        confirmButtonText: '삭제',
        cancelButtonText: '취소',
        reverseButtons: false,
    }).then(result => {
        if (result.isConfirmed) {
            // 탈퇴 버튼이 클릭되었을 때 수행할 동작
            // 성공했을때 버튼 다시 그대로 실행하기
           
            
            mypageFrm.attr('action', '/admin/remove');   // 해당 form의 action 속성 설정
            mypageFrm.attr('method', 'post');			// 해당 form의 method 속성 설정
            mypageFrm.submit();						// submit
        }
    });
});

//삭제하기 버튼 클릭시 end --------------

   

</script>


	<%@ include file="../includes/footer.jsp" %>