DROP TABLE DATING_USER CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_ADMIN CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_PLACE CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_DIAMOND CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_PLACE_TIMETABLE CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_PLACE_CURRENTTIMETABLE CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_CONNECTION CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_RESERVATION CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_USER CASCADE CONSTRAINTS PURGE;
DROP TABLE DATING_TRANSACTION CASCADE CONSTRAINTS PURGE;



CREATE TABLE dating_user(
	usernum number(10) PRIMARY KEY,
	userid varchar2(300) NOT NULL,
	userpw varchar2(300) NOT NULL,
	username varchar2(300) NOT NULL,
	userage NUMBER(3) NOT NULL,
	userbirthday DATE NOT NULL,
	useredustatus varchar2(300) NOT NULL,
	userjobstatus varchar2(300),
	userphone varchar2(300) NOT NULL,
	usergender varchar2(1) NOT NULL,
	useremail varchar2(300) NOT NULL,
	usermbti varchar2(4) NOT NULL,
	userpersonality varchar2(1000) NOT NULL,
	userhobby varchar2(1000) NOT NULL,
	userdiamond number(5) NOT NULL,
	userjoindate DATE DEFAULT SYSDATE NOT NULL, 
	userregion varchar2(300) NOT NULL
);

CREATE TABLE dating_transaction(
	transnum number(10) PRIMARY KEY,
	usernum number(10),
	transwon number(8) NOT NULL,
	transdia number(5) NOT NULL,
	transdate DATE DEFAULT SYSDATE NOT NULL,
	CONSTRAINT fk_user_transaction FOREIGN KEY(usernum)
	REFERENCES dating_user(usernum) ON DELETE CASCADE 
);

CREATE TABLE dating_diamond( --사용자가 다이아를 사용한 기록을 저장
	dianum number(10) PRIMARY KEY,
	usernum number(10),
	diausedate DATE DEFAULT SYSDATE NOT NULL,
	CONSTRAINT fk_user_diamond FOREIGN KEY(usernum)
	REFERENCES dating_user(usernum) ON DELETE CASCADE 
);

CREATE TABLE dating_admin(
	adminnum number(10) PRIMARY KEY,	
	adminid varchar2(300) NOT NULL,
	adminpw varchar2(300) NOT NULL,
	adminname varchar2(300) NOT NULL,
	adminjoindate DATE DEFAULT sysdate NOT NULL	
);

CREATE TABLE dating_manager(
	managernum number(10) PRIMARY KEY,
	managerid varchar2(300) NOT NULL,
	managerpw varchar2(300) NOT NULL,
	managername varchar2(300) NOT NULL,
	managerjoindate DATE DEFAULT sysdate NOT NULL	
);




CREATE TABLE dating_chat( --.질문 . can there be multiple foreign keys pointing to the same column
--in the same table?  yes.
	chatnum number(10) PRIMARY KEY,
	chatsender NUMBER(10) NOT NULL,
	chatreceiver NUMBER(10) NOT NULL,
	chattime DATE DEFAULT sysdate NOT NULL,
	chatcontent varchar2(3000) NOT NULL,
	CONSTRAINT fk_user_chat_sender FOREIGN KEY(chatsender)
	REFERENCES dating_user(usernum) ON DELETE CASCADE, 
	CONSTRAINT fk_user_chat_receiver FOREIGN KEY(chatreceiver)
	REFERENCES dating_user(usernum) ON DELETE CASCADE 
);

CREATE TABLE dating_place(
	placenum number(10) PRIMARY KEY,
	managernum number(10) NOT NULL,
	placename varchar2(300) NOT NULL,
	placeregion varchar2(300) NOT NULL,
	placepostcode varchar2(300) NOT NULL,
	placeroadaddr varchar2(300) NOT NULL,
	placejibunaddr varchar2(300) NOT NULL,
	placedetailaddr varchar2(300) NOT NULL,
	placeetcaddr varchar2(300) NOT NULL,
	CONSTRAINT fk_place_manager FOREIGN KEY(managernum)
	REFERENCES dating_manager(managernum) ON DELETE CASCADE 	
);
----------------------------여기서부터 좀 check 하기. 살짝 오류 많을수도.
CREATE TABLE dating_place_timetable(
	placenum number(10) NOT NULL,
	timetable_weekday varchar2(300) NOT NULL, --어느 요일의 시간표를 나타낼건지를 표시
	timetable_capacity number(3) NOT NULL,
	timetable_timestring varchar2(300) NOT NULL,
	CONSTRAINT fk_timetable_place FOREIGN KEY(placenum)
	REFERENCES dating_place(placenum) ON DELETE CASCADE 	
);

CREATE TABLE dating_place_currenttimetable(
	placenum number(10) NOT NULL,
	curtimetable_date DATE NOT NULL,
	curtimetable_weekday varchar2(300) NOT NULL,
	curtimetable_timenum number(2) NOT NULL,
	curtimetable_capacity number(3) NOT NULL,
	CONSTRAINT fk_curtimetable_place FOREIGN KEY(placenum)
	REFERENCES dating_place(placenum) ON DELETE CASCADE
);


CREATE TABLE dating_connection(
	connnum number(10) NOT NULL PRIMARY KEY,
	connsender number(10) NOT NULL,
	connreceiver number(10) NOT NULL,
	connstatus varchar2(300) NOT NULL,
	CONSTRAINT fk_user_connection_receiver FOREIGN KEY(connreceiver)
	REFERENCES dating_user(usernum) ON DELETE CASCADE,
	CONSTRAINT fk_user_connection_sender FOREIGN KEY(connsender)
	REFERENCES dating_user(usernum) ON DELETE CASCADE
);


CREATE TABLE dating_reservation(
	resnum NUMBER(10) PRIMARY KEY,
	connnum number(10) NOT NULL,
	placenum number(10) NOT NULL,
	restime number(2) NOT NULL,	
	CONSTRAINT fk_connection_reservation FOREIGN KEY(connnum)
	REFERENCES dating_connection(connnum) ON DELETE CASCADE,
	CONSTRAINT fk_place_reservation FOREIGN KEY(placenum)
	REFERENCES dating_place(placenum) ON DELETE CASCADE
);









