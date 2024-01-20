<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>자유게시판</title>
<style>
table th { text-align: center;}
table td {text-align: center; font-size: 13px;}
td a {font-weight: 600;}

#searchFrm { text-align: center; margin: 30px;}
.col-lg-12 select {height: 26.8px;}
.tableFrm {height: 561.2px;}
.table td { text-align: center; }

</style>

	<%@ include file="../includes/header.jsp" %>
      
      <section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/m.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                <h5 class="font-serif">Board List</h5><span class="holder-w"></span>
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
        
         <!-- 검색 타입 및 검색 키워드  -->
                            <!-- 타입, 제목T, 내용C, 작성자W, 제목/내용TC, 제목/작성자TW, 제목/내용/작성자TCW -->
                            <form action="/free/list" id="searchFrm">
                            <!-- list에서 보내는 값 생각하기 여기서서는 dto 안에 cri 안에 있다. -->
                            	<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
								<input type="hidden" name="amount" value="${pageDTO.cri.amount }">			
                            
                            <div class="row">
									<div class="col-lg-12"> 
										<select name="type" >
										<c:set var="type" value="${pageDTO.cri.type}" /> <!-- 변수 만들기 이렇게 변수를 쓰면 간단하게 사용가능 -->
											<option value="T" ${type eq 'T' ? 'selected' :'' }>제목</option>
											<option value="C" ${type eq 'C' ? 'selected' :'' }>본문</option>
											<option value="W" ${type eq 'W' ? 'selected' :'' }>작성자</option>
											<option value="TC" ${type eq 'TC' ? 'selected' :'' }>제목 or 내용</option>
											<option value="TW" ${type eq 'TW' ? 'selected' :'' }>제목 or 작성자</option>
											<option value="TCW" ${type eq 'TCW' ? 'selected' :'' }>제목 or 내용 or 작성자</option>
										</select>
										<input type="text" name="keyword" value="${!empty pageDTO.cri.keyword ? pageDTO.cri.keyword : '' }">
										<input type="submit" id="search" class="btn btn-info btn-sm" value="검색">	
										</div>
							</div>
                            </form>
                            <!-- end 검색 타입 및 검색 키워드  -->     
        
          
            <div class="row main">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            　<sec:authorize access="isAuthenticated()">
                            		<sec:authentication property="principal.mvo.auth.auth" var ="auth"/>              
 		 							<c:if test="${auth eq 'ROLE_ARTIST' || auth eq 'ROLE_ADMIN'|| auth eq 'ROLE_USER'}">
								 <button id="regBtn" type="button" class="btn btn-xs pull-right btn-info">
                            		<!-- onclick="location.href='register'" -->
                           			 Register new board</button>
                           			 </c:if>
                          	  </sec:authorize>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body tableFrm">
                          <!--   <table width="100%" 
                            class="table table-striped table-bordered table-hover" 
                            id="dataTables-example">--> 
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>No.</th>
                                        <th>제목</th>
                                        <th>작성자</th>
                                        <th>조회수</th>
                                        <th>작성일</th>
                                        <th>수정일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <!-- Model 데이터 출력 -->
                              <c:forEach items="${list }" var="list">
                              
                              	<%-- <c:url var="viewlink" value="view">
									<c:param name="frno" value="${list.frno }"/>
									<c:param name="amount" value="${pageDTO.cri.amount }"/>
									<c:param name="pageNum" value="${pageDTO.cri.pageNum }"/>			
								</c:url> --%>
								<c:set var="replyCnt" value="${list.replyCnt }" />
                                <tr>
                                	<td style =' vertical-align : middle '>${list.frno }</td>
                                	<td style =' vertical-align : middle '><a class="move" data-mid="${list.mid }" href="${list.frno }" >${list.title }${replyCnt != 0 ?[replyCnt] :'' }</a></td>
                                	<td style =' vertical-align : middle '>${list.mid }</td>
                                	<td style =' vertical-align : middle '>${list.hit }</td>
                                	<td style =' vertical-align : middle '><fmt:formatDate value="${list.regDate }"  type="date" pattern="yyyy-MM-dd (E)"/></td>
                                	<td style =' vertical-align : middle '><fmt:formatDate value="${list.updateDate }"  type="date" pattern="yyyy-MM-dd (E)"/></td>
                                </tr>
                                </c:forEach>
                                <!-- END Model 데이터출력 -->
                                
                                </tbody>
                            </table>     <!-- /.table-responsive -->   
                            
                                                  
                            
                       <div class="text-center">     
                            <%-- 페이징 --%>
					<ul class="pagination">
					
						<%-- 이전 버튼 --%>
						
						<c:if test="${pageDTO.prev }">
						<li class="page-item">
							<a href="${pageDTO.start - 1 }" 
							   class="page-link">&laquo; Previous</a></c:if>
						
						<%--페이지 번호 버튼 --%>
						
						<c:forEach begin="${pageDTO.start }" end="${pageDTO.end }" var="i">
						
						<li class="page-item ${pageDTO.cri.pageNum == i ? 'active' : '' }">
							<a href="${i }"  onclick="return false;" class="page-link">${i }</a>
						</c:forEach>
						
						<%-- 다음 버튼 --%>
						
						<c:if test="${pageDTO.next }">
						<li class="page-item">
							<a href="${pageDTO.end + 1 }" 
							   class="page-link">Next &raquo;</a></c:if>
					</ul>	<!-- 여기 이전, 다음으로 보낼때 hidden으로 pageNum과 amount를 보내니까 여기는 이렇게만 처리! -->	
				   </div>  <!-- end paging -->
				   </div>
				   
				   <!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
					<form action="/free/list" id="actionFrm" >
						<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageDTO.cri.amount }">
						<input type="hidden" name="type" value="${pageDTO.cri.type }">
						<input type="hidden" name="keyword" value="${pageDTO.cri.keyword }">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">

					</form>			   
                       
	                                                            
                         </div> 		 <!-- /.panel-body -->     
                     </div> 			 <!-- /.panel -->
                 </div>  				 <!-- /.col-lg-6 -->
                 				
                      
           <script>
             
           $(function(){ 
             // 검색 버튼 이벤트 처리
             var searchFrm = $('#searchFrm');
             var keyword = searchFrm.find("input[name='keyword']");
             
            
            	    $('#search').on('click', function(e) {
            	        e.preventDefault();    // onclick 말고 이렇게도 가능함.
            	    	if(keyword.val() == ''){
            	    		Swal.fire(
                    		        '검색어를 입력하세요.',
                    		        '',
                    		        'warning'
            	        		      )	
            	    	//	return false;   else 안쓰고 할때 ? default 안쓰고 
            	    	}else{
            	     	// 검색 시 페이지 번호를 1이 되도록 설정
            	        searchFrm.find("input[name='pageNum']").val('1');
            	        searchFrm.submit();
            	    	}
            	       
            	    });           
              // end 검색 버튼 이벤트 처리
            
              
            
             // a 태그가 클릭되면 class page - item이 클릭이 되면 actionform으로 전송 submit
             // 페이징 이벤트 처리
             
             // 일단 a태그니까 원래 하던 동작은 안하도록 해놓고 그건 위에서 onclick return false
             
             var actionFrm = $('#actionFrm');
             
          
            	    $('.page-item a').on('click', function(e) {
            	        e.preventDefault();    // onclick 말고 이렇게도 가능함.
            	        console.log($(this).attr('href'));

            	        // a 태그의 href 값을 pageNum에 저장
            	        actionFrm.find("input[name='pageNum']").val($(this).attr('href'));
            	        actionFrm.submit();
            	    });  
         
            		 // 게시물 제목 클릭 이벤트 처리 
            	       
            	    $('.move').on('click', function(e) {
            	        e.preventDefault();    // onclick 말고 이렇게도 가능함.
            	        console.log($(this).attr('href'));
            	        var mid = $(this).data('mid');
            	        console.log(mid);

            	        // a 태그의 href 값을 frno에 저장
            	        actionFrm.append("<input type='hidden' name='frno' value='"+ $(this).attr('href') + "'>");
            	        actionFrm.append("<input type='hidden' name='mid' value='"+ mid + "'>");
            	    	
            	        actionFrm.attr('action', '/free/view');
            	        
            	        actionFrm.submit();
            	    }); 
            
            	   // end 게시물 제목 클릭 이벤트 처리
      
                                                
             // 게시물 처리 결과 알림 처리
             
             var result = '${result }';
             
        	 userOut(result);
        	 
        	history.replaceState({},null,null); // history 초기화
        	
        	function userOut(result){
          	  // result 값이 있는경우에 알림창 표시
          	  
          	  if(result === '' || history.state) {
          		  return; 
          		  }
	
          	  if(result == 'register success') {    // 게시물 등록 성공시
          		Swal.fire(
        		        '게시물이 등록되었습니다.',
        		        '',
        		        'success'
	        		      )			
          	}  
          	  
          	if(result == 'remove success') {      // 게시물 삭제 성공시
          		Swal.fire(
        		        '게시물이 삭제되었습니다.',
        		        '',
        		        'success'
	        		      )			
          	} 
          	
          	if(result == 'modify success') {    // 게시물 수정 성공시
          		Swal.fire(
        		        '게시물이 수정되었습니다.',
        		        '',
        		        'success'
	        		      )			
          	}  
          	  
          	  
          	  
        	}
              //  알림창 처리하기
    
              // 게시물 처리 버튼 클릭 이벤트처리 (로그인했을때)
           
                 $('#regBtn').on('click', function() {
                    
                     self.location = "/free/register";
   
                 }); // click end
     
             // END 게시물 등록 버튼클릭 이벤트 처리
           });//END $
             </script>
             
               <%@ include file="../includes/footer.jsp" %>
          
            
