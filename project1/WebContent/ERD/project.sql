SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS member;




/* Create Tables */

CREATE TABLE board
(
	btype int NOT NULL COMMENT '게시판 구분
1 : 공지사항
2 : 지역문화탐색
3 : 정보나눔',
	num int NOT NULL AUTO_INCREMENT,
	area varchar(100),
	category varchar(100) NOT NULL,
	period_from date NOT NULL,
	period_to date,
	subject varchar(100) NOT NULL,
	content varchar(4000),
	coordinate varchar(500),
	readcnt int NOT NULL,
	regdate date NOT NULL,
	imgfile varchar(20),
	id varchar(20) NOT NULL,
	PRIMARY KEY (num)
);


CREATE TABLE comment
(
	nickname varchar(20) NOT NULL,
	content varchar(1000),
	seq int NOT NULL,
	regdate date,
	id varchar(20) NOT NULL,
	num int NOT NULL,
	cnum int NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (cnum)
);


CREATE TABLE member
(
	kbn int NOT NULL COMMENT '회원구분
1 : 일반회원
2 : 기관회원
3: 관리자',
	lv int NOT NULL COMMENT '회원레벨
1 : 신규회원
2 : 일반회원
3 : 기관회원
4 : 관리자',
	id varchar(20) NOT NULL,
	pass varchar(20) NOT NULL,
	nickname varchar(20) NOT NULL,
	email varchar(100) NOT NULL,
	area varchar(100),
	birth varchar(50),
	name varchar(20),
	comp varchar(100),
	hobby varchar(500),
	regdate date NOT NULL,
	apply int NOT NULL COMMENT '0 : 등업 미신청
1 : 등업 신청
2 : 등업 완료',
	PRIMARY KEY (id)
);



/* Create Foreign Keys */

ALTER TABLE comment
	ADD FOREIGN KEY (num)
	REFERENCES board (num)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE board
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE comment
	ADD FOREIGN KEY (id)
	REFERENCES member (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



