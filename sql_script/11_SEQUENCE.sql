-- SEQUENCE

CREATE SEQUENCE SEQ_TEST;

SELECT SEQ_TEST.NEXTVAL FROM DUAL;

CREATE TABLE EMP_TEMP
AS SELECT EMP_ID, EMP_NAME FROM EMPLOYEE;

SELECT * FROM EMP_TEMP;

CREATE SEQUENCE SEQ_TEMP
START WITH 223
INCREMENT BY 10
NOCYCLE
NOCACHE;

INSERT INTO EMP_TEMP VALUES(SEQ_TEMP.NEXTVAL, '홍길동');
INSERT INTO EMP_TEMP VALUES(SEQ_TEMP.NEXTVAL, '김길동');
INSERT INTO EMP_TEMP VALUES(SEQ_TEMP.NEXTVAL, '전길동');

ALTER SEQUENCE SEQ_TEMP
INCREMENT BY 1;

INSERT INTO EMP_TEMP VALUES(SEQ_TEMP.NEXTVAL, '문길동');
INSERT INTO EMP_TEMP VALUES(SEQ_TEMP.NEXTVAL, '종길동');
INSERT INTO EMP_TEMP VALUES(SEQ_TEMP.NEXTVAL, '황길동');

DROP TABLE EMP_TEMP;
DROP VIEW V_DCOPY2;
DROP SEQUENCE SEQ_TEMP;
DROP SEQUENCE SEQ_TEST;

GRANT SELECT ON EMPLOYEE TO sh_sample;

SELECT EMP_NAME, JOB_NAME, SALARY, SALARY*12 AS ANNUALSALARY FROM EMPLOYEE
NATURAL JOIN JOB
WHERE JOB_NAME = '부사장' AND SALARY > 4000000;

--//		JOB_NAME, SALARY -> insert
--//		JOB_NAME < salary emp_name, job_name,salary, annual salary
--//		execpt -> if null "조회 결과 없음"
--//		if not null 
--//		집급명 입력 : 부사장
--//		급여 입력 : 5000000
--//		송종기 / 부사장 / 6000000 / 72000000



SELECT EMP_NAME AS "이름", TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일"') AS "입사일", DECODE(SUBSTR(EMP_NO, 8, 1), 1, 'M', 2, 'F', '없음') AS "성별" FROM EMPLOYEE
WHERE HIRE_DATE < TO_DATE('2004-01-01', 'YYYY-MM-DD');