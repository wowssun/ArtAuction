<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-60 faq-page-header"
		data-background="/resources/img/title/qna.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">Enquiries List</h2>
					<div class="module-subtitle font-serif"></div>
				</div>
			</div>
		</div>
	</section>
			<section class="module-small">
				<div class="container">
					<form class="row" action="/inquiry/inqlist" id="searchFrm">
						<div class="col-sm-2 mb-sm-20">
							<select class="form-control" name="type">
								<option value="T" ${type == 'T' ? 'selected' : '' }>제목</option>
								<option value="C" ${type == 'C' ? 'selected' : '' }>작성자</option>
								<option value="TC" ${type == 'TC' ? 'selected' : '' }>제목
									or 작성자</option>
							</select>
						</div>
						<div class="col-sm-2 mb-sm-20">
							<input class="form-control" placeholder="Default input"
								type="text" name="keyword" value="${pageDTO.cri.keyword}">
						</div>
						<div class="col-sm-2">
							<button class="btn btn-block btn-round btn-g" type="submit">Apply</button>
						</div>
						<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
					</form>
				</div>
			</section>
			<hr class="divider-w pt-20">
			<div class="row">
				<div class="col-sm-12">
					<table class="table table-striped table-border checkout-table">
						<tbody>
							<tr>
								<th class="hidden-xs">번호</th>
								<th>제목</th>
								<th class="hidden-xs">작성자</th>
								<th>작성일</th>
								<th>답변일</th>
							</tr>
							<c:forEach items="${list }" var="ivo">
								<tr>
									<td class="hidden-xs">${ivo.rno }</td>
									<td><a class="move" href="${ivo.rno }">
											<h5 class="product-title font-alt">${ivo.title }
									</a> <c:if test="${not empty ivo.answerDate}">
											<span style="color: red;">[답변 완료]</span>
										</c:if></h5></td>
									<td class="hidden-xs">
										<h5 class="product-title font-alt">${ivo.mid }</h5>
									</td>
									<td>
										<h5 class="product-title font-alt">${ivo.writeDate }</h5>
									</td>
									<td>
										<h5 class="product-title font-alt">${ivo.answerDate }</h5>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!-- paging -------------------------------->
			<div class="col-sm-12">
				<div class="pagination font-alt">
					<c:if test="${pageDTO.prev }">
						<a href="${pageDTO.start - 1}"><i class="fa fa-angle-left"></i></a>
					</c:if>
					<c:forEach begin="${pageDTO.start }" end="${pageDTO.end }" var="i">
						<a class="active ${pageDTO.cri.pageNum == i ? 'active' : '' }"
							href="${i}">${i}</a>
					</c:forEach>
					<c:if test="${pageDTO.next }">
						<a href="${pageDTO.end + 1}"><i class="fa fa-angle-right"></i></a>
					</c:if>
				</div>
			</div>

			<form action="/auction/bidlist" id="actionFrm">
				<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageDTO.cri.amount}">
				<input type="hidden" name="mid" value="">
			</form>


	<script>
		var searchFrm = $('#searchFrm')

		$('.searchBtn').on('click', function() {
			//검색 키워드를 입력하지 않은 경우
			//		if(searchFrm.find("input[name='keyword']").val() == ''){
			//			alert('검색 키워드를 입력해 주세요.');
			//			return false;
			//		}

			//검색 시 페이지 번호를 1이 되도록 설정
			searchFrm.find("input[name='pageNum']").val('1');
			searchFrm.submit();
		});
		//END 검색 버튼 이벤트 처리 -----------------------

		//페이징 이벤트 처리 ------------------------------
		var actionFrm = $('#actionFrm');

		$('.pagination a').on('click', function(e) {
			e.preventDefault();

			//a 태그의 href 값을 pageNum에 저장
			actionFrm.find("input[name='pageNum']").val($(this).attr('href'));

			actionFrm.submit();
		});

		$('.move').on('click', function(e) {
			e.preventDefault();

			var rno = $(this).attr('href'); // 클릭한 링크의 href 값을 가져옴

			// auction/view 경로로 이동
			window.location.href = '/inquiry/view?rno=' + rno;
		});

		$('#regBtn').on('click', function() {
			window.location.href = "/inquiry/register";
		});
	</script>
	<%@ include file="../includes/footer.jsp"%>