-- DML (Data Manipulation Language)

-- INSERT / UPDATE / DELETE

CREATE TABLE EMPLOYEE2 AS SELECT * FROM EMPLOYEE;

CREATE TABLE DEPARTMENT2 AS SELECT * FROM DEPARTMENT;

CREATE TABLE JOB2 AS SELECT * FROM JOB;

CREATE TABLE LOCATION2 AS SELECT * FROM LOCATION;

CREATE TABLE NATIONAL2 AS SELECT * FROM NATIONAL;

--------------------------------------------------------- 
-- 1. Insert
-- if insert default -> default value

SELECT * FROM EMPLOYEE2;
SELECT * FROM DEPARTMENT2;

Insert into EMPLOYEE2 
values ('223','신생아','760202-1235531','seng_a@or.kr','01041553125','D1','J7','S3',4300000,0.2,'200',SYSDATE,null,'N');

ROLLBACK;

Insert into EMPLOYEE2 (EMP_ID,EMP_NAME,EMP_NO,EMAIL,PHONE,DEPT_CODE,JOB_CODE,SAL_LEVEL,SALARY)
values ('223','신생아','760202-1235531','seng_a@or.kr','01041553125','D1','J7','S3',4300000);
COMMIT;
--DROP TABLE EMPLOYEE2 ;

INSERT INTO DEPARTMENT2 (DEPT_ID,DEPT_TITLE,LOCATION_ID) VALUES ('D10', 'ㅇㅇ부', 'L2');

-- sub query

CREATE TABLE EMP_01(
	EMP_ID NUMBER,
	EMP_NAME VARCHAR2(30),
	DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE2
LEFT JOIN DEPARTMENT2 ON (DEPT_CODE = DEPT_ID);

INSERT INTO EMP_01 
(SELECT EMP_ID, EMP_NAME, DEPT_TITLE FROM EMPLOYEE2
LEFT JOIN DEPARTMENT2 ON (DEPT_CODE = DEPT_ID));

-- 2. UPDATE

SELECT * FROM DEPARTMENT2;

UPDATE DEPARTMENT2 SET DEPT_TITLE = '전략기획팀' WHERE DEPT_ID = 'D9';

UPDATE EMPLOYEE2 SET BONUS = '0.1' WHERE BONUS IS NULL;

SELECT * FROM EMPLOYEE2;

UPDATE EMPLOYEE2 SET BONUS = NULL WHERE BONUS = '0.1';

ROLLBACK;

UPDATE DEPARTMENT2 SET DEPT_ID = 'D0', DEPT_TITLE = '전략기획팀' WHERE DEPT_ID = 'D9' AND DEPT_TITLE = '총무부';

SELECT SALARY FROM EMPLOYEE2 WHERE EMP_NAME = '유재식'; --3400000
SELECT BONUS FROM EMPLOYEE2 WHERE EMP_NAME = '유재식'; --0.2

UPDATE EMPLOYEE2 SET SALARY = (SELECT SALARY FROM EMPLOYEE2 WHERE EMP_NAME = '유재식'), 
BONUS = (SELECT BONUS FROM EMPLOYEE2 WHERE EMP_NAME = '유재식') WHERE EMP_NAME = '방명수';

SELECT EMP_NAME, SALARY, BONUS FROM EMPLOYEE2 WHERE EMP_NAME IN ('방명수','유재식');

------------------------------------------------------------
-- 3. MERGE

CREATE TABLE EMP_M01
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_M01;

CREATE TABLE EMP_M02
AS SELECT * FROM EMPLOYEE WHERE JOB_CODE = 'J4';

SELECT * FROM EMP_M02;

UPDATE EMP_M02 SET DEPT_CODE = 'D0'WHERE DEPT_CODE = 'D6';
UPDATE EMP_M02 SET DEPT_CODE = 'D9'WHERE DEPT_CODE = 'D2';


Insert into EMP_M02 
values ('223','신생아','760202-1235531','seng_a@or.kr','01041553125','D1','J7','S3',4300000,0.2,'200',SYSDATE,null,'N');

MERGE INTO EMP_M01 USING EMP_M02 ON(EMP_M01.EMP_ID = EMP_M02.EMP_ID)
WHEN MATCHED THEN
UPDATE SET
	EMP_M01.EMP_NAME = EMP_M02.EMP_NAME,
	EMP_M01.EMP_NO = EMP_M02.EMP_NO,
	EMP_M01.EMAIL = EMP_M02.EMAIL,
	EMP_M01.PHONE = EMP_M02.PHONE,
	EMP_M01.DEPT_CODE = EMP_M02.DEPT_CODE,
	EMP_M01.JOB_CODE = EMP_M02.JOB_CODE,
	EMP_M01.SAL_LEVEL = EMP_M02.SAL_LEVEL,
	EMP_M01.SALARY = EMP_M02.SALARY,
	EMP_M01.BONUS = EMP_M02.BONUS,
	EMP_M01.MANAGER_ID = EMP_M02.MANAGER_ID,
	EMP_M01.HIRE_DATE = EMP_M02.HIRE_DATE,
	EMP_M01.ENT_DATE = EMP_M02.ENT_DATE,
	EMP_M01.ENT_YN = EMP_M02.ENT_YN
WHEN NOT MATCHED THEN
INSERT VALUES(EMP_M02.EMP_ID, EMP_M02.EMP_NAME, EMP_M02.EMP_NO, EMP_M02.EMAIL, 
	         EMP_M02.PHONE, EMP_M02.DEPT_CODE, EMP_M02.JOB_CODE, EMP_M02.SAL_LEVEL, 	  	         EMP_M02.SALARY, EMP_M02.BONUS, EMP_M02.MANAGER_ID, EMP_M02.HIRE_DATE, 
	         EMP_M02.ENT_DATE, EMP_M02.ENT_YN);

DELETE FROM EMP_M02;

DELETE FROM EMPLOYEE2 WHERE EMP_NAME = '신생아';

SELECT * FROM EMPLOYEE2;
COMMIT;


-- 5. TRUNCATE


CREATE TABLE EMPLOYEE3 AS SELECT * FROM EMPLOYEE2;
SELECT * FROM EMPLOYEE3;

DELETE FROM EMPLOYEE3;

ROLLBACK;

TRUNCATE TABLE EMPLOYEE3;

ROLLBACK;