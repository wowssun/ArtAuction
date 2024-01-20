<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%@ include file="../includes/header.jsp"%>

<style>

.cregi {
	width: 500px;
}

.info {
	width:100px; text-align: right;
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
                <h2 class="module-title font-alt mb-0">원데이 클래스 정보 수정</h2>
              </div>
            </div>
          </div>
        </section>

<div class="container">
	<br>
	<div class="align-items-center justify-content-center">
	<form action="/class/classMod" id="actionForm" method="post" role="form">
		<div class="title">
			<input type="text" name="classname" class="title cregi" value="${view.classname }">
		</div>
		<br>
		<div>
			<textarea name="classinfo" class="content cregi" rows="4">${view.classinfo }</textarea>
		</div>
		<br>
		
		<div>
			<label>진행 날짜 &nbsp;</label> <input type="date" name="classdate" class="info"
				min="2000-01-01" max="2024-12-31" value="${view.classdate }">
		</div>
		<br>
		<div>
			<label>시작 시간 &nbsp;</label> <input type="time" name="classtime" class="info"
				value="${view.classtime }">
		</div>
		<br>
		<div>
			<label>신청 가능 최대 인원 &nbsp;</label> <input type="text" name="peoplenum" class="info"
				value="${view.peoplenum }" placeholder="숫자만 작성 ex)10">명
		</div>
		<br>
		<div>
			<label>클래스 진행 시간 &nbsp;</label> <input type="text" name="runningtime" class="info"
				value="${view.runningtime}" placeholder="숫자만 작성 ex)60">분
		</div>
		<br>

		<button type="submit" data-oper="classMod" id="modBtn">수정 완료</button>
		<button type="button" class="cancleBtn" onclick="history.back()">취소</button>

		<input type="hidden" name="cno" value="${view.cno }">
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">                      

	</form>
	
	<br>
	
	<!-- 첨부파일 -->
		<div>
			<!-- 업로드 -->
			<div>
				<input type="file" class="upload" name="classimg" multiple>
			</div>
			<!-- END 업로드 -->

			<!-- 업로드 결과 출력 -->
			<div class="uploadResult">
				<ul>
				</ul>
			</div>
			<!-- END 업로드 결과 출력 -->

		</div>
		<!-- END 첨부파일 -->
	</div>
</div>
<!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> jQuery 스크립트 추가 -->
<script>
	var form = $('#actionForm');
	var cnoVal = "${view.cno}";
	//첨부 파일 가져오기 ----------------------------
	(function() {
		$.getJSON('/class/getArtImg', {
			cno : cnoVal
		}, function(result) {
			console.log(result);

			showUploadFile(result);
		});//END getJSON()
	})();//END 첨부 파일 가져오기 -------------------
	
	//수정 버튼 이벤트 처리-------------
	$('#modBtn').on('click', function(event) {
		event.preventDefault();
		console.log('modBtn 눌림!');

		var formData = $('#actionForm').serialize();
		console.log('Form Data:', formData);

		var hidden = '';

		$('.uploadResult ul li').each(function(i, obj) {
			var filename = $(this).data('filename');
			console.log(filename);
			hidden += '<input type="hidden" name="classimg" value="' + filename + '">';

		});
// 		form.append(hidden); //전송 전 확인용 confirm form on console
		// 히든 입력 필드를 폼에 추가하고 폼을 서버로 전송
		console.log("hidden: " + hidden);
		form.append(hidden).submit();
	});
	//END 수정 버튼 이벤트 처리-------------

	//업로드 제한 사항-------------
	var regEx = new RegExp("(.*?)\.(exe|sh|zip)$"); //업로드 제한
	var maxSize = 5242880;
	function checkExtension(fileName, fileSize) {

		if (fileSize > maxSize) {//크기 확인 및 알림 메시지 출력
			alert("파일 크기(5MB)가 초과하여 업로드 할 수 없습니다.");
			return false;
		}

		if (regEx.test(fileName)) {//확장자 확인 및 알림 메시지 출력
			alert("해당 형식의 파일은 업로드 할 수 없습니다.");
			return false;
		}

		//그 외의 경우 업로드
		return true;

	}
	//END 업로드 제한 사항-------------
	

	//첨부파일 상태 변경 이벤트-----------------
	var csrfHeaderName = '${_csrf.headerName}';
	var csrfTokenValue = '${_csrf.token}';
	
	$('input[type="file"]').on('change',function(){
		
		var formData = new FormData();
		var files = $('input[name="classimg"]')[0].files;
		console.log("업로드 버튼 확인 콘솔 O");

		//업로드 제한 사항 확인
		if (checkExtension(files[0].name, files[0].size)) {
			formData.append('classimg', files[0]);
		} else {
			return false;
		}

		//ajax로 파일 전송 위의 formdata를 보냄
		$.ajax({
			type : 'post', //get | post
			url : '/upload/cAjaxAction', //전송할 곳 - replyContoller로 넘어감
			data : formData, //전송할 데이터, 위에new해서 만든것
			dataType : 'json', //수신할 데이터 타입
			contentType : false, //컨텐트 타입 및 인코딩
			processData : false,
			beforeSend : function(xhr) {//xhr; xml http request
				//전송 전 csrf헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

			},//성공시
			success : function(result, status, xhr) {
				
// 				console.log("업로드 컨트롤러로 넘어가냐?");
				$('input[type="file"]').val(""); //input 타입이 file일때 초기화 - 파일선택에서 안뜸
				showUploadFile(result); //upload 호출 해야함
// 				alert("delete?");
				
			}, //에러시
			error : function(xhr, status, er) {
				console.log("upload error");

			}

		});
		console.log("업로드 완료? O");
		console.log("업로드 파일:" + files);
//		showUploadFile(result); //위에서 이미 값을 받아온것이라 여기서 불러오면 못찾고 에러남~

	});

	//END 첨부파일 상태 변경 이벤트----------------

	//업로드 결과 출력--------------
	var resultUL = $('.uploadResult ul'); //div's ul Tag select

	function showUploadFile(result) { //위의 버튼 이벤트에서 result를 보내옴
		console.log(result.classimg);
		var liTag = '';
		var fileName = result.classimg;
		var thumbnail = encodeURIComponent("s_" + fileName);
		
		resultUL.empty(); // 기존 결과를 비움
		console.log(thumbnail);
		
		liTag += '<li data-filename="' + fileName + '">';
		liTag += '<img src="/cDisplay?filename=/' + thumbnail + '" alt ="Thumbnail"><br>';
		liTag += fileName;
		liTag += '<button type="button" class="btn btn-warning btn-circle"'
				 + ' data-file="' + thumbnail + '" data-type="image"> '
				 + '<i class="fa fa-times"></i></button></li>';

		//이미지는 썸네일과 파일명 표시
		//일반 파일은 attach.png 이미지와 파일명 표시

		resultUL.append(liTag); //출력하게 함

	}
	//END 업로드 결과 출력--------------

	//파일 삭제
	$('.uploadResult').on('click', 'button', function() {
		console.log("delete file");
		var xbtn = $(this).closest('li');
		var file = $(this).data("file");
		var type = $(this).data("type");

		//ajax로 전송, formData를 보내면 됨 - ajax에서 함수를 호출 해야함
		$.ajax({
			type : 'post',
			url : '/cDeleteFile',
			data : {
				filename : file,
				type : type
			},
			dataType : 'text',
			beforeSend : function(xhr) {//xhr; xml http request
				//전송 전 csrf헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

			},//성공시
			success : function(result, status, xhr) {
				//alert(result);
				xbtn.remove();

			}, //에러시
			error : function(xhr, status, er) {
				console.log("delete error");

			} 
		}); //END ajax;

		console.log("-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-");

		console.log(files);

	});
	
	
	//dom에서만 지우고 modify를 눌러야 데이터와 서버에서 지워짐
// 	$('.uploadResult').on('click', 'button', function() {

// 		if (confirm('첨부 파일을 삭제하시겠습니까?')) {

// 			$(this).closest('li').remove();
// 		}
// 	});
	//END 파일 삭제
	
</script>

<%@ include file="../includes/footer.jsp"%>