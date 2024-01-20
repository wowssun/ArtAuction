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

.btn{
--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: .75rem;
}
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
                <h2 class="module-title font-alt mb-0">신청자 목록</h2>
              </div>
            </div>
          </div>
        </section>

<div class="container">
	<form action="/class/classReqList" id="actionForm">
		<div>
		<br>
			<div class="btn btn-xs pull-left">
				<button type="button" id="backBtn" onclick="history.back()">◀ 뒤로가기</button>
			    
			</div>
			<br> <br>
			<div>
				<c:choose>
					<c:when test="${empty reqList }">
						<h1>신청자가 없습니다.</h1>
					</c:when>
					<c:otherwise>
						<table class="rwd-table">
							<thead>
								<tr>
									<th>이름</th>
									<th>아이디</th>
									<th>이메일</th>
									<!-- 							<th>신청 취소</th> -->
								</tr>
							</thead>
							<tbody>
								<c:forEach var="req" items="${reqList}">
									<tr>
										<!-- reqno을 받아옴, list 참조 -->
										<td>${req.mvo.name }</td>
										<td>${req.mid}</td>
										<td>${req.mvo.email}</td>
										<!-- 									<td><button data-oper="classReqRem"  -->
										<!-- 									            id="classReqRem" class="" style="color: red" -->
										<%-- 									            formaction="/class/classReqRem?reqno=${req.reqno }">신청 취소</button></td> --%>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:otherwise>
				</c:choose>
				<input type="hidden" name="${_csrf.parameterName }"
					value="${_csrf.token }"> <input type="hidden" name="cno"
					value="${req.cno }"> <input type="hidden" name="reqno"
					value="${req.reqno }">
			</div>
		</div>
	</form>

	<!-- 게시물 등록 완료 표시 -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">MESSAGE</h4>
				</div>
				<div class="modal-body">처리가 완료되었습니다.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
					<!-- <button type="button" class="btn btn-primary">Save
									changes</button> -->
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
	<!-- END게시물 등록 완료 표시 -->

</div>


<script>

//beforeSend 대신 csrf 토큰 헤더 추가
var csrfHeaderName = '${_csrf.headerName }';
var csrfTokenValue = '${_csrf.token }';

//ajax를 할때마다 모든 csrf 헤더를 보내줌
$(document).ajaxSend(function(e, xhr, options) {
	xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

});

//END beforeSend 대신 csrf 토큰 헤더 추가
//클래스 신청 취소--------------------
	$('#classReqRem').on('click', function(event) {
		var actionForm = $('#actionForm');

		event.preventDefault(); // 일단 기존버튼 막기()
		console.log("next?")
		if(confirm('정말로 신청을 취소하시겠습니까?')){
			actionForm.append("<input type='hidden' name='reqno' value='" + $(this).attr('formaction') +"'>");
			actionForm.attr('action', '/class/classReqRem'); // 해당 form의 action 속성 설정
			actionForm.attr('method', 'post'); // 해당 for                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               m의 method 속성 설정
			actionForm.submit();
		}
	});
		
// 	$(function(}{	
		var actionForm = $('#actionForm');
		
		//beforeSend 대신 csrf 토큰 헤더 추가
		var csrfHeaderName = '${_csrf.headerName }';
		var csrfTokenValue = '${_csrf.token }';

		//ajax를 할때마다 모든 csrf 헤더를 보내줌
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

		});

		//END beforeSend 대신 csrf 토큰 헤더 추가
		
		//게시물 처리 결과 알림 모달창 처리
		var result = '${result}'; //값 받아오기
		checkModal(result); //값을 불러와야함, result를 매개변수로 전달

		//모달 창 재출력 방지
		history.replaceState({}, null, null); //history 초기화

		function checkModal(result) { //컨트롤러가 보낸 result값을 저장함
			//result 값이 있는 경우 모달 창 표시
			if (result === '' || history.state) {
				return;
			}

			//게시물이 등록된 경우
			//modal-body의 메시지 벼경
			if (parseInt(result) > 0) { //파싱해도 안해도 노상관
				$('.modal-body').text(result + '번 게시물 등록이 완료되었습니다.');
			}

			$('#myModal').modal('show');

		}
		//END 게시물 처리 결과 알림 모달창 처리 
// 	});
</script>
<%@ include file="../includes/footer.jsp"%>