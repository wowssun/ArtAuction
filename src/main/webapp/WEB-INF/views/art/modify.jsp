<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp"%>


<div class="main">
	<section class="module bg-dark-30 about-page-header" data-background="/resources/live/assets/images/gallery.jpg">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-sm-offset-3">
					<h1 class="module-title font-alt mb-0">Art Modify</h1>
				</div>
			</div>
		</div>
	</section>
	<section class="module" style="padding: 50px;">
		<div class="container">
			<div class="row">
				<div class="col-sm-8 col-sm-offset-2">
					<h4 class="font-alt mb-0">Modify Form</h4>
					<hr class="divider-w mt-10 mb-20">

					<div class="row">
						<div class="col-sm-8">

							<form action="/art/modify" method="post" role="form">

								<input type="hidden" name="${_csrf.parameterName }"
									value="${_csrf.token }"> <input type="hidden"
									name="ano" value="${avo.ano }">

								<div class="form-group">
									<label>작가명</label> <input type="text" name="artist" id="artist"
										class="form-control" value="${avo.artist }" readonly>
								</div>

								<div class="form-group">
									<label>작품명</label> <input type="text" name="artName"
										id="artName" value="${avo.artName }" class="form-control"
										required />
								</div>

								<div class="form-group">
									<label>기법/종류</label> <input type="text" name="genre" id="genre"
										value="${avo.genre }" class="form-control" required />
								</div>

								<div class="form-group">
									<label>작품 크기</label> <input type="text" name="asize" id="asize"
										value="${avo.asize }" class="form-control" required />
								</div>

								<div class="form-group">
									<label>작품 소개</label>
									<textarea name="intro" id="intro" class="form-control" rows="3"
										class="form-control" required>${avo.intro}</textarea>
									<p>Bytes: <span id="byteCount">0</span></p>
								</div>


								<div class="text-right" style="margin: 20px 0 20px 0;">
									<!-- 로그인한 사용자가 작성한 글 -> 수정/삭제버튼 표시 -->
									<sec:authorize access="isAuthenticated()">
										<sec:authentication property='principal.username'
											var="loginId" />
										<c:if test="${loginId == avo.mid or loginId == 'admin'}">

											<button data-oper="remove" class="btn btn-danger"
												formaction="/art/remove">Remove</button>
											<button data-oper="modify" id="modBtn"
												class="btn btn-warning">Modify</button>

										</c:if>
									</sec:authorize>

									<a class="btn btn-secondary backBtn" onclick="history.back()"
										style="background-color: lightgray; color: #fff;">뒤로가기</a>
								</div>

								<!-- 페이지 번호와 페이지에 표시할 게시물의 수, 검색 타입, 키워드 -->
								<input type="hidden" name="type" value="${cri.type}"> <input
									type="hidden" name="keyword" value="${cri.keyword}"> <input
									type="hidden" name="pageNum" value="${cri.pageNum}"> <input
									type="hidden" name="amount" value="${cri.amount}">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- End Section -->



<div class="row">
	<div class="col-sm-8">
	<div class="col-sm-4 col-sm-offset-6">
		<div class="panel panel-default">
			<div class="panel-heading">파일 첨부</div>
			<!-- /.panel-heading -->
			<div class="panel-body">


				<div class="form-group uploadDiv">
					<input type="file" name="artImg" multiple>
					<hr>


					<!-- 업로드 결과 출력 -->
					<div class="uploadResult">
						<ul></ul>
					</div>


				</div>


				<!-- END 파일 등록 폼 -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
	</div>
</div>
<!-- /.row -->


<script>
var anoVal = '${avo.ano}';

//소개 부분에서 4000바이트 크기 제한하기.------------

// textarea의 내용이 변경될 때 호출되는 함수
     function updateByteCount() {
         var intro = $('#intro');
         var byteCount = $('#byteCount');

         // UTF-8로 인코딩하고 바이트 수 계산
         var text = intro.val();
         var encodedText = unescape(encodeURIComponent(text)); // UTF-8 인코딩
         var length = encodedText.length;

         $("#byteCount").text(length + " bytes");

         // 4000바이트 이상이면 버튼 비활성화, 미만이면 활성화
//          if (length > 4000) {
//              submitButton.disabled = true;
//          } else {
//              submitButton.disabled = false;
//          }

}


     $('#intro').on('input',function(){
        updateByteCount();
        
     });


// 소개 부분에서 4000바이트 크기 제한하기 end-----------


//첨부 파일 가져오기 ----------------------------
		(function(){
		$.getJSON('/art/getArtImg', { ano : anoVal }, function(result){
		console.log(result);

		uploadFile(result);
		});//END getJSON()
		})();//END 첨부 파일 가져오기 -------------------

		var frm = $('form[role="form"]');

		//만약 버튼에 아이디 안 붙여두면 $('button[type="submit"]')으로 사용
		$('#modBtn').on('click', function(event){
		    event.preventDefault();
		    console.log('modBtn 눌림!');

		    // 입력값을 가져옴
		    var artName = $('#artName').val();
		    var genre = $('#genre').val();
		    var asize = $('#asize').val();
		    var intro = $('#intro').val();

		    // 입력값이 비어있는지 확인
		    if (artName === '' || genre === '' || asize === '' || intro === '') {
		        // 입력값이 비어있는 경우 알림창을 띄움
		        Swal.fire('입력값을 모두 작성해주세요.', '', '');
		        return;
		    }



		    var formData = $('form[role="form"]').serialize();
		    console.log('Form Data:', formData);

		    var hidden = '';

		    $('.uploadResult ul li').each(function(i, obj) {
		    	//var uuid = $(this).data('uuid');
		        var filename = $(this).data('filename');
		        console.log(filename);

		        hidden += '<input type="hidden" name="artImg" value="' + filename + '">';

		    });
		  	//frm.append(hidden) //전송 전 확인용
		    // 히든 입력 필드를 폼에 추가하고 폼을 서버로 전송
		    console.log(hidden);
		    frm.append(hidden).submit();
		});

		// 업로드 제한 확인
		function checkExtension(fileName, fileSize) {
		    var regEx = new RegExp("(.*?)\.(exe|sh|zip)$");
		    var maxSize = 5242880;

		    if (fileSize >= maxSize) {
		        alert("파일이 너무 커서 업로드 할 수 없습니다!");
		        return false;
		    }

		    if (regEx.test(fileName)) {
		        alert("해당 형식의 파일은 업로드 할 수 없습니다!");
		        return false;
		    }

		    return true;
		}


	// 첨부파일 선택 이벤트 처리
	var csrfHeaderName = '${_csrf.headerName}';
	var csrfTokenValue = '${_csrf.token}';

	$('input[type="file"]').on('change', function(){
	    var formData = new FormData();
	    var files = $('input[name="artImg"]')[0].files; // 첫 번째 파일만 선택

	    console.log(formData);
	    console.log(files);

	    if(checkExtension(files[0].name, files[0].size)) {
	        formData.append('artImg', files[0]);
	    } else {
	        return false;
	    }

	        $.ajax({
	            type: 'post',
	            url: '/artupload/ajaxAction',
	            data: formData,
	            dataType: 'json',
	            contentType: false,
	            processData: false,
	            beforeSend: function(xhr){
	                xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	            },
	            success: function(result, status, xhr){
	                console.log('첨부파일 업로드 ok!!!');
	                console.log(result);
	                $('input[type="file"]').val('');
	                uploadFile(result); // 업로드 결과를 출력하는 함수 호출

	            },
	            error: function(xhr, status, er){
	                console.log('첨부파일 업로드 error!!!');
	            }
	        });
	});


	//업로드 결과 출력 ----------------------------------------------
	var fileUL = $('.uploadResult ul'); // div의 ul 태그 선택

	// 업로드 결과를 리스트로 표시하는 함수
	function uploadFile(result) {
	    console.log('uploadFile 함수 호출됨');
	    console.log(result.artImg);
	    //console.log(result.uuid);

	    var liTag = '';
	    //var uuid = result.uuid;
	    var fileName = result.artImg;

	    var thumbnailAddr = encodeURIComponent('s_'+ fileName);

	    // 이미지 태그를 liTag에 포함시킴
	    liTag += '<li data-fileName="' + fileName + '">';
	    liTag += '<img src="/artdisplay?fileName=/' + thumbnailAddr + '" alt="Thumbnail"><br>';
	    liTag += fileName;
	    liTag += '<button type="button" class="btn btn-warning btn-circle" '
	    +' data-file="' + thumbnailAddr + '" '
		+' data-type="image"> '
		+'<i class="fa fa-times"></i></button></li>';

	        // 리스트 아이템 추가
	        fileUL.append(liTag);
	    //}
	}
	// END 업로드 결과 출력 ----------------------------------------------



//X 버튼 클릭 이벤트 처리 -----------------------------------------
$('.uploadResult').on('click', 'button', function() {

	if(confirm('첨부 파일을 삭제하시겠습니까?')){
		$(this).closest('li').remove();
	}
});

 
 var result = '${result }';
 userOut(result);

 history.replaceState({}, null, null); // history 초기화

 function userOut(result) {
 	// result 값이 있는경우에 알림창 표시

 	if (result === '' || history.state) {
 		return;
 	}

 	if (result == 'modifyerror') {
 		Swal.fire('작품 수정에 실패했습니다. 다시 시도해주세요.', '', 'success')
 	}

 }

$('button[data-oper="remove"]').on('click', function(e) {
	e.preventDefault();
	Swal.fire({
		   title: '작품을 삭제하시겠습니까?',
		   text: '',
		   icon: 'warning',
		   
		   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
		   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
		   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
		   confirmButtonText: '확인', // confirm 버튼 텍스트 지정
		   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
		   
		   reverseButtons: true, // 버튼 순서 거꾸로
		   
		}).then(result => {
		   // 만약 Promise리턴을 받으면,
		   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
		      Swal.fire('삭제가 완료되었습니다.','','artdelete').then(() => {
		    	  $('form').attr('action', '/art/remove'); 
	                $('form').submit();
	            });
		   }
		});
});



</script>

<%@ include file="../includes/footer.jsp"%>