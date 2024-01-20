<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>
<div class="main">
	<section class="module bg-dark-60 faq-page-header"
		data-background="/resources/img/title/qna.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h2 class="module-title font-alt">Inquiry</h2>
					<div class="module-subtitle font-serif"></div>
				</div>
			</div>
		</div>
	</section>
	<section class="module">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<div role="tabpanel">
						<ul class="nav nav-tabs font-alt" role="tablist">
							<li class="active"><a href="#support" data-toggle="tab"><span
									class="icon-tools-2"></span>Question</a></li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="support">
								<div class="panel-group" id="accordion">
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title font-alt">
												<a data-toggle="collapse" data-parent="#accordion"
													href="#support1">${ivo.title }</a>
											</h4>
										</div>
										<div class="panel-collapse collapse in" id="support1">
											<div class="panel-body">${ivo.detail }</div>
										</div>
									</div>
									<div class="panel panel-default">
										<div class="panel-heading">
											<h4 class="panel-title font-alt">
												<a class="collapsed" data-toggle="collapse"
													data-parent="#accordion" href="#support2">Answer</a>
											</h4>
										</div>
										<div class="panel-collapse collapse" id="support2">
											<div class="panel-body">${ivo.answer }</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<form action="/inquiry/modify">
						<div class="row mb-20">
							<div class="col-sm-8">
								<button class="btn btn-primary">modify</button>
								<input type="hidden" name="rno" value="${ivo.rno }">
								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }"> <input type="hidden"
									name="type" value="${cri.type}"> <input type="hidden"
									name="keyword" value="${cri.keyword}"> <input
									type="hidden" name="pageNum" value="${cri.pageNum}"> <input
									type="hidden" name="amount" value="${cri.amount}">
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
	</div>
	<%@ include file="../includes/footer.jsp"%>