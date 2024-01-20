<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta charset="UTF-8">
<title>작가 정보 조회</title>
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
.back { margin-bottom:50px;}

.back button {background: rgb(162, 217, 206); border: 1px solid rgb(162, 217, 206); color : white;}
.info button { background: rgb(93, 173, 226); border: 1px solid rgb(93, 173, 226); color: white;}
.pw button { background: rgb(93, 173, 226); border: 1px solid rgb(93, 173, 226); color: white;}

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
	                <h2 class="module-title font-alt mb-0">작가 정보</h2>
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
					<sec:authentication property="principal.mvo.auth.auth" var ="auth"/>
				 	<c:if test="${auth eq 'ROLE_ARTIST' || auth eq 'ROLE_USER'}">
					<form action="/user/mypage"  id="mypageFrm">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
         				<input type="hidden" name="mid" value="<sec:authentication property='principal.mvo.mid'/>">
					
					<div class="allBtn">
						<div class="row">	   
						<div class="col-md-2 back pull-right">
							<button class="btn btn-success backBtn">
								뒤로가기
							</button>
						</div>
						
						<div class="col-lg-10 info text-center">	 
							<button class="btn btn-success infoBtn" formaction="/user/artmodify">
								정보수정
							</button>
						</div>
						
						
					
					</div>
					</div>
				</form>
				</c:if>
				
				<c:if test="${auth eq 'ROLE_ADMIN' }">
					<form action="/admin/artistList"  id="amypageFrm">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
         				<input type="hidden" name="mid" value="${mvo.mid }">
					
					<div class="allBtn">
						<div class="row">	   
						<div class="col-md-2 back pull-right">
							<button class="btn btn-success backBtn">
								뒤로가기
							</button>
						</div>
						
						<div class="col-lg-10 info text-center">	 
							<button class="btn btn-success infoBtn" formaction="/user/artmodify">
								정보수정
							</button>
						</div>								
					
					</div>
					</div>
				</form>
				</c:if>
				</sec:authorize>


</div>


<%@ include file="../includes/footer.jsp" %>