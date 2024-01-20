<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>free mylist</title>
<style>
.main{ margin: 20px;}
table th { text-align: center;}
table td {text-align: center; font-size: 13px;}
td a {font-weight: 600;}
.tableFrm { height: 396px; margin: 70px auto;}

</style>

<%@ include file="../includes/header.jsp" %>

<section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/m.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">List of My Posts</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">내가 작성한 게시글</h2>
              </div>
            </div>
          </div>
        </section>

		<div class="row main">
                <div class="col-lg-12">
                    <div class="panel panel-default">
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
                              <c:forEach items="${mylist }" var="mylist">
                              
                              	<%-- <c:url var="viewlink" value="view">
									<c:param name="frno" value="${list.frno }"/>
									<c:param name="amount" value="${pageDTO.cri.amount }"/>
									<c:param name="pageNum" value="${pageDTO.cri.pageNum }"/>			
								</c:url> --%>
								<c:set var="replyCnt" value="${mylist.replyCnt }" />
                                <tr>
                                	<td style =' vertical-align : middle '>${mylist.frno }</td>
                                	<td style =' vertical-align : middle '><a class="move" data-mid="${mylist.mid }" href="${mylist.frno }" >${mylist.title }${replyCnt != 0 ?[replyCnt] :'' }</a></td>
                                	<td style =' vertical-align : middle '>${mylist.mid }</td>
                                	<td style =' vertical-align : middle '>${mylist.hit }</td>
                                	<td style =' vertical-align : middle '><fmt:formatDate value="${mylist.regDate }"  type="date" pattern="yyyy-MM-dd (E)"/></td>
                                	<td style =' vertical-align : middle '><fmt:formatDate value="${mylist.updateDate }"  type="date" pattern="yyyy-MM-dd (E)"/></td>
                                </tr>
                                </c:forEach>
                                <!-- END Model 데이터출력 -->
                                
                                </tbody>
                            </table>     <!-- /.table-responsive -->   
                            
                             </div> 
                            <div class="pull-right">
								<button class="btn btn-g btn-round backBtn">뒤로가기</button>	
							</div>	
                        
                        
                                                  
                    
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
				 
				   <!-- 현재 페이지 번호 및 출력 게시물 수 전송 폼 -->
					<form action="/free/mylist" id="actionFrm" >
						<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageDTO.cri.amount }">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
						<input type="hidden" name="mid" value="<sec:authentication property='principal.mvo.mid'/>">				
					</form>			   
                       
	                                                            
                         </div> 		 <!-- /.panel-body -->     
                     </div> 			 <!-- /.panel -->
                 </div>  				 <!-- /.col-lg-6 -->
           


 <script>
             
           $(function(){ 
                  
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
      
             // 뒤로가기 버튼 눌렀을때                                   
            $('.backBtn').on('click',function(e){
            	e.preventDefault();
            	
            	location.href='/user/mypage';
            	            	
            });
    
           
           });//END $
             </script>
             
               <%@ include file="../includes/footer.jsp" %>
          