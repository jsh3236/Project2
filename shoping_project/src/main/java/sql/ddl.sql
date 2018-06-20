CREATE  TABLE users (
  username VARCHAR(45) NOT NULL primary key,
  password VARCHAR(60) NOT NULL,
  enabled number(1) DEFAULT 1
 );

CREATE TABLE user_roles (
  user_role_id number(11) NOT NULL,
  username varchar(45) NOT NULL,
  role varchar(45) NOT NULL,
  PRIMARY KEY (user_role_id),
  CONSTRAINT fk_username FOREIGN KEY (username) 
     REFERENCES users (username)
 );
 
create sequence user_roles_seq
	start with 1
	increment by 1
	maxvalue 99999
    nocycle 

-- example
-- pw : 123456789
INSERT INTO users(username,password,enabled)
VALUES ('admin','$2a$10$US3HfE49gc5k.2nDwr/a9u1uCg6O8olzJZc5yERG.obR7xveqIHE2', 1);

INSERT INTO users
VALUES ('admin','$2a$10$US3HfE49gc5k.2nDwr/a9u1uCg6O8olzJZc5yERG.obR7xveqIHE2', 1,1,1,1,1,1,sysdate);


INSERT INTO user_roles (user_role_id, username, role)
VALUES (user_roles_seq.nextval, 'admin', 'ROLE_ADMIN');

CREATE  TABLE users (
  username VARCHAR(45) NOT NULL primary key,
  password VARCHAR(60) NOT NULL,
  enabled number(1) DEFAULT 1,
  name varchar(20) not null,
  sex varchar(5) not null,
  phone varchar(20) not null,
  address varchar(200) not null,
  email varchar(100) not null,
  joindate date default sysdate
 );


// ���̺� �÷� ���� ����

column username format a10;
column password format a30;
column name format a5;
column sex format a3;
column phone format a10;
column address format a30;
column email format a20;


//���̺� ���� ���ϰ�
set linesize 150
set pagesize 150




CREATE TABLE BOARD_TBL (
    BOARD_NUM INT, -- �� ��ȣ (oracle������ number �������� �ڵ� ��ȯ��)
    BOARD_NAME VARCHAR(30) NOT NULL, -- �ۼ��� (oracle������ varchar2 �������� �ڵ� ��ȯ��)
    BOARD_PASS VARCHAR(15) NOT NULL, -- ��й�ȣ
    BOARD_SUBJECT VARCHAR(50) NOT NULL, -- ����
    BOARD_PRICE INT NOT NULL,
    BOARD_CONTENT VARCHAR(2000) NOT NULL, -- ����
    BOARD_FILE VARCHAR(50) NOT NULL, -- ÷�� ����
    BOARD_RE_REF INT NOT NULL, -- ���ñ� ��ȣ
    BOARD_RE_LEV INT NOT NULL, -- ��� ����
    BOARD_RE_SEQ INT NOT NULL, -- ���ñ� �� ��� ����
    BOARD_READCOUNT INT DEFAULT 0, -- ��ȸ��
    BOARD_DATE DATE, -- �ۼ���
    PRIMARY KEY(BOARD_NUM)
);
 
-- ����
ALTER TABLE board MODIFY board_num INT DEFAULT 0;
ALTER TABLE board MODIFY BOARD_NAME VARCHAR(30);


out.println("<script>alert('3');</script>");
