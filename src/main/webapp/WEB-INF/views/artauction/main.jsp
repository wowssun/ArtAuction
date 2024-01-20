<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="../includes/header.jsp"%>
<section class="home-section home-fade home-full-height" id="home">
	<div class="hero-slider">
		<ul class="slides">
         <li class="bg-dark-30 bg-dark shop-page-header"
            style="background-image: url(/resources/img/title/museum.jpg);">
            <div class="titan-caption">
               <div class="caption-content">
                  <div class="font-alt mb-30 titan-title-size-4">작품</div>
                  <div class="font-alt mb-40 titan-title-size-1">신예 작가들의 작품을 감상해 보세요.</div>
                  <a class="section-scroll btn btn-border-w btn-round"
                     href="/art/list">Learn More</a>
               </div>
            </div>
         </li>
			</li>
			<li class="bg-dark-30 bg-dark shop-page-header"
				style="background-image: url(/resources/img/title/background.jpg);">
				<div class="titan-caption">
					<div class="caption-content">
						<div class="font-alt mb-40 titan-title-size-4">AUCTION</div>
						<div class="font-alt mb-30 titan-title-size-1">Your Precious
							Work, We'll Raise that Value.</div>
						<a class="section-scroll btn btn-border-w btn-round"
							href="/auction/auclist">Looking at the works</a>
					</div>
				</div>
			</li>
		</ul>
	</div>
</section>
<div class="main">
	<section class="module-small">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">AUCTION</h2>
				</div>
			</div>
			<div class="row multi-columns-row">
				<c:forEach items="${list}" var="avo" varStatus="status">
					<c:if test="${empty avo.payDate}">
						<div class="col-sm-6 col-md-3 col-lg-3">
							<div class="shop-item">
								<div class="shop-item-image">
									<img src="/artdisplay?fileName=/${avo.artImg}"
										alt="Accessories Pack" />
									<div class="shop-item-detail">
										<a class="btn btn-round btn-b">VIEW</span></a>
									</div>
								</div>
								<h4 class="shop-item-title font-alt">
									<a href="#">${avo.artName}</a>
								</h4>
								${avo.priceC}
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
		</div>
	</section>
	<section class="module module-video bg-dark-30" data-background="">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt mb-0">For Your Collecting
						Journey</h2>
				</div>
			</div>
		</div>
		<div class="video-player"
			data-property="{videoURL:'https://www.youtube.com/watch?v=fXTEreK4Ol0', containment:'.module-video', startAt:0, mute:true, autoPlay:true, loop:true, opacity:1, showControls:false, showYTLogo:false, vol:25}"></div>
	</section>

   <section class="module-small">
      <div class="container">
         <div class="row">
            <div class="col-sm-6 col-sm-offset-3">
               <h2 class="module-title font-alt">작품</h2>
            </div>
         </div>
         <div class="row multi-columns-row">
            <c:forEach items="${artlist}" var="artvo" varStatus="status">
             <c:if test="${status.index < 8}">
                  <div class="col-sm-6 col-md-3 col-lg-3">
                     <div class="shop-item">
                        <div class="shop-item-image">
                           <img src="/artdisplay?fileName=/${artvo.artImg}"
                              alt="${artvo.artName}" style="width:300px; height:300px;"/>
                           <div class="shop-item-detail">
                              <a class="artmove btn btn-round btn-b" href="${artvo.ano }">VIEW</a>
                           </div>
                        </div>
                        <h4 class="shop-item-title font-alt">
                           <a href="#">${artvo.artName}</a>
                        </h4>
                     </div>
                  </div>
      			  </c:if>
            </c:forEach>
         </div>
      </div>
   </section>
</div>
<script>
        
        $(function(){ 
           
           // 탈퇴, 회원가입시 메인으로 돌아와서 알림창.?
           var result = '${result }';
            userOut(result);
            
           history.replaceState({},null,null); // history 초기화
           
           function userOut(result){
               // result 값이 있는경우에 알림창 표시
               
               if(result === '' || history.state) {
                  return; 
                  }
   
               if(result == 'remove success') {    // 회원 탈퇴 성공시
                Swal.fire(
                      '회원탈퇴가 완료되었습니다.',
                      '',
                      'success'
                       )         
             } 
               
             if(result == 'logoutsuccess') {    // 로그아웃 완료시  -- (미완)
                Swal.fire(
                      '로그아웃이 완료되었습니다.',
                      '',
                      'success'
                       )         
             } 
              
             
             if(result == 'join success') {    // 회원가입 완료시  -- (미완)
                Swal.fire(
                      '회원가입이 완료되었습니다.',
                      '',
                      'success'
                       )         
             }
                    
             
                } 
           
             var result1 = '${param.result }';
              console.log(result1,'1');
             if(result1 == 'logoutsuccess') {    // 로그아웃 완료시  -- 
                
                
                  console.log(result1,'2');
                       Swal.fire({
                         title: '로그아웃이 완료되었습니다.',
                         icon: 'success',
                         showConfirmButton: true, // 확인 버튼 보이기
                         confirmButtonText: '확인', // 확인 버튼의 텍스트 설정
                     }).then((result) => {
                         if (result.isConfirmed) {
                             // 확인 버튼을 눌렀을 때 실행할 작업을 여기에 추가
                             location.href='/'; // 
                         }
                     });
             
             
           }   //  메인에서 뜨는 알림창 처리
           
 

  
        });//END $
        
        $('.move').on('click', function(e) {
         e.preventDefault();

         var ano = $(this).attr('href'); // 클릭한 링크의 href 값을 가져옴

         // auction/view 경로로 이동
         window.location.href = '/auction/view?ano=' + ano;
      });
        
        $('.artmove').on('click', function(e) {
            e.preventDefault();

            var ano = $(this).attr('href'); // 클릭한 링크의 href 값을 가져옴

            // auction/view 경로로 이동
            window.location.href = '/art/view?ano=' + ano;
         });

</script>

<%@ include file="../includes/footer.jsp"%>