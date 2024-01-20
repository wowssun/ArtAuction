<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../includes/header.jsp" %>

<title>작가 정보 수정</title>
<style>

.centered-content{
 		display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100%;
        margin-top: 30px; 
        margin-bottom: 100px;
        

}

.errorintro {
   color: red;
    font-size: 14px;
}

.find-btn{
	text-align: center;
}
.find-btn1{
	display :inline-block;
}

ul {list-style: none;}

.panel { margin-top: 50px;}
.panel-heading {padding: 0px 20px; }
.panel-body {width:400px; height: 290px; }

.requeform { width:370px;}

.photo { text-align: center; margin-right: 50px; margin-top: 20px; }

.deBtn { padding-left: 10px; padding-right: 10px;}

.input #addbtn{
    width: 30px;
    height: 30px;
    border: none;
    border-radius: 3px;
    background: rgb(6, 6, 6);
    cursor: pointer;
    color: white;
    font-size: 15px;
}
#addValue { width: 360px;}

.Todolist li{
    width: 400px;
    list-style: none;
    line-height: 40px; 
    position: relative;
    margin-bottom: 9px;
    text-indent: 15px; 
    background: rgb(241, 242, 241);
    border-radius: 3px;
    font-weight: 400;
    cursor: pointer;
}


textarea.form-control { height: 200px; resize:none;}


</style>



<section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/j.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">Artist Info Modify</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">작가 정보 수정</h2>
              </div>
            </div>
          </div>
        </section>
        
        <div class="main">
			 <div class="centered-content">
					
				
				<div class="panel panel-default">
           				 <div class="panel-heading">
           				 📷 File  📷</div>   <!-- /.panel-heading -->   	
                          <div class="panel-body"> 
						
							<div class="form-group ">
								<label><b>대표사진</b></label>
								<p>파일 이름은 자신의 아이디로 설정해주세요.</p>
								<div class="input">
           						 <input type="file" name="photo" id="photo" class="form-control" value="${avo.photo }"  required >
           						 
         			  		 </div>
         			   	
         				<!--업로드 결과 출력  -->
						<div class="upLoadResult">
							<ul></ul>
						</div>	
					</div>
				</div>
				</div>	
				
				
				<form action="/user/artmodify" method="post" class="form-horizontal requeform ">
					<div class="form-group">
						<label><b>분야정보</b></label>
						<div class="input">
							<select class="form-control" name="major1" id="major1" 
							onchange="javascript:setMajor(this)">
								<option value="회화" ${avo.major eq '회화' ? 'selected' :'' }>회화</option>
								<option value="조각" ${avo.major eq '조각' ? 'selected' :'' }>조각</option>
								<option value="공예" ${avo.major eq '공예' ? 'selected' :'' }>공예</option>
								<option value="디자인" ${avo.major eq '디자인' ? 'selected' :'' }>디자인</option>
								<option value="판화" ${avo.major eq '판화' ? 'selected' :'' }>판화</option>
								<option ${avo.major eq 'avo.major' ? 'selected' :'' }>기타</option>
							</select>
							<!-- 기타로 처리할시 직접 넣어야함. 이메일 처리할때랑 비슷하게 -->
							<div class="input">
							<input type="text" name="major2" id="major2" class="form-control"
								 required maxlength="10" value="${avo.major}">
						</div>
							
						</div>
					</div>
					
					<div class="form-group">
						<label><b>이력</b></label>
						<div class="input">
          					<!--  <textarea name="career" id="career" class="form-control" required >- 연도 이력사항 - 연도 ~ 연도 이력사항 </textarea> --> 
					            <input type="text" id="addValue" placeholder="2023 ~ 2023 이력" autofocus/><!--자동포커스-->
					            <button type="button" id ="addbtn" >+</button> 
					        <div>
					        	
					            <ul id="addTodo" class="Todolist" style="padding-left: 0px;"> 
					                <li>
					                 <div id="result"> </div> 
					               </li>      
					            </ul>
					        </div>		
           						 <div>
           						 최신순으로 양식에 맞춰 작성해주세요.
           						 </div>
					</div>
					</div>
					
					<div class="form-group">
						<label><b>소개</b></label>
						<div class="input">
           						  <textarea name="introduce" id="introduce" class="form-control" required >${avo.introduce }</textarea>
           						<p>Bytes: <span id="byteCount">0</span></p>
					</div>			
					</div>
				
					<div class="find-btn"> 
							<input type="button" class="cancelBtn btn find-btn1" value="뒤로가기">	  
							<input type="submit" class="okBtn btn find-btn1" value="수정">			 
					</div>
				
				<input type="hidden" name="major" id="major">
				<input type="hidden" id="mid" name="mid" value="<sec:authentication property='principal.mvo.mid'/>">
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
			</form>
			</div>
		</div>

	
	<script>
	
	var midval = '${avo.mid}';
	//첨부 파일 가져오기 ----------------------------
	(function(){
	$.getJSON('/user/getPhoto', { mid : midval }, function(result){
	console.log(result);

	showFile(result);
	});//END getJSON()
	})();//END 첨부 파일 가져오기 -------------------
	
	
	//이력 가져오기 ----------------------------
	 (function() {
        $.getJSON('/user/getCareer', { mid: midval }, function(result) {
            console.log(result);

            showCareer(result);
        });

        function showCareer(data) {
            var result = $('#result');

            data.forEach(function(item) {
                var list = $('<li></li>');
                var del = $('<button>x</button>');

                list.text(item.career);
                result.append(list);
                list.append(del);

                del.css({
                    fontSize: '15px',
                    border: 'none',
                    height: '15px',
                    float: 'right',
                    right: '17px',
                    cursor: 'pointer',
                    position: 'relative'
                });

                del.click(deleteList);
            });
        }
    })();
		
			
	
	// 소개 부분에서 4000바이트 크기 제한하기.------------
	
	// textarea의 내용이 변경될 때 호출되는 함수
        function updateByteCount() {
            var introduce = $('#introduce');
            var byteCount = $('#byteCount');

            // UTF-8로 인코딩하고 바이트 수 계산
            var text = introduce.val();
            var encodedText = unescape(encodeURIComponent(text)); // UTF-8 인코딩
            var length = encodedText.length;

            $("#byteCount").text(length + " bytes");
            
            if(length > 4000) {
     			 // 아니 바이트부분 밑에다가 문구 삽입하기
     			 $('.errorintro').remove();  // 메시지 있으면 먼저 삭제
     		      var errorMessage = $('<div class="errorintro">4000byte 이하로 작성하세요.</div>'); 
     		      byteCount.after(errorMessage); // 바이트수 확인란 아래에 메시지 추가
     			 
     		 }else if(length < 4000){
     			$('.errorintro').remove();  // 메시지 있으면 먼저 삭제
     		 }
	}
	
        $('#introduce').on('input',function(){
        	updateByteCount();
        	
        });
	// 소개 부분에서 4000바이트 크기 제한하기 end-----------
	

	
	// 수정 버튼 클릭시 -------------------
	
	 // 수정 눌리면 
	// 일단 ajax로 파일 업로드 처리하고 
	
	var requeform = $('.requeform');
	
	$('.okBtn').on('click', function(e) {
		 e.preventDefault();
		 
		    var major = $('#major');
		 	var major1 = $('#major1');
			var major2 = $('#major2');
			var career = $('#career');
			var introduce = $('#introduce');
			var photo = $('#photo');
		 
		 major.val(major2.val());
		 console.log(major.val())
		
	 
		 // 빈칸 안돼
		    if (major.val() === '' || major1.val() === '' || major2.val() === ''|| introduce.val() === '' ||photo.val()==='') {
		    	Swal.fire({
		    	      icon: 'warning',
		    	      title: '모두 입력해주세요.',
		    	      text: '',
		    	    });
		        return;
		    }
		 
         var byteCount = $('#byteCount');

         // UTF-8로 인코딩하고 바이트 수 계산
         var text = introduce.val();
         var encodedText = unescape(encodeURIComponent(text)); // UTF-8 인코딩
         var length = encodedText.length;
		 
		 if(length > 4000) {
			 Swal.fire({
	    	      icon: 'warning',
	    	      title: '소개글의 글자수를 확인해주세요.',
	    	      text: '',
	    	    }); 
			 return;
		 }
		 
		// 직렬화한 데이터
		 var formData = requeform.serialize();

		 console.log(formData);
		 // formData의 값
		 // "name=John&email=john%40example.com"
		 
		 $('.upLoadResult ul li').each(function(i, obj) {
	        var filename = $(this).data('filename');
	        console.log(filename);

	       var hidden = '<input type="hidden" name="photo" value="' + filename + '">';
	        console.log(hidden)
	        requeform.append(hidden)
	    });
		 	
		// liTag를 li 길이만큼 for문을 돌리고 li 태그를 각각 뽑아낸다.
			// 그리고 그 개별 값을 hidden Tag에 저장해서 artistVO에 있는 careerlist 에 form 제출한다.
			// 그리고 컨트롤러에서 값을 받은 다음 서비스에서 등록할때 for문 돌려서 있는 만큼 테이블에 저장하면 된다.
				var hiddenTag = '';
				var i = 0; // li 태그의 인덱스를 나타내기 위한 변수
				var midval = $('#mid').val();
				
				$("#result li").each(function() {
				    var liValue = $(this).contents().filter(function() {
				        return this.nodeType === 3;   // nodeType이 text
				    }).text();
				
				    if (liValue.trim() !== '') { // 빈 문자열이 아닌 경우에만 처리
				        hiddenTag += '<input type="hidden" name="careerlist[' + i + '].career" value="' + liValue + '">'
				        		 	+ '<input type="hidden" name="careerlist[' + i + '].mid" value="' + midval + '">' ;
				        i++;
				    }
				});
		 	 console.log(hiddenTag);
		 	 console.log(photo);
		 	 console.log(major);
		 	 console.log(text);
		 	 
		 	requeform.append(hiddenTag);
		 
		 requeform.submit();
		
	});
	
	// 등록 버튼 클릭시 end -------------------
	

	
	// 분야정보 선택하기 --------
	
	function setMajor(obj){
		
		var major1 = document.getElementById('major1');
		var major2 = document.getElementById('major2');
		
		
			if(major1.value == '기타'){ 
				major2.readOnly = false;  		
				major2.value = '';					 
			}else{
				major2.value = major1.value;
				major2.readOnly = true;
			}					
		
       }
	// 분야정보 선택하기 end --------
	
	// 업로드 제한 확인 ---------------------------------
    
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
	
	// 업로드 제한 확인 END--------------------------
	
	
	
	// 첨부파일 선택 이벤트 처리 (완)----------------------
	// input type=file이 change 되면
	
	// 이제 여기에서 ajax로 보낼때도 csrf 토큰을 보내야한다.
	// 미리 이렇게 토큰 변수를 만들어 놓고
	var csrfHeaderName = '${_csrf.headerName }';   // CSRF 토큰 관련 변수
	var csrfTokenValue = '${_csrf.token }';		  // 토큰
		
	$('input[type="file"]').on('change', function(){
		console.log('버튼 눌림');
		
		var formData = new FormData();    // ajax는 폼태그 없이 formdata를 사용해서 -> 그럼 formtag를 사용한것처럼 사용가능
		var files = $('input[name="photo"]')[0].files;
		
		console.log(formData);
		console.log(files);
		
		// formData 객체에 파일 추가
		
			if(checkExtension(files[0].name, files[0].size)){
				
				 formData.append('photo', files[0]);
			 } else {
			        return false;
			    }
		
		 $.ajax({
			type : 'post',											 // get or post 등등 method
			url :  '/upload/ajaxAction',							 // 전송할 곳, json으로 받아야 나온다.
			data : formData,					 					 // 전송할 테이터 위에서 담아둔 객체
			dataType : 'json',
			contentType : false , 		 //  컨텐트 타입 및 인코딩
			processData : false,
			beforeSend : function(xhr) { // xhr  : XML Http Request 
				// 전송 전 CSFR 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		 },
			success : function(result, status, xhr) {
								 // 서버로 데이터로 등록하고 성공했을경우 이쪽으로
								console.log('uplod ok');
								console.log(result);
								showFile(result);
			},
			error : function(xhr, status, er) {		// 등록 못했을때, 에러 시
				
						console.log('uplod error');
				}
		}); // END ajax()	 
	});// click end
	
	
	// 첨부파일 선택 이벤트 처리 end -----------------
	
	
	
	// 업로드 결과 출력  - 나는 uuid도 없고 그냥 파일 이름 그대로 가져온다. 그리고 파일 하나만 있음
	    var upLoadResult =	$('.upLoadResult ul');
	
	function showFile(result){
		
		var liTag = '';    // 변수 초기화  li태그 다 가져오기
			           		 
       		 // 서버로 전송할 정보 li태그 (여는 태그만 만든 후에 밑에 li붙이기)		           	
       		 liOpenTag = '<li data-fileName="' + result.photo + '">';
       		 	
       		 var uri = encodeURIComponent('/s_' + result.photo);    // 썸네일 주소 경로
       		 console.log(result.photo)
       		      		 
      		 
     			 // 이미지는 썸네일과 파일명 표시  href를 이용해서 함수 호출하기
     			liTag += liOpenTag + '<img src="/display?fileName=' + uri + '"><br>' + result.photo
     				  + '<button style="padding-left: 3px; padding-right: 3px; background: lightblue; border:1px solid lightblue; padding-top:0px; padding-bottom:0px; margin-left:5px;"' 
     				  +'type="button" class=" btn btn-warning btn-circle" data-file="' + uri + '"' + 'data-type="image"><i class="fa fa-times"></i></button></li>';
     			// 여기 src에서 /display?fileName으로 들어가는 서버에 저장된 썸네일 경로값 
     			// span 태그 넣어서 x 표시
    	
	           		 
			upLoadResult.append(liTag);    //ul에 li 붙이기 먼저 for문돌려서 litag를 작성해놓고 그다음에 붙임.
			// append는 계속 추가해서 붙이는듯?
           }
                  
	 // 업로드 결과 출력 end
	 
	 // 파일 삭제
	 
	 $('.upLoadResult').on('click','button',function(){
		
		 var xBtn = $(this).closest('li');
		 
		//alert('클릭확인');
		
		// 여기서 클릭이 되어진것이 button 태그 이므로 this를 사용할 수 있다.
		
		 $.ajax({
			type : 'post',											 // get or post 등등 method
			url :  '/deleteFile',							 // 전송할 곳, json으로 받아야 나온다.
			data : { fileName : $(this).data('file'), type : $(this).data('type')},			 // 전송할 테이터 위에서 담아둔 객체
			dataType : 'text',					// 전송할 테이터
			beforeSend : function(xhr) { // xhr  : XML Http Request 
				// 전송 전 CSFR 헤더 설정
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		 },
			success : function(result, status, xhr) {
								 // 서버로 데이터로 등록하고 성공했을경우 이쪽으로
								//alert(result);
								 
								// 버튼에서 제일 가까운 li를 가져와서 지워
							//	$('.upLoadResult button[type="button"]').closest('li').remove();
								xBtn.remove();
								
			},
			error : function(xhr, status, er) {		// 등록 못했을때, 에러 시
				
						console.log(' delete error');
				}
		}); // END ajax()
		
	 } );
	  	  
	 
	 // 파일 삭제 end
	 
	 // 경력 추가하기----------------
	 
	 var btn = $('#addbtn');          //추가 버튼
	 var addValue = $('#addValue');   //경력 입력창
	 var result = $('#result');    // li 태그에 추가된 경력
	
	 // 플러스 버튼 추가하면
	 $('#addbtn').on('click', function () {
		    if (addValue.val().length < 1) { /*''도 가능 */
		        Swal.fire({
		            icon: 'warning',
		            title: '내용을 입력해주세요.',
		            text: '',
		        });
		        return;
		    }  // if end

		    var list = $('<li></li>');
		    var del = $('<button>x</button>');

		    list.text(addValue.val());
		    result.append(list); 
		    list.append(del); 
		    
		    del.css({
		        fontSize: '15px',
		        border: 'none',
		        height: '15px',
		        float: 'right',
		        right: '17px',
		       /*  marginTop: '10px', */
		        cursor: 'pointer',
		        position: 'relative'
		    });  // css end
		    
		    del.click(deleteList); // 삭제버튼 클릭시 리스트 지우기 이벤트 실행

		    addValue.val(''); //  입력 창 초기화
		    addValue.focus(); // 입력창에 포커스
		    	
		});
	 
	 
	 //경력 삭제시
	 function deleteList(e){ //삭제 버튼(x) 클릭시 
	     let removeOne = e.target.parentElement;  //선택한 목록 한개만 지우기(부모 객체를 지운다)
	     removeOne.remove();
	 }
	 
	  
	 
	 // 경력 추가하기 end---------------
	 
	 // 뒤로가기 버튼 ---------------------
	 
	 $('.cancelBtn').on('click',function(e){
		 e.preventDefault();
		 
		 console.log('버튼 눌림');
		 location.href='/user/mypage';
		 		 
	 });
	 
	 
	 // 뒤로가기 버튼  end
	 
	
	</script>


<%@ include file="../includes/footer.jsp" %>