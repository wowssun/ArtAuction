# 🎨Sproutist - 개인 작가 작품 경매 사이트🎨

![경매사이트 메인 페이지](https://github.com/wowssun/ArtAuction/assets/119738419/ea55a331-10e0-40a1-9b6a-ebf5f21914a7)


## 💡프로젝트 소개

- 본 시스템은 Spring framework의 MVC 패턴 기법을 적용한 개인 작가 경매 사이트로 개인 작가들의 활발한 활동을 지원합니다.
- 회원은 경매에 올라온 작품을 입찰, 낙찰(결제) 할 수 있습니다.
- 작가는 자신의 작품을 경매에 등록, 오프라인으로 진행되는 원데이 클래스를 등록할 수 있습니다.
- 신예작가지원을 통해 작가 PR과 후원이 가능합니다.
- 관리자는 작가의 회원가입 신청을 승인/거절 할 수 있으며 전반적인 회원 관리를 담당하고 모든 게시판의 게시물, 댓글 ,리뷰 삭제가 가능합니다
- 1:1 문의 게시판, 자유게시판을 이용하여 사이트 내 관리자 또는 회원들과 소통 가능합니다.
- 전국 전시회 홍보 게시판, 문화/ 예술 뉴스 게시판을 이용할 수 있습니다.

## 📑개발 기간 및 개발 환경

- **개발 기간** : 2023.09.21 ~ 2023.11.07
- **개발 환경**
<div>
  <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white">
  <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
  <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white">
  <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
  <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white"><br>
  <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white">
  <img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white">
  <img src="https://img.shields.io/badge/eclipse-2C2255?style=for-the-badge&logo=eclipseide&logoColor=white">
  <img src="https://img.shields.io/badge/Apache-Tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white"><br>
  <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
  <img src="https://img.shields.io/badge/notion-000000?style=for-the-badge&logo=notion&logoColor=white">
</div>

## 📌 역할 분담 ( UI + 기능 )

### ⭐ 김지헌
- **경매, 입찰 및 낙찰, 1:1문의**
	- 경매 작품 목록, 상세 조회, 경매 등록, 수정, 삭제, 입찰 및 낙찰, 입찰 목록, 결제, 경매 작품 목록
	- 문의글 전체 목록, 상세 조회, 작성, 수정, 삭제, 답글 작성, 수정, 삭제, 내 문의글 목록

### ⭐ 손지희
- **작품, 신예작가지원, 전국 전시회, 홍보 게시판, 문화/예술 뉴스 게시판**
	- 작품 전체 목록, 상세 조회, 등록, 수정, 삭제, 나의 작품 목록
	- 신예작가지원 목록, 상세 조회, 등록, 수정, 삭제, 펀딩, 결제, 나의 펀딩 내역(일반), 나의 펀딩 목록(작가)
	- 홍보 게시판 목록
	- 문화/예술 뉴스 게시판 목록

### ⭐ 우선제
- **회원, 작가, 관리자, 자유게시판**
	- 로그인 및 로그아웃, 회원가입(아이디, 비밀번호 유효성검사, 아이디 중복체크), 아이디 찾기,비밀번호 찾기 및 변경
	- 마이페이지, 내 정보 조회, 수정, 탈퇴
	- 작가 정보 조회, 작가 신청,신청 현황 조회
	- 회원 전체 목록, 작가 신청 목록, 작가 승인/거절, 작가 승인/거절 내역,잠금 회원 목록, 잠금 및 잠금 해제
	- 게시글 전체 목록, 상세 조회, 작성, 수정, 삭제, 댓글 목록, 조회, 수정, 삭제, 내 게시글 목록, 내 댓글 목록

### ⭐ 조민경
- **원데이 클래스**
	- 클래스 전체 목록, 상세 조회, 작성, 수정, 삭제, 클래스 신청,내 클래스 목록, 클래스 신청 목록

## ⚒️ 프로젝트 구조

```
📦 ArtAuction
├─ .classpath
├─ .project
├─ .settings
├─ .springBeans
├─ README.md
├─ pom.xml
└─ src
   ├─ main
   │  ├─ java
   │  │  └─ org
   │  │     └─ artauc
   │  │        ├─ controller
   │  │        │  ├─ AdminController.java
   │  │        │  ├─ ArtController.java
   │  │        │  ├─ ArtUploadController.java
   │  │        │  ├─ AucController.java
   │  │        │  ├─ BidController.java
   │  │        │  ├─ ClassController.java
   │  │        │  ├─ ClassUploadController.java
   │  │        │  ├─ ErrorController.java
   │  │        │  ├─ FreeController.java
   │  │        │  ├─ FreeUploadController.java
   │  │        │  ├─ FundController.java
   │  │        │  ├─ HomeController.java
   │  │        │  ├─ HongboController.java
   │  │        │  ├─ InqController.java
   │  │        │  ├─ MainController.java
   │  │        │  ├─ NewsController.java
   │  │        │  ├─ PayController.java
   │  │        │  ├─ ReplyController.java
   │  │        │  ├─ ReviewController.java
   │  │        │  ├─ UploadController.java
   │  │        │  └─ UserController.java
   │  │        ├─ domain
   │  │        │  ├─ ArtVO.java
   │  │        │  ├─ ArtistVO.java
   │  │        │  ├─ AttachFileDTO.java
   │  │        │  ├─ AucCriteria.java
   │  │        │  ├─ AucPageDTO.java
   │  │        │  ├─ AucVO.java
   │  │        │  ├─ AuthVO.java
   │  │        │  ├─ BidVO.java
   │  │        │  ├─ CareerVO.java
   │  │        │  ├─ ClassAttachVO.java
   │  │        │  ├─ ClassReqVO.java
   │  │        │  ├─ ClassVO.java
   │  │        │  ├─ Criteria.java
   │  │        │  ├─ FCriteria.java
   │  │        │  ├─ FPageDTO.java
   │  │        │  ├─ FreeAttachVO.java
   │  │        │  ├─ FreeVO.java
   │  │        │  ├─ FundPayVO.java
   │  │        │  ├─ FundVO.java
   │  │        │  ├─ HongboVO.java
   │  │        │  ├─ InqVO.java
   │  │        │  ├─ MemberVO.java
   │  │        │  ├─ NewsVO.java
   │  │        │  ├─ PageDTO.java
   │  │        │  ├─ PayVO.java
   │  │        │  ├─ PhotoVO.java
   │  │        │  ├─ ReplyPageDTO.java
   │  │        │  ├─ ReplyVO.java
   │  │        │  ├─ RequestVO.java
   │  │        │  └─ ReviewVO.java
   │  │        ├─ mapper
   │  │        │  ├─ AdminMapper.java
   │  │        │  ├─ ArtMapper.java
   │  │        │  ├─ AucMapper.java
   │  │        │  ├─ BidMapper.java
   │  │        │  ├─ ClassAttachMapper.java
   │  │        │  ├─ ClassMapper.java
   │  │        │  ├─ ClassReqMapper.java
   │  │        │  ├─ FreeAttachMapper.java
   │  │        │  ├─ FreeMapper.java
   │  │        │  ├─ FundMapper.java
   │  │        │  ├─ InqMapper.java
   │  │        │  ├─ MainMapper.java
   │  │        │  ├─ MemberMapper.java
   │  │        │  ├─ PayMapper.java
   │  │        │  ├─ ReplyMapper.java
   │  │        │  ├─ ReviewMapper.java
   │  │        │  └─ UserMapper.java
   │  │        ├─ security
   │  │        │  ├─ CustomAccessDeniedHandler.java
   │  │        │  ├─ CustomLoginSuccessHandler.java
   │  │        │  ├─ CustomLogoutSuccessHandler.java
   │  │        │  ├─ CustomNoOpPasswordEncoder.java
   │  │        │  ├─ CustomUserDetailsService.java
   │  │        │  └─ domain
   │  │        │     └─ CustomUser.java
   │  │        └─ service
   │  │           ├─ AdminService.java
   │  │           ├─ AdminServiceImpl.java
   │  │           ├─ ArtService.java
   │  │           ├─ ArtServiceImpl.java
   │  │           ├─ AucService.java
   │  │           ├─ AucServiceImpl.java
   │  │           ├─ BidService.java
   │  │           ├─ BidServiceImpl.java
   │  │           ├─ CLassReqServiceImpl.java
   │  │           ├─ ClassReqService.java
   │  │           ├─ ClassService.java
   │  │           ├─ ClassServiceImpl.java
   │  │           ├─ FreeService.java
   │  │           ├─ FreeServiceImpl.java
   │  │           ├─ FundService.java
   │  │           ├─ FundServiceImpl.java
   │  │           ├─ InqService.java
   │  │           ├─ InqServiceImpl.java
   │  │           ├─ MainService.java
   │  │           ├─ MainServiceImpl.java
   │  │           ├─ PayService.java
   │  │           ├─ PayServiceImpl.java
   │  │           ├─ ReplyService.java
   │  │           ├─ ReplyServiceImpl.java
   │  │           ├─ ReviewService.java
   │  │           ├─ ReviewServiceImpl.java
   │  │           ├─ UserService.java
   │  │           └─ UserServiceImpl.java
   │  ├─ resources
   │  │  ├─ log4j.xml
   │  │  ├─ log4jdbc.log4j2.properties
   │  │  └─ org
   │  │     └─ artauc
   │  │        └─ mapper
   │  │           ├─ AdminMapper.xml
   │  │           ├─ ArtMapper.xml
   │  │           ├─ AucMapper.xml
   │  │           ├─ BidMapper.xml
   │  │           ├─ ClassAttachMapper.xml
   │  │           ├─ ClassMapper.xml
   │  │           ├─ ClassReqMapper.xml
   │  │           ├─ FreeAttachMapper.xml
   │  │           ├─ FreeMapper.xml
   │  │           ├─ FundMapper.xml
   │  │           ├─ InqMapper.xml
   │  │           ├─ MainMapper.xml
   │  │           ├─ MemberMapper.xml
   │  │           ├─ PayMapper.xml
   │  │           ├─ ReplyMapper.xml
   │  │           ├─ ReviewMapper.xml
   │  │           └─ UserMapper.xml
   │  └─ webapp
   │     ├─ WEB-INF
   │     │  ├─ spring
   │     │  │  ├─ appServlet
   │     │  │  │  └─ servlet-context.xml
   │     │  │  ├─ root-context.xml
   │     │  │  └─ security-context.xml
   │     │  ├─ views
   │     │  │  ├─ admin
   │     │  │  │  ├─ adminPage.jsp
   │     │  │  │  ├─ artistList.jsp
   │     │  │  │  ├─ checkList.jsp
   │     │  │  │  ├─ rqList.jsp
   │     │  │  │  ├─ userList.jsp
   │     │  │  │  └─ userLockList.jsp
   │     │  │  ├─ art
   │     │  │  │  ├─ list.jsp
   │     │  │  │  ├─ modify.jsp
   │     │  │  │  ├─ myartlist.jsp
   │     │  │  │  ├─ register.jsp
   │     │  │  │  └─ view.jsp
   │     │  │  ├─ artauction
   │     │  │  │  ├─ idSearch.jsp
   │     │  │  │  ├─ main.jsp
   │     │  │  │  ├─ pwChange.jsp
   │     │  │  │  ├─ pwSearch.jsp
   │     │  │  │  ├─ userJoin.jsp
   │     │  │  │  ├─ userLogin.jsp
   │     │  │  │  └─ userLogout.jsp
   │     │  │  ├─ auction
   │     │  │  │  ├─ auclist.jsp
   │     │  │  │  ├─ bidlist.jsp
   │     │  │  │  ├─ modify.jsp
   │     │  │  │  ├─ myauclist.jsp
   │     │  │  │  ├─ register.jsp
   │     │  │  │  ├─ sbidlist.jsp
   │     │  │  │  └─ view.jsp
   │     │  │  ├─ class
   │     │  │  │  ├─ classInfo.jsp
   │     │  │  │  ├─ classList.jsp
   │     │  │  │  ├─ classMod.jsp
   │     │  │  │  ├─ classMyReq.jsp
   │     │  │  │  ├─ classRegi.jsp
   │     │  │  │  ├─ classReqList.jsp
   │     │  │  │  └─ myClassList.jsp
   │     │  │  ├─ error
   │     │  │  │  └─ accessDenied.jsp
   │     │  │  ├─ free
   │     │  │  │  ├─ list.jsp
   │     │  │  │  ├─ modify.jsp
   │     │  │  │  ├─ mylist.jsp
   │     │  │  │  ├─ register.jsp
   │     │  │  │  ├─ remylist.jsp
   │     │  │  │  └─ view.jsp
   │     │  │  ├─ fund
   │     │  │  │  ├─ list.jsp
   │     │  │  │  ├─ modify.jsp
   │     │  │  │  ├─ myfundlist.jsp
   │     │  │  │  ├─ mypaylist.jsp
   │     │  │  │  ├─ register.jsp
   │     │  │  │  └─ view.jsp
   │     │  │  ├─ home.jsp
   │     │  │  ├─ hongbo
   │     │  │  │  ├─ NewFile.jsp
   │     │  │  │  └─ list.jsp
   │     │  │  ├─ includes
   │     │  │  │  ├─ footer.jsp
   │     │  │  │  └─ header.jsp
   │     │  │  ├─ inquiry
   │     │  │  │  ├─ answerlist.jsp
   │     │  │  │  ├─ inqlist.jsp
   │     │  │  │  ├─ modify.jsp
   │     │  │  │  ├─ mylist.jsp
   │     │  │  │  ├─ register.jsp
   │     │  │  │  └─ view.jsp
   │     │  │  ├─ news
   │     │  │  │  └─ list.jsp
   │     │  │  ├─ review
   │     │  │  │  ├─ myReview.jsp
   │     │  │  │  ├─ reviewInfo.jsp
   │     │  │  │  ├─ reviewMod.jsp
   │     │  │  │  └─ reviewRegi.jsp
   │     │  │  └─ user
   │     │  │     ├─ artistMypage.jsp
   │     │  │     ├─ artmodify.jsp
   │     │  │     ├─ artview.jsp
   │     │  │     ├─ modify.jsp
   │     │  │     ├─ myinfo.jsp
   │     │  │     ├─ mypage.jsp
   │     │  │     ├─ request.jsp
   │     │  │     ├─ rqcheck.jsp
   │     │  │     └─ rqview.jsp
   │     │  └─ web.xml
   │     └─ resources
   │        ├─ .gitignore
   │        ├─ img
   │        │  ├─ myicon
   │        │  └─ title
   │        ├─ js
   │        │  └─ reply.js
   └─ test
      ├─ java
      │  └─ org
      │     └─ artauc
      │        ├─ persistence
      │        │  ├─ AdminMapperTest.java
      │        │  ├─ AucMapperTests.java
      │        │  ├─ ClassMapperTest.java
      │        │  ├─ DataSourceTests.java
      │        │  └─ MainMapperTest.java
      │        └─ service
      │           ├─ AdminServiceTest.java
      │           ├─ AucServiceTests.java
      │           ├─ ClassServiceTest.java
      │           └─ MainServiceTest.java
	  └─ resources
	        └─ log4j.xml
   
```

## 🔍 팀 PPT
### 팀 PPT
- 자세한 작업 과정과 완성 화면을 볼 수 있습니다.

[![구글 드라이브](https://github.com/wowssun/jejuOseyo/assets/119738419/1ebc8fd6-f200-4a30-a9d6-770931d508fe)](https://drive.google.com/file/d/1-evB_yrjVvYKv3_VlafSkP-xnvmyS-Ku/view?usp=sharing)

### 블로그
- 프로젝트를 경험하며 공부한 기록입니다.

  [![hashnode](https://github.com/wowssun/jejuOseyo/assets/119738419/c95c2300-5109-4b94-b6c8-8964d396f915)](https://wowssun.hashnode.dev/)

