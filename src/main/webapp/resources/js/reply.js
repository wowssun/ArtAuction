var replyService = ( function() {

	// 댓글 조회 -----------
		function view(rpno, callback, error){
			// 함수이름이 getJSON
			// 1번째는 전송할 url
			// 2번째는 콜백으로 받는거
			$.get('/replies/' + rpno + '.json',
					function(result){
						callback(result);// 성공시
					}
		
		).fail(function(xhr, status, er){
					if(error){		// 실패라면 여기
						error(er);
					}	// 에러시
			
         });  	 	
       }    	 	
           	 	
	// 댓글 조회 END---------





	// 댓글 삭제------------
		function remove(rpno, callback, error){
			$.ajax({
			type : 'delete',						// get or post 등등 method
			url :  '/replies/' + rpno,						// 전송할 곳
		//	data : JSON.stringify(reply),					// 전송할 테이터가 없기 때문에 여기서는 삭제, 밑에도
		//	contentType : 'application/json; charset=UTF-8' , 			 //  컨텐트 타입 및 인코딩
			success : function(result, status, xhr) {
							if(callback){
								callback(result);			// 서버로 데이터로 등록하고 성공했을경우 이쪽으로
							} 								// 성공하면 callback으로 result담아서 
			},							
			error : function(xhr, status, er) {		// 등록 못했을때, 에러 시, 만약에 에러가 있다면 
					if(error){							// 매개변수로  error를 받아서 또는 error를 안받고 그냥 여기서 출력
						error(er);
					}	// 에러시
				}
		}); // END ajax()
					
		}

	// 댓글 삭제 END---------------


	
	// 댓글 수정---------
		function modify(reply, callback, error){
			$.ajax({
			type : 'put',						// get or post 등등 method
			url :  '/replies/' + reply.rpno,						// 전송할 곳
			data : JSON.stringify(reply),					// 전송할 테이터
			contentType : 'application/json; charset=UTF-8' , 			 //  컨텐트 타입 및 인코딩
			success : function(result, status, xhr) {
							if(callback){
								callback(result);			// 서버로 데이터로 등록하고 성공했을경우 이쪽으로
							} 								// 성공하면 callback으로 result담아서 
			},							
			error : function(xhr, status, er) {		// 등록 못했을때, 에러 시
					if(error){
						error(er);
					}	// 에러시
				}
		}); // END ajax()	

} 



	// 댓글 수정 END--------


	// 댓글 목록 -----------
		function list(param, callback, error){
			// 함수이름이 getJSON
			// 1번째는 전송할 url
			// 2번째는 콜백으로 받는거
			$.getJSON('/replies/pages/' + param.frno + '/' + param.pageNum +'.json',
					function(result){   // 여기는 result안에 list랑 pateDTO가 넘어오고
						callback(result.list, result.replyCnt);   // 성공시 두개를 각자 반환하려고 하니까
					}
		
			
		).fail(function(xhr, status, er){
					if(error){		// 실패라면 여기
						error(er);
					}	// 에러시
			
         });  	 	
       }    	 	
           	 	
	// 댓글 목록 END---------
         

	
	// 댓글 등록 ----------------
	function add(reply, callback){   // reply = ReplyVO. 이름이라서 아무거나 써도 상관 X
		$.ajax({
			type : 'post',					// get or post 등등 method
			url :  '/replies/add',						// 전송할 곳
			data : JSON.stringify(reply),					// 전송할 테이터
			contentType : 'application/json; charset=UTF-8' , 			 //  컨텐트 타입 및 인코딩
			success : function(result, status, xhr) {
							if(callback){
								callback(result);			// 서버로 데이터로 등록하고 성공했을경우 이쪽으로
							} 								// 성공하면 callback으로 result담아서 
			},							
			error : function(xhr, status, er) {		// 등록 못했을때, 에러 시
					if(error){
						error(er);
					}	// 에러시
				}
		}); // END ajax()	
			console.log('reply add()');	
	} // End 댓글 등록()---------------
	
	// 날짜 및 시간 출력 포맷---------------
		function display(regDate){
			var today = new Date();
			var rDate = new Date(regDate);
    
			// 변수로 모두 빼서 해도 된다.
			// 이런식으로 비교, 오늘은 현재와 연,월,일 비교 하고
			console.log(today.getFullYear() , rDate.getFullYear());
			console.log(today.getMonth());
     
      	var yy = rDate.getFullYear();
		var MM = rDate.getMonth();
		var dd = rDate.getDate();
    
    	var hh = rDate.getHours();
		var mm = rDate.getMinutes();
		var ss = rDate.getSeconds();
      
   
		
	    // 과거는 yyyy-MM-dd만
	    // 오늘 작성한 것은 시 : 분 : 초 반환 getHour해서 시분초 가져오기
		if(today.getFullYear() == yy
		   && today.getMonth() == MM
		   && today.getDate() == dd ){	//오늘 작성한 댓글의 경우
			return 	[ (hh < 10 ? '0' : '') + hh, ':',
			 	      (mm < 10 ? '0' : '') + mm, ':',
			 		  (ss < 10 ? '0' : '') + ss      ].join('');
			 		  ///시:분:초 반환
		} else {						//그렇지 않으면
			return 	[ yy,'/', 
					  ( (MM+1) < 10 ? '0' : '') + (MM + 1), '/',	
					  (dd < 10 ? '0' : '') + dd      ].join('');	//연/월/일 반환
		}
	
	
	
 //END 날짜 및 시간 출력 포맷---------------
	
}
	return { display : display, add : add, list :list, modify : modify, remove : remove, view : view  };  // return하는값

})();
