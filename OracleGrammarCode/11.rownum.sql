--11.rownum.sql

-- *** rownum
-- oracle 자체적으로 제공하는 컬럼
-- table 당 무조건 자동 생성
-- 검색시 검색된 데이터 순서대로 rownum값 자동 반영(1부터 시작)

-- *** 인라인 뷰
	-- 검색시 빈번히 활용되는 스펙
	-- 다수의 글들이 있는 게시판에 필수로 사용(paging 처리)
	-- 서브쿼리의 일종으로 from절에 위치하여 테이블처럼 사용
	-- 원리 : sql문 내부에 view를 정의하고 이를 테이블처럼 사용 

select rownum, empno from emp;
select rownum, deptno from dept;

-- dept의 rownum은 정렬 방식과 무관하게 1부터 적용
select rownum, deptno from dept order by deptno desc;
select rownum, deptno from dept order by deptno asc;

-- dept01은 desc/asc 영향을 받은 것 처럼 검색
select rownum, deptno from dept01 order by deptno desc;
select rownum, deptno from dept01 order by deptno asc;


-- 1. ? dept의 deptno를 내림차순(desc)으로 검색, rownum
select rownum, deptno from dept order by deptno desc;
/*
    ROWNUM     DEPTNO
---------- ----------
         1         40
         2         30
         3         20
         4         10
*/

-- 2. ? deptno의 값이 오름차순으로 정렬해서 30번 까지만 검색, rownum 포함해서 검색
-- 3. ? deptno의 값이 오름차순으로 정렬해서 상위 3개의 데이터만 검색, rownum 포함해서 검색
select rownum, deptno from dept where deptno <= 30 order by deptno asc;

-- 방법 1
select rownum, deptno from dept where rownum < 4;

-- 방법 2 : 인라인 view
-- 검색된 결과도 table로 간주 : 
-- 실행 순서 : from(이미 존재하는 table or view) -> select
select rownum, deptno 
from (select rownum, deptno 
	  from dept
	  where rownum <4);

-- 인라인 뷰 / deptno 내림차순 정렬 / rownum은 1 ~ 검색
select rownum, deptno 
from (select rownum, deptno 
	  from dept
	  order by deptno desc);

-- 인라인 뷰 / deptno 오름차순 정렬 / rownum은 1 ~ 검색
select rownum, deptno 
from (select rownum, deptno 
	  from dept
	  order by deptno asc);

-- dept01의 deptno를 오름차순으로 정렬해서 상위 3개의 데이터만 검색 요청
-- dept01의 deptno를 내림차순으로 정렬해서 상위 3개의 데이터만 검색 요청
-- dept01 table

-- 나의 답 : 정답~~~~~~~~~~
select rownum, deptno 
from (select rownum, deptno 
	  from dept01
	  order by deptno desc)
where rownum < 4;

select rownum, deptno 
from (select rownum, deptno 
	  from dept01
	  order by deptno asc)
where rownum < 4;


-- 수업 내용 
select rownum, deptno from dept01 order by deptno desc;
/*
    ROWNUM     DEPTNO
---------- ----------
         4         40
         3         30
         2         20
         1         10
*/
select rownum, deptno from (select rownum, deptno from dept01 order by deptno desc);
-- 이렇게 하면 1, 2, 3, 4 잘 나옴. 미리 정렬을 하고 rownum을 해야지!

select rownum, deptno
from dept01
where rownum > 1
order by deptno asc;
--no rows selected

select rownum, deptno from dept01 order by deptno asc;
/*
    ROWNUM     DEPTNO
---------- ----------
         1         10
         2         20
         3         30
         4         40
*/
select rownum, deptno from dept01 where rownum <4 order by deptno asc;
/*
    ROWNUM     DEPTNO
---------- ----------
         1         10
         2         20
         3         30
*/
-- 정상
select rn, deptno
from (select rownum as rn, deptno from dept);

-- 정상
select rownum, rn, deptno
from (select rownum as rn, deptno from dept);

-- 오류
select rownum, rn, deptno3
from (select rownum as rn, deptno from dept);

-- 오류
select rownum, rn2, deptno
from (select rownum as rn, deptno from dept);

-- 정상, rownum값이 1로 검색됨
-- 참고 : 조건없이 검색시에는 rn 컬럼값이 2인 row는 rownum이 2였음
-- 결론 : select 시에 검색되는 table에 rownum값은 가변적 즉 검색된
-- 결과에 1부터 무조건 적용
select rownum, rn, deptno
from (select rownum as rn, deptno from dept)
where rn = 2;
/*
    ROWNUM         RN     DEPTNO
---------- ---------- ----------
         1          2         20
*/

-- 4.  인라인 뷰를 사용하여 급여를 많이 받는 순서대로 3명만 이름과 급여 검색 

 
 select rownum, ename, sal
 from (select rownum, ename, sal from emp order by sal desc)
 where rownum <= 3;
