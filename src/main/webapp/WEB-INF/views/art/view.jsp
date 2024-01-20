<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ include file="../includes/header.jsp"%>

<!--  -->
      <div class="main">
        <section class="module bg-dark-60 portfolio-page-header" data-background="/resources/live/assets/images/gallery.jpg">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h2 class="module-title font-alt">Art View</h2>
                <div class="module-subtitle font-serif">A wonderful serenity has taken possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart.</div>
              </div>
            </div>
          </div>
        </section>
        

<!-- 상세보기 -->
        <section class="module pt-0 pb-0" id="about" style="margin-top:60px;">
          <div class="row position-relative m-0">
            <div class="col-xs-12 col-md-6 side-image"
            style=" background-image : url('/artdisplay?fileName=/${avo.artImg}'); background-size : contain">
			</div>
            <div class="col-xs-12 col-md-6 col-md-offset-6 side-image-text">
              <div class="row">
                <div class="col-sm-12">
                  <h2 class="module-title font-alt align-left">${avo.artName}</h2>
                  <div class="module-subtitle font-serif align-left">${avo.intro}</div>
                  <p>${avo.artist}</p>
                  <p>${avo.genre}</p>
                  <p>${avo.asize}</p>
                </div>
              </div>
            </div>
          </div>
          
          		<form action="/art/modify">
				<input type="hidden" name="ano" value="${avo.ano }">

					<div class="text-right" style="margin:20px 0 20px 0;">
									<sec:authorize access="hasRole('ARTIST') or hasRole('ADMIN')">
					<sec:authentication property="principal.username" var="loginId" />
					<c:if test="${loginId == avo.mid or loginId == 'admin'}">
						<button data-oper="modify" class="btn btn-warning">
							Modify</button>
					</c:if>
				</sec:authorize>
				
		<a class="btn btn-secondary backBtn" onclick="history.back()"
			style="background-color: lightgray; color: #fff;">뒤로가기</a>
	</div>
					
					<!-- 페이지 번호와 페이지에 표시할 게시물의 수, 검색 타입, 키워드 -->
					<input type="hidden" name="type" value="${cri.type}"> 
					<input type="hidden" name="keyword" value="${cri.keyword}"> 
					<input type="hidden" name="pageNum" value="${cri.pageNum}"> 
					<input type="hidden" name="amount" value="${cri.amount}">
				</form>
				
        </section>
        

        <hr class="divider-d">
      </div>
      <div class="scroll-up"><a href="#totop"><i class="fa fa-angle-double-up"></i></a></div>


<script>
/* //게시물 알림창
$(document).ready(function(){
    var modifysuccess = "${modifysuccess}"; // 작품 수정 성공
    
    if(modifysuccess === "success") {
        alert("작품이 수정되었습니다.");
    }
}); */


$(function() {
var result = '${result }';
userOut(result);

history.replaceState({}, null, null); // history 초기화

function userOut(result) {
	// result 값이 있는경우에 알림창 표시

	if (result === '' || history.state) {
		return;
	}

	if (result == 'modifysuccess') {
		Swal.fire('작품이 수정되었습니다.', '', 'success')
	}

}
});
</script>




<%@ include file="../includes/footer.jsp" %>
