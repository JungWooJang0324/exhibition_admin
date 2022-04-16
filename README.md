# 3조 exhibition_admin 페이지
* 사용 언어: JSP, Oracle DB, Jquery..
* 제작기간: (2022.03.28~)

## ClassDiagram
<img src="https://user-images.githubusercontent.com/93374409/163676590-f85c0068-d2ae-4eca-92a7-9328433905c1.png"/>



# 필요한 정보 
* 로그인 페이지-세션적용
* 회원관리 페이지, 회원 상세조회
* 전시관리 페이지, 전시 상세조회
* 전시장 관리 페이지, 전시장 상세조회
* 전시 예약관리 페이지, 예약 상세조회
* 게시판 관리 페이지, 글 상세조회와 글쓰기페이지 
 
# 결과물
-------------------
### 로그인
<img src="https://user-images.githubusercontent.com/93374409/163676765-9d10f7df-4c16-4e24-bc09-054ce2aad4ef.PNG" width="300" height=auto/>

* Login 성공
    * 관리자 계정 : db 조회 성공시 아이디 세션 저장
* Login 실패
    * 실패 시 "로그인 실패!" 메세지 출력 후 로그인창 재호출

-------------------
### DashBoard
<img src="https://user-images.githubusercontent.com/93374409/163676454-48369b71-9de9-4560-bcf2-5aef1ff588fe.PNG"/>

* 총 회원수, 신규 가입회원수
* 전시일정, 예약건 등

### 회원관리
<img src="https://user-images.githubusercontent.com/93374409/163676878-751d8dee-6c4a-4549-96f4-293be7d1d1ac.PNG"/>
<img src="https://user-images.githubusercontent.com/93374409/163676970-c546778a-5ba9-46fd-998b-9c7d08270973.PNG"/>

* DB호출 List로 전체 보여준 후 클릭 시 상세 정보 
