<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="../includes/header.jsp"%>

<style>
/* #classRegi { */
/* 	align-content: flex-end; */
/* } */

/* 클래스 목록을 가로로 나열하도록 스타일링 */ */
.  .class-container {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
  }

   .class-item {
    width: calc(100% - 20px);
    border: 1px solid #ccc;
    margin: 10px;
    padding: 10px;
    text-align: center;
    box-sizing: border-box;
  } 

  .class-item img {
    max-width: 100%;
    height: 150px;
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
                <h2 class="module-title font-alt mb-0">원데이 클래스</h2>
              </div>
            </div>
          </div>
        </section>

<div class="container class-container">
	<form action="/class/classlist" id="actionForm">
		<div class="row multi-columns-row post-columns">
		<br>
			<div>
				<sec:authorize access="hasRole('ARTIST')">
					<sec:authentication property="principal" var="p" />
					<c:set var="loggedInUsername" value="${p.mvo.mid}" />
					<c:if test="${p.username == loggedInUsername}">
						<button type="button" id="regBtn">➕클래스 개설하기</button>
					</c:if>
				</sec:authorize>
			</div>
			<input type="hidden" name="mid" value="${p.username}" />
			
			<br>
			
			<div class="post">
				<c:forEach var="cvo" items="${list}" varStatus="loop">
					<div class="col-sm-6 col-md-4 col-lg-4">
						<div class="class-item">
							<div>
								${loop.index + 1}번
								<!-- 순서대로 번호 표시 -->
<%-- 								${cvo.cno }번 --%>
							</div>
							<div class="post-thumbnail">
								<img src="/cDisplay?filename=/${cvo.classimg}"
									alt="${cvo.classimg}">
							</div>
							<div class="post-meta">
								<div>${cvo.classdate}&nbsp;|&nbsp;${cvo.classtime}</div>
							</div>
							<div class="post-header font-alt">
								<h2 class="post-title">
									<a id="actionForm" class="move" href="${cvo.cno}">${cvo.classname}</a>
								</h2>
							</div>
						</div>
					</div>
				</c:forEach>
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
	$(function() {

		var actionForm = $('#actionForm');

		//게시물 제목 클릭 이벤트--------
		$('.move').on(
				'click',
				function(e) {
					e.preventDefault();
					//hidden 태그를 생성해 이름을 bno로 지정
					//a태그의 href 값을 bno에 저장
					actionForm.append("<input type='hidden' name='cno' value='"
							+ $(this).attr('href') + "'>");
					actionForm.attr('action', '/class/classInfo'); //컨트롤러로 감 > pageNum, amount를 cri로 받음

					
					actionForm.submit();
				});

		//END 게시물 제목 클릭 이벤트--------

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

		// 게시물 등록 버튼 클릭 이벤트 처리
		$('#regBtn').on('click', function() {
			self.location = "/class/classRegi";
		});

		//END 게시물 등록 버튼 클릭 이벤트 처리

	});
</script>

<%@ include file="../includes/footer.jsp"%>

