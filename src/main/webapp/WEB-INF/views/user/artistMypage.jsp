<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<hr style="border:0; background : #566573 ; height: 2px; width: 300px; ">

<div class="main">
    <div class="container">
    	<div class="my">
         <form action="/user/artview">
         	<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token  }">
         	<input type="hidden" name="mid" value="<sec:authentication property='principal.mvo.mid'/>">

        <div class="row">
			<div class="col-md-6">
                <div class="item">
                <button><img alt="" src="/resources/img/myicon/artinfo.png">
	                    <span>작가 정보</span></button>
	                </div>
            </div>
           <div class="col-md-6">
                <div class="item">
                    <a href="/art/myartlist?mid=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/myart.png">
                    <span>내 작품 목록</span></a>
                </div>
             </div>
          </div>
           <div class="row">
			<div class="col-md-6">
                <div class="item">
                    <a href="/auction/myauclist?mid=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/artwork.png">
                    <span>경매에 올린 작품</span></a>
                </div>
            </div>
           <div class="col-md-6">
                <div class="item">
                    <a href="/class/myClassList?mid=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/myclass.png">
                    <span>나의 원데이 클래스</span></a>
                </div>
             </div>
          </div>
           <div class="row">
			<div class="col-md-6">
                <div class="item">
                    <a href="/fund/myfundlist?mid=<sec:authentication property='principal.mvo.mid'/>"><img alt="" src="/resources/img/myicon/myfund.png">
                    <span>나의 펀딩 목록</span></a>
                </div>
            </div>
          </div>
          </form>
          </div>
         </div>
        </div>

