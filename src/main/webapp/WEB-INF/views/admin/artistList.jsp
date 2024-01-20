<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<title>작가 회원 목록</title>
<style>
body {
  color: #666; }

table {
  border-collapse: separate;
  border-spacing: 0;
  margin: -50px auto; /* 가운데 정렬을 위한 스타일 */
  width: 70%; /* 원하는 크기로 조절 (예: 70%) */
  
}
tr th { text-align: center;  padding: 5px 0;}
tr td { padding: 4px 0px; }

th,
td {
  padding: 6px 15px;
  text-align: center;
}
th {
  background: #42444e;
  color: #fff;
  text-align: center;
}
tr:first-child th:first-child {
  border-top-left-radius: 6px;
}
tr:first-child th:last-child {
  border-top-right-radius: 6px;
}
td {
  border-right: 1px solid #c6c9cc;
  border-bottom: 1px solid #c6c9cc;
  
}
td:first-child {
  border-left: 1px solid #c6c9cc;
}
tr:nth-child(even) td {
  background: #eaeaed;
}
tr:last-child td:first-child {
  border-bottom-left-radius: 6px;
}
tr:last-child td:last-child {
  border-bottom-right-radius: 6px;
}

tr:hover {background: lightyellow;}
tr:nth-child(even):hover td {
  background: lightyellow;
}
#search { background-color: rgb(213, 245, 227); border: 1px solid rgb(213, 245, 227); 
			color:rgb(11, 83, 69);}
			
#searchFrm { text-align: center; margin-top: 40px;  }

.col-lg-12 select {height: 26.8px;}


td a { text-decoration : none; color: black; } 


#tableSec { height: 396px; margin: 70px auto; }   

button { border: 1px solid rgb(213, 245, 227); background-color: rgb(213, 245, 227); text-decoration: none;
			color:rgb(11, 83, 69); margin: 10px 20px;}
			
/* #backBtn { position: relative; left :1300px ; top: 80px;} */

#backBtn
 {  
border: 1px solid rgb(213, 245, 227); background-color: rgb(213, 245, 227);
color:rgb(11, 83, 69); margin: 10px 20px; }
 	

.badge-wrap .badge { color: black; text-align: right; background: rgb(234, 237, 237); }



.genReque{background: rgb(44, 62, 80); color: white; border-radius: 10px;}
.artReque{background: rgb(44, 62, 80); color: white; border-radius: 10px;}


</style>


	<%@ include file="../includes/header.jsp" %>
	
	<section class="module bg-dark-30 parallax-bg restaurant-menu-bg"  style="background-image: url(&quot;/resources/img/title/o.jpg&quot;);">
          <div class="container">
            <div class="row">
              <div class="col-sm-2 col-sm-offset-5">
                <div class="alt-module-subtitle"><span class="holder-w"></span>
                  <h5 class="font-serif">Try our confectionery</h5><span class="holder-w"></span>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h2 class="module-title font-alt mb-0">작가 회원 목록</h2>
              </div>
            </div>
          </div>
        </section>
        
       
        <!-- 검색 타입 및 검색 키워드  -->
           <!-- 타입, 아이디 M, 이름 N -->
           <form action="/admin/artistList" id="searchFrm">
           <!-- list에서 보내는 값 생각하기 여기서서는 dto 안에 cri 안에 있다. -->
           	<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
			<input type="hidden" name="amount" value="${pageDTO.cri.amount }">			
                   
            <div class="row">
				<div class="col-lg-12"> 
					<select name="type" >
						<c:set var="type" value="${pageDTO.cri.type}" /> <!-- 변수 만들기 이렇게 변수를 쓰면 간단하게 사용가능 -->
						<option value="M" ${type eq 'M' ? 'selected' :'' }>아이디</option>
						<option value="N" ${type eq 'N' ? 'selected' :'' }>이름</option>
					</select>
				<input type="text" name="keyword" value="${!empty pageDTO.cri.keyword ? pageDTO.cri.keyword : '' }">
				<input type="submit" id="search" class="btn btn-sm searchBtn" value="검색">	
				</div>
				
			</div> <!-- end 검색 타입 및 검색 키워드  --> 
            </form>
           
            <div class="row" style="margin-right: 250px"> 
            <div class="col-5 text-right badge-wrap" > 
				<div class="badge">
					총 회원 수 :  ${count }명</div></div>
                  
                  
                  </div>
                 
    
    
      <section id="tableSec">
			<table>
			  <thead>
			    <tr>
			      <th>No.</th>
			      <th>아이디</th>
			      <th>이름</th>
			      <th>가입일자</th>
			      <th>회원정보</th>
			      <th>작가정보</th>
			    </tr>
			  </thead>
			  <tbody>
			   <c:forEach items="${list }" var="mvo" varStatus="loop">
			    <tr> 
			      <td>${loop.count }</td>
		     	  <td>${mvo.mid } </td>		   
			       <td>${mvo.name }</td>
			      <td><fmt:formatDate value="${mvo.joinDate }"  type="date" pattern="yyyy.MM.dd (E)"/></td>
			      <td><button class="genReque" data-mid="${mvo.mid}">조회</button></td>
			      <td><button class="artReque" data-mid="${mvo.mid}">조회</button></td>
			    </tr>
			    </c:forEach>
			  </tbody>
			</table>
		</section>
			
			<div class="row" style="margin-right: 250px" >
				<div class="col-5 text-right">
			    	<button id="backBtn" type="button" onclick="location.href='/admin/adminPage';"> 뒤로가기 </button>
		   		</div>
		   </div>
 			
 	  
 			<div class="text-center">  
 	    		 <%-- 페이징 --%>
					<ul class="pagination ">
					
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
					<form action="/admin/artistList" id="actionFrm" >
						<input type="hidden" name="pageNum" value="${pageDTO.cri.pageNum }">
						<input type="hidden" name="amount" value="${pageDTO.cri.amount }">
						<input type="hidden" name="type" value="${pageDTO.cri.type }">
						<input type="hidden" name="keyword" value="${pageDTO.cri.keyword }">
						<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
					</form>		

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

	 var actionFrm = $('#actionFrm');
	 var midval = $("input[name='mid']").attr('value');
 
 // 페이징 이벤트 처리-----------------
 
 $('.page-item a').on('click', function(e) {
       e.preventDefault();    // onclick 말고 이렇게도 가능함.
       console.log($(this).attr('href'));

       // a 태그의 href 값을 pageNum에 저장
       actionFrm.find("input[name='pageNum']").val($(this).attr('href'));
       actionFrm.submit();
   });  
//  END 페이징 이벤트 처리-------------------

// 일반조회버튼 클릭 이벤트 처리--------------

$('.genReque').on('click', function(e) {   // onclick 말고 이렇게도 가능함.
    e.preventDefault();     // 기본 a태그 막기
    var mid = $(this).data('mid');
    console.log(mid); 

    actionFrm.append("<input type='hidden' name='mid' value='"+ mid + "'>");
	
    actionFrm.attr('action', '/user/myinfo');
    
    actionFrm.submit();
}); 


// 일반조회버튼 클릭 이벤트 처리 end---------------

// 작가조회버튼 클릭 이벤트 처리--------------

$('.artReque').on('click', function(e) {   // onclick 말고 이렇게도 가능함.
    e.preventDefault();     // 기본 a태그 막기
    var mid = $(this).data('mid');
    console.log(mid); 

    // a 태그의 href 값을 bno에 저장
    actionFrm.append("<input type='hidden' name='mid' value='"+ mid + "'>");
	
    actionFrm.attr('action', '/user/artview');
    
    actionFrm.submit();
}); 


// 작가조회버튼 클릭 이벤트 처리 end---------------


	// 삭제시 회원목록으로 돌아와서 알림창.?
	var result = '${result }';
	
	 userOut(result);
	 
	history.replaceState({},null,null); // history 초기화
	
	function userOut(result){
  	  // result 값이 있는경우에 알림창 표시
  	  
  	  if(result === '' || history.state) {
  		  return; 
  		  }

  	  if(result == 'remove success') {    // 회원 탈퇴 성공시
  		Swal.fire(
		        '회원삭제가 완료되었습니다.',
		        '',
		        'success'
    		      )			
  	} 
  	   	
   	 
   }   //  메인에서 뜨는 알림창 처리






 });   //END $
</script>
	
	
	<%@ include file="../includes/footer.jsp" %>