<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
  
 <style>
.view {margin: 80px;}
.upLoadResult li { list-style: none;}

</style>
      
             <section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/m.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                <h5 class="font-serif">Board Modify</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">자유게시판</h2>
              </div>
            </div>
          </div>
        </section>
            
            
            
            <div class="row view">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Board View Page
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">        
                        	 <!-- 수정은 form으로 내용을 보내야 하기 때문에 view와는 달리 여기 form으로 보내야함.  --> 
							<form action="/free/modify" method="post" role="form"> 		
								<div class="form-group">
									<label>#No</label>
								    <div class="pull-right">작성일 : <fmt:formatDate value="${fvo.regDate }"  type="date" pattern="yyyy.MM.dd (E)"/></div>
									<input type="text" name="frno" class="form-control" value="${fvo.frno }" readonly></div>
									
									
								<div class="form-group">
									<label>Title</label>
									<input type="text" name="title" id="title" class="form-control" value="${fvo.title }" ></div>
									
									
								<div class="form-group">
									<label>Content</label>
									<textarea name="content" class="form-control" id="content"
											  rows="3" >${fvo.content }</textarea></div>
									
								<div class="form-group">
									<label>Writer</label>
									<input type="text" name="mid" class="form-control" value="${fvo.mid }" readonly ></div>
									
									<!-- 여기 버튼 처리   -->	
									<!-- 수정과 삭제버튼은 postmapping으로 했으니까 method를 post로 변경하기  -->
									<!-- 목록가는거는 getmapping으로 했으니까 formmethod를 get으로 변경해야함. -->		
								
										<input type="hidden" name="pageNum" value="${cri.pageNum }">
										<input type="hidden" name="amount" value="${cri.amount }">
										<input type="hidden" name="type" value="${cri.type }">
										<input type="hidden" name="keyword" value="${cri.keyword }">
										<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
										
									<sec:authorize access="isAuthenticated()">
										<sec:authentication property="principal.username" var="username" /> <!-- c태그 사용안하고 이렇게 바로 변수만들기 가능  -->
										<sec:authentication property="principal.mvo.auth.auth" var ="auth"/>    
										<c:if test="${fvo.mid eq username || auth eq 'ROLE_ADMIN' }"> 						
									<button data-oper="remove" class=" ReBtn btn btn-danger" formaction="/free/remove" >	
										Remove</button>
									<button data-oper="modify" class=" moBtn btn btn-warning" >	
										Modify</button>
										</c:if> 
									</sec:authorize>
									<button data-oper="list"  class="btn btn-primary back" formaction="/free/list" formmethod="get">
										List</button>
								</form>		
							
            			 <!-- END 게시물 등록 폼 -->     
                         </div> 		 <!-- /.panel-body -->     
                     </div> 			 <!-- /.panel -->
                 </div>  				 <!-- /.col-lg-6 -->
             </div>       				 <!-- /.row -->
             
              <!-- 첨부파일 등록 폼  -->
             <div class="row view">
                <div class="col-lg-12">
                    <div class="panel panel-default">
           				 <div class="panel-heading">
                          <i class="fa fa-comments fa-fw"></i>File Attach </div>   <!-- /.panel-heading -->   	
                          <div class="panel-body"> 
                          	<div class="form-group upLoadDiv">
									<input type="file" name="uploadFile" multiple="multiple" ></div> <!-- 파일 여러개 선택  -->
							<!--업로드 결과 출력  -->
							<div class="upLoadResult">
								<ul>
								</ul>	
							 </div>	
                          </div>		               
 					 </div>	
            	 </div>
            </div>  <!-- 첨부 파일 end -->
            
            <script>  
            
            var csrfHeaderName = '${_csrf.headerName }';   // CSRF 토큰 관련 변수
        	var csrfTokenValue = '${_csrf.token }';		  // 토큰
            
            $('.ReBtn').on('click',function(e){
            	e.preventDefault();	
            	if(confirm('게시글을 삭제하시겠습니까?')){
            		var formAction = $(this).attr('formaction'); // Remove 버튼의 formaction 속성 값 가져오기
                    var removeForm = $(this).closest('form');    // Remove 버튼이 속한 폼 가져오기
                    
                    
                    removeForm.attr('method','post')
                    removeForm.attr('action', formAction);       // 폼의 action 속성을 변경
                    removeForm.submit();   						// 폼 submit
            	}
            });
            
            
                     
          //첨부파일이 있을때 첨부파일 표시하기
            // getJSON으로 보내기
             var frnoval = '${fvo.frno}';
             
             //여기 ul 밑에 li로 만들어져야 함. 그리고 이미지 태그 포함.
             var upLoadResult =	$('.upLoadResult ul');

            var liTag = '';
            (function(){
           	    $.getJSON('/free/attachList', {frno: frnoval}, function(result) {
           	        console.log(result);
           	        console.log(result.length);

           	        // 화면에 표시하기 for문 돌려서?
           	        $(result).each(function(i, obj) {
           	        	
           	            
           	        	liTag += '<li data-uuid="' + obj.uuid + '" data-upFolder="' + obj.upFolder + '" data-fileName="'
           	            			+ obj.fileName + '" data-image="' + obj.image + '">';
           	            			
                       	var uri = encodeURIComponent(obj.upFolder + '/s_' +obj.uuid +'_' + obj.fileName);    // 썸네일 주소 경로
           	   	        var downUri = encodeURIComponent(obj.upFolder +'/'+ obj.uuid +'_' + obj.fileName);   // 다운로드 주소 경로
           	   	        var originImg = obj.upFolder +'\\'+ obj.uuid +'_' + obj.fileName;	
               	           		
              	        originImg = originImg.replace(new RegExp(/\\/g), "/");			
           	            
           	            
              	       if(obj.image){
                  			 // 이미지는 썸네일과 파일명 표시  href를 이용해서 함수 호출하기
                  			liTag +=  '<img src="/freedisplay?fileName=' + uri + '"><br>' + obj.fileName 
	           				  + '<button style="padding-left: 3px; padding-right: 3px; background: lightblue; border:1px solid lightblue; padding-top:0px; padding-bottom:0px; margin-left:5px; "'
	           				  + 'type="button" class=" btn btn-warning btn-circle" data-file="' + uri + '"' + 'data-type="image"><i class="fa fa-times"></i></button></li>';
                  					     		  
                  			// 여기 src에서 /display?fileName으로 들어가는 서버에 저장된 썸네일 경로값 
                  			// span 태그 넣어서 x 표시
                  		 }else {

                  			  // 일반 파일은 attach.png 이미지와 파일명 표시 이미지 누르면 다운로드.
                  			  // // span 태그 넣어서 x 표시
                  			liTag +=  '<img src="../../resources/img/myicon/attach.png"><br>' + obj.fileName 
           					+'<button style="padding-left: 3px; padding-right: 3px; background: lightblue; border:1px solid lightblue; padding-top:0px; padding-bottom:0px; margin-left:5px; "' 
           					+'type="button" class=" btn btn-warning btn-circle" data-file="' + downUri + '"' + 'data-type="file"><i class="fa fa-times"></i></button></li>';
                  					
                  		 }     				      	                  	           

           	        });
           	        
           	        upLoadResult.append(liTag);
           	    });
           	})();
            // 첨부파일이 있을때 첨부파일 표시하기 END
            
            // 업로드 제한 확인 ---------------------------------
            
            var regEx = new RegExp("(.*?)\.(exe|sh|zip)$");
        	var maxSize = 5242880;     // 파일 업로드 크기는 5MB로 제한
        	
        	function checkExtension(fileName, fileSize){

        			//확장자 확인 및 알림 메시지 출력
        			if(regEx.test(fileName)){    // 정규표현식은 이렇게 패턴이 일치하나 일치하지 않나 테스트 할 수 있다.
        				alert('파일 확장자를 확인해주세요.');
        				return false;
        			}
        			
        			// 크기 확인 및 알림 메시지 출력
        			if(maxSize < fileSize){
        				alert(' 파일 업로드는 5MB이하만 가능');
        				return false;
        			}
        			
        			return true;
        	}	
        	
        	// 업로드 제한 확인 END--------------------------
        	
        	// 첨부파일 선택 이벤트 처리----------------------
        	// input type=file이 change 되면
        	$('input[type="file"]').on('change', function(){
        		console.log('버튼 눌림');
        		
        		var formData = new FormData();    // ajax는 폼태그 없이 formdata를 사용해서 -> 그럼 formtag를 사용한것처럼 사용가능
        		var files = $('input[name="uploadFile"]')[0].files;
        		
        		
        		// formData 객체에 파일 추가
        		for(var i = 0; i<files.length; i++){
        			if(!checkExtension(files[i].name, files[i].size)){
        				
        			// 업로드 제한 사항이 있으면 폼에 추가 x 중단
        				return false;
        			}
        			
        			formData.append('uploadFile', files[i]);
        		}
        		
        		 $.ajax({
        			type : 'post',											 // get or post 등등 method
        			url :  '/freeupload/ajaxAction',							 // 전송할 곳, json으로 받아야 나온다.
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
        								$('input[name="uploadFile"]').val('');	
        			},
        			error : function(xhr, status, er) {		// 등록 못했을때, 에러 시
        				
        						console.log('uplod error');
        				}
        		}); // END ajax()	 
        	});// click end
        	
        	
        	// 첨부파일 선택 이벤트 처리 end -----------------
        	
        	// 업로드 결과 출력---------------------------------------
	    var upLoadResult =	$('.upLoadResult ul');
	
		function showFile(result){
		
		var liTag = '';    // 변수 초기화  li태그 다 가져오기	
		
	    $(result).each(function(i,obj){						// foreach를 이렇게 쓴다. result를 가져와서 each 간단하게
			 /* liTag += '<li>' + obj.fileName + '</li>'
					 + '<li>' + obj.upFolder + '</li>'
	           		 + '<li>' +obj.uuid+ '</li>'
	           		 + '<li>' +obj.image + '</li><br>'; */
	           		 
	           		 // 서버로 전송할 정보 li태그 (여는 태그만 만든 후에 밑에 li붙이기)		           	
	           		 liOpenTag = '<li data-uuid="' + obj.uuid + '" data-upFolder="' + obj.upFolder + '" data-fileName="' + obj.fileName + '" data-image="' + obj.image + '">';
	           		 	
	           		 var uri = encodeURIComponent(obj.upFolder + '/s_' +obj.uuid +'_' + obj.fileName);    // 썸네일 주소 경로
	           		 var downUri = encodeURIComponent(obj.upFolder +'/'+ obj.uuid +'_' + obj.fileName);   // 다운로드 주소 경로
	           		 var originImg = obj.upFolder +'\\'+ obj.uuid +'_' + obj.fileName;					  // 이미지 원본 주소 경로
	           		
	           		 originImg = originImg.replace(new RegExp(/\\/g), "/");
	           		 
	           		 console.log(originImg);
	           		 
	           		 if(obj.image){
	           			 // 이미지는 썸네일과 파일명 표시  href를 이용해서 함수 호출하기
	           			liTag += liOpenTag + '<a href="javascript:showOriginal(\'' + originImg + '\')"><img src="/freedisplay?fileName=' + uri + '"></a><br>' + obj.fileName 
	           				  + '<button type="button" class=" btn btn-warning btn-circle" data-file="' + uri + '"' + 'data-type="image"><i class="fa fa-times"></i></button></li>';
	           			// 여기 src에서 /display?fileName으로 들어가는 서버에 저장된 썸네일 경로값 
	           			// span 태그 넣어서 x 표시
	           		 }else {
	   
	           			  // 일반 파일은 attach.png 이미지와 파일명 표시 이미지 누르면 다운로드.
	           			  // // span 태그 넣어서 x 표시
	           			liTag += liOpenTag + '<li><a href="/freedownload?fileName=' + downUri + '"><img src="../../resources/img/myicon/attach.png"></a><br>' + obj.fileName 
	           					+'<button type="button" class=" btn btn-warning btn-circle" data-file="' + downUri + '"' + 'data-type="file"><i class="fa fa-times"></i></button></li>';
	           		 }
	           		 
	           
		});  // each end
	
			upLoadResult.append(liTag);    //ul에 li 붙이기 먼저 for문돌려서 litag를 작성해놓고 그다음에 붙임.
			// append는 계속 추가해서 붙이는듯?
           }
                  
			 // 업로드 결과 출력 end---------------------------------------
        	 
        	 // 파일 삭제 (화면에서만 삭제하기)-------------------------------
        	 
        	 $('.upLoadResult').on('click','button',function(){
        		
        		 var x = $(this).closest('li');
        		 
        		if(confirm('첨부파일을 삭제하시겠습니까?')){
        			
        		// 여기서 버튼만 누르면 화면에서만 삭제되도록 해야함.
				// alert으로 첨부파일 삭제하는지 물어보고.
        			x.remove();
			
        			      			
        		}
        		
        		// 여기서 클릭이 되어진것이 button 태그 이므로 this를 사용할 수 있다.
        		 
        	 });
        	  	  
        	 // 파일 삭제(화면에서만 ) end----------------------------------
        	 
        	 
       	 // modify 버튼 처리 ----------------------------
        	 var frm = $('form[role="form"]');
        	 
       	$('.moBtn').on('click',function(e) {
        		e.preventDefault();	
       		
        	
       				// 성공하면
        				// li태그 찾기
                		var li = upLoadResult.find('li');				
                		
                		var hiddenTag ='';
                		
                						
                		// hidden태그로 만들어서 form에 붙인다.
                		// form에 들어갈 hidden태그를 for문 돌려서 attachList안에 있는 개수만큼? li 개수만큼?
                		 li.each(function(i,hidden){	
                			 
                			 var uuid = $(hidden).data('uuid');
                		        var fileName = $(hidden).data('filename');
                		        var upFolder = $(hidden).data('upfolder');
                		        var image = $(hidden).data('image');
                		               
                		        if (typeof uuid !== 'undefined' && typeof fileName !== 'undefined' && typeof upFolder !== 'undefined') {
                		            hiddenTag += '<input type="hidden" name="attachList[' + i +'].uuid" value="' + uuid + '">' 
                		                      + '<input type="hidden" name="attachList[' + i +'].fileName" value="' + fileName + '">' 
                		                      + '<input type="hidden" name="attachList[' + i +'].upFolder" value="' + upFolder + '">';
                		                      

                		            if (typeof image !== 'undefined') {
                		                hiddenTag += '<input type="hidden" name="attachList[' + i +'].image" value="' + image + '">';
                		            }
                		        }
                		});
                		
             	     	// console.log(hiddenTag);
                		// 히든태그를 폼에 붙인다.
                		frm.append(hiddenTag);	
                		
                		var titleval = $('#title').val();
                		var contentval = $('#content').val();
                		
                		if (titleval.length < 1) {
                			Swal.fire({
                				  icon: 'warning',  // 여기다가 아이콘 종류를 쓰면 됩니다.                     
                				  title: '제목을 입력해주세요.',    
                				  text: '', 
                				});
                				  return;
                				 }
                		
                		if (contentval.length < 1) {
                			Swal.fire({
                				  icon: 'warning',  // 여기다가 아이콘 종류를 쓰면 됩니다.                     
                				  title: '내용을 입력해주세요.',    
                				  text: '', 
                				});
                				  return;
                				 }
                				
                				
                		// 그리고 폼 제출
                		frm.submit();
        							   		
        	 
        	 
       	 }); // modify 버튼 처리 end-------------------------------
       	 
       	 // 뒤로가기 버튼
         
         $('.back').on('click',function(e){
       	  e.preventDefault();
       	  
       	  history.back();
       	  
       	  
         });
       
            </script>
  
            <%@ include file="../includes/footer.jsp" %>
