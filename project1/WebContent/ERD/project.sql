SET SESSION FOREIGN_KEY_CHECKS=0;

/* Drop Tables */

DROP TABLE IF EXISTS comment;
DROP TABLE IF EXISTS board;
DROP TABLE IF EXISTS member;




/* Create Tables */

CREATE TABLE board
(
	btype int NOT NULL COMMENT '�Խ��� ����
1 : ��������
2 : ������ȭŽ��
3 : ��������',
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
	kbn int NOT NULL COMMENT 'ȸ������
1 : �Ϲ�ȸ��
2 : ���ȸ��
3: ������',
	lv int NOT NULL COMMENT 'ȸ������
1 : �ű�ȸ��
2 : �Ϲ�ȸ��
3 : ���ȸ��
4 : ������',
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
	apply int NOT NULL COMMENT '0 : ��� �̽�û
1 : ��� ��û
2 : ��� �Ϸ�',
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



