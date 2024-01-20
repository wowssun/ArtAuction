<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../includes/header.jsp" %>

<style>
.view {margin: 80px;}
.chat li { list-style: none;}
.upLoadResult li {list-style: none;}

</style>
      
            <section class="module bg-dark-30 parallax-bg restaurant-menu-bg" style="background-image: url(&quot;/resources/img/title/m.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">Board View</h5><span class="holder-w"></span>
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
        
         
             <section class="module-small">
		          <div class="container">
		            <div class="row">
		              <div class="col-lg-12">
		                <div class="post"> 
		                <div class="post-meta">No. ${fvo.frno } </div>
		                  <div class="post-header font-alt">
		                    <h1 class="post-title">${fvo.title }</h1>
		                    <div class="post-meta">By&nbsp;<a href="#">${fvo.mid }</a> | <fmt:formatDate value="${fvo.regDate }"  type="date" pattern="yyyy.MM.dd (E)"/> | <a href="#">조회수 </a><a href="#">${fvo.hit }</a>
		                    </div>
		                  </div>
		                  <div class="post-entry" style="font-size: 17px;">
		                  ${fvo.content }
		                  </div>
		                </div>
		                
		                <div class="text-right ">
              			  <div class="col-lg-12">
									<!-- 여기 버튼 처리   -->
								<!--페이지 번호와 페이지에 표시할 게시물의 수 -->
								<!-- 여기서는 컨트롤러에서 cri만 보냈기 때문에 list처럼 dto에서 꺼내지 않는다.  -->	
								<form action="/free/modify">	
								
										<input type="hidden" name="pageNum" value="${cri.pageNum }">
										<input type="hidden" name="amount" value="${cri.amount }">
										<input type="hidden" name="type" value="${cri.type }">
										<input type="hidden" name="keyword" value="${cri.keyword }">
										<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
										
									<input type="hidden" name="frno" value="${fvo.frno }">
									 <sec:authorize access="isAuthenticated()"> 
									
									<sec:authentication property="principal" var="prin" /> <!-- c태그 사용안하고 이렇게 바로 변수만들기 가능  -->
									<sec:authentication property="principal.mvo.auth.auth" var ="auth"/>              
									<c:if test="${fvo.mid eq prin.username || auth eq 'ROLE_ADMIN' }"> 					
										<button data-oper="modify" class="btn btn-warning" >	
											Modify</button> 		
									 </c:if>
									 </sec:authorize>	 
									<button data-oper="list"  class="btn btn-primary back" 
									formaction="/free/list">
										List</button>
								</form>		
								<!-- </form> -->    
                 </div>  				 <!-- /.col-lg-6 -->
             </div>       				 <!-- /.row -->
		                
		                
		                <div class="comments">
		                  <h4 class="comment-title font-alt">File</h4>
				                  	  <!-- 첨부파일 확인 폼  -->
				             <div class="row view">
				                <div class="col-lg-12">
				                    <div class="panel panel-default">
				           					
				                          <div class="panel-body">
				                          <!--업로드 결과 출력  -->
											<div class="upLoadResult">
												<ul></ul>
												</div><!-- 그 안쪽에는 사진이 표시  -->
												
					                          <!-- 썸네일 원본 이미지 표시  -->
											<div class="originImgDiv view"> <!-- 배경을 100%로 배경색 채워지고 회색  -->
												<div class="originImg">
												</div>			
											 </div>	
											 
				                          </div>		               
				 					 </div>	
				            	 </div>
				            </div>  <!-- 첨부 파일 end -->
		                  
		                </div>
		               
		                <div class="comment-form">
		                  <h4 class="comment-form-title font-alt">Reply</h4>
		                  
		                  <sec:authorize access="isAuthenticated()"> 
		                          <sec:authentication property="principal.mvo.auth.auth" var ="auth"/>              
										<c:if test="${auth eq 'ROLE_ARTIST' || auth eq 'ROLE_ADMIN'|| auth eq 'ROLE_USER'}">
		                          		<button id="newBtn" class="btn btn-primary btn-xs pull-right">new reply </button> 
		                          </c:if>
		                    </sec:authorize>	
		                  
		                  
		                  	  <!-- 댓글 폼 -->
		           <div class="row view">
		                <div class="col-lg-12">
		                    <div class="panel panel-default">
		           			              
		   						  <div class="panel-body"> 
		       			 				<ul class="chat">
				          			 		<!--------- reply START ----------->
				          			 		<li class="left clearfix" data-rno="12">
				          			 			<div>
				          			 				<div class="header">
				          			 					<strong class="primary-font">user00</strong>
				          			 					<small class="pull-right text-muted">2023-08-24-16:26</small>
				         			 					</div>
				          			 					<p>Good job!</p>	 		
				 							   	 </div>
				          			 		 </li>	
				          			 		<!------- reply END -------->
				          			 	</ul>
				           			</div>
				           			
				           			
				           			<div class="pannel-footer"> <!-- 댓글 목록 페이징------------->
				           			<ul class="pagination pull-right">
				      						<!-- 여기 안에 들어갈 내용은 동적으로 스크립트에서  -->
				         			</ul>	
				           			</div> <!-- 댓글 목록 페이징 END --------->
			           			
			           			</div>
			           		</div>
			          </div>
		                 
		                </div>
		              </div>
		                             
		              </div>
		            </div>
      
        </section>
             
           
   
        
           
           
            <!-- Modal 댓글 등록 버튼 클릭 -->
                 <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				    <div class="modal-dialog">
				        <div class="modal-content">
				            <div class="modal-header">
				                <button type="button" class="close" 
				                		data-dismiss="modal" aria-hidden="true">&times;</button>
				                <h4 class="modal-title" id="myModalLabel">
				                  REPLY</h4>
				            </div>
				            <div class="modal-body">
				                <div class="form-group">
				                	<label>댓글</label>
				                	<input type="text" name="reply" id="reply" class="form-control">
				                </div>
				                <div class="form-group">
				                	<label>작성자</label>
				                	<input type="text" name="mid" id="mid" class="form-control" readonly>
				                </div>
				                <div class="form-group">
				                	<label>작성일자</label>
				                	<input type="text" name="regDate" id="regDate" class="form-control" readonly>
				                </div>
				            </div>
				            <div class="modal-footer">
				                <button id="remBtn" type="button" class="btn btn-danger">Remove</button>
				                <button id="modBtn" type="button" class="btn btn-warning">Modify</button>
				                <button id="addBtn" type="button" class="btn btn-primary">Add</button>
				                <button id="closeBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				            </div>
				        </div>  <!-- /.modal-content -->
				    </div>		<!-- /.modal-dialog -->
				</div>          <!-- /.modal -->
           <!-- Modal 댓글 등록 버튼 클릭 end -->
           
           <script src="/resources/js/reply.js"></script>
           <script>
           
            var frnoval = '${fvo.frno}';
      	    var replyUL= $('.chat');    // ul태그 찾아오기
      		
      	 	makeList(1);   // 댓글목록 출력
      	 	
      	// class가 chat인걸 찾아서 ul 태그 밑에다가 for문 돌려서 붙이면 된다.
         	// result[i].rno,  result[i].reply, result[i].regDate . result[i].replyer
         //댓글 목록 출력 ----------------------------------
   		function makeList(pageNum){
   			replyService.list(
   				{ frno : frnoval, pageNum : pageNum },
   				function(result, replyCnt){   // 그럼 여기 result에서는 list가 되는거고, replyCnt에서는 댓글 개수
   					// 댓글을 추가한 경우 마지막 페이지를 계산해서 이동
   					console.log(result);
   				 	if(pageNum == -1){		
   						pageNum = Math.ceil(replyCnt / 3.0 );  //  마지막 페이지로 가기
   						makeList(pageNum);
   						return;
   						
   					} 
   								
   					//댓글이 없는 경우 ul 비우기
   					if(result == null || result.length == 0) {
   						replyUL.html('');
   						return;    // return
   					}
   					
   					//댓글 목록 li 작성
   					var liTag = '';    // 변수 초기화  li태그 다 가져오기
   					//var regDate = display(result[i].regDate);    
   					
   			               for (var i = 0; i < result.length; i++) {    //for문 돌려서 li태그
   			            	 //  console.log(result[i].reply)  확인용
   			                   liTag += '<li class="left clearfix" data-rpno=' + result[i].rpno + '><div>' 
   			                    	 + '<div class="header">' 
   			                         + '<strong class="primary-font">' + result[i].mid + '</strong>'  
   			                         + '<small class="pull-right text-muted">' + replyService.display(result[i].regDate) + '</small></div>' 
   			                         + '<p>' + result[i].reply + '</p>'
   			                         + '</div> </li>';
   			                      
   			               }
   					replyUL.html(liTag);//ul에 li 붙이기 먼저 for문돌려서 litag를 작성해놓고 그다음에 붙임.
   					makePageNum(replyCnt,pageNum);
   				
   			});
   		}//END 댓글 목록 출력 -----------------------------
           
   	// 댓글 목록 페이지 번호 출력---------------------------
		var pageNum = 1;
		var pageUL = $('.pagination');
			
		function makePageNum(replyCnt, pageNum){
			
			// 자바스크립트라서 형변환은 따로 X
			var numPerPage = 5.0;   // 한 페이지에 표시할 페이지 번호 수
			var amountPage = 3.0;   // 한 페이지에 표시할 댓글 수 3개
			var pages = Math.ceil(replyCnt / amountPage); // 전체 페이지 번호 수
			var end = Math.ceil(pageNum / numPerPage) * numPerPage ;// 끝 페이지 번호 내가 현재 있는 곳에서의 마지막 번호 
			var start = end - (numPerPage - 1);// 시작 페이지 번호
			 	end = end > pages ? pages : end;
			var	prev = start > 1;    // 이전 버튼
			var	next = end < pages;  // 다음 버튼
				
			// pageDTO에서 만들었던 값이랑 
		 	// 페이징 태그를 여기로 다 가져오고
		 	// 그 안에 변수값 바꿔주기
		 	 	
		// 페이징 li 작성 및 ul에 추가--------------
		var liTag = ''; 
			// start privious에서 꺼내기
			
			// 이전 버튼 만들기
			if(prev){
				liTag += "<li class='page-item'>"
					  + "<a href='" + (start - 1) + "' class='page-link'> &laquo; Previous</a></li>";		  
			}

			 // 페이지 번호 만들기
			for(var i=start ; i <= end ; i++){
				liTag += '<li class="page-item ' + (pageNum == i ? "active" : "") + '">' + 
							'<a href="' + i + '" class="page-link">' + i + '</a></li>'; 
			}
				 
			// 다음 버튼 만들기
			if(next){
				liTag += "<li class='page-item'>"
					  +	"<a href='" + ( end + 1 ) + "' class='page-link'>Next &raquo; </a></li>";
  
			}	
			
			pageUL.html(liTag); // ul에 추가하기
		}
		 	// 페이지 번호 클릭 이벤트 처리 --------------------
		 	//a태그 링크 눌렸을때 한 일
		 	// 페이지 번호를 누르면 페이지 번호를 넣어서 makeList()에 넣어서 다시 출력한다.
			// pageUL 클릭하면 li 태그의 a 태그 찾고  pageNum을 저장하고 makePageNum
			
			pageUL.on('click', 'li a', function(e){
				e.preventDefault();
				pageNum = $(this).attr('href');
				makeList(pageNum);
				 		
			});    // 페이지 번호 클릭 이벤트 처리 END----------------
			
		// 댓글 목록 페이지 번호 출력 END---------------------------   
        
		 // 댓글작성 모달창 이벤트 처리--------------------------- 
           var modal = $('#myModal'); 
          
           	var remBtn = $('#remBtn');   		// 삭제버튼
           	var modBtn = $('#modBtn');			// 수정버튼
           	var addBtn = $('#addBtn');			// 등록버튼
            var closeBtn = $('#closeBtn');  	// 닫기버튼
                  
            var replyTxt = $('#reply');			// 댓글내용
            var replyerTxt = $('#mid');		   // 댓글작성자
            var regDateTxt = $('#regDate');		// 댓글작성일
            
          
			//에러난 이유를 알았다. 로그인 안한 상태에서는 new Btn이 안보여서 오류난듯. 이 부분 수정해주기.
		
			var replyer = '';
            
			<sec:authorize access="isAuthenticated()">
				replyer = '<sec:authentication property="principal.username"/>';
			
			    $('#newBtn').on('click', function() {
			    	modal.find('#mid').val(replyer);    // 여기 댓글 내용에도 아이디 들어감 ㅎ
			    //	replyerTxt.val("<sec:authentication property='principal.username'/>");
			    	// $('#replyer').val('하이');	
			    	
    				regDateTxt.closest('div').hide();
			    	modal.find("button[id != 'closeBtn']").hide();
				    	addBtn.show();
				    	
				    	modal.modal('show');
				    });
			    </sec:authorize>
              
           // 댓글작성 모달창 이벤트 END--------------------------------
		
           
            // beforeSend 대신 CSFR 토큰 헤더 추가-----------------
           var csrfHeaderName = '${_csrf.headerName }';   // CSRF 토큰 관련 변수
		   var csrfTokenValue = '${_csrf.token }';		  // 토큰
		   $(document).ajaxSend(function(e,xhr, options){
			   xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		   });
           
		   // beforeSend 대신 CSFR 토큰 헤더 추가 END -----------------------------
    		
    		
           // addBtn 버튼 클릭 이벤트 처리-------------------------
           	addBtn.on('click', function() {
          		 replyService.add(
		    		{ frno : frnoval, reply : replyTxt.val(), mid: replyerTxt.val() }, // 여기 따옴표 안적어도 됨 컬럼 이름에
				function(result) {
		    			
		    			Swal.fire(
		        		        '댓글이 등록되었습니다.',
		        		        '',
		        		        'success'
			        		      )
			       
			        modal.modal('hide');
			       // location.reload(); 새로고침 하지 말고 댓글 목록을 다시 불러오기
			       makeList(-1);   // 댓글 등록일때는 마지막 페이지로 감. 그래서 일단 -1값 보내기
			    });
           
           }); 
           // addBtn 버튼 클릭 이벤트 처리 END 
           
             // 댓글 클릭이벤트 댓글 상세조회창
	           	replyUL.on('click', 'li', function() {    // ul 태그의 li를 찾고
	           		var rpno = $(this).data('rpno'); 	// 그 li data에 있는 rpno
	           		// 댓글 누르면 원래 있던 값 가져오기.
	           		replyService.view(
	           				rpno,		   // li 안에 data-rno = result 이 값을  여기 가져와야함
	        		function(result) {
	           			console.log(result)// 성공
	           			console.log(result.reply);
	           			console.log(result.mid);
	           			console.log(result.regDate);
	           			replyTxt.val(result.reply);
	           			replyerTxt.val(result.mid);
	           			regDateTxt.val(replyService.display(result.regDate));
	        			
	        			regDateTxt.closest('div').show();
	        			modal.find("button[id != 'closeBtn']").hide();
	        			
	        			// 댓글 작성자가 로그인한 아이디와 같을때만 수정,삭제 가능
	        			// 여기서 관리자도 가능해야 하는데 !!!
	        			<sec:authorize access="isAuthenticated()"> 
	        			var auth = '<sec:authentication property="principal.mvo.auth.auth"/>';    

	        			// 정규 표현식을 사용하여 &#95;를 _로 치환
	        			var realauth = auth.replace(/&#95;/g, "_");

	        			// 결과 출력
	        			console.log(realauth); // "ROLE_ADMIN"
                          console.log(auth);
	        			if(replyer == result.mid || realauth == 'ROLE_ADMIN'){
	        				modBtn.show();
	        				remBtn.show();
	        			}	
	        			 </sec:authorize>
	    				modal.data('rpno',rpno);
				    	modal.modal('show');
	         		
	         			    });
					    });           
	           // 댓글 클릭이벤트 댓글 상세조회창 END 
	           
	           
				 // modBtn 버튼 클릭 이벤트 처리-------------
				 
		           modBtn.on('click', function() {
		        	   replyService.modify(
		        				{rpno: modal.data('rpno'), reply: replyTxt.val() },  // rno 처리 여기 다시 하기 모달창에 있는 rno
		       			function(result) {
		        					Swal.fire(
		    		        		        '댓글이 수정되었습니다.',
		    		        		        '',
		    		        		        'success'
		    			        		      )
		       			   	 modal.modal('hide');
		       			       
		       			  makeList(pageNum);   // 여긴 페이지넘 바꿔야할듯  수정하고 나면 다시 그 페이지로 pageNum 바꾸기
		       			    });
		           
		           });             
		           // modBtn 버튼 클릭 이벤트 처리 end -------------
		           
		      
		           // remBtn 버튼 클릭 이벤트 처리-------------
		           
		 			 remBtn.on('click', function() {
		        	   replyService.remove(
		        			   modal.data('rpno'),   // 댓글 번호만 넘어감 , 파라미터로 그래서 그냥 숫자만
		       				
		      			function(result) {
		        				   Swal.fire(
		    		        		        '댓글이 삭제되었습니다.',
		    		        		        '',
		    		        		        'success'
		    			        		      )
		      					 modal.modal('hide');
		          			  makeList(pageNum);   // 여긴 페이지넘 바꿔야할듯  pageNum 바꾸기 삭제하고 다시 그 페이지로
		      			    });
		           
		           }); 
		           // remBtn 버튼 클릭 이벤트 처리 end -------------
		
				// closeBtn 누르면 모달창 닫기-----------------------
	           		closeBtn.on('click', function() {
				        $('#myModal').modal('hide');
				    });	
          		 // closeBtn 누르면 모달창 닫기 END-----------------
	           
	           
    		// ----------------------첨부파일 목록 가져오기 ----           
           // 첨부파일이 있을때 첨부파일 표시하기
           // getJSON으로 보내기
            (function(){
        	    $.getJSON('/free/attachList', {frno: frnoval}, function(result) {
        	        console.log(result);
        	        
        	        showFile(result);
        	    });//END getJSON()
            })();//END 첨부 파일 목록 가져오기 ------------------- 즉시실행함수
           
           
          // 업로드 결과 출력 ------------------------------
          
            //여기 ul 밑에 li로 만들어져야 함. 그리고 이미지 태그 포함.
            var upLoadResult =	$('.upLoadResult ul');
            
            function showFile(result){
        		
        		var liTag = '';    // 변수 초기화  li태그 다 가져오기
        		
       	    $(result).each(function(i,obj){						// foreach를 이렇게 쓴다. result를 가져와서 each 간단하게

       			//서버로 전송할 정보를 li 태그의 속성으로 저장
       			liTag += '<li data-uuid="' + obj.uuid + '" ' + 
       						' data-upfolder="' + obj.upFolder + '" ' + 
       						' data-filename="' + obj.fileName + '" ' + 
       						' data-image="' + obj.image + '">';
        	           		 	
        	           		 var uri = encodeURIComponent(obj.upFolder + '/s_' +obj.uuid +'_' + obj.fileName);    // 썸네일 주소 경로
        	           		 var downUri = encodeURIComponent(obj.upFolder +'/'+ obj.uuid +'_' + obj.fileName);   // 다운로드 주소 경로
        	           		 var originImg = obj.upFolder +'\\'+ obj.uuid +'_' + obj.fileName;					  // 이미지 원본 주소 경로
        	           		
        	           		 originImg = originImg.replace(new RegExp(/\\/g), "/");
        	           		 
        	           		 console.log(originImg);
        	           		 
        	           		 if(obj.image){
        	           			 // 이미지는 썸네일과 파일명 표시  href를 이용해서 함수 호출하기
        	           			liTag += '<img src="/freedisplay?fileName=' + uri + '"><br>' + obj.fileName + '</li>';	
    					 							 
        	           			// 여기 src에서 /display?fileName으로 들어가는 서버에 저장된 썸네일 경로값 
        	           		
        	           		 }else {
        	   
        	           			  // 일반 파일은 attach.png 이미지와 파일명 표시 이미지 누르면 다운로드.
        	           	
        	           			liTag += '<img src="../../resources/img/myicon/attach.png"><br>' + obj.fileName + '</li>';
        	           					
        	           		 }
        	           		 
        	           
        		});  // each end
        	
        			upLoadResult.append(liTag);    //ul에 li 붙이기 먼저 for문돌려서 litag를 작성해놓고 그다음에 붙임.
        			// append는 계속 추가해서 붙이는듯?
                   }

           // 첨부파일이 있을때 첨부파일 표시하기 END--------------------
           
       
		   //첨부파일 클릭 이벤트 처리 ----------------------------------------
			$('.upLoadResult').on('click', 'li', function(e){
				var li = $(this);
				var filePath = encodeURIComponent(li.data('upfolder') + "/" + 
												  li.data('uuid') + "_" + 
												  li.data('filename'));
				
				if(li.data('image')) {
					filePath = filePath.replace(new RegExp(/\\/g), "/"); 
					
					$('.originImgDiv').css('display', 'flex').show();
					$('.originImg').html('<img src="/freedisplay?fileName=' + filePath + '">')
								   .animate({width:'100%', height:'100%'}, 1000);
				} else { 
					self.location = "/freedownload?fileName=" + filePath;
				}
			});
		//END 첨부파일 클릭 이벤트 처리 ----------------------------------------
           
          //썸네일 원본 이미지 클릭 이벤트 처리 -------------------------------------
			$('.originImgDiv').on('click', function(){
				$('.originImg').animate({width:'0%', height:'0%'}, 1000);
				setTimeout(() => { $(this).hide(); }, 1000);
			});
          //END 썸네일 원본 이미지 클릭 이벤트 처리 ------------------------------   
          
          
          // 뒤로가기 버튼
          
          $('.back').on('click',function(e){
        	  e.preventDefault();
        	  
        	  history.back();
        	  
        	  
          });
           
           </script>
          <%@ include file="../includes/footer.jsp" %>