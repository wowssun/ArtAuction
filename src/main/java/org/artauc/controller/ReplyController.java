package org.artauc.controller;


import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.artauc.domain.Criteria;
import org.artauc.domain.PageDTO;
import org.artauc.domain.ReplyPageDTO;
import org.artauc.domain.ReplyVO;
import org.artauc.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@RestController    // json 받을 수 있도록 restController로 변경해야한다.
@Log4j
@RequestMapping("/replies/")
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService replyService;
	
	// http://localhost:8090/replies/pages/50/1
	// 전체 목록 가져오기 + 페이징
	// 상태코드 반환, ResponseEntity 이거 쓰고 list도 반환이니까 그 <List>
	// bno처럼 들어오는거 이름 지정도 가능
		@GetMapping(value = "pages/{frno}/{pageNum}")
		public ResponseEntity <ReplyPageDTO> list(@PathVariable("frno") int frno,@PathVariable int pageNum) {
					
			log.info("reply list......");
			
			Criteria cri = new Criteria(3,pageNum);   // cri 값을 지정한 경우, pageNum은 일단 파라미터로 받음.
														// 실제로 돌릴때는 변경해서
			
			// 댓글 목록 및 200번 상태 코드 반환
			return new ResponseEntity <ReplyPageDTO>(
						replyService.list(frno, cri),HttpStatus.OK);
		}
	
	
	
		
		//JSON 데이터를 받아서 VO 객체로 반환
		@PostMapping(value = "add",
					 produces = {MediaType.TEXT_PLAIN_VALUE})
		@PreAuthorize("isAuthenticated()")
		public ResponseEntity<String> add(@RequestBody ReplyVO rvo) {   // 스프링에서 돌려보내기 할때는 이걸쓴다.
			log.info(" reply add....");									// 확인용		
			
			
			// 파라미터로 값 보내야 함.
			// 댓글 등록 성공이면 200과 success 반환, 실패하면 500 코드(INTERNAL_SERVER_ERROR 반환

			return replyService.add(rvo) 
					? new ResponseEntity<String>("success", HttpStatus.OK)
				    : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
			
			// jsp 파일로 보내면 안되고 mapping 된 list로 보내야 한다. 리턴하고 다시 가는 곳이 같으면  void 사용
			// 그렇지 않을때는 String 으로 
		}
		
		
		// 하나 조회하기
		// rno만 받으니까 @PathVariable로 받는다. url 경로를 사용해서 rno를 받으니까
		@GetMapping(value = "{rpno}")
		public ResponseEntity<ReplyVO> view(@PathVariable int rpno) {		
																				  
			log.info("reply view......");	
			
			// 하나 조회한 값이랑 상태코드 200을 반환한다.
			return new ResponseEntity<ReplyVO>(
					 replyService.view(rpno),HttpStatus.OK);
				
			
		}
	
		// 수정하기
		@RequestMapping(value = "{rpno}",
					 produces = {MediaType.TEXT_PLAIN_VALUE},
					 method= {RequestMethod.PUT, RequestMethod.PATCH})
		@PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')")
		public ResponseEntity<String> modify(@PathVariable int rpno, @RequestBody ReplyVO rvo) {		
			log.info("reply modify......");
			
			// 댓글 수정 성공이면 200과 success 반환, 실패하면 500 코드(INTERNAL_SERVER_ERROR 반환

			return replyService.modify(rvo) 
						? new ResponseEntity<String>("success", HttpStatus.OK)
					    : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}	
		
		// 삭제하기
		@DeleteMapping(value="{rpno}")
		@PreAuthorize("hasAnyRole('ROLE_USER', 'ROLE_ADMIN')")
		public ResponseEntity<String> remove(@PathVariable int rpno) {	
			
			log.info("reply remove......");
			
			// 댓글 삭제 성공이면 200과 success 반환, 실패하면 500 코드(INTERNAL_SERVER_ERROR 반환
			
			return replyService.remove(rpno) 
					? new ResponseEntity<String>("success", HttpStatus.OK)
				    : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		
		}
		
		
}
