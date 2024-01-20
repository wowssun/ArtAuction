<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp"%>


<style>

.rwd-table {
  margin: auto;
  min-width: 700px;
  max-width: 100%;
  border-collapse: collapse;
}

/* header color */
.rwd-table th {
  border-top: none;
  background: #4d545c;
  color: #fff;
}

.rwd-table tr {
  border-top: 1px solid #ddd;
  border-bottom: 1px solid #ddd;
  background-color: #f5f9fc;
}

.rwd-table tr:nth-child(odd):not(:first-child) {
  background-color: #ebf3f9;
}

.rwd-table th {
  display: none;
}

.rwd-table td {
  display: block;
}

.rwd-table td:first-child {
  margin-top: .5em;
}

.rwd-table td:last-child {
  margin-bottom: .5em;
}

.rwd-table td:before {
  content: attr(data-th) ": ";
  font-weight: bold;
  width: 120px;
  display: inline-block;
  color: #000;
}

.rwd-table th,
.rwd-table td {
  text-align:center;
}

.rwd-table {
  color: #333;
  border-radius: .4em;
  overflow: hidden;
}

.rwd-table tr {
  border-color: #bfbfbf;
}

.rwd-table th,
.rwd-table td {
  padding: .5em 1em;
}
@media screen and (max-width: 601px) {
  .rwd-table tr:nth-child(2) {
    border-top: none;
  }
}
@media screen and (min-width: 600px) {
  .rwd-table tr:hover:not(:first-child) {
    background-color: #d8e7f3;
  }
  .rwd-table td:before {
    display: none;
  }
  .rwd-table th,
  .rwd-table td {
    display: table-cell;
    padding: .25em .5em;
  }
  .rwd-table th:first-child,
  .rwd-table td:first-child {
    padding-left: 0;
  }
  .rwd-table th:last-child,
  .rwd-table td:last-child {
    padding-right: 0;
  }
  .rwd-table th,
  .rwd-table td {
    padding: 1em !important;
  }
}

#backBtn{}


</style>

 <section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/d.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                <h5 class="font-serif">OneDay Class</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">나의 클래스 신청 목록</h2>
              </div>
            </div>
          </div>
        </section>

<div class="container">
	<form action="/class/classReqRem" id="actionForm">
		<div>
			<br>
			<div class="btn btn-xs pull-left">
				<button type="button" id="backBtn" onclick="history.back()">◀ 뒤로가기</button>
			</div>
			<br> <br>
			<div>
				<c:choose>
					<c:when test="${empty myReqList }">
						<h1>신청한 클래스가 없습니다.</h1>
					</c:when>
					<c:otherwise>
						<table class="rwd-table">
							<thead>
								<tr>
									<th>클래스 이름</th>
									<th>작가</th>
									<th>클래스 진행 날짜</th>
									<th>신청 취소</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="req" items="${myReqList}">
									<tr>
										<td>${req.cvo.classname }</td>
										<td>${req.mid}</td>
										<!-- 신청자 아이디로 바꿔야함 -->
										<td>${req.cvo.classdate}</td>
										<td><a type="button" class="reqDelBtn"
											href="${req.reqno }">신청 취소 ▶</a></td>
									</tr>



								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
			</div>
			<input type="hidden" name="mid"
				value="<sec:authentication property='principal.mvo.mid'/>">
			<input type="hidden" name="${_csrf.parameterName }"
				value="${_csrf.token }">
		</div>

	</form>
</div>


<script>
	$(function() {

		var actionForm = $('#actionForm');

		//신청 취소 클릭 이벤트--------
		$('.reqDelBtn')
				.on(
						'click',
						function(e) {
							e.preventDefault();

							if (confirm("해당 클래스의 신청을 취소하시겠습니까?")) {
								actionForm
										.append("<input type='hidden' name='reqno' value='"
												+ $(this).attr('href') + "'>");
								actionForm.submit();
							}

						});
		//END 신청 취소 클릭 이벤트--------

	});
</script>
<%@ include file="../includes/footer.jsp"%>