-- 7.DDL.sql
-- table 생성(create)과 삭제(drop), table 구조 수정(alter)

-- DDL(Data Definition Language)
/*
  DB에 데이터를 CRUD 작업 가능하게 해주는 기본 구성
  
 [1] table 생성 명령어
    create table table명(
		칼럼명1 칼럼타입[(사이즈)] [제약조건] ,
		칼럼명2....
    ); 

[2] table 삭제 명령어
	drop table table명;
	- 삭제 시도시 table 미존재시 에러 발생

[3] table 구조 수정 명령어
	alter table

*/
--1. table삭제 
drop table test;
	

-- db사용자에겐 불필요한 table 정리(쓰레기통 비우기로 간주)
purge recyclebin;


--2. table 생성  
-- name(varchar2(12)), age(number(3)) 칼럼 보유한 people table 생성

CREATE TABLE people(
	name varchar2(12),
	age number(3)
);

SELECT * FROM people;

-- 3. 서브 쿼리 활용해서 emp01 table 생성(이미 존재하는 table기반으로 생성)
-- 구조와 데이터는 복제 가능하나 제약조건은 적용 불가
-- dept table과 무관한 emp01 table
-- emp table의 모든 데이터로 emp01 생성

CREATE TABLE emp01 AS SELECT * FROM emp;
SELECT * FROM emp01;

DROP TABLE emp01;

-- 거짓 조건식 적용시에는 구조만 복제
CREATE TABLE emp01 AS SELECT * FROM emp WHERE 1 = 0;
SELECT * FROM emp01;


-- 4. 서브쿼리 활용해서 특정 칼럼(empno)만으로 emp02 table 생성

DROP TABLE emp02;  -- 습관적으로 emp02가 있을 수도 있으니 날리자. 없으면 error
CREATE TABLE emp02 AS SELECT empno FROM emp;
SELECT * FROM emp02;


--5. deptno=10 조건문 반영해서 empno, ename, deptno로  emp03 table 생성

DROP TABLE emp03;
CREATE TABLE emp03 AS SELECT empno, ename, deptno FROM emp WHERE DEPTNO = 10;
SELECT * FROM emp03;


-- 6. 데이터 insert없이 table 구조로만 새로운 emp04 table생성시 
-- 사용되는 조건식 : where=거짓




-- emp01 table로 실습해 보기

--7. emp01 table에 job이라는 특정 칼럼 추가(job varchar2(10))
-- 이미 데이터를 보유한 table에 새로운 job칼럼 추가 가능 
-- add () : 컬럼 추가 연산자

--desc emp01;
drop table emp01;
create table emp01 as select empno, ename from emp;
--desc emp01;

SELECT * FROM emp01;

ALTER TABLE emp01 ADD(job varchar2(10));

SELECT * FROM emp01;
--desc emp01;

--desc emp01;
select * from emp01;

--8. 이미 존재하는 칼럼 사이즈 변경 시도해 보기
-- 데이터 미 존재 칼럼의 사이즈 수정(크게/ 작게 다 수정 가능)
-- modify (컬럼명 타입(크기))

--desc emp01;
ALTER TABLE emp01 MODIFY(job varchar2(20));
ALTER TABLE emp01 MODIFY(job varchar2(10));

--desc emp01;



--9. 이미 데이터가 존재할 경우 칼럼 사이즈가 큰 사이즈의 컬럼으로 변경 가능 
-- 혹 사이즈 감소시 주의사항 : 이미 존재하는 데이터보다 적은 사이즈로 변경 절대 불가 
-- 발생 가능한 문제: 데이터 보다 적은 사이즈로 수정 시도시 데이터 손실 가능성 있음
-- DB는 거부
drop table emp01;
create table emp01 as select empno, ename, job from emp;
select * from emp01;
--desc emp01;
 
-- job 컬럼 사이즈를 작게 수정 시도 시 실패
--ALTER TABLE emp01 MODIFY (job varchar2(5)); 오류
ALTER TABLE emp01 MODIFY (job varchar2(15));

desc emp01;
select * from emp01;




--10. job 칼럼 삭제 
-- 데이터 존재시에도 자동 삭제 
-- drop 
-- add시 필요 정보(컬럼명 타입(사이즈)) / modify 필요 정보(컬럼명 타입(사이즈)) / drop 필요 정보(컬럼명)

desc emp01;
select * from emp01;
ALTER TABLE emp01 DROP COLUMN job;
SELECT * FROM emp01;

--11. emp01을 test01로 table 이름 변경
RENAME emp01 TO test01;
SELECT * FROM emp01;
SELECT * FROM test01;

--12. table의 순수 데이터만 완벽하게 삭제하는 명령어 
-- 주의 사항 : tool 사용시 tool 기능 auto commit 즉 삭제시 영구 삭제하는지 반드시 확인
-- commit 불필요
-- DELETE or TRUNCATE 

DROP TABLE test01;
CREATE TABLE test01 AS SELECT * FROM emp;
SELECT * FROM test01;

-- 데이터만 삭제 / delete로 삭제한 데이터는 rollback으로 복구
DELETE FROM test01;
SELECT * FROM test01; -- 데이터 없음
ROLLBACK;			  -- delete로 삭제한 데이터 복원 명령어
SELECT * FROM test01; -- 복원된 데이터 검색

-- TRUNCATE 로 삭제 - 완전 영구 삭제
TRUNCATE TABLE test01;
SELECT * FROM test01;
ROLLBACK;

SELECT * FROM test01;



-- 자바 + table + select 
-- table 설계
-- 지인 소개 app 개발한다 가정시 오늘 팀원들 떠오르는 이미지 데이터(동물 이미지 매핑)

-- 저장하고자 하는 데이터들 표현

DROP TABLE team6;
CREATE TABLE team6(
	name varchar2(12),
	age number(3),
	gender varchar2(3),
	major varchar2(15),
	height number(3),
	animal varchar2(12),
	mbti varchar2(12),
	food varchar2(15)
);


INSERT INTO TEAM6 VALUES('손현오', 26, '남', '컴퓨터공학'	, 175, '소',	'ENTP', '떡볶이');
INSERT INTO TEAM6 VALUES('김진주', 25, '여', '산업공학', 173, '호랑이', 'ENFP', '제육볶음');
INSERT INTO TEAM6 VALUES('이승현', 28, '남', '산업공학',	178, '돼지', 'ESTJ', '국밥');

INSERT ALL 
	INTO TEAM6 VALUES('손현오', 26, '남', '컴퓨터공학', 175, '소',	'ENTP', '떡볶이')
	INTO TEAM6 VALUES('김진주', 25, '여', '산업공학', 173, '호랑이', 'ENFP', '제육볶음')
	INTO TEAM6 VALUES('이승현', 28, '남', '산업공학', 178, '돼지', 'ESTJ', '국밥')
SELECT *
FROM dual;


SELECT * FROM team6;



