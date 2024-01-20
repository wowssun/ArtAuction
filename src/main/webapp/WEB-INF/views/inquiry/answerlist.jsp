<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-60 faq-page-header"
		data-background="/resources/img/title/qna.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">Posts Requiring Answers</h2>
					<div class="module-subtitle font-serif"></div>
				</div>
			</div>
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
							<c:forEach items="${answerlist }" var="ivo">
								<tr>
									<td class="hidden-xs">${ivo.rno }</td>
									<td><a class="move" href="${ivo.rno }">
										<h5 class="product-title font-alt">${ivo.title }</h5></a>
									</td>
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
							<c:if test="${empty answerlist}">
								<tr>
									<td colspan="5" style="text-align: center;">답변이 필요한 글이 존재하지않습니다.</td>
								</tr>
							</c:if>
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
	$('.move').on('click', function(e) {
		e.preventDefault();

		var rno = $(this).attr('href'); // 클릭한 링크의 href 값을 가져옴

		// auction/view 경로로 이동
		window.location.href = '/inquiry/view?rno=' + rno;
	});
</script>
<%@ include file="../includes/footer.jsp"%>
















