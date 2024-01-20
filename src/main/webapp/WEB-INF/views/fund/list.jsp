<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<div class="main">
	<section class="module bg-dark-30 about-page-header" data-background="/resources/live/assets/images/fund.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">진행중인 펀딩</h2>
					<div class="module-subtitle font-serif">Be a part of our success story! Your contribution fuels our passion and helps us achieve milestones. Let's make this project a reality, together!
</div>
				</div>
			</div>
		</div>
	</section>


	<!-- Section-->
	<section class="module">
		<div class="container">
			<div class="row text-right justify-content-end">
			

<div class="col-sm-12">
    <ul class="filter font-alt" id="filters">
        <li id="latest">최신순</li>
        <li id="price">금액순</li>
        <li id="deadline">마감일순</li>
    </ul>
</div>

			</div>
			

			<div class="row multi-columns-row post-columns" id="fundList">
				<c:forEach items="${list}" var="fvo">
					<div class="col-sm-6 col-md-3 col-lg-3">
						<div class="post">
							<div class="post-thumbnail">
								<%-- <a class="move" href="${fvo.fno }">  --%><img
									src="/display?fileName=/${fvo.atvo.photo }"
									alt="${fvo.mvo.name }" 
									style="width: 400px; height: 300px; object-fit: cover;"/>
								<!-- </a> -->
							</div>
							<div class="post-header font-alt">
								<h2 class="post-title">
									${fvo.fundName}
								</h2>
								<div class="post-meta">${fvo.totalPrice}원펀딩중</div>
							</div>
							<div class="post-entry">
								<p>
									<fmt:formatDate value="${fvo.endDate }" type="date"
										pattern="yyyy-MM-dd (E)" />
									까지
								</p>
								<div id="remainingDays"></div>
							</div>
							<div class="post-more">
								<a class="move" href="${fvo.fno }">Read more</a>
							</div>
						</div>
					</div>
				</c:forEach>
			<!-- </div> -->
			</div> 
		</div>
		
			<div class="text-right">
		<a class="btn btn-secondary backBtn" onclick="history.back()"
			style="background-color: lightgray; color: #fff; margin-right:10px;">뒤로가기</a>
	</div>
	
		
		
		<!-- Paging-->
			<div class="pagination-container text-center">
				<ul class="pagination">
					<%-- 이전 버튼 --%>
					<c:if test="${fpageDTO.prev }">
						<li class="page-item"><a href="${fpageDTO.start - 1}"
							class="page-link">&laquo; Pre</a>
					</c:if>

					<%-- 페이지 번호 버튼 --%>
					<c:forEach begin="${fpageDTO.start }" end="${fpageDTO.end }" var="i">
						<%-- <c:url var="link" value=""/> --%>
						<li class="page-item ${fpageDTO.cri.pageNum == i ? 'active' : '' }">
							<a href="${i }" class="page-link">${i }</a>
					</c:forEach>

					<%-- 다음 버튼 --%>
					<c:if test="${fpageDTO.next }">
						<li class="page-item"><a href="${fpageDTO.end + 1}"
							class="page-link">Next &raquo;</a>
					</c:if>
				</ul>
			</div>

			
			<form action="/fund/list" id="actionFrm">
				<input type="hidden" name="sort" value="${fpageDTO.cri.sort}">
				<%-- <input type="hidden" name="type" value="${fpageDTO.cri.type}">
				<input type="hidden" name="keyword" value="${fpageDTO.cri.keyword}"> --%>
				<input type="hidden" name="pageNum" value="${fpageDTO.cri.pageNum}">
				<input type="hidden" name="amount" value="${fpageDTO.cri.amount}">
			</form> 
	</section>
</div>



<script>

		$(function() {
			
			/* console.log('${fpageDTO.cri.amount}');˙ */

			// 페이징 이벤트 처리 ------------------------------
			var actionFrm = $('#actionFrm');

			$('.page-item a').on('click',function(e) {
						e.preventDefault();

						// a 태그의 href 값을 pageNum에 저장
						actionFrm.find("input[name='pageNum']").val(
								$(this).attr('href'));

						actionFrm.submit();
					});

			//게시물 제목 클릭 이벤트 처리 -----------------------
			$('.move').on('click',function(e) {
								e.preventDefault();

								actionFrm
										.append("<input type='hidden' name='fno' value='"
												+ $(this).attr('href') + "'>");

								actionFrm.attr('action', '/fund/view');

								actionFrm.submit();
							});


		});
		
		var csrfHeaderName = '${_csrf.headerName}';
		var csrfTokenValue = '${_csrf.token}';
		
		
		    
		    $('#filters').on('click', 'li', function() {
		        var sort = this.id;
		        console.log(sort);

		        // 정렬된 데이터를 받아온 후에 원하는 페이지로 이동
		        var newUrl = '/fund/list?sort=' + sort;
		        window.location.href = newUrl;
		    });


		    /* 
		    	$('#filters').on('click', 'li', function() {
		    var sort = this.id;
		    console.log(sort);
		    
		    
		    var formData = new FormData();
		    formData.append('sort', sort); // 필드 이름과 값을 설정

		    // AJAX 요청을 보냅니다.
		    $.ajax({
		        url: "/fund/list", // 요청을 보낼 URL
		        type: "GET", // GET 방식의 요청
		        data: formData, // 요청에 포함될 데이터
		        processData: false, // FormData를 처리하지 않도록 설정
		        contentType: false, 
		        beforeSend: function(xhr) {
		            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		        },
		        success: function(data) {
		            // 받은 데이터로 #fundList의 내용을 업데이트합니다.
		            var extractedData = $(data).find('#fundList').html();
		            $('#fundList').html(extractedData);

		            // 성공 시 sort 값을 콘솔에 출력합니다.
		            console.log("선택된 정렬 방식: " + sort);

		            // 정렬된 데이터를 받아온 후에 원하는 페이지로 이동
		            var newUrl = '/fund/list?sort=' + sort;
		            window.location.href = newUrl;
		        },
		        error: function(xhr, status, error) {
		            console.error("에러 발생 : " + error);
		        }
		    });

		}); */

/* 
		//게시물 알림창
		$(document).ready(function(){
		    var fundsuccess = "${fundsuccess}"; // 작품 등록 성공
		    var funddelete = "${funddelete}"; // 작품 삭제 성공
		    
		    if(fundsuccess === "success") {
		        alert("펀딩이 등록되었습니다.");
		    } else if(funddelete === "success") {
		        alert("펀딩이 삭제되었습니다.");
		    }
		}); */
		
		var result = '${result }';
		userOut(result);

		history.replaceState({}, null, null); // history 초기화

		function userOut(result) {
			// result 값이 있는경우에 알림창 표시

			if (result === '' || history.state) {
				return;
			}

			if (result == 'fundsuccess') {
				Swal.fire('펀딩이 등록되었습니다.', '', 'success')
			}

		}

	
	</script>

<%@ include file="../includes/footer.jsp"%>

