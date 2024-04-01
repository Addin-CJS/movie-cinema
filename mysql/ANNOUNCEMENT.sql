--------------------------------------------------------
--  파일이 생성됨 - 월요일-4월-01-2024   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table ANNOUNCEMENT
--------------------------------------------------------

  CREATE TABLE "ADDIN"."ANNOUNCEMENT" 
   (	"ID" NUMBER(19,0), 
	"CONTENT" VARCHAR2(700 CHAR), 
	"CREATE_DATE" TIMESTAMP (6), 
	"TITLE" VARCHAR2(255 CHAR), 
	"UPDATE_DATE" TIMESTAMP (6), 
	"USERNAME" VARCHAR2(255 CHAR)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into ADDIN.ANNOUNCEMENT
SET DEFINE OFF;
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (31,'안녕하세요. 고객님

 

원활하고 안정된 서비스 제공을 위하여 현대카드 시스템 점검 작업이 예정되어 있습니다.  

점검 시간 중 현대카드 포인트사용 및 간편결제(카드등록) 등 일부 서비스가 중단될 예정이오니 이용에 불편 없으시기 바랍니다.         



1. 작업기간 : ''24년 2월 18일(일) 01시 ~ 07시(6시간)

2. 작업내용
   현대카드 정기 PM작업

3. 서비스 제공 불가 항목
   현대카드 포인트사용 및 간편결제(카드등록) 등 일부 서비스 중단
    

더욱 안정적이고 편리한 서비스를 제공하는 MVC가 되겠습니다.

감사합니다. ',to_timestamp('24/02/15 15:06:38.684809000','RR/MM/DD HH24:MI:SSXFF'),'[[시스템점검]] 현대카드 정기 점검(2/18(일) 01:00 ~ 07:00)',to_timestamp('24/02/15 15:06:38.684809000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (33,'안녕하십니까, MVC입니다.

4DX 레드 카드 서비스 종료 사전 안내드립니다. 



22/12/31까지 등록된 카드의 경우, 정상적인 카드 혜택 이용이 가능하며

미등록카드를 소지하신 고객님께서는 22/12/31까지 카드를 등록하실 수 있습니다.

(카드 유효기간 : 등록 후 기본 1년, 관람횟수 별 혜택에 따라 최대 2년 이용 가능)

 

미등록카드에 한하여 카드 이용을 희망하지 않는 고객님께서는

MVC 고객센터를 통해 문의 부탁드립니다. 

(실물 카드 지참 필수, 미등록 내역 확인을 위한 실물 카드 정보 확인 필요)

 

25년 1월 1일부터는 4DX 레드 카드의 서비스가 종료되오니

이용에 참고 부탁드립니다.

 

감사합니다.',to_timestamp('24/02/15 15:08:26.141318000','RR/MM/DD HH24:MI:SSXFF'),'[[기타]] 4DX 레드 카드 서비스 종료 안내 (~24/12/31)',to_timestamp('24/02/15 15:08:26.141318000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (34,'안녕하세요.
MVC 천안지점입니다.

천안지점을 이용해주시는 고객님들께 보다 나은 관람 환경 제공을 위하여
전 상영관의 좌석 및 바닥, 영사기 교체 공사가 진행됩니다.

[상영관 리뉴얼 공사 일정]
 ▶ 1~3관 : 2024년 2월 14일(수)부터 2월 22일(목)까지
 ▶ 6~9관 : 2024년 2월 23일(금)부터 3월 4일(월)까지
 ▶ 4~5관 : 2024년 3월 5일(화)부터 3월 8일(금)까지

※ 공사 기간은 진행 상황에 따라 일부 변동될 수 있습니다.
※ 리뉴얼 상영관을 제외한 나머지 상영관은 정상 운영되오니,
   위 일정을 확인하시어 관람에 참고 바랍니다.

해당 공사 기간 동안 이용에 다소 불편함이 있으시더라도 너른 양해 부탁드리며,
고객 여러분의 불편이 최소화될 수 있도록 최선을 다하겠습니다.

관련 문의사항은 관리자를 통해 문의주시면 안내 도와드리겠습니다.

변화하는 천안지점의 새로운 모습에 많은 관심과 응원 부탁드립니다.',to_timestamp('24/02/15 15:09:47.889674000','RR/MM/DD HH24:MI:SSXFF'),'[지점] [천안] 상영관 리뉴얼 공사 일정 안내 (2/14~3/8)',to_timestamp('24/02/15 15:09:47.889674000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (1,'안녕하세요, MVC입니다. 

최근 무대 인사 티켓을 대량 구매하여 높은 가격으로 재판매하거나 상영 직전 환불하는 등의 사례가 빈번하게 발생하고 있습니다. 

이에 MVC는 실제로 행사를 즐기고자 하시는 고객님들께 참여 기회를 제공하기 위하여 무대인사 회차에 대한 예매취소 정책을 아래와 같이 변경하오니 이용에 참고 부탁드립니다. 


기존 
- 상영시간 20분 전까지 취소 가능

변경 후 

- 온라인 : 상영 전일 23시 59분까지 취소 가능

- 현장 : 상영 시간 20분 전까지 매표소에서 취소 가능

(키오스크 환불 불가, PRIVATE BOX는 기존과 같이 당일 환불 불가)


시행일: 1월 2일 이후 진행하는 무대인사부터 시행',to_timestamp('24/02/15 14:31:17.514601000','RR/MM/DD HH24:MI:SSXFF'),'[MVC] 무대인사 예매취소 정책 변경 안내',to_timestamp('24/02/15 15:02:35.089215000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (35,'안녕하세요, MVC 입니다.

서울페이(서울사랑상품권) 결제서비스 운영이 종료될 예정이오니

아래 내용 참고 부탁드리겠습니다.

=======================================
1. 종료일시 : 2024년 2월 1일 (1월 31일 23시 59분까지 사용가능)

2. 종료서비스 : 서울페이(서울사랑상품권)

3. 사유 : 서울페이 주관사 요청에 의한 서비스 종료

=======================================

더 좋은 서비스로 찾아 뵙겠습니다.

감사합니다.',to_timestamp('24/02/15 15:10:31.637299000','RR/MM/DD HH24:MI:SSXFF'),'[기타] 서울페이(서울사랑상품권) 서비스 종료 안내 (1/31)',to_timestamp('24/02/15 15:10:31.637299000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (36,'1. 온라인 예매 시(MVC 홈페이지) 1회 결제 시 최대 8매까지 예매 가능합니다.

2. 1일 5회 또는 최대 24매, 최대 5개 지점까지만 예매 가능합니다. (3가지 조건 중 1개라도 충족시 추가 예매 불가)
  1) 2매씩 총 5번 예매 시도시 회수 조건 충족으로 추가 예매 불가 (5회)
  2) 8매씩 총 3번 예매 시도시 최대 매수 조건 충족으로 추가 예매 불가 (24매)
  3) 서로다른 5개 지점 예매 시 최대 이용가능 지점 초과로 추가 예매 불가 (5지점)
  4) 예매를 취소하시면 회수 및 매수 조건은 초기화됩니다.

3. 매 월 1일에서 마지막날짜를 기준으로 인당 최대 100매까지 예매 가능합니다.
  1) 월 예매 제한 수량을 초과 할 경우 추가 예매가 불가하여 추후 예매 제한 수량이 감소할 수 있습니다. 
  2) 월 예매 횟수는 예매를 취소하여도 초기화 되지 않습니다.

※ 만약 단체관람등으로 다량의 좌석 구매가 필요하시다면 관리자를 통해 관람을 원하시는 지점으로 문의 부탁드립니다.

※적용일: 2024년 2월 10일',to_timestamp('24/02/15 15:12:19.218634000','RR/MM/DD HH24:MI:SSXFF'),'[MVC] 예매 가능 횟수 매수 제한 안내',to_timestamp('24/02/15 15:12:19.218634000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (37,'MVC 공식 홈페이지를 통한 예매 진행 시 별도의 수수료는 발생되지 않습니다.

* 제휴 사이트를 통한 예매시 별도로 책정된 수수료가 부과되오니,

   이점 유의 부탁드립니다.',to_timestamp('24/02/15 15:13:10.384593000','RR/MM/DD HH24:MI:SSXFF'),'[MVC] 인터넷 예매 수수료',to_timestamp('24/02/15 15:13:10.384593000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (44,' 페이머니 신규발급 웰컴쿠폰

신규 발급하면 MVC 최대 28,000원 할인 혜택

2D 영화관 할인, 콤보할인, 포토티켓 무료 증정 !',to_timestamp('24/02/15 19:18:12.977387000','RR/MM/DD HH24:MI:SSXFF'),'[이벤트] 페이머니 신규발급 웰컴쿠폰',to_timestamp('24/02/16 17:27:36.216779000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (32,'안녕하세요. 고객님

 

원활하고 안정된 서비스 제공을 위하여 해피머니상품권 해피캐시 시스템 점검 작업이 예정되어 있습니다.  

점검 시간 중 해피머니상품권 해피캐시 영화 예매 및 취소 모든 서비스가 중단될 예정이오니 이용에 불편 없으시기 바랍니다.         



1. 작업기간 : ''23년 12월 29일 10시반 ~ ''23년 12월 30일 10시

2. 작업내용
   해피머니상품권 해피캐시 점검

3. 서비스 제공 불가 항목
    해피머니상품권 해피캐시 점검
     해피머니 상품권(지류), 해피머니 모바일상품권(바코드) 오프라인사용은 가능합니다.

관련 문의사항은 컬쳐랜드 고객센터 (1588-5245)로 문의 부탁드립니다.
  

더욱 안정적이고 편리한 서비스를 제공하는 MVC가 되겠습니다.

 

감사합니다.',to_timestamp('24/02/15 15:07:28.885171000','RR/MM/DD HH24:MI:SSXFF'),'[[시스템점검]] 해피머니상품권 해피캐시(모바일, 홈페이지 점검)',to_timestamp('24/02/15 15:07:28.885171000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (42,'행사기간: 2023년8월1일~2024년7월31일

행사기간: 본 이벤트를 통해

          현대백화점모바일카드신규가입시
          MVC 2D영화관람권1매지급

증정일시: 신규가입월익월10일,
쿠폰번호 문자발송


!꼭확인하세요
•본 이벤트 혜택은 행사 기간 사이 해당 이벤트 페이지를 통해
현대백화점 모바일카드를 신규로발급받는고객에 한해 적용됩니다.',to_timestamp('24/02/15 19:12:46.745422000','RR/MM/DD HH24:MI:SSXFF'),'[이벤트] 현대백화점 모바일카드 신규 가입 프로모션',to_timestamp('24/02/15 19:12:46.745422000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (40,'네이버 페이로 결제 시 영화 할인 !

2024.02.05 ( 월 ) ~ 2024. 02.29( 목 )

주차별 1인 1회 참여 가능

포인트 / 머니, 카드 한정, 삼성페이 제외

** 확인 **
본 이벤트는 네이버페이 및 MVC  사정에 의해 변경 및 조기 종료될 수 있습니다.
지정된 결제수단 외 타 결제수단은 할인 적용이 불가합니다.
네이버페이 X 삼성페이 결제 시 혜택 대상에서 제외됩니다.',to_timestamp('24/02/15 19:08:00.796087000','RR/MM/DD HH24:MI:SSXFF'),'[이벤트] 네이버페이로 결제 시 영화 할인',to_timestamp('24/02/15 19:08:00.796087000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
Insert into ADDIN.ANNOUNCEMENT (ID,CONTENT,CREATE_DATE,TITLE,UPDATE_DATE,USERNAME) values (41,'VIP 콕! 영화 선택하고 무료 예매 혜택 받자

LG U+ VIP 이상 등급이라면 MVC에서만 받을 수 있는 영화 무료 예매 혜택을
놓치지 마세요 !

기간 : 2024. 01. 01 ~ 2025. 12.31
대상 :  VIP, VVIP 등급
내용 : 연 3회 무료, 연 9회 1+1 예매 혜택

** 꼭 확인하세요**
연 3회 무료, 연 9회 예매 혜택
2D 일반 영화에 한하여 예매 가능
유료 티켓만 단독으로 예매 불가',to_timestamp('24/02/15 19:12:38.014327000','RR/MM/DD HH24:MI:SSXFF'),'[이벤트] VIP 콕! 영화 선택하고 무료 예매 혜택 받자',to_timestamp('24/02/15 19:12:38.014327000','RR/MM/DD HH24:MI:SSXFF'),'sejin3');
--------------------------------------------------------
--  DDL for Index SYS_C008591
--------------------------------------------------------

  CREATE UNIQUE INDEX "ADDIN"."SYS_C008591" ON "ADDIN"."ANNOUNCEMENT" ("ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table ANNOUNCEMENT
--------------------------------------------------------

  ALTER TABLE "ADDIN"."ANNOUNCEMENT" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "ADDIN"."ANNOUNCEMENT" ADD PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
