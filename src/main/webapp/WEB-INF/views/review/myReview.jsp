<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>

<header class="py-5 bg-image-full"
	style="background-image: url('https://source.unsplash.com/wfh8dDlNFOk/1600x900')">
	<div class="text-center my-5">
		<img class="img-fluid rounded-circle mb-4"
			src="https://dummyimage.com/150x150/6c757d/dee2e6.jpg" alt="..." />
		<h1 class="text-white fs-3 fw-bolder">Full Width Pics</h1>
		<p class="text-white-50 mb-0">Landing Page Template</p>
	</div>
</header>

<div>
	<form action="/review/myReview" id="actionForm">
		<div>
			<div class="class-container">
				<table>
					<thead>
						<tr>
							<th>클래스 이름</th>
							<th>작성 내용</th>
							<th>작성 날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="mylist" items="${mylist}">
							<tr>
								<td>${mylist.cvo.classname }</td>
								<td>${mylist.cvo.mid}</td> 
								<td>${mylist.cvo.classdate}</td>
							</tr>

						</c:forEach>
					</tbody>
				</table>
				<input type="hidden" name="mid" value="${mylist.mid }">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</div>
		</div>

	</form>
</div>


<script>

</script>
<%@ include file="../includes/footer.jsp"%>