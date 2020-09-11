-- =============================================    
-- DROP TABLE
-- ============================================= 
--禮車開始
DROP TABLE CAR_PIC;
DROP TABLE CAR_EXT_ORDER;
DROP TABLE CAR_ORDER;
DROP TABLE CAR_COLLECT;
DROP TABLE CAR_EXT;
DROP TABLE CAR;
--禮車結束

--婚紗開始
DROP TABLE DRESS_ADD_ORDER;
DROP TABLE DRESS_ORDER_DETAIL;
DROP TABLE DRESS_ORDER;
DROP TABLE DRESS_ADD_ON;
DROP TABLE DRESS_ADD_TYPE;
DROP TABLE DRESS_CASE_TRACK;
DROP TABLE DRESS_CASE_PIC;
DROP TABLE DRESS_CASE;
--婚紗結束

--婚攝開始
DROP TABLE "WED_PHOTO_COLLECT";
DROP TABLE "WED_PHOTO_IMG";
DROP TABLE "WED_PHOTO_ORDER_DETAIL";
DROP TABLE "WED_PHOTO_ORDER";
DROP TABLE "WED_PHOTO_CASE";
--婚攝結束
--後臺開始
DROP TABLE AD;
DROP TABLE ADM_PER;
DROP TABLE ADM;
DROP TABLE ADM_FUNC;
DROP TABLE PINTHEPOST;
--後臺結束
--商城開始
drop table prod_pic;
drop table buy_list;
drop table order_detail;
drop table prod_order;
drop table prod;
drop table prod_type;
--商城結束

--討論區開始
DROP TABLE FORUM_MES;
DROP TABLE FORUM;
--討論區結束
DROP TABLE VENDER;
DROP TABLE MEMBRE;
-- =============================================    
-- DROP自增主鍵值
-- =============================================    
DROP SEQUENCE  MEMBRE_SEQ;
DROP SEQUENCE  VENDER_SEQ;
--禮車開始
DROP SEQUENCE  CAR_SEQ;
DROP SEQUENCE  CAR_PIC_SEQ;
DROP SEQUENCE  CAR_EXT_SEQ;
DROP SEQUENCE  CAR_EXT_ORDER_SEQ;
DROP SEQUENCE  CAR_ORDER_SEQ;
DROP SEQUENCE  CAR_COLLECT_SEQ;
--禮車結束
--婚紗開始
DROP SEQUENCE dressCase_seq;
DROP SEQUENCE dressCasePic_seq;
DROP SEQUENCE dressAddON_seq;
DROP SEQUENCE dressOrder_seq;
DROP SEQUENCE dressDetail_seq;
--婚紗結束
--婚攝開始
DROP SEQUENCE "WPC_SEQ";
DROP SEQUENCE "WPO_SEQ";
DROP SEQUENCE "WPP_SEQ";
--婚攝結束

--商城開始
drop sequence prod_seq;
drop sequence pic_seq;
drop sequence order_seq;
--商城結束

--後台開始
DROP SEQUENCE SEQ_AD_ID;
DROP SEQUENCE SEQ_ADM_ID;
DROP SEQUENCE SEQ_FUNC_ID;
DROP SEQUENCE SEQ_PTP_ID;
--後台結束
--討論區開始
DROP SEQUENCE FORUM_SEQ;
DROP SEQUENCE FORUM_MES_SEQ;
--討論區結束
-- =============================================    
-- 自增主鍵值
-- =============================================    
CREATE SEQUENCE MEMBRE_SEQ;
CREATE SEQUENCE VENDER_SEQ;
--禮車開始
CREATE SEQUENCE CAR_SEQ;
CREATE SEQUENCE CAR_PIC_SEQ; 
CREATE SEQUENCE CAR_ORDER_SEQ;
CREATE SEQUENCE CAR_EXT_SEQ;
CREATE SEQUENCE CAR_EXT_ORDER_SEQ;
CREATE SEQUENCE CAR_COLLECT_SEQ; 
    --禮車結束
    --婚攝開始
CREATE SEQUENCE  "WPC_SEQ"  MINVALUE 1 MAXVALUE 999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
CREATE SEQUENCE  "WPO_SEQ"  MINVALUE 1 MAXVALUE 999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
CREATE SEQUENCE  "WPP_SEQ"  MINVALUE 1 MAXVALUE 999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--婚攝結束

--後台開始
CREATE SEQUENCE SEQ_AD_ID;
CREATE SEQUENCE SEQ_ADM_ID;
CREATE SEQUENCE SEQ_FUNC_ID;
CREATE SEQUENCE SEQ_PTP_ID; 
--後台結束
--討論區開始
CREATE SEQUENCE FORUM_SEQ;
CREATE SEQUENCE FORUM_MES_SEQ;
--討論區結束

-- =============================================   
--時間格式
-- =============================================   
ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy-mm-dd';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'yyyy-mm-dd hh24:mi:ss';


-- =============================================    
-- 建立「會員」資料表
-- 用途：for管理員新增會員
-- =============================================    
	CREATE TABLE MEMBRE
	(
	MEMBRE_ID 	VARCHAR2(4) NOT NULL,
	MEM_NAME 	VARCHAR2(40),
	SEX 		CHAR(3),
	ADDRESS 	VARCHAR2(200),
	PHONE 		VARCHAR2(40),
	EMAIL 		VARCHAR2(100) NOT NULL,
	STATUS 		CHAR(1),
	COMPTE 		VARCHAR2(100)NOT NULL,
	PASSE 		VARCHAR2(100)NOT NULL,
	PHOTO 		BLOB,
	REGIS_TIME  	TIMESTAMP,
	
	CONSTRAINT MEMBRE_PK PRIMARY KEY (MEMBRE_ID)
	);
    

-- =============================================    
-- 建立「廠商」資料表
-- 用途：for管理員新增廠商
-- =============================================    
	CREATE TABLE VENDER
	(
	VENDER_ID 		VARCHAR2(4) NOT NULL,
	VEN_NAME 		VARCHAR2(120) NOT NULL,
	VEN_ADDR 		VARCHAR2(256),
	VEN_PHONE 		VARCHAR2(40) NOT NULL,
	VEN_CONTACT 		VARCHAR2(20),
	VEN_MAIL 		VARCHAR2(100) NOT NULL,
	IS_VAILD 		NUMBER(1),
	IS_ENABLE 		NUMBER(1),
	VEN_EVIDENCE_PIC 	BLOB,
	VEN_ACCOUNT 		VARCHAR2(100)NOT NULL,
	VEN_PWD 		VARCHAR2(100)NOT NULL,
	VEN_SPONSOR 		NUMBER(1),
	VEN_REGIS_TIME 		TIMESTAMP,
	VEN_REVIEW_COUNT 	NUMBER(3),
	VEN_STARS_TOTAL 	NUMBER(3),
	
	CONSTRAINT VENDER_PK PRIMARY KEY (VENDER_ID),
	UNIQUE (VEN_ACCOUNT)	
	);

    
-- =============================================    
-- 建立「禮車」資料表(廠商擁有車輛，單位為一台)
-- 用途：for廠商上架車子
-- =============================================    
	--禮車開始
	CREATE TABLE CAR
	(
	CID	   	VARCHAR2(6)   NOT NULL,
	VENDER_ID 	VARCHAR2(4)   NOT NULL,
	CBRAND   	VARCHAR2(120) NOT NULL,
	CMODEL		VARCHAR2(120) NOT NULL,
	CINTRO   	VARCHAR2(600) NOT NULL,
	CPRICE 		NUMBER(5,0)   NOT NULL,
	CADDTIME	TIMESTAMP,
	CSTATUS		NUMBER(1)     DEFAULT 1,
	
	CHECK (CPRICE > 0),
	CONSTRAINT CAR_PK PRIMARY KEY (CID),
	CONSTRAINT CAR_FK FOREIGN KEY (VENDER_ID) REFERENCES VENDER (VENDER_ID)
	);


-- =====================================      
-- 建立「禮車照片」資料表
-- 用途：for廠商上傳車子照片  
-- =====================================  

	CREATE TABLE CAR_PIC
	(
	CPIC_ID 	VARCHAR2(6) NOT NULL,
	CID	   	VARCHAR2(6) NOT NULL,
	C_PIC   	BLOB,
	
	CONSTRAINT CAR_PIC_PK PRIMARY KEY (CPIC_ID),
	CONSTRAINT CAR_PIC_FK FOREIGN KEY (CID) REFERENCES CAR (CID)
	);

-- =====================================      
-- 建立「禮車訂單」資料表
-- 用途：for廠商/客戶/後台管理員查看訂單
-- =====================================  

	CREATE TABLE CAR_ORDER
	(
	COD_ID		VARCHAR2(6) NOT NULL,
	MEMBRE_ID	VARCHAR2(4) NOT NULL,
	VENDER_ID	VARCHAR2(4) NOT NULL,
	CID		VARCHAR2(6) NOT NULL,
	COD_TIME	TIMESTAMP,
	CFINAL_PRICE	NUMBER(7,0) NOT NULL,
	CDEPOSIT	NUMBER(7,0) NOT NULL,
	CRETURN_PAY	NUMBER(7,0) NOT NULL,
	CNEED_DATE	DATE NOT NULL,	
	CRETURN_DATE	DATE NOT NULL,
	CSTART		VARCHAR2(300) NOT NULL,
	CDEST		VARCHAR2(300) NOT NULL,
	CREV_STAR	NUMBER(1),
	CREV_MSGS	VARCHAR2(300),
	CREV_TIME	TIMESTAMP,
	CPAY_STATUS	NUMBER(2) DEFAULT 0,	
	COD_STATUS	NUMBER(1) DEFAULT 1,
	CVR_STATUS	NUMBER(1) DEFAULT 0,
	CMR_STATUS	NUMBER(1) DEFAULT 0,
	CVR_DESC	VARCHAR2(500),
	CMR_DESC	VARCHAR2(500),
	CVR_RESULT	VARCHAR2(500),
	CMR_RESULT	VARCHAR2(500),
	

	CHECK (CFINAL_PRICE > 0),
	CHECK (CDEPOSIT > 0),
	CHECK (CRETURN_PAY > 0),

	CONSTRAINT CAR_ORDER_PK  PRIMARY KEY (COD_ID),
	CONSTRAINT CAR_ORDER_FK1 FOREIGN KEY(VENDER_ID) REFERENCES VENDER (VENDER_ID),
	CONSTRAINT CAR_ORDER_FK2 FOREIGN KEY(MEMBRE_ID) REFERENCES MEMBRE (MEMBRE_ID),
	CONSTRAINT CAR_ORDER_FK3 FOREIGN KEY(CID)       REFERENCES CAR (CID)
	);

-- =====================================  
-- 建立「禮車加購項目」資料表
-- 用途：for廠商上架加購品
-- =====================================  

	CREATE TABLE CAR_EXT
	(
	CEXT_ID 	VARCHAR2(6) NOT NULL,
	VENDER_ID	VARCHAR2(4) NOT NULL,
	CEXT_CAT_ID	NUMBER(1) NOT NULL,
	CEXT_NAME	VARCHAR2(120) NOT NULL,
	CEXT_PRICE	NUMBER(5,0) NOT NULL,
	CEXT_PIC 	BLOB,
    	CEXT_ADDTIME 	TIMESTAMP,
    	CEXT_STATUS	NUMBER(1) DEFAULT 0,
	
	CHECK (CEXT_PRICE > 0),
	CONSTRAINT CAR_EXT_PK PRIMARY KEY(CEXT_ID),
	CONSTRAINT CAR_EXT_FK FOREIGN KEY(VENDER_ID) REFERENCES VENDER (VENDER_ID)

	);

-- =====================================  
-- 建立「禮車訂單加購項目」資料表
-- 用途：for客戶選擇加購
-- =====================================  

	CREATE TABLE CAR_EXT_ORDER
	(
	CEXT_ID		VARCHAR2(6) NOT NULL,
	COD_ID		VARCHAR2(6) NOT NULL,

	CONSTRAINT CAR_EXT_ORDER_PK  PRIMARY KEY(CEXT_ID, COD_ID),
	CONSTRAINT CAR_EXT_ORDER_FK1 FOREIGN KEY(CEXT_ID) REFERENCES CAR_EXT (CEXT_ID),
	CONSTRAINT CAR_EXT_ORDER_FK2 FOREIGN KEY(COD_ID)  REFERENCES CAR_ORDER (COD_ID)
	);


-- =====================================   
-- 建立「禮車收藏清單」資料表
-- 用途：for會員收藏某廠商上架的禮車
-- =====================================  

    	CREATE TABLE CAR_COLLECT
	(
	CID 			VARCHAR2(6) NOT NULL,
	MEMBRE_ID 		VARCHAR2(4) NOT NULL,
	CONSTRAINT CAR_COLLECT_PK PRIMARY KEY (CID, MEMBRE_ID),
	CONSTRAINT CAR_COLLECT_FK1 FOREIGN KEY(CID) REFERENCES CAR (CID),
	CONSTRAINT CAR_COLLECT_FK2 FOREIGN KEY(MEMBRE_ID) REFERENCES MEMBRE (MEMBRE_ID)
	);
--禮車結束

--婚紗開始
--婚紗(1) table for dress case
CREATE TABLE DRESS_CASE (
    drcase_id VARCHAR2(6) NOT NULL,
    vender_id VARCHAR2(4) NOT NULL,
    drcase_na VARCHAR2(40) NOT NULL,
    drcase_br VARCHAR2(1000) NOT NULL,
    drcase_pr NUMBER(6) NOT NULL,
    drcase_st NUMBER(1) DEFAULT 1,
    CONSTRAINT PK_DRESS_CASE PRIMARY KEY (drcase_id),
    CONSTRAINT FK_DRESS_CASE FOREIGN KEY (VENDER_ID) REFERENCES VENDER (VENDER_ID)
);

CREATE SEQUENCE dressCase_seq;

--婚紗(2) table for dress_case_pic
CREATE TABLE DRESS_CASE_PIC (
    drpic_id VARCHAR2(6) NOT NULL,
    drcase_id VARCHAR2(6) NOT NULL,
    drpic BLOB,
    CONSTRAINT PK_DRESS_CASE_PIC PRIMARY KEY (drpic_id),
    CONSTRAINT FK_DRESS_CASE_PIC FOREIGN KEY (drcase_id) REFERENCES DRESS_CASE(drcase_id)
);

CREATE SEQUENCE dressCasePic_seq;

--婚紗(3) table for dress_case_track

CREATE TABLE DRESS_CASE_TRACK(
    drcase_id VARCHAR2(6) NOT NULL,
    membre_id VARCHAR2(4) NOT NULL,
    
    CONSTRAINT F1_DRESS_CASE__TRACK FOREIGN KEY (drcase_id) REFERENCES DRESS_CASE(drcase_id),
    CONSTRAINT F2_DRESS_CASE__TRACK FOREIGN KEY (membre_id) REFERENCES MEMBRE(membre_id),
    CONSTRAINT PK_DRESS_CASE_TRACK PRIMARY KEY (drcase_id,membre_id)
);


--婚紗(4) table for dress_add_type
CREATE TABLE DRESS_ADD_TYPE(
    dradd_type VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_DRESS_ADD_TYPE PRIMARY KEY (dradd_type)
);

--婚紗(5) table for dress_add_on
CREATE TABLE DRESS_ADD_ON (
    dradd_id VARCHAR2(6) NOT NULL,
    vender_id VARCHAR2(4) NOT NULL,
    dradd_type VARCHAR2(20) NOT NULL,
    dradd_na VARCHAR2(40) NOT NULL,
    dradd_pr NUMBER(5) NOT NULL,
    dradd_st NUMBER(1) DEFAULT 1,
    
    CONSTRAINT PK_DRESS_ADD_ON PRIMARY KEY (dradd_id),
    CONSTRAINT F1_DRESS_ADD_ON FOREIGN KEY (vender_id) REFERENCES VENDER(vender_id),
    CONSTRAINT F2_DRESS_ADD_ON FOREIGN KEY (dradd_type) REFERENCES DRESS_ADD_TYPE(dradd_type)
);
CREATE SEQUENCE dressAddON_seq;

--婚紗(6) table for dress_order

CREATE TABLE DRESS_ORDER (
    drord_id VARCHAR2(6) NOT NULL,
    membre_id VARCHAR2(4) NOT NULL,
    vender_id VARCHAR2(4) NOT NULL,
    drord_time TIMESTAMP NOT NULL,
    drord_pr NUMBER(6) NOT NULL,
    drord_depo NUMBER(6) NOT NULL,
    drord_ini NUMBER(6) NOT NULL,
    drord_pay_st NUMBER(1) DEFAULT 0,
    drord_fin_st NUMBER(1) DEFAULT 1,
    dr_mrep_st NUMBER(1) DEFAULT 0,
    dr_vrep_st NUMBER(1) DEFAULT 0,
    dr_mrep_de VARCHAR2(500),
    dr_vrep_de VARCHAR2(500),
    dr_mrep_res VARCHAR2(500),
    dr_vrep_res VARCHAR2(500),
    dr_rev_star NUMBER(1),
    dr_rev_con VARCHAR2(300),
    
    CONSTRAINT PK_DRESS_ORDER PRIMARY KEY (drord_id),
    CONSTRAINT F1_DRESS_ORDER FOREIGN KEY (membre_id) REFERENCES MEMBRE(membre_id),
    CONSTRAINT F2_DRESS_ORDER FOREIGN KEY (vender_id) REFERENCES VENDER(vender_id)
);
CREATE SEQUENCE dressOrder_seq;

--婚紗(7) table for order_detail
CREATE TABLE DRESS_ORDER_DETAIL (
    drde_id VARCHAR2(6) NOT NULL ,
    drord_id VARCHAR2(6) NOT NULL,
    drcase_id VARCHAR2(6) NOT NULL,
    drde_st NUMBER(1) DEFAULT 0,
    drcase_totpr NUMBER(6) NOT NULL,
    CONSTRAINT PK_DRESS_ORDER_DETAIL PRIMARY KEY (drde_id),
    CONSTRAINT F1_DRESS_ORDER_DETAIL FOREIGN KEY (drord_id) REFERENCES DRESS_ORDER(drord_id),
    CONSTRAINT F2_DRESS_ORDER_DETAIL FOREIGN KEY (drcase_id) REFERENCES DRESS_CASE(drcase_id)
);

CREATE SEQUENCE dressDetail_seq;


--婚紗(8) table for dress_add_order
CREATE TABLE DRESS_ADD_ORDER(
    dradd_id VARCHAR2(6) NOT NULL,
    drde_id VARCHAR2(6) NOT NULL,
   
    CONSTRAINT PK_DRESS_ADD_ORDER PRIMARY KEY (dradd_id,drde_id),   
    CONSTRAINT F1_DRESS_ADD_ORDER FOREIGN KEY (dradd_id) REFERENCES DRESS_ADD_ON(dradd_id),
    CONSTRAINT F2_DRESS_ADD_ORDER FOREIGN KEY (drde_id) REFERENCES DRESS_ORDER_DETAIL(drde_id)
);
--婚紗結束

--婚攝開始
/*****************************************
*        婚攝方案 WED_PHOTO_CASE          *
*****************************************/
CREATE TABLE "WED_PHOTO_CASE" 
(
    "WED_PHOTO_CASE_NO" VARCHAR2(6 BYTE) NOT NULL, 
    "VENDER_ID" VARCHAR2(4 BYTE) NOT NULL, 
    "WED_PHOTO_NAME" VARCHAR2(60 BYTE) NOT NULL, 
    "WED_PHOTO_INTRO" VARCHAR2(1500 BYTE) NOT NULL, 
    "WED_PHOTO_PRICE" NUMBER(6,0) NOT NULL, 
    "WED_PHOTO_ADDTIME" TIMESTAMP,
    "WED_PHOTO_STATUS" NUMBER(1,0) DEFAULT 0,

    CONSTRAINT WPCASE_PK PRIMARY KEY (WED_PHOTO_CASE_NO),
    CONSTRAINT WPCASE_FK FOREIGN KEY (VENDER_ID) REFERENCES VENDER (VENDER_ID)
);
/*****************************************
*   婚攝訂單明細 WED_PHOTO_ORDER_DETAIL    *
*****************************************/
CREATE TABLE "WED_PHOTO_ORDER_DETAIL" 
(
    "WED_PHOTO_ORDER_NO" VARCHAR2(6 BYTE) NOT NULL, 
    "WED_PHOTO_CASE_NO" VARCHAR2(6 BYTE) NOT NULL,

    CONSTRAINT WPODETAIL_PK PRIMARY KEY (WED_PHOTO_ORDER_NO, WED_PHOTO_CASE_NO),    
    CONSTRAINT WPODETAIL_FK2 FOREIGN KEY (WED_PHOTO_CASE_NO) REFERENCES WED_PHOTO_CASE (WED_PHOTO_CASE_NO)
); 
/*****************************************
*        婚攝訂單 WED_PHOTO_ORDER         *
*****************************************/
CREATE TABLE "WED_PHOTO_ORDER" 
(
    "WED_PHOTO_ORDER_NO" VARCHAR2(6 BYTE) NOT NULL, 
    "MEMBRE_ID" VARCHAR2(4 BYTE) NOT NULL, 
    "VENDER_ID" VARCHAR2(4 BYTE) NOT NULL, 
    "FILMING_TIME" TIMESTAMP (6) NOT NULL, 
    "WED_PHOTO_ODTIME" TIMESTAMP (6) NOT NULL, 
    "ORDER_STATUS" NUMBER(1,0) DEFAULT 1, 
    "ORDER_EXPLAIN" VARCHAR2(600 BYTE) , 
    "REVIEW_STAR" NUMBER(1,0), 
    "REVIEW_CONTENT" VARCHAR2(600 BYTE), 
    "WP_PAY_S" NUMBER(2,0) DEFAULT 0, 
    "WP_VREP_S" NUMBER(1,0) DEFAULT 0, 
    "WP_MREP_S" NUMBER(1,0) DEFAULT 0, 
    "WP_VREP_D" VARCHAR2(500 BYTE), 
    "WP_MREP_D" VARCHAR2(500 BYTE),      
    "WP_VREP_R" VARCHAR2(500 BYTE),
    "WP_MREP_R" VARCHAR2(500 BYTE),

    CONSTRAINT WPORDER_PK PRIMARY KEY (WED_PHOTO_ORDER_NO),
    CONSTRAINT WPORDER_FK1 FOREIGN KEY(VENDER_ID) REFERENCES VENDER (VENDER_ID),
    CONSTRAINT WPORDER_FK2 FOREIGN KEY(MEMBRE_ID) REFERENCES MEMBRE (MEMBRE_ID)    
); 
ALTER TABLE WED_PHOTO_ORDER_DETAIL ADD CONSTRAINT WPODEATAL_FK1 FOREIGN KEY(WED_PHOTO_ORDER_NO) REFERENCES WED_PHOTO_ORDER(WED_PHOTO_ORDER_NO);
/*****************************************
*     收藏婚攝方案 WED_PHOTO_COLLECT       *
*****************************************/
CREATE TABLE "WED_PHOTO_COLLECT" 
(
    "WED_PHOTO_CASE_NO" VARCHAR2(6 BYTE) NOT NULL, 
    "MEMBRE_ID" VARCHAR2(4 BYTE) NOT NULL,
    
    CONSTRAINT WPCOLLECT_PK PRIMARY KEY (WED_PHOTO_CASE_NO, MEMBRE_ID),
    CONSTRAINT WPCOLLECT_FK1 FOREIGN KEY(WED_PHOTO_CASE_NO) REFERENCES WED_PHOTO_CASE (WED_PHOTO_CASE_NO),
    CONSTRAINT WPCOLLECT_FK2 FOREIGN KEY(MEMBRE_ID) REFERENCES MEMBRE (MEMBRE_ID)
);
/*****************************************
*         婚攝圖片 WED_PHOTO_IMG          *
*****************************************/
CREATE TABLE "WED_PHOTO_IMG" 
(
    "WED_PHOTO_IMGNO" VARCHAR2(6 BYTE), 
    "WED_PHOTO_CASE_NO" VARCHAR2(6 BYTE), 
    "WED_PHOTO_IMG" BLOB,
    
    CONSTRAINT WPIMG_PK PRIMARY KEY (WED_PHOTO_IMGNO),
    CONSTRAINT WPIMG_FK FOREIGN KEY (WED_PHOTO_CASE_NO) REFERENCES WED_PHOTO_CASE (WED_PHOTO_CASE_NO)
); 
--婚攝結束

--後台開始
 --========================================================--
 
 CREATE TABLE AD (
 AD_ID    VARCHAR2(20)NOT NULL PRIMARY KEY,
 AD_PIC   BLOB,
 AD_DETAIL VARCHAR2(1000) NOT NULL,
 AD_START_TIME TIMESTAMP NOT NULL,
 AD_END_TIME TIMESTAMP NOT NULL
 );
 
 --========================================================--

CREATE TABLE ADM (
ADM_ID VARCHAR2(20)NOT NULL PRIMARY KEY,
ADM_ACCOUNT VARCHAR2(50) NOT NULL,
ADM_PWD VARCHAR2(20) NOT NULL,
ADM_NAME VARCHAR2(20) NOT NULL,

UNIQUE (ADM_ACCOUNT)	
);

 --========================================================--
 
 CREATE TABLE ADM_FUNC (
 FUNC_ID      VARCHAR2(20)NOT NULL PRIMARY KEY,
 FUNC_NAME    VARCHAR2(50)NOT NULL,
 FUNC_SWITCH  NUMBER(1)NOT NULL
 );
 
 --====================================================================--
 
 CREATE TABLE PINTHEPOST (
 PTP_ID          VARCHAR2(20)NOT NULL PRIMARY KEY,
 PTP_DETAIL       VARCHAR2(1000) NOT NULL,
 PTP_SUBJECT     VARCHAR2(50) NOT NULL,
 PTP_DATE        TIMESTAMP NOT NULL
  );
                                                          
--========================================================--

CREATE TABLE ADM_PER (
 ADM_ID     VARCHAR2(20)NOT NULL,
 FOREIGN KEY (ADM_ID) REFERENCES ADM(ADM_ID),
 FUNC_ID      VARCHAR2(20)NOT NULL,
 FOREIGN KEY (FUNC_ID) REFERENCES ADM_FUNC(FUNC_ID)
 );
 --後臺結束
 
 --商城開始
create table prod_order(
order_no varchar2(5),
membre_id varchar2(4),
total number(10)not null,
order_date timestamp not null,
ship_date timestamp,
order_status char(1),
primary key (order_no),
foreign key (membre_id) references membre(membre_id)
);

create sequence order_seq;

create table prod_type (
type_no varchar2(4) primary key,
type_name varchar2(100) not null
);

create table prod (
prod_no varchar2(4) not null,
membre_id varchar2(4) not null,
type_no varchar2(4),
price number(8) ,
prod_qty number(4),
prod_name varchar2(100),
prod_status char(1),
sale_time timestamp,

check (price>0),
check (prod_qty>=0),
 primary key(prod_no),
 foreign key(type_no) references prod_type(type_no)
);

create sequence prod_seq;

create table prod_pic (
pic_no number(4) not null,
prod_no varchar2(4) not null,
pic blob,
primary key (pic_no),
foreign key(prod_no) references prod(prod_no)
);

create sequence pic_seq;

create table order_detail (
order_no varchar2(5) ,
prod_no varchar2(4), 
order_qty number(4) not null,
check(order_qty>0),
primary key(order_no, prod_no),
foreign key(order_no) references prod_order(order_no),
foreign key(prod_no) references prod (prod_no)
);

create table buy_list(
prod_no varchar2(4),
membre_id varchar2(4),
primary key (prod_no, membre_id),
foreign key (prod_no) references prod(prod_no),
foreign key (membre_id) references membre(membre_id)
);
--商城結束
--討論區開始
CREATE TABLE FORUM(
forum_id varchar2(10) NOT NULL PRIMARY KEY,
membre_id varchar2(4),
FORUM_CLASS varchar2(15) NOT NULL,
FORUM_TITLE varchar2(60) NOT NULL,
FORUM_CONTENT CLOB NOT NULL,
FORUM_ADDTIME timestamp,
foreign key (membre_id) references membre(membre_id)
);

CREATE TABLE FORUM_MES(
forum_mes_id varchar2(10) NOT NULL PRIMARY KEY,
membre_id varchar2(4),
forum_id varchar2(10),
mes_text CLOB NOT NULL,
MES_ADDTIME timestamp,
foreign key (membre_id) references membre(membre_id),
foreign key (forum_id) references forum(forum_id)
);
--討論區結束

-- =============================================    
-- 新建資料開始
-- ============================================= 
-- 新增「會員」資料(M004-M009:婚紗)
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), 'Nezuko', '女', '日本東京', '094565456', 'Nezuko@gmail.com', '1', 'Nezuko@gmail.com', 'Nezuko', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), 'Tanjiro', '男', '日本名古屋', '098978978', 'Tanjiro@gmail.com', '1', 'Tanjiro@gmail.com', 'Tanjiro', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), 'Zenitsu', '男', '日本大阪', '091233211', 'Zenitsu@gmail.com', '0', 'Zenitsu@gmail.com', 'Zenitsu', sysdate);

insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '洪小玲', '女', '台北信義區', '0911222333', 'ling@gamil.com', '0', 'ling', 'ling', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '洪大明', '男', '台中向上路', '0800000000', 'smonkey@gamil.com', '0', 'smonkey', 'smonkey', sysdate);

insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '林朝章', '男', '新北板橋區', '0912345678', 'mingdow@gamil.com', '0', 'mingdow', 'mingdow', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '程虹喬', '女', '台北信義區', '0921987654', 'hongchiao@gamil.com', '0', 'hongchiao', 'hongchiao', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '林書宏', '男', '台中北區', '0800010000', 'shuhong@gamil.com', '0', 'shuhong', 'shuhong', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time) values
('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '鄭茵聲', '女', '台北信義區', '0911222555', 'yingsheng@gamil.com', '0', 'yingsheng', 'yingsheng', sysdate);

insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time)
values('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '孫語涵', '女', '新北新莊', '0945645720', 'wed0803030@wedphoto.com.tw', '0', 'test4561', 'test456', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time)
values('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '安子晴', '女', '台中北區', '0989120520', 'wed0803031@wedphoto.com.tw', '0', 'test4562', 'test456', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time)
values('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '趙苡薰', '女', '桃園蘆竹', '0948521321', 'wed0803032@wedphoto.com.tw', '0', 'test4564', 'test456', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time)
values('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '胡毓昕', '女', '高雄三民', '0921447823', 'wed0803032@wedphoto.com.tw', '0', 'test4565', 'test456', sysdate);
insert into membre(membre_id, mem_name, sex, address, phone, email, status, compte, passe, regis_time)
values('M'|| LPAD(TO_CHAR(MEMBRE_SEQ.NEXTVAL),3,'0'), '田宥潔', '女', '台南中西', '0930678921', 'wed0803032@wedphoto.com.tw', '0', 'test4566', 'test456', sysdate);

--新增「廠商」資料
--1、2、4、8、10是禮車
--3、5、6、7、9是婚紗
--11~15是婚攝
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '1314一生一世專業禮車租借', '台北市信義區市府路45號', '02-664-9917', '黃穎筑', 'donna22@bosco.biz', 1, 1,'century1314', 'qweqwe', 0, CURRENT_TIMESTAMP, 30, 130);
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '幸福久久結婚禮車','桃園市大園區三民路二段95號', '0973-318-520', '李經理', 'happiness99@happy.com.tw', 1, 1,'happiness99', '1qaz1qaz', 0, CURRENT_TIMESTAMP, 20, 66 );
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'),'Mr.Warmth工作室','高雄市前鎮區幸福一路300號', '0930-653-273', '張經理', 'warmth@gmail.com', 1, 1, 'warmth', 'warmth', 0, CURRENT_TIMESTAMP, 4, 19 );
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '123結婚禮車','台南市新興路278巷(近台南火車站)', '06-269-9852', '吳先生', '123carrental@cr.com.tw', 1, 1,'cr123', 'cr123', 0, CURRENT_TIMESTAMP, 55, 200 );
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '第五大道工作室','桃園市平鎮區中央路100號', '0919-138-520', '郭專員', 'fifthAvenue@gmail.com', 1, 1, 'fifthAvenue', 'fifthAvenue', 0, CURRENT_TIMESTAMP, 4, 18 );
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '西服紳士','台中市台灣大道四段一號', '0966-754-663', '王專員', 'gentleSuit@gmail.com', 1, 1, 'gentleSuit', 'gentleSuit', 0, CURRENT_TIMESTAMP, 2, 9 );
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'),'Diana手工婚紗', '台北市信義區基隆路三段一號', '02-2571-2175', '林專員', 'dianaWed@gmail.com', 1, 1,'dianaWed', 'dianaWed', 0, CURRENT_TIMESTAMP, 5, 23);
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), 'pro專業結婚禮車','台中市市政北七路95號', '0961-314-520', '陳沛羽', 'wedpro9487@wed.com.tw', 1, 1,'wedpro9487', 'wedpro9487', 0, CURRENT_TIMESTAMP, 25, 70 );
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '中式旗袍工作室','台南市北門路五段一號', '0921-678-142', '陳經理', 'chinWed@gmail.com', 1, 1,'chinWed', 'chinWed', 0, CURRENT_TIMESTAMP, 3, 13 );
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '囍洋洋結婚禮車','新北市中和區廣福路53巷16號', '02-8245-2566', '蔡副理', 'love4ever@happy.com.tw', 1, 1,'love4ever', 'love4ever', 0, CURRENT_TIMESTAMP, 30, 100 );

INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '奔跑少年影像事務所', '新北市板橋區民生路二段240巷23號', '02-7728-3610#1754', '吳小姐', 'Runningboy@wedphoto.com.tw', 1, 1, 'test1231', 'test123', 0, to_date('2019-11-30 10:31:22','yyyy-mm-dd hh24:mi:ss'), 20, 91);
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), '無風格映像紀錄','台南市東區裕農路121巷2弄7號2F', '02-7728-3610#8208', '戴小姐', 'nostyle99@wedphoto.com.tw', 1, 1,'test1232', 'test123', 0, to_date('2020-01-21 13:51:31','yyyy-mm-dd hh24:mi:ss'), 21, 84);
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), 'Pon-Pon Photography','台中市南屯區永春路60-7號', '02-7728-3610#9173', '楊先生', 'ponponph@wedphoto.com.tw', 1, 1,'test1233', 'test123', 0, to_date('2020-02-21 11:46:07','yyyy-mm-dd hh24:mi:ss'), 12, 49);
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), 'J-Love 婚禮攝影團隊','台北市中山區復興北路290號16樓', '02-7728-3610#5726', '陳先生', 'jlove@wedphoto.com.tw', 1, 1, 'test1234', 'test123', 0, to_date('2020-04-08 20:22:13','yyyy-mm-dd hh24:mi:ss'), 9, 37);
INSERT INTO VENDER(VENDER_ID, VEN_NAME, VEN_ADDR, VEN_PHONE, VEN_CONTACT, VEN_MAIL, IS_VAILD, IS_ENABLE, VEN_ACCOUNT, VEN_PWD, VEN_SPONSOR, VEN_REGIS_TIME, VEN_REVIEW_COUNT, VEN_STARS_TOTAL)  
VALUES ('V'|| LPAD(TO_CHAR(VENDER_SEQ.NEXTVAL),3,'0'), 'RT 映像工作室','台中市大雅區德勝路493號-7號', '02-7728-3610#1996', '康先生', 'rtRichie@wedphoto.com.tw', 1, 1, 'test1235', 'test123', 0, to_date('2020-06-03 09:05:08','yyyy-mm-dd hh24:mi:ss'), 17, 66);


-- 新增「禮車」資料
INSERT INTO CAR(CID, VENDER_ID, CBRAND, CMODEL, CINTRO, CPRICE, CADDTIME, CSTATUS) 
        VALUES ('WCC'|| LPAD(TO_CHAR(CAR_SEQ.NEXTVAL),3,'0'),'V001' , 'BENZ', 'E200', '賓士中階商務車型的代表，中大型房車，後座寬敞，外表洗鍊簡潔，方便新娘穿婚紗上下車，適合作為主禮車(新娘車)或前導車。', '4000',  CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR(CID, VENDER_ID, CBRAND, CMODEL, CINTRO, CPRICE, CADDTIME, CSTATUS)  
        VALUES ('WCC'|| LPAD(TO_CHAR(CAR_SEQ.NEXTVAL),3,'0'),'V001' , 'BMW', '520i', '寶馬經典系列之一，精緻奢華與前衛設計更顯品味獨具，後座寬敞舒適，適合作為前導車或主禮車(新娘車)。', 4000,  CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR(CID, VENDER_ID, CBRAND, CMODEL, CINTRO, CPRICE, CADDTIME, CSTATUS) 
        VALUES ('WCC'|| LPAD(TO_CHAR(CAR_SEQ.NEXTVAL),3,'0'),'V001' , 'Rolls-Royce', 'Ghost', '英國豪華車品牌，Ghost為勞斯萊斯目前新款車型，千萬級豪華轎車，後座空間舒適寬敞適合作為主禮車(新娘車)。', '45000',  CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR(CID, VENDER_ID, CBRAND, CMODEL, CINTRO, CPRICE, CADDTIME, CSTATUS) 
        VALUES ('WCC'|| LPAD(TO_CHAR(CAR_SEQ.NEXTVAL),3,'0'),'V002' , 'BENZ', 'S350', '賓士高階商務車型的代表，大型房車，外型大氣高端，後座空間舒適寬敞，適合作為主禮車(新娘車)。', '5500',  CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR(CID, VENDER_ID, CBRAND, CMODEL, CINTRO, CPRICE, CADDTIME, CSTATUS) 
        VALUES ('WCC'|| LPAD(TO_CHAR(CAR_SEQ.NEXTVAL),3,'0'),'V002' , 'BMW', '740Li', '寶馬經典系列之一，高端商務的代表，後座空間舒適寬敞，外型大氣穩重，是為主禮車(新娘車)的不二人選。', '10000',  CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR(CID, VENDER_ID, CBRAND, CMODEL, CINTRO, CPRICE, CADDTIME, CSTATUS)  
        VALUES ('WCC'|| LPAD(TO_CHAR(CAR_SEQ.NEXTVAL),3,'0'),'V002' , 'Bentley', 'Flying Spur', '英國豪華車品牌，豪門人士的首選，千萬級豪華轎車，素有「移動豪宅」的稱號。後座空間舒適寬敞，外型霸氣大方，適合作為主禮車(新娘車)的唯一首選。', '25000',  CURRENT_TIMESTAMP, '0' );     
INSERT INTO CAR(CID, VENDER_ID, CBRAND, CMODEL, CINTRO, CPRICE, CADDTIME, CSTATUS) 
        VALUES ('WCC'|| LPAD(TO_CHAR(CAR_SEQ.NEXTVAL),3,'0'),'V002' , 'Toyota', 'Alphard', '商務級別中老闆車的代表，寬敞的乘客空間，大器的外觀，內部保有私密空間，讓新人可優雅的上下車與獨享新婚的愉悅。適合做為主禮車(新娘車)。', '45000',  CURRENT_TIMESTAMP, '0' );


-- 新增「禮車加購項目」資料
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 1, '車頭彩·泰迪熊', '600', CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
            VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 1, '車頭彩·HelloKitty', '300', CURRENT_TIMESTAMP, '0');
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
            VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 2, '車門手把花(粉)/四入1組', '100', CURRENT_TIMESTAMP, '0');
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 3, '司機代駕費用/日', '2000', CURRENT_TIMESTAMP, '0');
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 4, '甘蔗竹子吸盤固定架/台', '450', CURRENT_TIMESTAMP, '0');
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V002', 2, '車門手把花(大紅)/四入1組', '120', CURRENT_TIMESTAMP, '0');
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V002', 2, '車門手把花(紅金)/四入1組', '150', CURRENT_TIMESTAMP, '0');
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 1, '車頭彩·米奇米妮(粉)', '480', CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 1, '車頭彩·米奇米妮(紅)', '480', CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 1, '車頭彩·米飛兔', '660', CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V001', 1, '車頭彩·彩紅色玫瑰', '300', CURRENT_TIMESTAMP, '0' );
INSERT INTO CAR_EXT(CEXT_ID, VENDER_ID, CEXT_CAT_ID, CEXT_NAME, CEXT_PRICE, CEXT_ADDTIME, CEXT_STATUS) 
	    VALUES ('WCA'|| LPAD(TO_CHAR(CAR_EXT_SEQ.NEXTVAL),3,'0') , 'V002', 3, '司機代駕費用/日', '1500', CURRENT_TIMESTAMP, '0');

--禮車假資料結束

--婚紗假資料開始
--(1)insert dress case
INSERT INTO DRESS_CASE VALUES
('WDC'|| LPAD(TO_CHAR(dressCase_seq.NEXTVAL),3,'0'),'V005',
'義式純白手工婚紗','義式純白手工婚紗，設計師取經自米蘭，以細緻手工打造歐美系高級訂製禮服，納入時尚之都的百年文化古典蕾絲元素，
成就經典不敗的婚紗印象。

【方案內容】
一套義式純白手工婚紗，讓您在婚禮上感受來自義大利溫暖熱情的氣息。
簡單高雅的設計襯托出您獨一無二的氣質，方案價已包含試穿後可能的修改費用。
',35000,1);

INSERT INTO DRESS_CASE VALUES
('WDC'||LPAD(TO_CHAR(dressCase_seq.NEXTVAL),3,'0'),'V006','英倫紳士西服',
'以深厚的西服訂做底子起家，同時追求頂尖時尚、不斷精進創新，設計出挺拔正式、低調奢華、兼具顧客需求與時尚的男仕西服。
講究版型契合度，任何身型的新郎都能展現出自己的個人風格。

【方案內容】
一套英倫風西裝與皮鞋，在試穿時，讓我們幫您找出最適合您的西裝與皮鞋的尺寸。
若希望在婚禮時更能展現雄風，可在下訂時另外加購我們的鞋墊，尺寸有s,m,l,xl號。
方案價已包含試穿後可能的修改費用。
',6000,1);
INSERT INTO DRESS_CASE VALUES
('WDC'||LPAD(TO_CHAR(dressCase_seq.NEXTVAL),3,'0'),'V003','維納斯款柔膚拖尾禮服',
'上半身到下半身的裙體流暢，紗質透膚又輕柔，古典刺繡蕾絲的高質感設計讓您輕鬆驚艷全場。亮橘色的禮服讓您彷彿將春天的喜悅穿在身上。

【方案內容】
一套維納斯款春系柔膚拖尾禮服。
因此款禮服胸前較低，需自備nubra，或在下訂時一起加購我們的nubra，
尺寸分為s,m,l,xl號，可在試穿禮服時與我們確認最適合的尺寸。
方案價已包含試穿後可能的修改費用。
',18000,1);

INSERT INTO DRESS_CASE VALUES
('WDC'||LPAD(TO_CHAR(dressCase_seq.NEXTVAL),3,'0'),'V007','法式浪漫雪紡禮服',
'A-line 裙尾設計，典雅大方又莊重，帶點雪紡的紗軟材質，適合氣質路線的新娘們。胸前的蕾絲服貼細緻，顯現出您的好曲線!

【方案內容】
一套法式浪漫純白雪紡禮服，可在下訂時，另外加購我們上架的”公主系花環頭飾”。
方案價已包含試穿後可能的修改費用。
',23000,1);
INSERT INTO DRESS_CASE VALUES
('WDC'||LPAD(TO_CHAR(dressCase_seq.NEXTVAL),3,'0'),'V009','傳統中式婚紗禮服',
'方案簡介：
想要有跟Angelababy及黃曉明一樣的婚禮效果嗎 ?
還是想要在完成人生終身大事時，有著四爺和若曦的中式效果呢 ?

【方案內容】
一套中式傳統婚紗，附有髮簪、內部襯衣與鞋子。
原價20000，疫情特價15000，還在等什麼呢？
方案價已包含試穿後可能的修改費用。
',
15000,1);

INSERT INTO DRESS_CASE VALUES
('WDC'||LPAD(TO_CHAR(dressCase_seq.NEXTVAL),3,'0'),'V007','輕婚紗',
'方案簡介：買一件輕婚紗去旅行已經成了趨勢，不想再帶著一件件沉甸甸的婚紗去旅行。

沒有走過一趟，妳怎麼知道未來會發生甚麼事?您可以選擇讓Diana手工婚紗陪著妳與愛人去旅行。

【方案內容】
一套純白輕婚紗，可在下訂時，可另外加購我們上架的”公主系花環頭飾”與”歐式紅玫瑰捧花”。

方案價已包含試穿後可能的修改費用。
',
8500,1);

--(2)insert dressCasepic(改由developOnly.java灌入圖片)

--(3)insert dressCaseTrack
INSERT INTO DRESS_CASE_TRACK VALUES('WDC001','M001');
INSERT INTO DRESS_CASE_TRACK VALUES('WDC002','M002');
INSERT INTO DRESS_CASE_TRACK VALUES('WDC003','M003');

--(4)insert dressAddType
INSERT INTO DRESS_ADD_TYPE VALUES('nubra');
INSERT INTO DRESS_ADD_TYPE VALUES('捧花');
INSERT INTO DRESS_ADD_TYPE VALUES('頭飾');
INSERT INTO DRESS_ADD_TYPE VALUES('鞋墊');
INSERT INTO DRESS_ADD_TYPE VALUES('其他');

--(5)insert dressAddOn
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V003','nubra','s號nubra',500,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V003','nubra','m號nubra',600,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V003','nubra','l號nubra',700,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V003','nubra','xl號nubra',800,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V007','捧花','歐式紅玫瑰捧花',2800,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V007','頭飾','公主系花環頭飾',880,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V006','鞋墊','s號紳士鞋墊',500,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V006','鞋墊','m號紳士鞋墊',550,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V006','鞋墊','l號紳士鞋墊',600,1);
INSERT INTO DRESS_ADD_ON VALUES('WDA'||LPAD(TO_CHAR(dressAddON_seq.NEXTVAL),3,'0'),'V006','鞋墊','xl號紳士鞋墊',650,1);

--(6)insert dressOrder
INSERT INTO DRESS_ORDER (drord_id,membre_id,vender_id,drord_time,drord_pr,drord_depo,drord_ini,drord_pay_st,drord_fin_st,
dr_mrep_st,dr_vrep_st,dr_mrep_de,dr_vrep_de,dr_mrep_res,dr_vrep_res,dr_rev_con,dr_rev_star)
VALUES('WDO'||LPAD(TO_CHAR(dressOrder_seq.NEXTVAL),3,'0'),'M004','V007',CURRENT_TIMESTAMP,25800,7740,7740,0,5,0,0,
'未檢舉','未檢舉','未檢舉','未檢舉','真的很謝謝這間廠商，從一開始的預約試穿，到試穿，再到最後的歸還禮服，幾乎完全無法挑剔!
感謝當初朋友的介紹，一個好的婚紗廠商真的能省下不少時間與精力。過來人的經驗，一定要大力推薦給你們！',5);

INSERT INTO DRESS_ORDER (drord_id,membre_id,vender_id,drord_time,drord_pr,drord_depo,drord_ini,drord_pay_st,drord_fin_st,
dr_mrep_st,dr_vrep_st,dr_mrep_de,dr_vrep_de,dr_mrep_res,dr_vrep_res,dr_rev_con,dr_rev_star)
VALUES('WDO'||LPAD(TO_CHAR(dressOrder_seq.NEXTVAL),3,'0'),'M004','V007',CURRENT_TIMESTAMP,35180,10554,10554,0,5,0,0,
'未檢舉','未檢舉','未檢舉','未檢舉','趨近於完美的租賃體驗，從頭到尾廠商都很細心的回答任何問題，時間上也都很準時，大力給推!',5);

INSERT INTO DRESS_ORDER (drord_id,membre_id,vender_id,drord_time,drord_pr,drord_depo,drord_ini,drord_pay_st,drord_fin_st,
dr_mrep_st,dr_vrep_st,dr_mrep_de,dr_vrep_de,dr_mrep_res,dr_vrep_res,dr_rev_con,dr_rev_star)
VALUES('WDO'||LPAD(TO_CHAR(dressOrder_seq.NEXTVAL),3,'0'),'M005','V006',CURRENT_TIMESTAMP,6600,1980,1980,0,5,0,0,
'未檢舉','未檢舉','未檢舉','未檢舉','這次租賃的是男士西裝，不得不說英倫紳士真的是第一首選！假設重來一次，我一定還是會選這間廠商。',5);

--0908更新：新增三筆假資料
INSERT INTO DRESS_ORDER (drord_id,membre_id,vender_id,drord_time,drord_pr,drord_depo,drord_ini,drord_pay_st,drord_fin_st,
dr_mrep_st,dr_vrep_st,dr_mrep_de,dr_vrep_de,dr_mrep_res,dr_vrep_res,dr_rev_con,dr_rev_star)
VALUES('WDO'||LPAD(TO_CHAR(dressOrder_seq.NEXTVAL),3,'0'),'M004','V003',CURRENT_TIMESTAMP,18000,5400,5400,0,5,0,0,
'未檢舉','未檢舉','未檢舉','未檢舉','這次真的很開心，沒想到一切的租賃過程都是這麼順利，跟廠商之間的一切溝通都蠻不錯的。',5);

INSERT INTO DRESS_ORDER (drord_id,membre_id,vender_id,drord_time,drord_pr,drord_depo,drord_ini,drord_pay_st,drord_fin_st,
dr_mrep_st,dr_vrep_st,dr_mrep_de,dr_vrep_de,dr_mrep_res,dr_vrep_res,dr_rev_con,dr_rev_star)
VALUES('WDO'||LPAD(TO_CHAR(dressOrder_seq.NEXTVAL),3,'0'),'M004','V005',CURRENT_TIMESTAMP,35000,10500,10500,0,5,0,0,
'未檢舉','未檢舉','未檢舉','未檢舉','當初透過朋友的介紹，發現這間超棒的廠商，從頭到尾的服務態度都非常好，沒有收了錢就態度大轉變的情況。',5);

INSERT INTO DRESS_ORDER (drord_id,membre_id,vender_id,drord_time,drord_pr,drord_depo,drord_ini,drord_pay_st,drord_fin_st,
dr_mrep_st,dr_vrep_st,dr_mrep_de,dr_vrep_de,dr_mrep_res,dr_vrep_res,dr_rev_con,dr_rev_star)
VALUES('WDO'||LPAD(TO_CHAR(dressOrder_seq.NEXTVAL),3,'0'),'M006','V009',CURRENT_TIMESTAMP,15000,4500,4500,0,5,0,0,
'未檢舉','未檢舉','未檢舉','未檢舉','現在中式傳統旗袍的婚紗工作室其實不多，我們找了很久才找到這間工作室，但非常值回票價！',5);

--(7)insert orderDetail
--第一筆訂單只有一個訂單明細
INSERT INTO DRESS_ORDER_DETAIL VALUES('WDD'||LPAD(TO_CHAR(dressDetail_seq.NEXTVAL),3,'0'),'WDO001','WDC004',0,25800);
--第二筆訂單有兩個訂單明細
INSERT INTO DRESS_ORDER_DETAIL VALUES('WDD'||LPAD(TO_CHAR(dressDetail_seq.NEXTVAL),3,'0'),'WDO002','WDC004',0,23880);
INSERT INTO DRESS_ORDER_DETAIL VALUES('WDD'||LPAD(TO_CHAR(dressDetail_seq.NEXTVAL),3,'0'),'WDO002','WDC006',0,11300);
--第三筆訂單只有一個訂單明細
INSERT INTO DRESS_ORDER_DETAIL VALUES('WDD'||LPAD(TO_CHAR(dressDetail_seq.NEXTVAL),3,'0'),'WDO003','WDC002',0,6600);
--第四筆訂單只有一個訂單明細
INSERT INTO DRESS_ORDER_DETAIL VALUES('WDD'||LPAD(TO_CHAR(dressDetail_seq.NEXTVAL),3,'0'),'WDO004','WDC003',0,18000);
--第五筆訂單只有一個訂單明細
INSERT INTO DRESS_ORDER_DETAIL VALUES('WDD'||LPAD(TO_CHAR(dressDetail_seq.NEXTVAL),3,'0'),'WDO005','WDC001',0,35000);
--第六筆訂單只有一個訂單明細
INSERT INTO DRESS_ORDER_DETAIL VALUES('WDD'||LPAD(TO_CHAR(dressDetail_seq.NEXTVAL),3,'0'),'WDO006','WDC005',0,15000);

--(8)insert dressAddOrder
INSERT INTO DRESS_ADD_ORDER VALUES('WDA005','WDD001');
INSERT INTO DRESS_ADD_ORDER VALUES('WDA006','WDD002');
INSERT INTO DRESS_ADD_ORDER VALUES('WDA005','WDD003');
INSERT INTO DRESS_ADD_ORDER VALUES('WDA009','WDD004');

--婚紗假資料結束
--婚攝假資料開始
/*****************************************
*      INSERT「方案」假資料  CASE          *
*****************************************/
INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V011', '【奔跑少年】雙機平面婚攝-單宴客★', 
 '服務時間4hr
●視內容400-1500張風格修圖照片
●時間允許可拍攝類婚紗
●USB*1+外裝盒*1 
【注意事項】
●若開拍時間早於8:00，晚於22:00將酌收加時費。
●台北市免收車馬費(除文山區、北投區)
●其餘外縣市車馬費實報實銷', 18000, to_date('2019-12-21 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V011', '【奔跑少年】雙機平面婚攝-全天★', 
 '全天: 08:00-22:00
●儀式前一小時開拍，最早為8點
●視內容400-1500張風格修圖照片
●時間允許可拍攝類婚紗
●USB*1+外裝盒*1 
【注意事項】
●若開拍時間早於8:00，晚於22:00將酌收加時費。
●台北市免收車馬費(除文山區、北投區)
●其餘外縣市車馬費實報實銷 ', 28000, to_date('2019-12-21 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V011', '【奔跑少年】雙機婚禮錄影-單宴客★',
'單宴客:4hr
●交件為精華版和完整版各一組
●若有簡單儀式需另外加價
●USB*1+外裝盒*1 
【注意事項】
●若開拍時間早於8:00，晚於22:00將酌收加時費
●台北市免收車馬費(除文山區、北投區)
●其餘外縣市車馬費實報實銷

【攝影師的小貼心】
為什麼要雙機動態錄影或是雙機平面主攝影師拍攝？

1.可以安排新郎/新娘雙兩地拍攝。
2.可拍攝同一時間軸上更多主流程外的畫面。
3.儀式過程擁有更多鏡位讓畫面更流暢豐富。', 32000, to_date('2019-12-21 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V011', '【奔跑少年】雙機婚禮錄影-全天★',
'全天:08:00-22:00
●交件為精華版和完整版各一組
●不限定儀式項目數
●USB*1+外裝盒*1 
【注意事項】
●儀式前一小時開拍，開拍時間最早為8點
●若開拍時間早於8:00，晚於22:00將酌收加時費
●台北市免收車馬費(除文山區、北投區)
●其餘外縣市車馬費實報實銷

【攝影師的小貼心】
為什麼要雙機動態錄影或是雙機平面主攝影師拍攝？

1.可以安排新郎/新娘雙兩地拍攝。
2.可拍攝同一時間軸上更多主流程外的畫面。
3.儀式過程擁有更多鏡位讓畫面更流暢豐富。', 42000, to_date('2019-12-21 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V012', '『無風格映像』兩天?單機 平面',
'午宴：08:00-16:00｜晚宴：17:00-22:00

?儀式前半小時或一小時開拍，最早為8點
(早上8點前抵達拍攝，一位攝影師需酌收費用 一小時NT$1000)
?午宴晚於16:00需酌收加時費，晚宴晚於22:00需酌收加時費

成品
?視內容400-1500張修圖照片(調色、對比、亮度，不包含去背、修臉、修瘦等工作)
?時間允許可拍攝類婚紗
?成品:檔案全贈(視容量需自備USB或加購)(會先把閉眼、曝光等NG照先刪掉，其餘拍攝照片全贈)
?木盒*1+相本*1+USB*1 ', 21000, to_date('2020-02-11 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V012', '『無風格映像』兩天?單機 錄影',
'午宴：08:00-16:00｜晚宴：17:00-22:00

?儀式前半小時或一小時開拍，最早為8點
(早上8點前抵達拍攝，一位攝影師需酌收費用 一小時NT$1000)
?午宴晚於16:00需酌收加時費，晚宴晚於22:00需酌收加時費

成品
?精華版影片*1
?完整版影片*1
?成品:檔案全贈(視容量需自備USB或加購)
?木盒*1+桌框*1+USB*1 ', 26000, to_date('2020-02-11 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V012', '『無風格映像』兩天?雙機 一平一錄',
'午宴：08:00-16:00｜晚宴：17:00-22:00

?儀式前半小時或一小時開拍，最早為8點
(早上8點前抵達拍攝，一位攝影師需酌收費用 一小時NT$1000)
?午宴晚於16:00需酌收加時費，晚宴晚於22:00需酌收加時費

成品
?視內容400-1500張修圖照片(調色、對比、亮度，不包含去背、修臉、修瘦等工作)
?時間允許可拍攝類婚紗
?成品:照片全贈(視容量需自備USB或加購)(會先把閉眼、曝光等NG照先刪掉，其餘拍攝照片全贈)
?精華版影片*1 (3-6分鐘-視內容調整)
?完整版影片*1 (1小時-2小時-視內容調整)
?成品:影片全贈(影片檔案較大需自備USB或加購)
?木盒*1+相本*1+USB*1 ', 37000, to_date('2020-02-11 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V012', '『無風格映像』兩天?雙機 錄影',
'午宴：08:00-16:00｜晚宴：17:00-22:00

?儀式前半小時或一小時開拍，最早為8點
(早上8點前抵達拍攝，一位攝影師需酌收費用 一小時NT$1000)
?午宴晚於16:00需酌收加時費，晚宴晚於22:00需酌收加時費

成品
?精華版影片*1
?完整版影片*1
?成品:檔案全贈(視容量需自備USB或加購)
?木盒*1+桌框*1+USB*1 ', 34000, to_date('2020-02-11 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V012', '『無風格映像』兩天?三機 一平雙錄',
'午宴：08:00-16:00｜晚宴：17:00-22:00

?儀式前半小時或一小時開拍，最早為8點
(早上8點前抵達拍攝，一位攝影師需酌收費用 一小時NT$1000)
?午宴晚於16:00需酌收加時費，晚宴晚於22:00需酌收加時費

成品
?視內容400-1500張修圖照片(調色、對比、亮度，不包含去背、修臉、修瘦等工作)
?時間允許可拍攝類婚紗
?成品:照片全贈(視容量需自備USB或加購)(會先把閉眼、曝光等NG照先刪掉，其餘拍攝照片全贈)
?精華版影片*1 (3-6分鐘-視內容調整)
?完整版影片*1 (1小時-2小時-視內容調整)
?成品:影片全贈(影片檔案較大需自備USB或加購)
?木盒*1+相本*1+USB*1 ', 45000, to_date('2020-02-11 13:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V013', '?Pon Pon? 單宴客/單儀式?',
'在相愛的過程裡 你們選擇了用影像記錄當下
讓我來把這份美好 幫你們好好的保留下來吧~

婚禮裡總是有很多的細節 這些細節都很值得被記錄、被保存
歡迎一起來共同「記錄美好」 

單宴客/單儀式 $12800

成品內容：當日儀式/宴客過程記錄檔案收入精美木質USB*1，皮革烙印寫真書一本，約收入80-100張精選。
都會拍攝全家福，類婚紗只要在時間可以的情況下都會拍攝！！ ',
12800,to_date('2020-03-17 15:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V013', '?Pon Pon? 單儀式+午宴?',
'在相愛的過程裡 你們選擇了用影像記錄當下
讓我來把這份美好 幫你們好好的保留下來吧~

婚禮裡總是有很多的細節 這些細節都很值得被記錄、被保存
歡迎一起來共同「記錄美好」 

單儀式（訂婚/迎娶）+午宴 $15800

成品內容：當日儀式/宴客過程記錄檔案收入精美木質USB*1，皮革烙印寫真書一本，約收入80-100張精選。
都會拍攝全家福，類婚紗只要在時間可以的情況下都會拍攝！！ ',
15800, to_date('2020-03-17 15:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V013', '?Pon Pon? 單儀式+晚宴?',
'在相愛的過程裡 你們選擇了用影像記錄當下
讓我來把這份美好 幫你們好好的保留下來吧~

婚禮裡總是有很多的細節 這些細節都很值得被記錄、被保存
歡迎一起來共同「記錄美好」 

單儀式（訂婚/迎娶）+晚宴 $16800

成品內容：當日儀式/宴客過程記錄檔案收入精美木質USB*1，皮革烙印寫真書一本，約收入80-100張精選。
都會拍攝全家福，類婚紗只要在時間可以的情況下都會拍攝！！ ',
16800, to_date('2020-03-17 15:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V013', '?Pon Pon? 雙儀式+午宴?',
'在相愛的過程裡 你們選擇了用影像記錄當下
讓我來把這份美好 幫你們好好的保留下來吧~

婚禮裡總是有很多的細節 這些細節都很值得被記錄、被保存
歡迎一起來共同「記錄美好」 

雙儀式（訂婚+迎娶）+午宴 $17800

成品內容：當日儀式/宴客過程記錄檔案收入精美木質USB*1，皮革烙印寫真書一本，約收入80-100張精選。
都會拍攝全家福，類婚紗只要在時間可以的情況下都會拍攝！！ ',
17800, to_date('2020-03-17 15:51:31','yyyy-mm-dd hh24:mi:ss'));

INSERT INTO wed_photo_case
(wed_photo_case_no, vender_id, wed_photo_name, wed_photo_intro, wed_photo_price,wed_photo_addtime)
VALUES ('WPC' || lpad(WPC_SEQ.NEXTVAL, 3, '0'), 'V013', '?Pon Pon? 雙儀式+晚宴?',
'在相愛的過程裡 你們選擇了用影像記錄當下
讓我來把這份美好 幫你們好好的保留下來吧~

婚禮裡總是有很多的細節 這些細節都很值得被記錄、被保存
歡迎一起來共同「記錄美好」 

雙儀式（訂婚+迎娶）+晚宴 $18800 

成品內容：當日儀式/宴客過程記錄檔案收入精美木質USB*1，皮革烙印寫真書一本，約收入80-100張精選。
都會拍攝全家福，類婚紗只要在時間可以的情況下都會拍攝！！ ',
18800, to_date('2020-03-17 15:51:31','yyyy-mm-dd hh24:mi:ss'));

/*****************************************
*      INSERT「訂單」假資料  ORDER          *
*****************************************/
--WP_ORDER
INSERT INTO wed_photo_order(wed_photo_order_no,membre_id,vender_id,filming_time,wed_photo_odtime,order_explain)
VALUES('WPO' || lpad(WPO_SEQ.NEXTVAL, 3, '0'),'M010','V011',to_date('2020-09-17 20:20:20','yyyy-mm-dd hh24:mi:ss'),
sysdate,'訂單備註test1');

INSERT INTO wed_photo_order(wed_photo_order_no,membre_id,vender_id,filming_time,wed_photo_odtime,order_explain)
VALUES('WPO' || lpad(WPO_SEQ.NEXTVAL, 3, '0'),'M004','V011',to_date('2020-02-18 20:20:20','yyyy-mm-dd hh24:mi:ss'),
sysdate,'訂單備註test2');

INSERT INTO wed_photo_order(wed_photo_order_no,membre_id,vender_id,filming_time,wed_photo_odtime,order_explain)
VALUES('WPO' || lpad(WPO_SEQ.NEXTVAL, 3, '0'),'M009','V012',to_date('2020-02-19 20:20:20','yyyy-mm-dd hh24:mi:ss'),
sysdate,'訂單備註test3');

--WP_ORDERDETAIL
INSERT INTO wed_photo_order_detail(wed_photo_order_no, wed_photo_case_no)VALUES('WPO001','WPC001');
INSERT INTO wed_photo_order_detail(wed_photo_order_no, wed_photo_case_no)VALUES('WPO002','WPC004');
INSERT INTO wed_photo_order_detail(wed_photo_order_no, wed_photo_case_no)VALUES('WPO003','WPC007');
--婚攝假資料結束

---------後台開始--------------

--後臺管理員新增
INSERT INTO ADM(ADM_ID, ADM_ACCOUNT, ADM_PWD, ADM_NAME)
	VALUES ('ADM'|| LPAD(SEQ_ADM_ID.NEXTVAL, 3,'0'),'a0908280731@gmail.com','123','劉先生');

 --後台權限功能新增
 INSERT INTO ADM_FUNC(FUNC_ID,FUNC_NAME, FUNC_SWITCH) 
	VALUES ('FUNC'||LPAD(SEQ_FUNC_ID.NEXTVAL,3 ,'0'),
	'終極權限','1');
 INSERT INTO ADM_FUNC(FUNC_ID,FUNC_NAME, FUNC_SWITCH) 
	VALUES ('FUNC'||LPAD(SEQ_FUNC_ID.NEXTVAL,3 ,'0'),
	'後台登入權限','1');
 INSERT INTO ADM_FUNC(FUNC_ID,FUNC_NAME, FUNC_SWITCH) 
	VALUES ('FUNC'||LPAD(SEQ_FUNC_ID.NEXTVAL,3 ,'0'),
	'廠商審核','1');
 INSERT INTO ADM_FUNC(FUNC_ID,FUNC_NAME, FUNC_SWITCH) 
	VALUES ('FUNC'||LPAD(SEQ_FUNC_ID.NEXTVAL,3 ,'0'),
	'訂單管理,封鎖廠商','1');
    
--後台權限增加
 INSERT INTO ADM_PER(ADM_ID, FUNC_ID)
 VALUES ('ADM001','FUNC001');
 INSERT INTO ADM_PER(ADM_ID, FUNC_ID)
 VALUES ('ADM001','FUNC002');
 INSERT INTO ADM_PER(ADM_ID, FUNC_ID)
 VALUES ('ADM001','FUNC003');
 INSERT INTO ADM_PER(ADM_ID, FUNC_ID)
 VALUES ('ADM001','FUNC004');
 
 
 --後台置頂                 
 INSERT INTO pinthepost(PTP_ID, PTP_DETAIL, PTP_SUBJECT, PTP_DATE) 
	VALUES ('PTP'|| LPAD(SEQ_PTP_ID.NEXTVAL,3 ,'0'),'禮車方案','禮車',sysdate);
 INSERT INTO pinthepost(PTP_ID, PTP_DETAIL, PTP_SUBJECT, PTP_DATE)
	VALUES ('PTP'|| LPAD(SEQ_PTP_ID.NEXTVAL,3 ,'0'),'婚紗方案','婚紗',sysdate);
 INSERT INTO pinthepost(PTP_ID, PTP_DETAIL, PTP_SUBJECT, PTP_DATE)
	VALUES ('PTP'|| LPAD(SEQ_PTP_ID.NEXTVAL,3 ,'0'),'婚攝方案','婚攝',sysdate);

--後台廣告
    INSERT INTO AD(AD_ID, AD_DETAIL, AD_START_TIME, AD_END_TIME) 
        VALUES ('AD'|| LPAD(SEQ_AD_ID.NEXTVAL,3 ,'0'),'wedding_photo',sysdate,sysdate);
    INSERT INTO AD(AD_ID, AD_DETAIL, AD_START_TIME, AD_END_TIME) 
        VALUES ('AD'|| LPAD(SEQ_AD_ID.NEXTVAL,3 ,'0'),'wedding_photo',sysdate,sysdate);
    INSERT INTO AD(AD_ID, AD_DETAIL, AD_START_TIME, AD_END_TIME) 
        VALUES ('AD'|| LPAD(SEQ_AD_ID.NEXTVAL,3 ,'0'),'wedding_photo',sysdate,sysdate);
    INSERT INTO AD(AD_ID, AD_DETAIL, AD_START_TIME, AD_END_TIME) 
        VALUES ('AD'|| LPAD(SEQ_AD_ID.NEXTVAL,3 ,'0'),'wedding_photo',sysdate,sysdate);
    INSERT INTO AD(AD_ID, AD_DETAIL, AD_START_TIME, AD_END_TIME) 
        VALUES ('AD'|| LPAD(SEQ_AD_ID.NEXTVAL,3 ,'0'),'wedding_photo',sysdate,sysdate);
   INSERT INTO AD(AD_ID, AD_DETAIL, AD_START_TIME, AD_END_TIME) 
        VALUES ('AD'|| LPAD(SEQ_AD_ID.NEXTVAL,3 ,'0'),'wedding_photo',sysdate,sysdate);  
     
   
 
 
---------後台結束--------------

--商城假資料開始
insert into prod_type values('T001', '手提包');
insert into prod_type values('T002', '服飾');
insert into prod_type values('T003', '書籍');
insert into prod_type values('T004', '3C產品');
insert into prod_type values('T005', '鞋類');
insert into prod_type values('T010', '其他');
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T001', 20000, 2, 'Prada', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T002', 300, 10, '黑色素T', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T003', 350, 2, '休婚', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T004', 3000, 5, 'Airpods', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T005', 500, 4, '透氣餅乾鞋', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T005', 600, 4, '帆布鞋', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T005', 700, 4, '小白鞋', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T002', 350, 3, '短裙', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
insert into prod values('P'|| LPAD(TO_CHAR(PROD_SEQ.NEXTVAL),3,'0'), 'M001', 'T002', 400, 3, '荷葉領上衣', '1', to_date('2020-02-20 20:20:20','yyyy-mm-dd hh24:mi:ss'));
--商城假資料結束

--討論區資料開始

--TABLE FORUM
INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M001', '禮車',
'如何租禮車', ' 結婚了還在為結婚禮車煩惱嗎？找「嫁給我結婚禮車出租」就對了', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M001', '禮車',
'有網友租過新娘禮車嗎?',
'有網友能推薦新娘禮車公司嗎?朋友要娶媳婦，這是我第一次接這種任務，男方不願意麻煩朋友。因為指定要賓士，
只需要一小時即可，新房和婆家只距一條街之隔，實在太近了，租車是含司機和一切車外佈置嗎?需要給司機紅包嗎?感謝幫忙', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M002', '婚紗',
'如何租婚紗', ' 結婚了還在為婚紗煩惱嗎？找「非常婚紗」就對了', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M002', '婚紗',
'婚紗挑選與試穿~經驗分享', 
'話說我和先生在今年已經登記結婚，

因為想存錢買房，所以原本打算婚紗照和宴客都pass~

殊不知女性長輩們聽到後都表示反對，苦口婆心的勸：怎麼可以不拍婚紗？

所以和先生討論後就同意花個錢，有個美好的體驗也不錯。

話說這次找的婚紗工作室是同事介紹的，當初打動我的點是：「價格透明，不會亂加價。」

於是進行線上預約，開始了第一次的洽詢。

第一次接待我們的是Annie，除了談拍攝內容之外，

當然婚紗有沒有符合我們的風格也很重要！

因此詢問了能否看看婚紗。因為當天下午沒有其他客人，Annie就讓我先試了三件

 (給大家參考，我159cm，55kg)：

體會到專業的婚紗顧問很重要，

因為自己原本喜歡的樣式，不一定會適合自己的體型和氣質唷！

還是要親自試穿才能找到適合自己的禮服唷  

順帶一提，挑婚紗和試婚紗的當下，真的 心   情    超    好！！

因為試穿的體驗很滿意，所以就下訂啦！', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M003', '婚攝',
'如何安排婚攝', ' 結婚了還在為婚禮攝影煩惱嗎？找「珍愛婚攝團隊」就對了', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M003', '婚攝',
'不能錯過爆CP值婚攝的十個理由',
'【理由一-找對了人什麼都對了】

立勤的個人風格鮮明，特質溫暖、重視承諾、注意細節、性格誠懇、體貼細心，合作上令人感到舒服無壓力，聽說也是個好老公跟老爸爸，讓人感到放心。
        
【理由二-一切給新人方便就對了】

在忙碌操辦婚事的當下，立勤將一切事先溝通的流程簡化，舉凡簽約、需求、風格…等等，聯繫上也是會依照新人方便的時間進行溝通，一次性的就將婚禮當天所需注意的事項跟互相配合的部分交待清楚，不囉嗦，簽約也只透過電子郵件的方式不造成新人須格外花費時間面談，因為立勤是個全臺跑透透的婚攝，所以我們訂結婚的場地他早就拍過了，反而都比我們都還要清楚環境的狀況還有拍照的好點，真的很超值。

【理由三-注重細節心思細膩就對了】

仔細看立勤拍的作品，有很多意想不到的角度但卻有絕佳的效果，例如:從走廊的那頭拍到尾端坐著等待迎娶的新娘呈現出一種時間的長度、從房內拍到探頭來找新娘的新郎呈現出的靦腆不安及羞澀感、從車窗口拍到在新娘車上的新娘頭紗內的離別感、在新房內取景新郎掀起新娘頭紗的喜悅感，不僅僅是拍攝紀錄活動當下的景象，更把這當中的情感透過鏡頭記錄下來了。

【理由四-收費合理一口價不囉嗦就對了】

儀式加宴客，包含事前的討論與事後的成品寄送，車馬費與額外拍攝的類婚紗及親友互動創意照，全包。

【理由五-態度敬業作品專業就對了】

攝影師的角度就是跟我們一般拿手機拍拍照的角度不一樣，專業之所以為專業就是用他的那臺相機跟我們手上的手機，拍起來就是不一樣。

【理由六-會帶氣氛引導新人與親友就對了】

對於我們兩家都是第一次嫁娶的來說，很多婚禮當下的細節都需要被提醒，而立勤婚攝的經驗豐富，所以有種兼著當控場人員的感覺，都會適時的提醒接下來的流程跟注意事項，感覺像跟團的導遊一樣，跟著他走就對了，還有笑話可以聽，還有好康可以拿。

【理由七-照片量大檔案全送就對了】

一天下來的畫面都讓立勤手上的相機給鉅細靡遺的記錄下來了，給照片不手軟不藏私，除了那種眼睛閉閉跟試光線的照片以外，全給!全都給!張數也是出乎原本契約的多出快要兩倍的量~除了搶先開放線上讓新人下載外，還用精美木質紋的USB裝起來供實體收納。

【理由八-趁婚禮空檔拍攝類婚紗寫真就對了】

還有什麼可以比這件事情有更高的CP值了?快狠準的在婚禮進行中，趁縫插針的來個兩人小世界，不拖泥帶水的在兩套禮服換裝間就完成了類婚紗拍攝~

【理由九-拿到高質感的婚禮寫真本就對了】

在結束兵荒馬亂的婚禮之後，約略一個月內會收到一本由立勤編排的婚禮寫真本，對我們而言這本是最超值的部分，可以拿給沒有機會參與我們婚禮的長輩們看，也可以拿給見證我們幸福的長輩們回味，自己也不斷的翻閱了好幾次，看見自己的故事。

【理由十-把新娘紙拍瘦就對了】

其實新娘從小就屬肉肉型妹紙

所以當立勤用單手舉起重重的單眼邀我們自拍的時候

效果意外美妙的將肉新娘拍瘦瘦，讓新娘很尬意!', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M004', '交流提問',
'終於來到挑片這一天了！視覺流感婚紗攝影',
'終於來到這一天

因為沒有很認真在減肥

所以很怕出來的成果會胖胖

還好成品非常讚

看完都要心花怒放了', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M004', '交流提問',
'婚禮感覺不是自己的...',
'我們家人跟男方家人都是大台北市區的人

8月初時男方跟我的家人一起吃過飯了，男方家長在飯局上表示：現在年輕人很有自己的想法，想怎麼辦就讓他們去辦。我家人聽完之後也都說：好，就給年輕人自己決定。

之前就跟男友討論過想省下錢去度蜜月，就想要登記而已，一開始跟我媽提她也說好，她會去說服我爸，結果被我爸說 這是我們家的事情?

結果在雙方吃完飯後我們兩個想過，如果一定要辦的話，最低限度就是一場，想要辦成西式的婚禮（簡化的），就大家吃吃飯開開心心這樣就好，不要一些其餘的儀式。

我就某天晚上試探一下我媽的意思，她聽完整個大怒，說什麼 大餅小餅呢，為什麼你們什麼都要省略呢？？這樣以後吃虧的是你自己 這種話，還說男方怎麼沒有送大鑽鑽的戒指，

我是覺得沒有必要要有哪些繁文縟節，也沒有必要買一個鑽戒放在家裡積灰塵。我媽還說要訂結兩場，沒有人沒訂婚就結婚的。我就在想說 雙方都在北部，又不是一方在南部才需要辦兩場?唉.....

感覺在餐桌上說的都只是表面，為什麼不直說只有日期讓你們自己決定這種話，真的覺得頭很痛?', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M005', '婚禮心事',
'伴娘惹毛我',
' 婚禮前一天

我幫伴娘們找好飯店並且付好費用

想說隔天避免大家舟車勞頓來參加迎娶

結果某位伴娘

說要帶男友(她男友我不熟，她也沒有事先問我可以不可以)

就說能否再幫她訂一間

訂一間就算了

她居然打算扣掉自己的錢(也就是我原本幫她付的房間錢)

然後只貼差額給我...

我整個火大

當下也跟她表明我不高興的點

結果她還說我冤枉她

她只是想帶男友來幫忙而已

還說我是不是婚前憂鬱壓力很大

這麼容易暴怒。

-----------------------------

於是我就請她也不用來當伴娘了

這種朋友我真的不敢恭維!', SYSDATE);

INSERT INTO FORUM(FORUM_ID, MEMBRE_ID, FORUM_CLASS,
FORUM_TITLE, FORUM_CONTENT, FORUM_ADDTIME)
VALUES ('F'|| LPAD(TO_CHAR(FORUM_SEQ.NEXTVAL),3,'0'), 'M005', '婚禮心事',
'好想不結婚了',
'跟男友交往了7年決定要結婚了，最近在籌備婚禮時我和男友都覺得迎娶當天禮車同色系或同款式會比較整齊好看，

但男友的爸爸知道我們想租禮車後，就很直接的跟我說能省則省啊不需要租吧！然後又問了我們餐廳訂了嗎，在訂不到就路邊隨便辦一辦結ㄧ結就好啊！

當下聽到這些話心裡真的很不好受，覺得也很不尊重我父母，畢竟我也是爸媽辛苦拉拔長大的孩子', SYSDATE);


--========================================================--
--TABLE FORUM_MES
INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M001', 'F001', '你好,請問費用怎麼算呢', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M002', 'F002',
'之前有問過格上，他們是出新款S350 三小時3000（含司機不含司機紅包）忘記問有沒有含車彩，好像行情價也是這樣
給你參考看看', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M002', 'F002',
'費用大部份都是司機+車囉
紅包另外算
要包多少隨你500~1000即可
不包.......可能司機臉會臭到不行吧
除非事先已含在費用內
這些費用跟業主問一下即可知道
1個小時其實網路找台順眼、價格OK即可
一些細節就自己要注意囉
像要不要指定司穿西裝等等
另外車外佈置怎麼個佈置法？不就綁帶子而已？
這種事朋友幫忙一下就好
記得如果是新娘車車頭彩記的四周包的膠帶
免得刮花別人的車！', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M003', 'F003', '你好,請問費用怎麼算呢', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M004', 'F004',
'看起來真的很讚耶，果然挑對廠商跟跟對老師一樣重要', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M005', 'F005', '你好,請問費用怎麼算呢', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M006', 'F006',
'多謝分享，已收藏', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M007', 'F007',
'好看好美?', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M008', 'F008',
'拍拍
12345
我跟你遇到的一模一樣

後來詢問長輩 他們覺得「本來就應該這樣做」 所以也沒特別說

我後來用一招

訂結分開辦兩場他們要付錢的話就照辦

結果就被長輩同意同一天一場就好

別人的錢都不是錢', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M009', 'F009',
'還有辦法更換人嗎 如果不行也只能認了!

就當一場婚禮其中一件小事情看透一個朋友也是很值得的', SYSDATE);

INSERT INTO FORUM_MES(FORUM_MES_ID, MEMBRE_ID, FORUM_ID, MES_TEXT, MES_ADDTIME)
VALUES ('MES'|| LPAD(TO_CHAR(FORUM_MES_SEQ.NEXTVAL),3,'0'), 'M010', 'F010',
'首先幫您先拍拍哦～籌備婚禮的過程非常繁瑣又會遇到很多鳥事，心情難免大受影響，此時隊友很重要哦！
對於隊友爸媽的意見，您可以請隊友去溝通協調，過程中有任何不愉快，最好找人訴說，不要委屈自己或獨自難過哦！加油?', SYSDATE);

--討論區資料結束

COMMIT;
    
