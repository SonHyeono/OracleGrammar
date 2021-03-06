--12.sequence.sql
/*
1. 시퀀스 
	: 순차적인 순서 번호를 자동으로 반영할수 있는 매우 유용한 기술
	: 기본은 1씩 자동 증가
		- 증가치, 최대값 추가 설정도 가능
		- 권장 : 하나의 시퀀스를 다수의 table에서 사용 비추

2. 대표적인 활용 영역
	- 게시물 글번호에 주로 사용
	- insert 시에 고유한 순차적인 번호를 부여하는 기술
	- 게시글 table의 어떤 컬럼에 적용할지 먼저 분석, 설계 후 생성
	- 주의 사항
		: 시퀀스는 여러 table에서 공유 금지

3. sequence가 보유한 속성
	1. nextval - 새로 적용되는 숫자 / insert시에만(새로운 데이터 생성) 적용
	2. currval - 현재 sequence 값


4. 참고
	create 명령어로 생성 가능한 것
		table/view/sequence

*/	
	     
--1. sequence 생성 명령어
-- a라는 table의 no는 고유한 숫자값(counting)으로 간주
drop table a;
drop table b;

create table a(
	no number(2),
	msg varchar2(10)
);

create table b(
	no number(2),
	msg varchar2(10)
);

create sequence a_seq;
drop sequence a_seq;

create sequence a_no_seq;


--2. seq~를 활용한 insert

insert into a values (a_no_seq.nextval, 'db');
select * from a;

-- 현재 시퀀스 값 검색 명령어
select a_no_seq.currval from dual;

--3. 다수의 table에서 하나의 seq를 공동 사용시 문제 발생
-- table별 고유한 숫자 사용시에는 사용 불가

insert into a values (a_no_seq.nextval, 'db');
insert into b values (a_no_seq.nextval, 'db');
select * from a;
select * from b;



--4. 시작 index 지정 및 증가치도 지정하는 seq 생성 명령어
-- 10부터 시작 2씩 증가 하며, 최대치는 20까지
-- 10, 12, 14, 16, 18, 20만 사용

drop sequence seq_test_no1;
create sequence seq_test_no1
start with 10
increment by 2
maxvalue 20;


--5. seq 삭제 명령어
drop sequence a_no_seq;


--6. 현 sequence의 데이터값 검색하기

select a_no_seq.currval from dual;



 


